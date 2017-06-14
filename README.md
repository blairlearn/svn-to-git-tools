# svn-to-git-tools
Tools to help automate the SVN to Git conversion

Based in large part on "[Converting a Subversion repository to Git](https://john.albin.net/git/convert-subversion-to-git),"
this project attempts to create a sequence of batch files for performing the conversiono in a Windows environment.

Prerequisites:

* git
* git-svn package
* Subversion
* [svndumpsanitizer](https://github.com/dsuni/svndumpsanitizer) *

\* **Note:** Despite its name, the svndumpsanitizer tool does *not* have the ability to redact passwords, etc.
    from version history. The tool's sole purpose is to extract a desired set of project file trees from an SVN repository.

## Step 1

Filter the dump file to contain only the desired tree structure and load it into a temporary Subversion
repository.
