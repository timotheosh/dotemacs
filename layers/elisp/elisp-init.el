(use-package emacs-lisp-mode
  :mode ("\\.el\\'" . emacs-lisp-mode)
  :init
  (require 'programming-init)
  (dolist (func '(my-programming-hooks
                  eldoc-mode
                  flyspell-prog-mode))
    (add-hook 'emacs-lisp-mode-hook func)))
(provide 'elisp-init)
