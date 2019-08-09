;; Add hooks to the major-mode this is called from.
;; Should be just major-modes for programming.

;;;;;; PART 1: Third Party Packages ;;;;;;;

;; Enforce column length.
;; https://github.com/jordonbiondo/column-enforce-mode/
(use-package column-enforce-mode
  :ensure t
  :hook prog-mode)

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

;;;;;; PART 2: Custom hooks and functions ;;;;;;;

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
  (local-set-key (kbd "<backtab>") 'my/match-paren)
  (use-package origami
    :ensure t
    :bind (("C-<tab>" . origami-recursively-toggle-node)
           ("C-<iso-lefttab>" . origami-toggle-all-nodes))
    :init
    (global-origami-mode 1)))

(add-hook 'prog-mode-hook 'my/programming-hooks)

(defun my/lisp-hook ()
  (smartparens-mode 1)
  (smartparens-strict-mode 1)

  (require 'flycheck-lib)

  (require 'aggressive-indent-lib))

(defun my/lisp-init ()
  (interactive)
  (require 'smartparens-lib)
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

(provide 'programming-init)
