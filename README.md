###lik

Lab Integration Kit

#### Structure of the Lab Integration Kit.

* makefile
* README.md
* user-docs
  * index.org     - Contians the content from which html file is generated.
  * elisp         - Support files to generate html
  * style         - Support files to generate html
  * org-templates - Support files to generate html


####Usage
    
`make -k` must be run which generates the **build** folder
containing all the required files for this particular LIK.

    make -k
    
The folder build is tarred and zipped that will be released to integrators.


    

    
