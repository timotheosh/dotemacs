;;
(use-package google-c-style)
(require 'programming-init)
(add-hook 'after-init-hook #'global-company-mode)

(defun my/ac-c-header-init()
  "Set paths for auto-header."
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/include/c++/4.8")
  (add-to-list 'achead:include-directories '"/usr/include/x86_64-linux-gnu/c++/4.8")
  (add-to-list 'achead:include-directories '"/usr/include/c++/4.8/backward")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/4.8/include")
  (add-to-list 'achead:include-directories '"/usr/local/include")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/4.8/include-fixed")
  (add-to-list 'achead:include-directories '"/usr/include/x86_64-linux-gnu")
  (add-to-list 'achead:include-directories '"/usr/include")
  ;; Sword Development
  (add-to-list 'achead:include-directories '"/usr/include/sword"))

					; start flymake-google-cpplint-load
(defun my/flymake-google-init()
  "Sets up cpplint for flymake"
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
  (require 'flymake-google-cpplint)
  (flymake-google-cpplint-load))

(defun my-irony-mode-hook ()
  "Check if a supported major mode is active before setting up irony."
  (when (member major-mode '(c++-mode c-mode objc-mode))
    (irony-mode)
    (setq-local company-backends (cons 'company-irony company-backends))
    (setq irony-server-install-prefix "~/.emacs.d/programs/irony/")
    (setq irony-user-dir "~/.emacs.d/programs/irony/")
    ; replace the `completion-at-point' and `complete-symbol' bindings in
    ; irony-mode's buffers by irony-mode's function
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async)))

;; setup GDB
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t)

;; Cling the C++ REPL
(use-package cling
  :init
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/programs/inferior-cling")))

;; Set helm-gtag key bindings
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(dolist (func '(cedet-init-loader
		my/ac-c-header-init
		my/flymake-google-init
		helm-gtags-mode
		my-irony-mode-hook
		(lambda()
		  (interactive)
		  (column-marker-1 80))))
  (add-hook 'c++-mode-hook func)
  (add-hook 'c-mode-hook func)
  (add-hook 'objc-mode-hook func))

(dolist (func '(google-set-c-style
                google-make-newline-indent
                (lambda ()
		  (local-set-key [f5] #'compile)
		  (local-set-key [f6] #'gdb))))
    (add-hook 'c-mode-common-hook func))
(provide 'c-init)
