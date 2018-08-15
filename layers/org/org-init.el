(use-package org
  :ensure org-plus-contrib
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
  (require 'ox-confluence)
  ;; getprograms retrieves this from git
  (use-package ob-racket
    :load-path "programs/ob-racket")

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
  (if (string= system-name "dunscotus")
      (setq org-agenda-files (file-expand-wildcards "~/org/GTD/work/*.org"))
    (setq org-agenda-files (file-expand-wildcards "~/org/GTD/home/*.org")))

  (setq org-capture-templates
        `(("h" "Home Templates")
          ("ht" "Todo" entry (file+datetree "~/org/GTD/home/home-gtd.org" "Tasks")
           "* TODO %?\nEntered on %U\n  %i\n  %a")
          ("hj" "Journal" entry (file+datetree "~/org/home/journal.org")
           "* %?\nEntered on %U\n  %i\n  %a")
          ("w" "Work Templates")
          ("wt" "Todo" entry (file+datetree "~/org/GTD/work/work-gtd.org" "Tasks")
           "* TODO %?\nEntered on %U\n  %i\n  %a")
          ("wT" "Training" entry (file+datetree "~/org/GTD/work/work-gtd.org" "Training")
           "* TODO %?\nEntered on %U\n  %i\n  %a")
          ("wk" "Kafka" entry (file+datetree "~/org/GTD/work/work-gtd.org" "Kafka")
           "* TODO %?\nEntered on %U\n  %i\n  %a")
          ("wz" "Zookeeper" entry (file+datetree "~/org/GTD/work/work-gtd.org" "Zookeeper")
           "* TODO %?\nEntered on %U\n  %i\n  %a")
          ("wm" "Tokumx" entry (file+datetree "~/org/GTD/work/work-gtd.org" "Tokumx")
           "* TODO %?\nEntered on %U\n  %i\n  %a")

          ))

  (dolist (func '((lambda ()
                    (visual-line-mode)
                    (org-indent-mode))
                  org-bullets-mode))
    (add-hook 'org-mode-hook func))

  (use-package org-projectile
    :bind (("C-c n p" . org-projectile-project-todo-completing-read)
           ("C-c c" . org-capture))
    :ensure t
    :config
    (progn
      (if (string= system-name "dunscotus")
          (setq org-projectile-projects-file
                "~/org/GTD/work/code-projects.org")
        (setq org-projectile-projects-file
              "~/org/GTD/home/code-projects.org"))
      (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
      (push (org-projectile-project-todo-entry) org-capture-templates))
    :ensure t))
(provide 'org-init)
