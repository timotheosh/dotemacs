(use-package python-mode
  :ensure t
  :mode ("\\.py\\'" . python-mode)
  :bind (("RET" . newline-and-indent)
         ("C-c !" . python-shell-send-buffer)
         ("C-c |" . python-shell-send-buffer)
         ("C->" . python-indent-shift-right)
         ("C-<" . python-indent-shift-left))
  :config
  (require 'programming-init)
  (use-package pymacs
    :load-path "programs/Pymacs"
    :diminish ropemacs-mode
    :config (pymacs-load "ropemacs" "rope-")
    :bind (("C-<tab>" . rope-lucky-assist)
           ("M-." . rope-goto-definition)))
  (use-package python
    :ensure t)
  (use-package virtualenvwrapper
    :ensure t)
  (use-package jedi
    :ensure t
    :commands jedi:setup)
  :init
  (use-package elpy
    :ensure t
    :commands elpy-enable)
  (with-eval-after-load 'python (progn
                                  (elpy-enable) ;; Our main python module
                                  (elpy-use-ipython)
                                  (setq elpy-dedicated-shells t)
                                  (setq jedi:complete-on-dot t)))
  (dolist (func '(my-programming-hooks
                  semantic-mode
                  smartparens-mode
                  jedi:setup))          ;; Jedi server for auto-completion
    (add-hook 'python-mode-hook func)))
(provide 'python-init)
