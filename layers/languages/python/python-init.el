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
  (use-package virtualenvwrapper
    :ensure t
    :config
    (venv-initialize-interactive-shells) ;; if you want interactive shell support
    (venv-initialize-eshell) ;; if you want eshell support
    ;; note that setting `venv-location` is not necessary if you
    ;; use the default location (`~/.virtualenvs`), or if the
    ;; the environment variable `WORKON_HOME` points to the right place
    (setq venv-location "/home/thawes/.virtualenvs/"))

  (use-package lsp-mode
    :ensure t
    :pin melpa
    :commands (lsp))
  ;; optionally
  (use-package lsp-ui
    :ensure t)
  (use-package company-lsp
    :ensure t
    :commands company-lsp)
  (use-package helm-lsp
    :ensure t
    :commands helm-lsp-workspace-symbol)
  (use-package lsp-treemacs
    :ensure t
    :commands lsp-treemacs-errors-list)
  ;; optionally if you want to use debugger
  (add-to-list 'company-backends 'company-lsp)
  (use-package dap-mode
    :ensure t)

  :init
  (linum-mode 1)
  (setq indent-tabs-mode nil ;; Spaces, not tabs!
        tab-width (default-value 'tab-width)
        python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i")

  (smartparens-mode)
  (dolist (func '(lsp-mode
                  lsp-ui-mode
                  flycheck-mode
                  company-mode
                  smartparens-strict-mode))
    (add-hook 'python-mode-hook func)))

(provide 'python-init)
