;; load slime
(use-package slime
    :init
    (add-to-list 'ac-modes 'lisp-mode)
    (setq slime-contribs '(slime-fancy slime-banner))
    (setq inferior-lisp-program "~/programs/bin/sbcl")
    (setq slime-startup-animation t)
    (setq slime-lisp-implementations
          '((sbcl ("~/programs/bin/sbcl") :coding-system utf-8-unix)
            (clisp ("/usr/bin/clisp"))
            (cmucl ("~/.nix-profile/bin/lisp" "-quiet"))
            (ecl ("~/.nix-profile/bin/ecl" "-q"))
            (abcl ("~/programs/bin/abcl"))))
    (add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
    (add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

    ;(defun my:slime-eval-last-expression()
    ;    (unless (slime-connected-p)
    ;        (save-excursion (slime)))
    ;    (slime-eval-last-expression))
    ;(add-hook 'lisp-mode-hook (lambda ()
    ;    (local-set-key (kbd "C-c C-c") #'my:slime-eval-last-expression)))

    (require 'ac-slime)
    (add-hook 'slime-mode-hook 'set-up-slime-ac)
    (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
    (eval-after-load "auto-complete"
      '(add-to-list 'ac-modes 'slime-repl-mode))
    (slime-setup))
