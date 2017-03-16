(use-package projectile
  :defer t
  :config
  (use-package perspective
    :ensure t
    :init
    (persp-mode)
    (use-package persp-projectile
      :ensure t))
  :init
  (projectile-global-mode)
  (setq projectile-enable-caching t))
(provide 'projectile-init)
