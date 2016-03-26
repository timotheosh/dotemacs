(use-package emacs-lisp-mode
  :mode ("\\.el\\'" . emacs-lisp-mode)
  :init
  (require 'programming-init)
  (add-hook 'emacs-lisp-mode-hook 'auto-complete-mode)
  (dolist (func '(my-programming-hooks
                  eldoc-mode
                  flyspell-prog-mode
                  smartparens-strict-mode))
    (add-hook 'emacs-lisp-mode-hook func)))
(provide 'elisp-init)
