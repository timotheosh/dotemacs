(use-package org-mode
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c u" . org-jira-get-issues)
         ("C-c c" . org-capture))
  :init
  (require 'ox-wk)
  (require 'ox-gfm)
  (require 'ox-odt)
  (require 'org-bullets)
  (require 'ox-confluence)

  ;; Remove html validation link
  (setq org-html-validation-link nil)

  ;; active Babel languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (ruby . t)
     (groovy . t)
     (scala . t)
     (lisp . t)
     (clojure . t)
     (emacs-lisp . t)
     (shell . t)
     (C . t)
   ))

  (setq auto-insert-alist
        '(
          ((org-mode . "Org mode file")
           nil
           ""
           '(setq doc-title (skeleton-read "Document Title: "))
           '(setq author-name (user-full-name))
           "#+OPTIONS: ^:nil" \n
           "#+TAGS: " \n
           "#+STARTUP: hidestars" \n
           "#+TITLE: " doc-title \n
           "#+AUTHOR: " author-name \n
           "")))

  (setq org-log-done t)
  (setq org-agenda-files (file-expand-wildcards "~/org/GTD/*.org"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; Blogging with Pelican ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (defun pelican-time ()
    (format-time-string "%Y-%m-%d %R"))

  (setq pelican-md-header (concat
                           "#+OPTIONS: toc:nil tex:verbatim\n"
                           "Title:\n"
                           "Date: %(pelican-time)\n"
                           "Category:\n"
                           "Tags:\n"
                           "Slug:\n"
                           "Author: %n\n"
                           "Summary:\n"
                           "%?"))

  (defun capture-pelican-draft-file (dir-path)
    (let ((name (read-string "File Name: ")))
      (expand-file-name (format "%s-%s.org"
                                (format-time-string "%Y-%m-%d")
                                name) dir-path)))


  ;; Code Blocks
  (setq pygments-synonym-alist
        '(("emacs-lisp" . "common-lisp")))

  (defun get-pygments-synonym (lang)
    (let ((synonym (cdr (assoc lang pygments-synonym-alist))))
      (if synonym synonym lang)))

  (defun pelican-src (src-block contents info)
    (let ((lang (get-pygments-synonym
                 (org-element-property :language src-block)))
          (caption (org-export-get-caption src-block))
          (code (org-element-property :value src-block)))
      (concat (format "    :::%s\n" lang)
              (replace-regexp-in-string
               "^" "    " code))))

  ;; Links
  (defun pelican-link (link desc info)
    (let* ((type (org-element-property :type link))
           (raw-path (org-element-property :path link))
           (base-filename (file-name-sans-extension raw-path)))
      (cond ((and (string= type "file")
                  (string= (downcase (file-name-extension raw-path)) "org"))
             (format "[%s](|filename|%s.md)" desc base-filename))
            (t (org-export-with-backend 'md link desc info)))))

  ;; Project Definition
  (defun org-pelican-md-publish-to-md (plist filename pub-dir)
    (org-publish-org-to 'pelican-md filename ".md" plist pub-dir))

  (use-package org-page
    :init
    (setq op/repository-directory (expand-file-name "~/org/Selfdidactic.com"))
    (setq op/site-domain "http://selfdidactic.com/")
    ;;; for commenting, you can choose either disqus or duoshuo
    (setq op/personal-disqus-shortname "timotheosh")
                                        ;(setq op/personal-duoshuo-shortname "your_duoshuo_shortname")
    ;;; the configuration below are optional
    (setq op/personal-google-analytics-id "UA-9488542-1")
    (setq op/site-main-title "Self Didactic")
    (setq op/site-sub-title "Self Didactic is dedicated to equipping anyone and everyone who wants to learn on their own. This is the contra-University!")
    (setq op/repository-org-branch "source") ;; default is "source"
    (setq op/repository-html-branch "master")  ;; default is "master"
    ;; Have a github account? It's cool:
    (setq op/personal-github-link "")
    (setq op/repository-html-branch "master")
    (setq op/theme (quote phaer))
    (setq op/theme-root-directory "/home/thawes/.emacs.d/programs/org-page-themes/"))


  (setq org-capture-templates
        `(
          ("t" "Todo" entry (file+datetree "~/org/GTD/newgtd.org" "Tasks")
           "* TODO %?\nEntered on %U\n  %i\n  %a")
          ("j" "Journal" entry (file+datetree "~/org/journal.org")
           "* %?\nEntered on %U\n  %i\n  %a")
          ("p" "New blog post" plain
           (file (capture-pelican-draft-file "~/src/sources/new_pelican_site/org"))
           ,pelican-md-header)))

  (setq org-publish-project-alist
        `(("org-selfdidactic"
           :base-directory "~/selfdidactic.org"
           :base-extension "org"
           :publishing-directory "~/selfdidactic.com"
           :recursive t
           :publishing-function org-html-publish-to-html
           :headline-levels 4
           :auto-preamble t
           :auto-sitemap t
           :sitemap-filename "sitemap.org"
           :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
           )
          ("org-static-selfdidactic"
           :base-directory "~/selfdidactic.org/"
           :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
           :publishing-directory "~/selfdidactic.com/"
           :recursive t
           :publishing-function org-publish-attachment
           )
          ("selfdidactic" :components ("org-selfdidactic" "org-static-selfdidactic"))))

  (dolist (func '((lambda ()
                    (set-fill-column 80)
                    (turn-on-auto-fill))
                  org-bullets-mode))
    (add-hook 'org-mode-hook func)))
(provide 'org-init)
