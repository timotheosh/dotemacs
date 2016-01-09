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
; Custom file
(setq custom-file "~/.emacs.d/lisp/custom.el")
; Email and user's name.
(setq user-mail-address "tim@easyfreeunix.com")
(setq user-full-name "Tim Hawes")

;; Allow for UTF-8 in place of utf-8
(define-coding-system-alias 'UTF-8 'utf-8)

; Display clock and line and column numbers.
(display-time)
(line-number-mode 1)
(column-number-mode 1)

(global-font-lock-mode t)
(setq font-lock-maximum-size nil)

; Color the cursor
(set-cursor-color "#98fb98")

; Hide tool bar
(tool-bar-mode -1)

; Hide menu bar
(menu-bar-mode -1)

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("mail.althusius.net" 25 nil nil))
      smtpmail-auth-credentials '("~/.netrc")
      smtpmail-default-smtp-server "mail.althusius.net"
      smtpmail-smtp-server "mail.althusius.net"
      smtpmail-smtp-service 25
      smtpmail-local-domain "althusius.net"
      smtpmail-queue-mail nil
      smtpmail-queue-dir "~/Maildir/INBOX.Queue/cur"
      )

;; Open files remotely after sudo'ing as root
(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))

;; Initial packages
(require 'use-package-init)
(require 'cedet-init)         ;; Gets loaded since we are using the latest CEDET.
(require 'ecb-init)

;; Customizations
(require 'custom-keys)
(require 'environment-init)

;; Org-mode
(require 'org-init)

;; Mail
(require 'mu4e-init)

;; Utilities
(require 'ido-init)
(require 'helm-init)
(require 'minimap-init)
(require 'ggtags-init)
(require 'projectile-init)
(require 'my-funcs)
(require 'unbound)

;; Language modes
(require 'elisp-init)
(require 'c-init)
(require 'php-init)
(require 'lisp-init)
(require 'python-init)
(require 'edi-init)
(require 'java-init)

;(load-library "w3m-init")
;(load-library "multi-term-init")
;(load-library "auto-complete-init")
;(load-library "yasnippet-init")
;(load-library "multi-web-mode-init")
;(load-library "sql-init")
;(load-library "yaml-init")
;(load-library "scheme-init")
;(load-library "perl-init")
;(load-library "flyspell-init")
;(load-library "geben-init")
;;(load-library "etags-init")
;;(load-library "etags-table-init")
;(load-library "ecb-init")
;(load-library "ruby-init")
;(load-library "puppet-init")
;(load-library "cider-init")
;(load-library "haskell-init")
;(load-library "json-init")
;(load-library "nix-init")
;(load-library "emacsclient-init")
;(load-library "cmake-init")
;(load-library "diatheke-init")
;(load-library "function-args-init")
;(load-library "cbible-init")
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
(require 'transparent-window)
(load custom-file)
(require 'terminal-mode-init)

(benchmark-init/deactivate)
