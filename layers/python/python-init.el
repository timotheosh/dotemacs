(use-package python-mode
  :ensure t
  :mode ("\\.py\\'" . python-mode)
  :bind (("RET" . newline-and-indent)
         ("C-c !" . python-shell-send-buffer)
         ("C-c |" . python-shell-send-buffer))
  :config
  (require 'programming-init)
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/programs/Pymacs"))
  (use-package pymacs
    :ensure t)
  (use-package python
    :ensure t)
  (use-package virtualenvwrapper
    :ensure t)
  (pymacs-load "ropemacs" "rope-")
  :init
  (with-eval-after-load 'python (progn
                                  (elpy-enable) ;; Our main python module
                                  (elpy-use-ipython)
                                  (setq jedi:complete-on-dot t)))
  (dolist (func '(my-programming-hooks
                  semantic-mode
                  jedi:setup))          ;; Jedi server for auto-completion
    (add-hook 'python-mode-hook func)))
(provide 'python-init)
