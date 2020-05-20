(require 'cc-mode)

(use-package hydra :ensure t)
(use-package lsp-java :ensure t
  :config (add-hook 'java-mode-hook 'lsp))

(use-package dap-mode
  :ensure t :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

(use-package dap-java :after (lsp-java))

(provide 'java-init)
