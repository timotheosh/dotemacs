(use-package racket
  :ensure racket-mode
  :mode ("\\.rkt$" . racket-mode)
  :bind (("C-c C-q m" . quack-view-manual)
         ("C-c C-q k" . quack-view-keyword-docs)
         ("C-c C-q s" . quack-view-srfi)
         ("C-c C-q t" . quack-tidy-buffer))
  :init
  (use-package flymake-racket
    :ensure t
    :config
    (add-hook 'scheme-mode-hook 'flymake-racket-load))
  (use-package dr-racket-like-unicode
    :ensure dr-racket-like-unicode)
  (use-package quack
    :ensure t)
  (require 'programming-init)
  (add-hook 'racket-mode-hook 'smartparens-strict-mode)

  (add-to-list 'ac-modes 'racket-mode)
  (add-hook 'racket-mode-hook 'auto-complete-mode)
  (add-hook 'racket-mode-hook 'flymake-racket-load)
  (add-hook 'racket-mode-hook 'my-programming-hooks)
  (add-hook 'racket-mode-hook
            (lambda ()
              (define-key racket-mode-map
                (kbd "C-c r") 'racket-run)
              (define-key racket-mode-map
                (kbd "C-c C-c") 'racket-run-and-switch-to-repl)))
  (add-hook 'racket-repl-mode-hook 'dr-racket-like-unicode-mode)
  (use-package aggressive-indent
    :ensure t
    :init
    (add-hook 'racket-mode-hook 'aggressive-indent-mode)
    (add-hook 'racket-repl-mode-hook 'aggressive-indent-mode)))
(provide 'racket-init)
