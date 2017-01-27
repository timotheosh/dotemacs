(use-package org-mode
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c u" . org-jira-get-issues)
         ("C-c c" . org-capture)
         ("C-c b" . org-iswitchb))
  :init
  (require 'ox-gfm)
  (require 'ox-odt)
  (require 'org-bullets)
  (require 'ox-confluence)

  ;; Remove html validation link
  (setq org-html-validation-link nil)

  ;; Smart quotes on
  (setq org-export-with-smart-quotes t)

  ;; Eval inline code without confirmation
  (setq org-confirm-babel-evaluate nil)
  ;; active Babel languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (ruby . t)
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

  (setq org-capture-templates
        `(
          ("t" "Todo" entry (file+datetree "~/org/GTD/newgtd.org" "Tasks")
           "* TODO %?\nEntered on %U\n  %i\n  %a")
          ("j" "Journal" entry (file+datetree "~/org/journal.org")
           "* %?\nEntered on %U\n  %i\n  %a")))

  (dolist (func '((lambda ()
                    (set-fill-column 80)
                    (turn-on-auto-fill))
                  org-bullets-mode))
    (add-hook 'org-mode-hook func)))
(provide 'org-init)
