;; Setup language server mode
(use-package lsp-mode
  :ensure t
  :pin melpa
  :commands (lsp))
;; optionally
(use-package lsp-ui
  :ensure t)
(use-package company-lsp
  :ensure t
  :commands company-lsp)
(use-package helm-lsp
  :ensure t
  :commands helm-lsp-workspace-symbol)
(use-package lsp-treemacs
  :ensure t
  :commands lsp-treemacs-errors-list)
;; optionally if you want to use debugger
(add-to-list 'company-backends 'company-lsp)
(use-package dap-mode
  :ensure t)
(provide 'lsp-init)
