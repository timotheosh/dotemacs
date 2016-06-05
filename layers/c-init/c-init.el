;; Modes for c/c++ programming
;; Install cpplint with "pip install cpplint"
;;     (yes, cpplint is a python program)
;; Be sure clang compiler is on your path for irony-mode
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
  (setq gcc-version 5) ;Set the gcc-version in preparing the header-paths below.
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
          '((format "/usr/include/c++/%s" gcc-version)
            (format "/usr/include/x86_64-linux-gnu/c++/%s" gcc-version)
            (format "/usr/include/c++/%s/backward" gcc-version)
            (format "/usr/lib/gcc/x86_64-linux-gnu/%s/include" gcc-version)
            "/usr/local/include"
            (format "/usr/lib/gcc/x86_64-linux-gnu/%s/include-fixed" gcc-version)
            "/usr/include/x86_64-linux-gnu"
            "/usr/include"
            "/usr/include/sword"))
    (setq company-c-headers-path-system my-header-paths))

  ; start flymake-google-cpplint-load
  (defun my/flymake-google-init()
    (custom-set-variables
     '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
    (require 'flymake-google-cpplint)
    (flymake-google-cpplint-load))

  (use-package google-c-style
    :init
    (add-hook 'c-mode-common-hook 'google-set-c-style)
    (add-hook 'c-mode-common-hook 'google-make-newline-indent))

  ;; setup GDB
  (setq
   ;; use gdb-many-windows by default
   gdb-many-windows t

   ;; Non-nil means display source file containing the main routine at startup
   gdb-show-main t
   )

  ;; CC-mode
  (add-hook 'c-mode-common-hook
            '(lambda ()
               ;;(setq ac-sources (append '(ac-source-semantic) ac-sources))
               (linum-mode 1)
               (local-set-key [f5] #'compile)
               (local-set-key [f6] #'gdb)
               ))

  ;; Sword
  (setq sword-includes "/usr/include/sword")

  ;; Set key bindings
  (eval-after-load "helm-gtags"
    '(progn
       (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
       (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
       (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
       (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
       (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
       (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
       (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))

  (setq-local ggtags-process-environment "GTAGSLIBPATH=/home/thawes/.gtags")


  ;; Cling the C++ REPL
  (use-package cling
    :init
    (add-to-list 'load-path (expand-file-name "~/.emacs.d/programs/inferior-cling")))

  (use-package irony
    :init
    ;; Irony mode
    (setq irony-server-install-prefix "~/.emacs.d/programs/irony/")
    (setq irony-user-dir "~/.emacs.d/programs/irony/")

    (defun my-irony-mode-hook ()
      "Enable the hooks in the preferred order: 'yas -> auto-complete -> irony'."
      ;; if yas is not set before (auto-complete-mode 1), overlays may persist after
      ;; an expansion.
      (when (member major-mode '(c++-mode c-mode objc-mode))
	(irony-mode 1)
        ; replace the `completion-at-point' and `complete-symbol' bindings in
        ; irony-mode's buffers by irony-mode's function
	(define-key irony-mode-map [remap completion-at-point]
	  'irony-completion-at-point-async)
	(define-key irony-mode-map [remap complete-symbol]
	  'irony-completion-at-point-async)))

    ;(add-hook 'irony-mode-hook 'my-irony-mode-hook)
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

    (use-package company
      :config
      (eval-after-load 'company
	'(add-to-list 'company-backends 'company-irony))
      ;; (optional) adds CC special commands to `company-begin-commands' in order to
      ;; trigger completion at interesting places, such as after scope operator
      ;;     std::|
      ;;  (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands))
      )
    (add-hook 'irony-mode-hook 'company-mode))

  (add-hook 'c-mode-hook 'my-programming-hooks)
  (add-hook 'c++-mode-hook 'my-programming-hooks)
  (add-hook 'objc-mode-hook 'my-programming-hooks)

  (add-hook 'c++-mode-hook 'my/company-c-header-init)
  (add-hook 'c-mode-hook 'my/company-c-header-init)
  (add-hook 'objc-mode-hook 'my/company-c-header-init)

  (add-hook 'c-mode-hook 'my/flymake-google-init)
  (add-hook 'c++-mode-hook 'my/flymake-google-init)
  (add-hook 'objc-mode-hook 'my/flymake-google-init)

  (add-hook 'c-mode-hook 'helm-gtags-mode)
  (add-hook 'c++-mode-hook 'helm-gtags-mode)
  (add-hook 'objc-mode-hook 'helm-gtags-mode)

  (add-hook 'c++-mode-hook 'my-irony-mode-hook)
  (add-hook 'c-mode-hook 'my-irony-mode-hook)
  (add-hook 'objc-mode-hook 'my-irony-mode-hook)
  )
(provide 'c-init)
