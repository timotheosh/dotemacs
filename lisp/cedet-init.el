;; Enable EDE (Project Management) features
(load-file "~/.emacs.d/programs/cedet/cedet-devel-load.el")
(global-ede-mode 1)
(semantic-load-enable-excessive-code-helpers)      ; Enable prototype help and smart completion 
;;(global-srecode-minor-mode 1)            ; Enable template insertion menu

;; Semantic
(global-semantic-idle-scheduler-mode)
(global-semantic-idle-completions-mode)
(global-semantic-decoration-mode)
(global-semantic-highlight-func-mode)
(global-semantic-show-unmatched-syntax-mode)

(when (cedet-gnu-global-version-check t)
  (semanticdb-enable-gnu-global-databases 'c-mode)
  (semanticdb-enable-gnu-global-databases 'c++-mode)
  (semanticdb-enable-gnu-global-databases 'objc-mode)
  (semanticdb-enable-gnu-global-databases 'lisp-mode))

;; Remove semantic from C/C++ and objective-c to make room for the much faster
;; irony-mode
;(add-to-list 'semantic-inhibit-functions
;  (lambda () (member major-mode '(c-mode c++-mode objc-mode))))
