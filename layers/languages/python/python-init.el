(use-package python-mode
  :ensure t
  :mode ("\\.py\\'" . python-mode)
  :bind (("RET" . newline-and-indent)
         ("C-c !" . python-shell-send-buffer)
         ("C-c |" . python-shell-send-buffer)
         ("C->" . python-indent-shift-right)
         ("C-<" . python-indent-shift-left))
  :config
  (setenv "IPY_TEST_SIMPLE_PROMPT" "1")
  (setenv "JUPYTER_CONSOLE_TEST" "1")
  (setenv "PYLINTRC" (concat (getenv "HOME") "/.pylintrc"))
  (require 'programming-init)
  (use-package pymacs
    :load-path "programs/Pymacs"
    :diminish ropemacs-mode
    :config (pymacs-load "ropemacs" "rope-")
    :bind ( ("M-." . rope-goto-definition)))
  (use-package python
    :ensure t)
  (use-package virtualenvwrapper
    :ensure t
    :config
    (venv-initialize-interactive-shells) ;; if you want interactive shell support
    (venv-initialize-eshell) ;; if you want eshell support
    ;; note that setting `venv-location` is not necessary if you
    ;; use the default location (`~/.virtualenvs`), or if the
    ;; the environment variable `WORKON_HOME` points to the right place
    (setq venv-location "/home/thawes/.virtualenvs/"))
  (use-package jedi
    :ensure t
    :commands jedi:setup)
  :init
  (use-package elpy
    ;; NOTE: Elpy makes use of py-flake. You may have to change
    ;; settings in ~/.config/flake8
    :ensure t
    :commands elpy-enable)

  (defun set-flychecker-executables ()
    "Configure virtualenv for flake8 and lint."
    (when (get-current-buffer-flake8)
      (flycheck-set-checker-executable (quote python-flake8)
                                       (get-current-buffer-flake8)))
    (when (get-current-buffer-pylint)
      (flycheck-set-checker-executable (quote python-pylint)
                                       (get-current-buffer-pylint))))

  (defun my-python-hooks ()
    (linum-mode 1)
    (setq-default indent-tabs-mode nil) ;; Spaces, not tabs!
    (setq tab-width (default-value 'tab-width)))

  (with-eval-after-load 'python (progn
                                  (elpy-enable) ;; Our main python module
                                  (setq python-shell-interpreter "ipython"
                                        python-shell-interpreter-args "-i"
                                        elpy-dedicated-shells t
                                        jedi:complete-on-dot t)))
  (dolist (func '(my-python-hooks
                  flycheck-mode
                  semantic-mode
                  smartparens-mode
                  jedi:setup
                  set-flychecker-executables))          ;; Jedi server for auto-completion
    (add-hook 'python-mode-hook func)))
(provide 'python-init)
