;; NOTE: This is NOT compatible with cider. Cider does not support the
;; new socket based repl available in Clojure 1.8. So we use this for
;; when we need it.

(use-package inf-clojure
  :ensure t
  :defer t
  :config
  (cider-mode -1)
  (setq inf-clojure-generic-cmd "lumo -d"))
(provide 'inf-clojure-init)
