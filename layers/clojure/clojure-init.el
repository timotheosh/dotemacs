(use-package clojure-mode
  :mode ("\\.clj\\'" . clojure-mode)
  :init
  (require 'clojure-mode-extra-font-locking)
  (require 'ac-cider)
  (eval-after-load 'flycheck '(flycheck-clojure-setup))
  ; (add-hook 'clojure-mode-hook #'paredit-mode)
  (add-hook 'clojure-mode-hook 'smartparens-strict-mode)
  (add-hook 'clojure-mode-hook 'cider-mode)
  (add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
  (add-hook 'cider-mode-hook 'ac-nrepl-setup)
  (add-to-list 'ac-modes 'cider-repl-mode)

  ;; clojure completion
  (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
  (add-hook 'cider-mode-hook 'ac-cider-setup)
  (add-hook 'cider-repl-mode-hook 'ac-cider-setup)
  (eval-after-load "auto-complete"
    '(progn
       (add-to-list 'ac-modes 'cider-mode)
       (add-to-list 'ac-modes 'cider-repl-mode)))

  ;; If you want to trigger auto-complete using TAB in CIDER buffers, add this to
  ;; your configuration file, but note that it is incompatible with (setq
  ;; tab-always-indent 'complete):

  (defun set-auto-complete-as-completion-at-point-function ()
    (setq completion-at-point-functions '(auto-complete)))
  (add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
  (add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function))

;; NOTE: 4clojure is installed.
;; To open a specific problem, use `4clojure-open-question':
;; e.g. "M-x 4clojure-open-question RET 2" opens question 2.

;; To check your answers, use `4clojure-check-answers':
;; e.g. `M-x 4clojure-check-answers`

;; To open the next question (or the first if you’re not in a 4clojure
;; buffer), use `4clojure-next-question'. Similarly,
;; `4clojure-previous-question' opens the previous question.
(provide 'clojure-init)
