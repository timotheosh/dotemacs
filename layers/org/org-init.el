(use-package org-mode
  :ensure org
  :pin org
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c u" . org-jira-get-issues)
         ("C-c c" . org-capture)
         ("C-c b" . org-iswitchb))
  :init
  ;; Github Flavored Markdown
  (use-package ox-gfm
    :ensure t)
  ;; Pretty bullets
  (use-package org-bullets
    :ensure t)
  ;; Convert org to OpenOffice. Comes with org
  (require 'ox-odt)
  ;; getprograms retrieves this from git
  (use-package ob-racket
    :load-path "programs/ob-racket")

  (use-package org-plus-contrib
    :ensure t
    :pin org
    :init
    (require 'ox-confluence))

  (use-package org-jira
    :ensure t
    :config
    (setq jiralib-url "https://inindca.atlassian.net"))

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
     (java . t)
     (racket . t)
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
        `(("h" "Home Templates")
          ("ht" "Todo" entry (file+datetree "~/org/GTD/home-gtd.org" "Tasks")
           "* TODO %?\nEntered on %U\n  %i\n  %a")
          ("hj" "Journal" entry (file+datetree "~/org/journal.org")
           "* %?\nEntered on %U\n  %i\n  %a")
          ("w" "Work Templates")
          ("wt" "Todo" entry (file+datetree "~/org/GTD/work-gtd.org" "Tasks")
           "* TODO %?\nEntered on %U\n  %i\n  %a")
          ("wT" "Training" entry (file+datetree "~/org/GTD/work-gtd.org" "Training")
           "* TODO %?\nEntered on %U\n  %i\n  %a")
          ("wk" "Kafka" entry (file+datetree "~/org/GTD/work-gtd.org" "Kafka")
           "* TODO %?\nEntered on %U\n  %i\n  %a")
          ("wz" "Zookeeper" entry (file+datetree "~/org/GTD/work-gtd.org" "Zookeeper")
           "* TODO %?\nEntered on %U\n  %i\n  %a")
          ("wm" "Tokumx" entry (file+datetree "~/org/GTD/work-gtd.org" "Tokumx")
           "* TODO %?\nEntered on %U\n  %i\n  %a")

          ))

  (dolist (func '((lambda ()
                    (set-fill-column 80)
                    (turn-on-auto-fill))
                  org-bullets-mode))
    (add-hook 'org-mode-hook func))

  (use-package org-projectile
    :bind (("C-c n p" . org-projectile:capture-for-current-project)
           ("C-c c" . org-capture))
    :ensure t
    :config
    (progn
      (setq org-projectile:projects-file
            "~/org/GTD/code-projects.org")
      (add-to-list 'org-capture-templates (org-projectile:project-todo-entry "p")))))
(provide 'org-init)
