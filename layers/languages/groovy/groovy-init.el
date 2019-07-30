(use-package groovy-mode
  :mode (("\\.groovy\\'" . groovy-mode)
         ("Jenkinsfile" . groovy-mode)
         ("\\.jenkinsfile\\'" . groovy-mode))
  :ensure t)
(provide 'groovy-init)
