(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/org/anx.org"
                             "~/org/easyfreeunix.org"
							 "~/org/history.org"
							 "~/org/programming.org"
                             "~/org/home.org"))
