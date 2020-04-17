(use-package ranger
  :ensure t)

(add-hook 'dired-mode-hook (lambda ()
                             (setq dired-hide-details-mode t)
                             (setq ranger-override-dired-mode t)))

(provide 'dired-init)
