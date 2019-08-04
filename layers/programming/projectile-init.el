(use-package projectile
  :defer t
  :config
  (use-package perspective
    :ensure t
    :pin melpa
    :init
    (persp-mode)
    (use-package persp-projectile
      :ensure t
      :pin melpa
      :init
      (define-key projectile-mode-map (kbd "s-s") 'projectile-persp-switch-project)))
  :init
  (setq projectile-completion-system 'ivy)
  (projectile-global-mode)
  (setq projectile-enable-caching t))
(provide 'projectile-init)
