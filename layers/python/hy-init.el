;; Hy mode
;;
;; You can get an hy repl by typing in M-x inferior-lisp while in a hy
;; buffer. Needs some work to send buffer to the repl, and only open a
;; new repl if one does not already exist for the active hy buffer.
(use-package hy-mode
  :ensure t
  :mode ("\\.hy\\'" . hy-mode)
  :config
  (require 'programming-init)
  (setq hy-mode-inferior-lisp-command "hy")
  :init
  ;; Add smartparens-strict-mode
  (dolist (func '(my-programming-hooks
                  smartparens-strict-mode
                  rainbow-delimiters-mode))
    (add-hook 'hy-mode-hook func))
  (use-package parinfer
    :ensure t
    :init
    (add-hook 'racket-mode-hook 'parinfer-mode)
    (add-hook 'racket-repl-mode-hook 'parinfer-mode)))
(provide 'hy-init)
