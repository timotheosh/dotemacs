(use-package emacs-lisp-mode
  :mode ("\\.el\\'" . emacs-lisp-mode)
  :init
  (require 'programming-init)
  (add-hook 'emacs-lisp-mode-hook 'auto-complete-mode)
  (use-package parinfer
    :ensure t)
  (dolist (func '(my-programming-hooks
                  eldoc-mode
                  flyspell-prog-mode
                  smartparens-strict-mode
                  parinfer-mode))
    (add-hook 'emacs-lisp-mode-hook func)))
(provide 'elisp-init)
