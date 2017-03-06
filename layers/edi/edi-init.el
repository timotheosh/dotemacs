;; Initialize EDI mode
(use-package edi-mode
  :load-path "programs/edi-mode/"
  :mode (("\\.edi\\'" . edi-mode)
         ("\\.x12\\'" . edi-mode))
  :init
  (add-hook 'edi-mode-hook '(lambda () (toggle-truncate-lines t))))
(provide 'edi-init)
