(use-package racket
  :ensure racket-mode
  :mode ("\\.rkt$" . racket-mode)
  :config
  (add-to-list 'ac-modes 'racket-mode)
  (use-package flymake-racket
    :ensure t)
  (use-package dr-racket-like-unicode
    :ensure dr-racket-like-unicode)
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
                (dr-racket-like-unicode-mode)
                (add-hook 'racket-repl-mode-hook func))))
(provide 'racket-init)
