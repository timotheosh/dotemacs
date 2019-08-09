(use-package emacs-lisp-mode
  :mode ("\\.el\\'" . emacs-lisp-mode)
  :init
  (require 'programming-init)
  (add-to-list 'company-backends 'company-elisp)
  (add-hook 'emacs-lisp-mode-hook 'company-mode)
  (use-package aggressive-indent
    :ensure t)
  (dolist (func '(eldoc-mode
                  flyspell-prog-mode
                  smartparens-strict-mode
                  aggressive-indent-mode))
    (add-hook 'emacs-lisp-mode-hook func)))
(provide 'elisp-init)
