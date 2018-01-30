(use-package sr-speedbar
  :ensure sr-speedbar
  :bind (([f10] . sr-speedbar-toggle))
  :config
  (use-package projectile-speedbar
    :ensure t
    :bind (([M-f10] . projectile-speedbar-open-current-buffer-in-tree)))
  (setq sr-speedbar-right-side nil))
(provide 'sr-speedbar-init)
