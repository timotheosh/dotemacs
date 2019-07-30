(use-package cython-mode
  :ensure t
  :mode (("\\.pyx\\'" . cython-mode)
         ("\\.pxd\\'" . cython-mode)
         ("\\.pxi\\'" . cython-mode))
  :init
  (use-package flycheck-cython
    :ensure t
    :config
    (add-hook 'cython-mode-hook 'flycheck-mode)))
(provide 'cython-init)
