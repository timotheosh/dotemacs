;; Add hooks to the major-mode this is called from.
;; Should be just major-modes for programming.

(defun my/match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert normally."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

(defun my/programming-hooks ()
  "Hook for all programming modes."

  ;; Line numbers
  (linum-mode 1)

  ;; Highlight active line
  (hl-line-mode 1)

  ;; Spaces and tabs. Spaces by default.
  (setq-default indent-tabs-mode nil)
  (setq tab-width (default-value 'tab-width))

  ;; Key for jumping from begining to end parens and brackets.
  ;; <backtab> is Shift-tab
  (local-set-key (kbd "<backtab>") 'my/match-paren))

(add-hook 'prog-mode-hook 'my/programming-hooks)

;; Enforce column length.
;; https://github.com/jordonbiondo/column-enforce-mode/
(use-package column-enforce-mode
  :ensure t
  :hook prog-mode)

;; agressive-indent
;; https://github.com/Malabarba/aggressive-indent-mode
(use-package aggressive-indent
  :ensure t
  :hook prog-mode)

;; origami for text folding
;; https://github.com/gregsexton/origami.el
(use-package origami
  :ensure t
  :bind (("C-<tab>" . origami-recursively-toggle-node)
         ("C-<iso-lefttab>" . origami-toggle-all-nodes))
  :hook prog-mode)

(defun my/tabs-matter ()
  "Allows tabs for modes that need them."
  (setq-default indent-tabs-mode nil))

(defun my/return-key ()
  "Return as usual, and then insert the comment-prefix."
  (interactive)
  (newline)
  (let (curpos (incomment nil))
    (save-excursion
      (forward-line -1)
      (goto-char (line-beginning-position))
      (if (or (looking-at comment-prefix-start)
              (looking-at comment-prefix-continue))
          (setq incomment t)))
    (if incomment
        (insert comment-prefix-continue))))

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


(use-package smartparens-config
  :ensure smartparens
  :hook prog-mode
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
                      (t (not (sp-point-in-string-or-comment))))))))

;; emacs-refactor
;; emr is for refactoring lisp, elisp, scheme, ruby, javascript, and c
;; https://github.com/emacsmirror/emr
;; emr package is broken in melpa-stable
(use-package emr
  :ensure t
  :pin melpa
  :hook ((emr-mode . lisp-mode)
         (emr-mode . scheme-mode)
         (emr-mode . elisp-mode)
         (emr-mode . ruby-mode)
         (emr-mode . javascript-mode)
         (emr-mode . c-mode))
  :config
  (autoload 'emr-show-refactor-menu "emr")
  (define-key prog-mode-map (kbd "M-RET") 'emr-show-refactor-menu)
  (eval-after-load "emr" '(emr-initialize)))

(use-package flycheck
  :ensure t
  :hook prog-mode
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

;; wgrep allows you to edit a grep buffer and apply those changes to
;; the file buffer.
;; https://github.com/mhayashi1120/Emacs-wgrep
(use-package wgrep
  :ensure t
  :config
  (use-package wgrep-ag
    :ensure t
    :hook wgrep-mode
    :config
    (autoload 'wgrep-ag-setup "wgrep-ag")
    (add-hook 'ag-mode-hook 'wgrep-ag-setup)))

;; iedit Edit multiple regions in the same way.
;; https://github.com/victorhge/iedit
(use-package iedit
  :ensure t
  :bind (("C-;" . iedit-mode)))
(provide 'programming-init)
