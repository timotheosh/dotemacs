(use-package cobol-mode
  :ensure t
  :mode (("\\.cob\\'" . cobol-mode)
         ("\\.cobol\\'" . cobol-mode))
  :bind (("RET" . newline-and-indent)))
(provide 'cobol-init)
