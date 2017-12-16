;; Enable EDE (Project Management) features

(defun cedet-init-loader ()
  "Initializes cedet"
  (if (not (featurep 'cedet))
      (load-library "~/.emacs.d/programs/cedet/cedet-devel-load"))
  ;(global-ede-mode 1)
  (semantic-load-enable-excessive-code-helpers)      ; Enable prototype help and smart completion
  ;;(global-srecode-minor-mode 1)            ; Enable template insertion menu

  ;; Semantic
  (global-semantic-idle-scheduler-mode)
  (global-semantic-idle-completions-mode)
  (global-semantic-decoration-mode)
  (global-semantic-highlight-func-mode)

  (when (cedet-gnu-global-version-check t)
    (semanticdb-enable-gnu-global-databases 'c-mode)
    (semanticdb-enable-gnu-global-databases 'c++-mode)
    (semanticdb-enable-gnu-global-databases 'objc-mode)
    (semanticdb-enable-gnu-global-databases 'lisp-mode)))
(cedet-init-loader)
(provide 'cedet-init)
