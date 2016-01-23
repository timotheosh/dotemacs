(use-package racket
  :mode (("\\.rkt\\'" . racket-mode)
         ("\\.scm\\'" . racket-mode))
  :config
  (defalias 'scheme-mode 'racket-mode)
  (add-to-list 'ac-modes 'scheme-mode)
  (add-to-list 'ac-modes 'racket-mode)
  (require 'flymake-racket)
  (dolist (func '(racket-unicode-input-method-enable
                  auto-complete-mode
                  flymake-racket-load
                   (lambda ()
                     (define-key racket-mode-map
                       (kbd "C-c r") 'racket-run)
                     (define-key racket-mode-map
                       (kbd "C-c C-c") 'racket-run-and-switch-to-repl)))
                (add-hook 'racket-mode-hook func)))

  (add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable))
(provide 'racket-init)
