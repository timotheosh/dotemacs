(use-package clojure-mode
  :ensure t
  :mode (("\\.clj\\'" . clojure-mode)
         ("\\.cljs\\'" . clojurescript-mode)
         ("\\.hl\\'" . clojurescript-mode))
  :init
  (use-package programming-init
    :init
    (require 'smartparens))
  (add-hook 'clojure-mode-hook 'my-programming-hooks)

  (use-package clj-refactor
    :ensure t)

  (defun my/clojure-hook ()
    (clj-refactor-mode 1)
    (cljr-add-keybindings-with-prefix "C-c C-m"))
  (add-hook 'clojure-mode-hook #'my/clojure-hook)

  ;; This keeps throwing errors.
  ;;(use-package cljdoc
  ;;  :ensure t)

  ;; A little more syntax highlighting
  (use-package clojure-mode-extra-font-locking
    :ensure t)

  (use-package rainbow-delimiters
    :ensure t
    :config
    (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode))

  ;; This is useful for working with camel-case tokens, like names of
  ;; Java classes (e.g. JavaClassName)
  (add-hook 'clojure-mode-hook 'subword-mode)

  ;; syntax hilighting for midje
  (add-hook 'clojure-mode-hook
            (lambda ()
              (setq inferior-lisp-program "lein repl")
              (font-lock-add-keywords
               nil
               '(("(\\(facts?\\)"
                  (1 font-lock-keyword-face))
                 ("(\\(background?\\)"
                  (1 font-lock-keyword-face))))
              (define-clojure-indent (fact 1))
              (define-clojure-indent (facts 1))
              (company-mode)))

  (use-package cider
    :ensure t
    :config
    ;; Path to lein for Cider-mode
    (setq cider-lein-command (format "%s/bin/lein" (getenv "HOME")))
    (if (string= system-type "cygwin")
        (setq cider-lein-command "~/bin/lein"))
    (add-hook 'cider-repl-mode-hook #'company-mode)
    (add-hook 'cider-mode-hook #'company-mode)
    (add-hook 'cider-mode-hook #'flycheck-clojure-setup)
    (add-hook 'clojure-mode-hook 'cider-mode)
    ;; For figwheel clojurescript projects
    ;;   To set the clojurescript repo back to default, run:
    (setq cider-cljs-lein-repl
          "(cemerick.piggieback/cljs-repl (cljs.repl.rhino/repl-env))")
    ;; or change with M-x customize-variable <ENTER> cider-cljs-lein-repl
    ;;(setq cider-cljs-lein-repl
    ;;      "(do (require 'figwheel-sidecar.repl-api)
    ;;         (figwheel-sidecar.repl-api/start-figwheel!)
    ;;         (figwheel-sidecar.repl-api/cljs-repl))"))
    )

  ;; If you want to trigger auto-complete using TAB in CIDER buffers, add this to
  ;; your configuration file, but note that it is incompatible with (setq
  ;; tab-always-indent 'complete):
  (add-hook 'clojure-mode-hook 'smartparens-strict-mode))

(use-package flycheck-clojure
  :ensure t)
(add-hook 'clojure-mode-hook 'flycheck-mode)



(use-package 4clojure
  :ensure t
  :config
  ;; NOTE: 4clojure is installed.
  ;; To open a specific problem, use `4clojure-open-question':
  ;; e.g. "M-x 4clojure-open-question RET 2" opens question 2.

  ;; To check your answers, use `4clojure-check-answers':
  ;; e.g. `M-x 4clojure-check-answers`

  ;; To open the next question (or the first if you’re not in a 4clojure
  ;; buffer), use `4clojure-next-question'. Similarly,
  ;; `4clojure-previous-question' opens the previous question.
  )
(provide 'clojure-init)
