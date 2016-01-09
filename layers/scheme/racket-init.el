(use-package racket
  :mode (("\\.rkt\\'" . racket-mode)
         ("\\.scm\\'" . racket-mode))
  :config
  (add-hook 'racket-mode-hook
            (lambda ()
              (define-key racket-mode-map (kbd "C-c r") 'racket-run)))
  (add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
  (add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)
  (add-hook 'racket-mode
            (lambda ()
              (define-key racket-mode-map (kbd "C-c C-c") 'racket-run-and-switch-to-repl)))
  (require 'flymake-racket)
  (add-hook 'racket-mode-hook 'flymake-racket-load))
(provide 'racket-init)
