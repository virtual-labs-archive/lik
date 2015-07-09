;;; Adapted from Sebastian Rose's org publishing tutorial at 
;;; http://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.html


;; (setq org-export-html-postamble nil)

;;; default-dir is the directory from where the emacs to run this script is called. 
(defvar base-dir default-directory)
;;; (defvar base-dir "/home/anoop/Courses/ITWS2/popl/offerings/2011-spring/")
(defvar publishing-dir (concat base-dir "build/"))
(defvar org-notes '())
(defvar org-static '())
(defvar presentation '())

(setq org-notes
`("org-notes"
 :base-directory ,(concat base-dir "user-docs/")
 :base-extension "org"
 :publishing-directory ,publishing-dir
 :recursive t
 :publishing-function org-html-publish-to-html
 :headline-levels 4             ; Just the default for this project.
 :auto-preamble t
 :auto-sitemap t
  ))

 (setq org-static `("org-static"
  :base-directory ,(concat base-dir "user-docs/")
  :base-extension "css\\|js\\|json\\|png\\|html\\|ico\\|jpg\\|png\\|gif\\|mp3\\|ogg\\|swf\\|emacs\\|sh\\|py\\|pdf\\|tex\\|ss\\|rkt\\|flv\\|tgz"
  :publishing-directory ,publishing-dir
  :recursive t
  :publishing-function org-publish-attachment
  ))

 (setq presentation  '("presentation" :components ("org-notes" "org-static")))

 (require 'ox-publish)
 ; (require 'htmlize)
 ; (load "~/emacs/lisp/htmlize/htmlize.el")
 ; the script is running from the parent directory
; (load-file "./elisp/htmlize.el")

 (setq org-publish-project-alist
       (list org-notes org-static presentation))

;; (org-publish-project 
;;  presentation  ; project name
;;  t ; force
;;  )


(setq project-plist presentation)

(org-publish-project
 presentation  ; project name
 t ; force
 )
