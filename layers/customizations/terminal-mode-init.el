;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

(defun is-in-terminal()
  (not (display-graphic-p)))

(setq current-t43m3 nil)


(defadvice load-theme (before theme-dont-propagate activate)
  (mapcar #'disable-theme custom-enabled-themes))

(defun enab-theme (theme)
  (if current-t43m3 (disable-theme current-t43m3))
  (setq current-t43m3 theme)
  (load-theme theme t))


(if (is-in-terminal)
    (progn
        (define-key function-key-map "\eOA" [up])
        (define-key function-key-map "\e[A" [up])
        (define-key function-key-map "\eOB" [down])
        (define-key function-key-map "\e[B" [down])
        (define-key function-key-map "\eOC" [right])
        (define-key function-key-map "\e[C" [right])
        (define-key function-key-map "\eOD" [left])
        (define-key function-key-map "\e[D" [left])
        (enab-theme 'tango-dark)))

(provide 'terminal-mode-init)
