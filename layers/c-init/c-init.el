;; Modes for c/c++ programming
;; Install cpplint with "pip install cpplint"
;;     (yes, cpplint is a python program)
;; Be sure clang compiler is on your path for irony-mode
;; rtags needs to be installed and rdm running for navigation.

(use-package c-mode
  :mode (("\\.c\\'" . c-mode)
	 ("\\.h\\'" . c-mode)
	 ("\\.cpp\\'" . c++-mode)
	 ("\\.hpp\\'" . c++-mode)
	 ("\\.cxx\\'" . c++-mode)
	 ("\\.hxx\\'" . c++-mode)
	 ("\\.objc\\'" . objc-mode)
	 ("\\.m\\'" . objc-mode))
  :init
  (use-package programming-init
    :init
    (use-package smartparens
      :ensure t
      :config
      (sp-local-pair '(c-mode)
                     "{" nil :post-handlers
                     '((my/create-newline-format "RET")))
      (sp-local-pair '(c++-mode)
                     "{" nil :post-handlers
                     '((my/create-newline-format "RET")))
      (sp-local-pair '(objc-mode)
                     "{" nil :post-handlers
                     '((my/create-newline-format "RET")))))

  (defun my/company-c-header-init()
    "Set paths for auto-header."
    (use-package company-c-headers
      :ensure t
      :config
      (setq my-header-paths
            '("/usr/include/c++/5"
              "/usr/include/x86_64-linux-gnu/c++/5"
              "/usr/include/c++/5/backward"
              "/usr/lib/gcc/x86_64-linux-gnu/5/include"
              "/usr/local/include"
              "/usr/lib/gcc/x86_64-linux-gnu/5/include-fixed"
              "/usr/include/x86_64-linux-gnu"
              "/usr/include"
              "/usr/include/sword"))
      (setq company-c-headers-path-system my-header-paths)))

  ;; Cling the C++ REPL
  (use-package cling
    :load-path "~/.emacs.d/programs/inferior-cling")

  ;; Set up irony and company-mode for completion.
  (use-package irony
    :ensure t
    :init
    ;; Irony mode
    (setq irony-server-install-prefix "~/.emacs.d/programs/irony/")
    (setq irony-user-dir "~/.emacs.d/programs/irony/")

    (defun my-irony-mode-hook ()
      (define-key irony-mode-map [remap completion-at-point]
        'irony-completion-at-point-async)
      (define-key irony-mode-map [remap complete-symbol]
        'irony-completion-at-point-async)))

  (use-package company
    :ensure t
    :config
    (add-to-list 'company-backends 'company-c-headers))

  (use-package company-irony
    :ensure t
    :config
    (add-to-list 'company-backends 'company-irony))

  (use-package irony-eldoc
    :ensure t
    :config
    (add-hook 'irony-mode-hook 'irony-eldoc))

  (add-hook 'irony-mode-hook
            '(lambda ()
               (my-irony-mode-hook)
               (irony-cdb-autosetup-compile-options)
               (company-mode)))

  ;; Set up rtags
  ;; I am using a later version of rtags because the rdm daemon has
  ;; log-flush option.
  (use-package rtags
    :load-path "~/.nix-profile/share/emacs/site-lisp/rtags/"
    :config
    ;; Flycheck setup
    (use-package flycheck-init
      :init
      (require 'flycheck-rtags))
    (defun my-flycheck-rtags-setup ()
      (flycheck-select-checker 'rtags)
      ;; RTags creates more accurate overlays.
      (setq-local flycheck-highlighting-mode nil)
      (setq-local flycheck-check-syntax-automatically nil))
    (rtags-restart-process)
    (rtags-diagnostics)
    (rtags-enable-standard-keybindings c-mode-base-map "\C-cr")
    (add-hook 'rtags-mode-hook 'my-flycheck-rtags-setup))

  ;; flycheck-irony
  (use-package flycheck-irony
    :ensure t
    :after irony
    :config
    (eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))

  ;; flycheck-clang-analyzer
  (use-package flycheck-clang-analyzer
    :ensure t
    :after flycheck
    :config (flycheck-clang-analyzer-setup))

  ;; clang-tidy
  (use-package flycheck-clang-tidy
    :ensure t
    :after flycheck
    :config
    (eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook #'flycheck-clang-tidy-setup)))

  ;; clangCheck
  (use-package flycheck-clangcheck
    :ensure t
    :after flycheck
    :config
    ;; enable static analysis
    (setq flycheck-clangcheck-analyze t))

  (defun my-select-clangcheck-for-checker ()
    "Select clang-check for flycheck's checker."
    (flycheck-set-checker-executable 'c/c++-clangcheck
                                     "/path/to/clang-check")
    (flycheck-select-checker 'c/c++-clangcheck))

  (add-hook 'c-mode-hook #'my-select-clangcheck-for-checker)
  (add-hook 'c++-mode-hook #'my-select-clangcheck-for-checker)

  ;; setup GDB
  (setq
   ;; use gdb-many-windows by default
   gdb-many-windows t

   ;; Non-nil means display source file containing the main routine at startup
   gdb-show-main t
   )

  ;; Cmake project support
  (use-package cmake-ide
    :ensure t
    :init
    (cmake-ide-setup)
    (defun proper-cmake-compile ()
      (interactive)
      (cmake-ide-run-cmake)
      (cmake-ide-compile)))

  (defun my/c-common-hooks ()
    ;;(setq ac-sources (append '(ac-source-semantic) ac-sources))
    (linum-mode 1)
    (local-set-key [f5] #'proper-cmake-compile)
    (local-set-key [f6] #'gdb)
    (local-unset-key [67108910])
    (local-unset-key [67108908])
    (local-set-key [67108910] ;; Bind key C-.
                   (quote rtags-find-symbol-at-point))
    (local-set-key [67108908] ;; Bind key C-,
                   (quote helm-gtags-find-rtag))
    (rtags-start-process-unless-running)
    (my-programming-hooks)
    (my/company-c-header-init)
    (irony-mode)
    (google-set-c-style)
    (google-make-newline-indent)
    (flycheck-mode)
    (rtags-start-process-unless-running))

  (add-hook 'c-mode-hook
            '(lambda ()
               (my/c-common-hooks)))
  (add-hook 'c++-mode-hook
            '(lambda ()
               (my/c-common-hooks)))
  (add-hook 'objc-mode-hook
            '(lambda ()
               (my/c-common-hooks)))
  )
(provide 'c-init)
