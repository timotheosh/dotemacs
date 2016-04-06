;; Add hooks to the major-mode this is called from.
;; Should be just major-modes for programming.

;; Ad this hook for all programming languages.
(defun my-programming-hooks ()
  (linum-mode 1)
  (setq-default indent-tabs-mode nil) ;; Spaces, not tabs!
  (setq tab-width (default-value 'tab-width))
  (when (derived-mode-p 'c-mode 'c++-mode 'java)
    (ggtags-mode 1))
  (column-marker-1 80)
  (column-enforce-mode 1))

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
    :config
    (progn
      (show-smartparens-global-mode t)))

(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
(add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)

(provide 'programming-init)
