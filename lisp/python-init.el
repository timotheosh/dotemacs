(add-to-list 'load-path (expand-file-name "~/.emacs.d/programs/Pymacs"))
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")

(require 'python)

; Our main python module
(elpy-enable)

; Use ipython (maybe we can get a REPL?)
(elpy-use-ipython)

; Some hooks
(add-hook 'python-mode-hook
      (lambda ()
        (abbrev-mode 1)                   ;; Use abreviations
        (linum-mode 1)                    ;; Show line numbers
		(lambda ()
		  (setq indent-tabs-mode t)       ;; Indent tabs
		  (setq tab-width (default-value 'tab-width))) ;; Set tab width
		))

(add-hook 'python-mode-hook 'auto-complete-mode) ;; Auto-completion on
(add-hook 'python-mode-hook 'jedi:setup)  ;; Jedi server for auto-completion
(setq jedi:complete-on-dot t)             ;; Jedi complete on dot (.)

;; Indent when I press <RETURN>
(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key (kbd "RET") 'newline-and-indent)))

(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c !") 'python-shell-send-buffer)))

(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c |") 'python-shell-send-region)))
