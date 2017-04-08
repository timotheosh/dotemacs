;; load slime
(use-package lisp-mode
    :mode (("\\.lisp\\'" . lisp-mode)
           ("\\.ros\\'" . lisp-mode)
           ("\\.lsp\\'" . lisp-mode))
    :init
    (require 'programming-init)
    (add-hook 'lisp-mode-hook 'smartparens-strict-mode)

    ;; Load roswell
    (load (expand-file-name "~/.roswell/helper.el"))

    (setq slime-contribs '(slime-fancy slime-banner))
    (setq inferior-lisp-program "~/programs/bin/ros -Q run")
    (setq slime-startup-animation t)
    (setq slime-lisp-implementations
          '((sbcl ("~/programs/bin/ros" "-L" "sbcl" "-Q" "run") :coding-system utf-8-unix)
            (clisp ("~/programs/bin/ros" "-L" "clisp" "-Q" "run"))
            (clozure-cl ("~/programs/bin/ros" "-L" "ccl-bin" "-Q" "run"))
            (cmucl ("~/programs/bin/ros" "-L" "cmu-bin" "-Q" "run"))
            (ecl ("~/programs/bin/ros" "-L" "ecl" "-Q" "run") :coding-system utf-8-unix)
            (abcl ("~/programs/bin/ros" "-L" "abcl-bin" "-Q" "run"))))

    (require 'programming-init)
    (use-package ac-slime
      :ensure t
      :init
      (add-to-list 'ac-modes 'slime-repl-mode))
    (use-package slime
      :ensure t
      :init
      (slime-setup))
    ;; Some hooks
    (add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
    (add-hook 'slime-mode-hook 'set-up-slime-ac)
    (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
    (add-hook 'slime-repl-mode-hook 'auto-complete-mode)
    (add-hook 'lisp-mode-hook 'my-programming-hooks)
    (add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
    (add-hook 'lisp-mode-hook 'auto-complete-mode)

    (use-package aggressive-indent
      :ensure t
      :init
      (add-hook 'lisp-mode-hook 'aggressive-indent-mode))

    ;; Hyperspec lookup
    ;; open CL REPL and execute: (ql:quickload "clhs")
    ;; Then follow instructions.
    (load "/home/thawes/.roswell/lisp/quicklisp/clhs-use-local.el" t))
(provide 'lisp-init)
