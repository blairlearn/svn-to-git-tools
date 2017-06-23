@echo off
setlocal

rem Based on the migration steps described in
rem http://www.sailmaker.co.uk/blog/2013/05/05/migrating-from-svn-to-git-preserving-branches-and-tags-3/
rem
rem This script encapsulates the steps for creating a local Git repository
rem based on a Subversion repository.  Change the variables below as needed and the
rem script will do the rest.

rem BASE directory. This should be an empty directory where git-svn can work without worrying
rem about trashing existing files.  If the does not exist, it will be created.
set BASE_DIRECTORY=C:\Migrate

rem Location of the file containing the author translation list.
rem The file is a list of svnuserids and github usernames in the format
rem svnuser = Real Name <githubusername@users.noreply.github.com>
set AUTHORS_FILE=C:\authors.txt

rem The SVN repository name. (e.g. OCE_WCMTEAM, OCPLSEARCH, etc.)
rem Do *NOT* include the name of any projects within the repository.
set SVN_REPO=NAME_GOES_HERE
set SVN_SERVER=https://ncisvn.nci.nih.gov
set SVN_REPO_URL=%SVN_SERVER%/svn/%SVN_REPO%

rem Path to the project (e.g. ContentDeliveryEngine). Do *NOT* include trunk/branches/tags/etc.
rem NOTE: The path is case-sensitive.  No leading or trailing slashes
set SVN_PROJECT_PATH=PATH_NAME_GOES_HERE


rem Sub paths to the project trunk, branches and tags.  These generally won't need to be changed.
rem NOTE: These names are case-sensitive (e.g. trunk is not the same as Trunk)
set TRUNK=trunk
set BRANCHES=branches
set TAGS=tags

rem Remember where we started
pushd .

rem Create directory structure.
set STAGE_DIR=%BASE_DIRECTORY%\staging
set TEST_DIR=%BASE_DIRECTORY%\test
set CLONE_DIR=%BASE_DIRECTORY%\clone

md %STAGE_DIR%
md %TEST_DIR%
md %CLONE_DIR%

rem Create the staging Git repo.
cd %STAGE_DIR%
git svn init "%SVN_REPO_URL%" -T "%SVN_PROJECT_PATH%/%TRUNK%" --prefix=svn/ --no-metadata
if errorlevel 1 goto error
git svn fetch  --authors-file=%AUTHORS_FILE%
if errorlevel 1 goto error
rem TODO: Convert branches and tags


rem Create a test repository
cd %TEST_DIR%
git init --bare
cd %STAGE_DIR%
git remote add test %TEST_DIR%
git push --all test
git push --tags test
git remote remove test

rem Clone the test repository
git clone %TEST_DIR% %CLONE_DIR%


rem Reset to starting directory
popd

echo .
echo .
echo Your repository has been created in '%STAGE_DIR%'.
echo .
echo Additonally, a clone repository has been created in '%CLONE_DIR%'.
echo If all appears well with the clone repository, then you may consider
echo '%STAGE_DIR%' to be ready for use.
echo .
echo .


goto end
:error
echo .
echo Errors have occured.  Exiting.
echo .
:end