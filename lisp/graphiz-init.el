;; Graphiz DOT mode
(use-package graphiz-dot-mode-autoloads
  :init
  (add-hook 'graphiz-dot-mode-hook
            (local-set-key (kbd "C-c C-p") 'graphiz-dot-preview))
