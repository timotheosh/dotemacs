;; Add hooks to the major-mode this is called from.
;; Should be just major-modes for programming.

;; Ad this hook for all programming languages.
(defun my-programming-hooks ()
  (linum-mode 1)
  (setq-default indent-tabs-mode nil) ;; Spaces, not tabs!
  (setq tab-width (default-value 'tab-width))
  (when (derived-mode-p 'java)
    (ggtags-mode 1))
  (use-package column-marker
    :ensure t
    :config
    (column-marker-1 80))
  (use-package column-enforce-mode
    :ensure t
    :config
    (column-enforce-mode 1))
  (use-package aggressive-indent
    :ensure t
    :init
    (global-aggressive-indent-mode 1))
  (use-package origami
    :ensure t
    :bind ("C-<tab>" . origami-recursively-toggle-node)
    :init
    (global-origami-mode 1)))

;; Key for jumping from begining to end parens and brackets.
;; <backtab> is Shift-tab
(global-set-key (kbd "<backtab>") 'match-paren)

(defun my/create-newline-format (&rest _ignored)
  ;; Usage: (sp-local-pair '(c-mode)
  ;;                       "{" nil :post-handlers
  ;;                       '((my/create-newline-format "RET")))
  (interactive)
  (progn
    (newline)
    (indent-according-to-mode)
    (previous-line)
    (indent-according-to-mode)))

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert normally."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

(use-package smartparens-config
  :ensure smartparens
  :bind (:map smartparens-mode-map
              ("C-M-a" . sp-beginning-of-sexp)
              ("C-M-e" . sp-end-of-sexp)

              ;;("C-<down>" . sp-down-sexp) ;; Conflicts with REPL bindings
              ;;("C-<up>"   . sp-up-sexp)   ;; Conflicts with REPL bindings
              ("M-<down>" . sp-backward-down-sexp)
              ("M-<up>"   . sp-backward-up-sexp)

              ("C-M-f" . sp-forward-sexp)
              ("C-M-b" . sp-backward-sexp)

              ("C-M-n" . sp-next-sexp)
              ("C-M-p" . sp-previous-sexp)

              ("C-S-f" . sp-forward-symbol)
              ("C-S-b" . sp-backward-symbol)

              ("C-<right>" . sp-forward-slurp-sexp)
              ("M-<right>" . sp-forward-barf-sexp)
              ("C-<left>"  . sp-backward-slurp-sexp)
              ("M-<left>"  . sp-backward-barf-sexp)

              ("C-M-t" . sp-transpose-sexp)
              ("C-M-k" . sp-kill-sexp)
              ("C-k"   . sp-kill-hybrid-sexp)
              ("M-k"   . sp-backward-kill-sexp)
              ("C-M-w" . sp-copy-sexp)

              ("C-M-d" . delete-sexp)

              ("M-<backspace>" . backward-kill-word)
              ("C-<backspace>" . sp-backward-kill-word)
              ([remap sp-backward-kill-word] . backward-kill-word)

              ("M-[" . sp-backward-unwrap-sexp)
              ("M-]" . sp-unwrap-sexp)

              ("C-x C-t" . sp-transpose-hybrid-sexp)

              ("C-c ("  . wrap-with-parens)
              ("C-c ["  . wrap-with-brackets)
              ("C-c {"  . wrap-with-braces)
              ("C-c '"  . wrap-with-single-quotes)
              ("C-c \"" . wrap-with-double-quotes)
              ("C-c _"  . wrap-with-underscores)
              ("C-c `"  . wrap-with-back-quotes))
  :init
  (show-smartparens-global-mode t)
  (sp-with-modes sp--lisp-modes
    ;; disable ', it's the quote character!
    (sp-local-pair "'" nil :actions nil)
    ;; also only use the pseudo-quote inside strings where it serve as
    ;; hyperlink.
    (sp-local-pair "`" "'" :when '(sp-in-string-p sp-in-comment-p))
    (sp-local-pair "`" nil
                   :skip-match
                   (lambda (ms mb me)
                     (cond
                      ((equal ms "'")
                       (or (sp--org-skip-markup ms mb me)
                           (not (sp-point-in-string-or-comment))))
                      (t (not (sp-point-in-string-or-comment)))))))
  ;; emr package is broken in melpa
  ;;(use-package emr
  ;;  ;; emr is for refactoring lisp, elisp, scheme, ruby, javascript, and c
  ;;  :ensure t
  ;;  :config
  ;;  (autoload 'emr-show-refactor-menu "emr")
  ;;  (define-key prog-mode-map (kbd "M-RET") 'emr-show-refactor-menu)
  ;;  (eval-after-load "emr" '(emr-initialize)))
  )
(use-package flycheck
  :ensure t
  :config
  (define-fringe-bitmap 'flycheck-fringe-bitmap-ball
    (vector #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00111000
            #b01111100
            #b11111110
            #b11111110
            #b01111100
            #b00111000
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00000000))
  (flycheck-define-error-level 'error
    :severity 100
    :compilation-level 2
    :overlay-category 'flycheck-error-overlay
    :fringe-bitmap 'flycheck-fringe-bitmap-ball
    :fringe-face 'flycheck-fringe-error
    :error-list-face 'flycheck-error-list-error))

(use-package wgrep
  :ensure t)
(use-package wgrep-ag
  :ensure t)
(use-package iedit
  :ensure t)
(provide 'programming-init)
