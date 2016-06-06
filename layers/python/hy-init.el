;; Hy mode
(use-package hy-mode
  :mode ("\\.hy\\'" . hy-mode)
  :config
  (require 'programming-init)
  :init
  ;; Add smartparens-strict-mode
  (dolist (func '(my-programming-hooks
                  smartparens-strict-mode
                  rainbow-delimiters-mode))
    (add-hook 'hy-mode-hook func)))
(provide 'hy-init)
