;; Initialize yasnippet
(use-package yasnippet
  :ensure yasnippet
  :config
  (require 'yasnippet)
  (setq yas-snippet-dirs
        (list (concat user-emacs-directory "yasnippets/snippets") ;; My personal snippets
              (concat user-emacs-directory "yasnippets/yasnippet-snippets") ;; Andrea Crotti's snippets
              (concat user-emacs-directory "yasnippets/yasnippet-licenses")   ;; Atkinson's license snippets
              ))
  (yas-global-mode 1))
(provide 'yasnippet-init)
