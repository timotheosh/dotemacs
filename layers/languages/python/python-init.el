(use-package python-mode
  :ensure t
  :pin melpa
  :mode ("\\.py\\'" . python-mode)
  :bind (("RET" . newline-and-indent)
         ("C-c !" . python-shell-send-buffer)
         ("C-c |" . python-shell-send-buffer)
         ("C->" . python-indent-shift-right)
         ("C-<" . python-indent-shift-left))
  :config
  ;;(setenv "IPY_TEST_SIMPLE_PROMPT" "1")
  ;;(setenv "JUPYTER_CONSOLE_TEST" "1")
  ;;(setenv "PYLINTRC" (concat (getenv "HOME") "/.pylintrc"))
  (setq py-max-specpdl-size 5000)
                                        ;(require 'programming-init)
  (use-package virtualenvwrapper
    :ensure t
    :config
    (venv-initialize-interactive-shells) ;; if you want interactive shell support
    (venv-initialize-eshell) ;; if you want eshell support
    ;; note that setting `venv-location` is not necessary if you
    ;; use the default location (`~/.virtualenvs`), or if the
    ;; the environment variable `WORKON_HOME` points to the right place
    (setq venv-location "/home/thawes/.virtualenvs/"))

  :init
  (linum-mode 1)
  (setq indent-tabs-mode nil ;; Spaces, not tabs!
        tab-width (default-value 'tab-width)
        python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i")

  (dolist (func '(company-mode
                  smartparens-strict-mode))
    (add-hook 'python-mode-hook func)))

(provide 'python-init)
