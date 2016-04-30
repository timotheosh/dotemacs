(use-package racket
  :mode ("\\.rkt\\'" . racket-mode)
  :config
  (add-to-list 'ac-modes 'racket-mode)
  (require 'flymake-racket)
  :init
  (require 'programming-init)
  (dolist (func '(racket-unicode-input-method-enable
                  auto-complete-mode
                  flymake-racket-load
                  my-programming-hooks
                  (lambda ()
                    (define-key racket-mode-map
                      (kbd "C-c r") 'racket-run)
                    (define-key racket-mode-map
                      (kbd "C-c C-c") 'racket-run-and-switch-to-repl)))
                (add-hook 'racket-mode-hook func)))
  (dolist (func '(racket-unicode-input-method-enable)
                (add-hook 'racket-repl-mode-hook func))))
(provide 'racket-init)
