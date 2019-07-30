;; NOTE: This is NOT compatible with cider. Cider does not support the
;; new socket based repl available in Clojure 1.8. So we use this for
;; when we need it.

(use-package inf-clojure
  :ensure t
  :config
  (defun my/planck ()
    (when (bound-and-true-p cider-mode)
      (cider-mode -1))
    (setq inf-clojure-program     "planck -d"
          inf-clojure-generic-cmd "planck -d"
          inf-clojure-lein-cmd    "planck -d"
          inf-clojure-boot-cmd    "planck -d"))
  (add-hook 'inf-clojure-mode-hook 'my/planck)
  (add-hook 'inf-clojure-minor-mode-hook 'my/planck))
(provide 'inf-clojure-init)
