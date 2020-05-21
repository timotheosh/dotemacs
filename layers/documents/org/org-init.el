(use-package org
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

  (use-package org-jira
    :ensure t
    :pin melpa
    :config
    (setq jiralib-url "https://inindca.atlassian.net"))

  ;; Remove completed scheduled and deadlined tasks from agenda view
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-agenda-skip-deadline-if-done t)

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
  (if (string= system-name "scholasticus")
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
          ("wc" "Credential Automation" entry (file+datetree "~/org/GTD/work/work-gtd.org" "Credential Automation")
           "* TODO %?\nEntered on %U\n  %i\n  %a")
          ("wd" "Documentation" entry (file+datetree "~/org/GTD/work/work-gtd.org" "Documentation")
           "* TODO %?\nEntered on %U\n  %i\n  %a")
          ("wm" "Metrics" entry (file+datetree "~/org/GTD/work/work-gtd.org" "Metrics")
           "* TODO %?\nEntered on %U\n  %i\n  %a")
          ("wD" "Dashboards" entry (file+datetree "~/org/GTD/work/work-gtd.org" "Dashboards")
           "* TODO %?\nEntered on %U\n  %i\n  %a")
          ))

  (dolist (func '((lambda ()
                    (visual-line-mode)
                    (org-indent-mode))
                  org-bullets-mode))
    (add-hook 'org-mode-hook func))

  ;; Full screen for agenda and todos
  (setq org-agenda-window-setup 'only-window)

  (use-package org-projectile
    :bind (("C-c n p" . org-projectile-project-todo-completing-read)
           ("C-c c" . org-capture))
    :ensure t
    :config
    (progn
      (if (string= system-name "scholasticus")
          (setq org-projectile-projects-file
                "~/org/GTD/work/code-projects.org")
        (setq org-projectile-projects-file
              "~/org/GTD/home/code-projects.org"))
      (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
      (push (org-projectile-project-todo-entry) org-capture-templates))
    :ensure t)

  (use-package org-protocol)

  (use-package org2blog
    :ensure t
    :config
    (setq org2blog/wp-blog-alist
          '(("timhawes"
             :url "https://timhawes.wordpress.com/xmlrpc.php"
             :username "timotheosh")))))
(provide 'org-init)
