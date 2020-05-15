(use-package fortune
  :config
  (setq fortune-dir "/usr/share/games/fortunes")
  (setq fortune-file "/usr/share/games/fortunes/computers")
  (defun my/fortune()
    (fortune)))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-navigator t)
  (setq dashboard-set-init-info t)

  (setq show-week-agenda-p t)

  (setq dashboard-footer-messages (list (fortune-to-signature)))
  (setq dashboard-items '((agenda . 5)
                          (projects . 5)
                          (recents  . 5)
                          (bookmarks . 5)
                          (registers . 5)))

  (defun dashboard-random-footer ()
    "Overrides original dashboard function to use Emacs fortune, instead."
    (fortune-to-signature)))

(provide 'dashboard-init)
