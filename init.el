;; Set up load paths
(let ((default-directory  "~/.emacs.d/layers/"))
  (normal-top-level-add-subdirs-to-load-path))
(push (expand-file-name "~/.emacs.d/libraries") load-path)
(push (expand-file-name "~/.emacs.d/programs") load-path)
(push (expand-file-name "~/.nix-profile/share/emacs/site-lisp/") load-path)
(push (expand-file-name "~/.nix-profile/share/emacs/site-lisp/mu4e") load-path)
(require 'packages-init)
(require 'benchmark-init)

(benchmark-init/activate)

;; Some importtant emacs configuration(s)
(setq max-lisp-eval-depth 500)  ;; default is 500
(setq max-specpdl-size 1000)    ;; default is 1000
;; Custom file
(if (string= system-type "cygwin")
    (setq custom-file "~/.emacs.d/layers/customizations/cygwin-custom.el")
  (setq custom-file "~/.emacs.d/layers/customizations/custom.el"))

;; Allow for UTF-8 in place of utf-8
(define-coding-system-alias 'UTF-8 'utf-8)

;; Display clock and line and column numbers.
(display-time)
(line-number-mode 1)
(column-number-mode 1)

(global-font-lock-mode t)
(setq font-lock-maximum-size nil)

;; Color the cursor
(set-cursor-color "#98fb98")
;; Hide tool bar
(tool-bar-mode -1)
;; Hide menu bar
(menu-bar-mode -1)

;; Default buffer to open
(setq initial-buffer-choice
      '(lambda ()
         (interactive)
         (setq buff (get-buffer-create "*text-scratch*"))
         (switch-to-buffer buff)
         (text-mode)
         buff))

;; Open files remotely after sudo'ing as root
(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))

;; Initial packages
(require 'use-package-init)
(require 'cedet-init)         ;; Gets loaded since we are using the latest CEDET.
(require 'tramp-init)
(require 'ecb-init)
(require 'yasnippet-init)

;; Customizations
(require 'custom-keys)
(require 'environment-init)
(require 'powerline-init)

;; Org-mode
(require 'org-init)
(require 'cbible-init)

(setq user-full-name "Tim Hawes")

(if (string= system-name "scotus")
    (progn
                                        ; Email and user's name.
      (setq user-mail-address "Tim.Hawes@inin.com")

      (setq message-send-mail-function 'smtpmail-send-it
            smtpmail-starttls-credentials '(("smtp.office365.com" 587 nil nil))
            smtpmail-auth-credentials '("~/.netrc")
            smtpmail-default-smtp-server "smtp.office365.com"
            smtpmail-smtp-server "smtp.office365.com"
            smtpmail-smtp-service 587
            smtpmail-local-domain "inin.com"
            smtpmail-queue-mail nil
            smtpmail-queue-dir "~/IninMaildir/queue/cur")
      ;; Mail
      (require 'mu4e-work-init))
  (progn
                                        ; Email and user's name.
    (setq user-mail-address "tim@easyfreeunix.com")

    (setq message-send-mail-function 'smtpmail-send-it
          smtpmail-starttls-credentials '(("mail.althusius.net" 25 nil nil))
          smtpmail-auth-credentials '("~/.netrc")
          smtpmail-default-smtp-server "mail.althusius.net"
          smtpmail-smtp-server "mail.althusius.net"
          smtpmail-smtp-service 25
          smtpmail-local-domain "althusius.net"
          smtpmail-queue-mail nil
          smtpmail-queue-dir "~/Maildir/INBOX.Queue/cur")
    ;; Mail
    (require 'mu4e-init)))




;; General Utilities
(require 'flyspell-init)
(require 'ido-init)
(require 'helm-init)
(require 'my-funcs)
(require 'unbound)
(require 'multi-term-init)

;; Programming Utilities
(require 'minimap-init)
(require 'ggtags-init)
(require 'projectile-init)
(require 'auto-complete-init)
(require 'magit-init)

;; Language modes
(require 'html-init)       ;; Editing html files
(require 'elisp-init)      ;; Emacs Lisp
(require 'c-init)          ;; C/C++ and ObjC
(require 'php-init)        ;; PHP
(require 'lisp-init)       ;; Common Lisp
(require 'chicken-init)    ;; Chicken Scheme
(require 'racket-init)     ;; Racket/Scheme
(require 'python-init)     ;; Python
(require 'hy-init)         ;; Hy-mode (Lisp for Python)
(require 'java-init)       ;; Java
(require 'perl-init)       ;; Perl
(require 'haskell-init)    ;; Haskell
(require 'ruby-init)       ;; Ruby
(require 'clojure-init)    ;; Clojure

;; File Formats
(require 'edi-init)
(require 'json-init)

;; Amazon AWS
;;(require 'aws-el-init)

;; Reading
(require 'kindly-init)

                                        ;(load-library "auto-complete-init")
                                        ;(load-library "multi-web-mode-init")
                                        ;(load-library "sql-init")
                                        ;(load-library "yaml-init")
                                        ;(load-library "geben-init")
;;(load-library "etags-init")
;;(load-library "etags-table-init")
                                        ;(load-library "puppet-init")
                                        ;(load-library "nix-init")
                                        ;(load-library "emacsclient-init")
                                        ;(load-library "cmake-init")
                                        ;(load-library "diatheke-init")
                                        ;(load-library "function-args-init")
                                        ;(load-library "graphiz-init")

;; Save desktop on exit, load saved desktop on startup.
                                        ;(setq desktop-dirname             "~/.emacs.d/desktop/"
                                        ;  desktop-base-file-name      "emacs24.desktop"
                                        ;  desktop-base-lock-name      "emacs24.lock"
                                        ;  desktop-path                (list desktop-dirname)
                                        ;  desktop-save                t
                                        ;  desktop-files-not-to-save   "^$" ;reload tramp paths
                                        ;  desktop-load-locked-desktop nil
                                        ;)
                                        ;(desktop-save-mode 1)

;; Themes directory
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;; We want themes only if we are in gui. We need to create a hook
;; as the themes will need to be activated on a per-case basis, while
;; running emacs in server mode.
(defun on-frame-open (frame)
  (if (not (display-graphic-p frame))
      (set-face-background 'default "unspecified-bg" frame)
    (progn
        (load-theme 'odersky t)
        (load-theme 'org-beautify t))))
(on-frame-open (selected-frame))
(add-hook 'after-make-frame-functions 'on-frame-open)

(require 'transparent-window)
(load custom-file)

(set-default 'server-socket-dir "~/.emacs.d/server")
(if (functionp 'window-system)
    (when (and (window-system)
               (>= emacs-major-version 24))
      (server-start)))

(benchmark-init/deactivate)
