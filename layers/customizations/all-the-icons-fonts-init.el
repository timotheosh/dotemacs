(use-package all-the-icons
  :ensure t)
;; Run the following, only once, or when fonts need to be updated.
;;(all-the-icons-install-fonts)

(use-package all-the-icons-dired
  :load-path "programs/all-the-icons-dired")
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

(use-package all-the-icons-ivy
  :ensure t
  :config
  (all-the-icons-ivy-setup))

(provide 'all-the-icons-fonts-init)
