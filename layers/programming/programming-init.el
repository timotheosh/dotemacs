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
    :bind (("C->" . sp-forward-slurp-sexp)
           ("C-<" . sp-forward-barf-sexp))
    :config
    (progn
      (show-smartparens-global-mode t)))

(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
(add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)

(provide 'programming-init)
