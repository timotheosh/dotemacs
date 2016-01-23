(use-package python-mode
  :mode ("\\.py\\'" . python-mode)
  :bind (("RET" . newline-and-indent)
         ("C-c !" . python-shell-send-buffer)
         ("C-c |" . python-shell-send-buffer))
  :config
  (add-to-list 'ac-modes 'python-mode)
  :init
  (require 'programming-init)
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/programs/Pymacs"))
  (require 'pymacs)
  (require 'python)
  (pymacs-load "ropemacs" "rope-")

  ; Our main python module
  (elpy-enable)

  ; Use ipython (maybe we can get a REPL?)
  (elpy-use-ipython)
  (setq jedi:complete-on-dot t)             ;; Jedi complete on dot (.)

  (dolist (func '(my-programming-hooks
                  jedi:setup))              ;; Jedi server for auto-completion
    (add-hook 'python-mode-hook func)))
(provide 'python-init)
