;; Load org-mode first.

(use-package jiralib2
  :ensure t)

(use-package ox-jira
  :ensure t)

(use-package language-detection
  :ensure t)

(use-package ejira
  :load-path "programs/ejira"
  :init
  (setq jiralib2-url              nil
        jiralib2-auth             'basic
        jiralib2-user-login-name  nil
        jiralib2-token            nil

        ejira-org-directory       "~/.emacs.d/jira"
        ejira-projects            '("CSA")

        ejira-priorities-alist    '(("Blocker"  . ?A)
                                    ("Critical" . ?B)
                                    ("Major"    . ?C)
                                    ("Minor"    . ?D)
                                    ("Trivial"  . ?E)
                                    ("High"     . ?F)
                                    ("Medium"   . ?G)
                                    ("Low"      . ?H))
        ejira-todo-states-alist   '(("To Do"       . 1)
                                    ("In Progress" . 2)
                                    ("In Review"   . 3)
                                    ("Done"        . 4)))
  :config
  ;; Tries to auto-set custom fields by looking into /editmeta
  ;; of an issue and an epic.
  (add-hook 'jiralib2-post-login-hook #'ejira-guess-epic-sprint-fields)

  ;; They can also be set manually if autoconfigure is not used.
  ;; (setq ejira-sprint-field       'customfield_10001
  ;;       ejira-epic-field         'customfield_10002
  ;;       ejira-epic-summary-field 'customfield_10004)

  (require 'ejira-agenda)

  ;; Make the issues visisble in your agenda by adding `ejira-org-directory'
  ;; into your `org-agenda-files'.
  (add-to-list 'org-agenda-files ejira-org-directory)

  ;; Add an agenda view to browse the issues that
  (org-add-agenda-custom-command
   '("j" "My JIRA issues"
     ((ejira-jql "resolution = unresolved and assignee = currentUser()"
                 ((org-agenda-overriding-header "Assigned to me")))))))

(provide 'org-jira-init)
