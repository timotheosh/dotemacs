;; Setup language server mode
(use-package lsp-mode
  :ensure t
  :hook (lsp-mode . lsp-enable-which-key-integration)
  :commands (lsp lsp-deferred))
;; optionally
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)
(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs
  :ensure t
  :commands lsp-treemacs-errors-list)
;;(use-package company-lsp
;;  :ensure t
;;  :commands company-lsp)
;; optionally if you want to use debugger
(add-to-list 'company-backends 'company-lsp)
(use-package dap-mode
  :ensure t)
(provide 'lsp-init)
