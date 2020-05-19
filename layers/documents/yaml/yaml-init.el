(use-package yaml-mode
  :mode ("\\.yml\\'" . yaml-mode)
  :ensure t
  :config
  (add-hook 'yaml-mode-hook
            '(lambda ()
               (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
  ;; For Yaml server run npm install -g yaml-language-server
  (add-hook 'yaml-mode-hook 'lsp-mode))
(provide 'yaml-init)
