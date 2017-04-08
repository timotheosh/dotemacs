(use-package emacs-lisp-mode
  :mode ("\\.el\\'" . emacs-lisp-mode)
  :init
  (require 'programming-init)
  (add-hook 'emacs-lisp-mode-hook 'auto-complete-mode)
  (use-package aggressive-indent
    :ensure t)
  (dolist (func '(my-programming-hooks
                  eldoc-mode
                  flyspell-prog-mode
                  smartparens-strict-mode
                  aggressive-indent-mode))
    (add-hook 'emacs-lisp-mode-hook func)))
(provide 'elisp-init)
