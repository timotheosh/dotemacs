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
  ;; Add smartparens-strict-mode
  (dolist (func '(smartparens-strict-mode
                  rainbow-delimiters-mode))
    (add-hook 'hy-mode-hook func))
  (use-package aggressive-indent
    :ensure t
    :init
    (add-hook 'hy-mode-hook 'aggressive-indent-mode)
    (add-hook 'inferior-lisp-mode-hook 'aggressive-indent-mode))
  (define-key hy-mode-map "\C-x\C-e" 'hy-shell-eval-last-sexp)
  (define-key hy-mode-map "\C-c\C-c" 'hy-shell-eval-buffer)
  (use-package python
    :ensure t)
  (use-package virtualenvwrapper
    :ensure t))
(provide 'hy-init)
