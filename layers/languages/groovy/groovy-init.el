(use-package groovy-mode
  :mode (("\\.groovy\\'" . groovy-mode)
         ("Jenkinsfile" . groovy-mode)
         ("\\.jenkinsfile\\'" . groovy-mode))
  :ensure t
  :config
  (setq groovy-indent-offset 2))
(provide 'groovy-init)
