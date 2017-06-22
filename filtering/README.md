# svn filtering tools
Tools to help automate filtering an SVN repository.


Prerequisites:

* Subversion
* [svndumpsanitizer](https://github.com/dsuni/svndumpsanitizer) *

\* **Note:** Despite its name, the svndumpsanitizer tool does *not* have the ability to redact passwords, etc.
    from version history. The tool's sole purpose is to extract a desired set of project file trees from an SVN repository.

## Step 1

Filter the dump file to contain only the desired tree structure and load it into a temporary Subversion
repository.
