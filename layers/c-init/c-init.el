;;

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
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
  (require 'flymake-google-cpplint)
  (flymake-google-cpplint-load))

(defun my-irony-mode-hook ()
  "Enable the hooks in the preferred order: 'yas -> auto-complete -> irony'."
  ;; if yas is not set before (auto-complete-mode 1), overlays may persist after
  ;; an expansion.
  (when (member major-mode '(c++-mode c-mode objc-mode))
    ; replace the `completion-at-point' and `complete-symbol' bindings in
    ; irony-mode's buffers by irony-mode's function
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async)))

(require 'company)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))
;; (optional) adds CC special commands to `company-begin-commands' in order to
;; trigger completion at interesting places, such as after scope operator
;;     std::|
;;  (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands))

(require 'column-marker)
(require 'google-c-style)
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
;; gtags
(setq ggtags-executable-directory "/home/thawes/.nix-profile/bin")
(setq-local ggtags-process-environment "GTAGSLIBPATH=/home/thawes/.gtags")

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

;; Irony mode
(setq irony-server-install-prefix "~/.emacs.d/programs/irony/")
(setq irony-user-dir "~/.emacs.d/programs/irony/")

(dolist (func '(my-irony-mode-hook
                irony-cdb-autosetup-compile-options
                company-mode))
  (add-hook 'irony-mode-hook func))

(dolist (func '(cedet-init-loader
		my/ac-c-header-init
		my/flymake-google-init
		helm-gtags-mode
		irony-mode
		(lambda()
		  (interactive)
		  (column-marker-1 80))))
  (add-hook 'c++-mode-hook func)
  (add-hook 'c-mode-hook func)
  (add-hook 'objc-mode-hook func))

(dolist (func '(google-set-c-style
                google-make-newline-indent
                (lambda ()
                  (linum-mode 1)
		  (local-set-key [f5] #'compile)
		  (local-set-key [f6] #'gdb))
		(lambda ()
		  (when (derived-mode-p 'c-mode 'c++-mode)
		    (ggtags-mode 1)))))
    (add-hook 'c-mode-common-hook func))
(provide 'c-init)
