;; NOTE: This is NOT compatible with cider. Cider does not support the
;; new socket based repl available in Clojure 1.8. So we use this for
;; when we need it.

(use-package inf-clojure
  :ensure t
  :config
  (defun my/lumo ()
    (when (bound-and-true-p cider-mode)
      (cider-mode -1))
    (setq inf-clojure-program     "lumo -d"
          inf-clojure-generic-cmd "lumo -d"
          inf-clojure-lein-cmd    "lumo -d"))
  (add-hook 'inf-clojure-mode-hook 'my/lumo))
(provide 'inf-clojure-init)
