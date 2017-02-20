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
    (require 'smartparens)
    (sp-local-pair '(c-mode)
                   "{" nil :post-handlers
                   '((my/create-newline-format "RET")))
    (sp-local-pair '(c++-mode)
                   "{" nil :post-handlers
                   '((my/create-newline-format "RET")))
    (sp-local-pair '(objc-mode)
                   "{" nil :post-handlers
                   '((my/create-newline-format "RET"))))

  (defun my/company-c-header-init()
    "Set paths for auto-header."
    (require 'company-c-headers)
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
    (setq company-c-headers-path-system my-header-paths))

  ;; Cling the C++ REPL
  (use-package cling
    :init
    (add-to-list 'load-path (expand-file-name "~/.emacs.d/programs/inferior-cling")))

  ;; Set up irony and company-mode for completion.
  (use-package irony
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
    :config
    (add-to-list 'company-backends 'company-irony)
    (add-to-list 'company-backends 'company-c-headers))

  (add-hook 'irony-mode-hook
            '(lambda ()
               (my-irony-mode-hook)
               (irony-cdb-autosetup-compile-options)
               (company-mode)))

  ;; Set up rtags
  (use-package rtags
    :config
    ;; Flycheck setup
    (use-package flycheck-rtags
      :config
      (defun my-flycheck-rtags-setup ()
        (flycheck-select-checker 'rtags)
        ;; RTags creates more accurate overlays.
        (setq-local flycheck-highlighting-mode nil)
        (setq-local flycheck-check-syntax-automatically nil)))
    (require 'rtags)
    (rtags-restart-process)
    (rtags-diagnostics)
    (rtags-enable-standard-keybindings c-mode-base-map "\C-cr")
    (add-hook 'rtags-mode-hook 'my-flycheck-rtags-setup))

  ;; Google style compliance
  ;; start flymake-google-cpplint-load
  (defun my/flymake-google-init()
    (custom-set-variables
     '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
    (require 'flymake-google-cpplint)
    (flymake-google-cpplint-load))

  (use-package google-c-style)

  ;; setup GDB
  (setq
   ;; use gdb-many-windows by default
   gdb-many-windows t

   ;; Non-nil means display source file containing the main routine at startup
   gdb-show-main t
   )

  ;; Cmake project support
  (cmake-ide-setup)

  (defun proper-cmake-compile ()
    (interactive)
    (cmake-ide-run-cmake)
    (cmake-ide-compile))

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
    (my/flymake-google-init)
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
