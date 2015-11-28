;; Initialize EDI mode
(use-package edi-mode
    :init
    (add-to-list 'auto-mode-alist '("\\.edi" . edi-mode))
    (add-to-list 'auto-mode-alist '("\\.x12" . edi-mode))
    (add-hook 'edi-mode-hook '(lambda () (toggle-truncate-lines t))))
