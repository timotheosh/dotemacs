(use-package yaml-mode
  :mode ("\\.yml\\'" . yaml-mode)
  :ensure t
  :config
  (add-hook 'yaml-mode-hook
            '(lambda ()
               (define-key yaml-mode-map "\C-m" 'newline-and-indent))))
(provide 'yaml-init)
