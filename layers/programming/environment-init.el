;; Setting up some Environment variables
(use-package exec-path-from-shell
  :ensure exec-path-from-shell
  :init
  (exec-path-from-shell-copy-env "PATH"))
(provide 'environment-init)
