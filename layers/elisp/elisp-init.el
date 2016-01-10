(use-package emacs-lisp-mode
  :mode ("\\.el\\'" . emacs-lisp-mode)
  :config
  (require 'auto-complete)
  (add-to-list 'ac-modes 'emacs-lisp-mode)
  :init
  (require 'programming-init)
  (dolist (func '(my-programming-hooks
                  auto-complete-mode
                  eldoc-mode
                  flyspell-prog-mode))
    (add-hook 'emacs-lisp-mode-hook func)))
(provide 'elisp-init)
