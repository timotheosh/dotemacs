(use-package sr-speedbar
  :ensure sr-speedbar
  :bind (([f10] . sr-speedbar-toggle)
         ([M-f10] . projectile-speedbar-open-current-buffer-in-tree))
  :config
  (use-package projectile-speedbar
    :ensure t)
  (setq sr-speedbar-right-side nil))
(provide 'sr-speedbar-init)
