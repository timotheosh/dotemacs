;; load slime
(use-package lisp-mode
    :mode (("\\.lisp\\'" . lisp-mode)
           ("\\.ros\\'" . lisp-mode)
           ("\\.lsp\\'" . lisp-mode))
    :init
    (require 'programming-init)
    (require 'ac-slime)
	(add-to-list 'ac-modes 'slime-repl-mode)

    (add-hook 'lisp-mode-hook 'my-programming-hooks)
    (add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
    (setq slime-contribs '(slime-fancy slime-banner))
    (setq inferior-lisp-program "~/programs/bin/sbcl")
    (setq slime-startup-animation t)
    (setq slime-lisp-implementations
          '((sbcl ("~/programs/bin/sbcl") :coding-system utf-8-unix)
            (clisp ("~/programs/bin/ros" "-L" "clisp" "run" "--"))
            (clozure-cl ("~/programs/bin/ros" "-L" "ccl-bin" "run" "--"))
            (cmucl ("~/.nix-profile/bin/lisp" "-quiet"))
            (ecl ("~/programs/bin/ros" "-L" "ecl" "run" "--" "-q" "--"))
            (abcl ("~/programs/bin/abcl"))))

    ;(defun my:slime-eval-last-expression()
    ;    (unless (slime-connected-p)
    ;        (save-excursion (slime)))
    ;    (slime-eval-last-expression))
    ;(add-hook 'lisp-mode-hook (lambda ()
    ;    (local-set-key (kbd "C-c C-c") #'my:slime-eval-last-expression)))

    ; Some hooks
    (add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
    (add-hook 'slime-mode-hook 'set-up-slime-ac)
    (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
    (add-hook 'slime-repl-mode-hook 'auto-complete-mode)
    (add-hook 'lisp-mode-hook 'auto-complete-mode)
    (slime-setup)

    ;; Hyperspec lookup
    ;; open CL REPL and execute: (ql:quickload "clhs")
    ;; Then follow instructions.
    (load "/home/thawes/programs/share/quicklisp/clhs-use-local.el" t))
(provide 'lisp-init)