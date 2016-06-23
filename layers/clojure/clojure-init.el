(use-package clojure-mode
  :mode ("\\.clj\\'" . clojure-mode)
  :init
  (use-package programming-init
    :init
    (require 'smartparens))
  (add-hook 'clojure-mode-hook 'my-programming-hooks)
  (require 'clojure-mode-extra-font-locking)
  (require 'ac-cider)
  (require 'rainbow-delimiters)
  (eval-after-load 'flycheck '(flycheck-clojure-setup))
  (add-hook 'clojure-mode-hook 'cider-mode)

  ;; This is useful for working with camel-case tokens, like names of
  ;; Java classes (e.g. JavaClassName)
  (add-hook 'clojure-mode-hook 'subword-mode)

  ;; A little more syntax highlighting
  (require 'clojure-mode-extra-font-locking)

  (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

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
              (define-clojure-indent (facts 1))))

  ;; clojure completion
  (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
  (add-hook 'cider-mode-hook 'ac-cider-setup)
  (add-hook 'cider-repl-mode-hook 'ac-cider-setup)
  (eval-after-load "auto-complete"
    '(progn
       (add-to-list 'ac-modes 'cider-mode)
       (add-to-list 'ac-modes 'cider-repl-mode)))


  (if (string= system-type "cygwin")
      (setq cider-lein-command "~/bin/lein"))

  ;; If you want to trigger auto-complete using TAB in CIDER buffers, add this to
  ;; your configuration file, but note that it is incompatible with (setq
  ;; tab-always-indent 'complete):

  (defun set-auto-complete-as-completion-at-point-function ()
    (setq completion-at-point-functions '(auto-complete)))
  (add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
  (add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)

  (add-hook 'cider-repl-mode-hook 'smartparens-strict-mode))
;; NOTE: 4clojure is installed.
;; To open a specific problem, use `4clojure-open-question':
;; e.g. "M-x 4clojure-open-question RET 2" opens question 2.

;; To check your answers, use `4clojure-check-answers':
;; e.g. `M-x 4clojure-check-answers`

;; To open the next question (or the first if you’re not in a 4clojure
;; buffer), use `4clojure-next-question'. Similarly,
;; `4clojure-previous-question' opens the previous question.
(provide 'clojure-init)
