;; load slime
(use-package slime
    :init
    (add-to-list 'ac-modes 'lisp-mode)
    (setq slime-contribs '(slime-fancy))
    (setq inferior-lisp-program (expand-file-name "/home/thawes/programs/bin/sbcl"))
    (add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
    (add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

    (require 'ac-slime)
    (add-hook 'slime-mode-hook 'set-up-slime-ac)
    (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
    (eval-after-load "auto-complete"
      '(add-to-list 'ac-modes 'slime-repl-mode))
    (slime-setup)
    (slime))
