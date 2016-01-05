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

(let ((default-directory  "~/.emacs.d/layers/"))
  (normal-top-level-add-subdirs-to-load-path))
(push (expand-file-name "~/.emacs.d/libraries") load-path)
(push (expand-file-name "~/.emacs.d/programs") load-path)
(push (expand-file-name "~/.nix-profile/share/emacs/site-lisp/") load-path)
(push (expand-file-name "~/.nix-profile/share/emacs/site-lisp/mu4e") load-path)
(require 'packages-init)
;(require 'benchmark-init)
(require 'use-package-init)
(require 'cedet-init)         ;; Gets loaded since we are using the latest CEDET.
(require 'custom-keys)
(require 'environment-init)
(require 'ido-init)
(require 'helm-init)
(require 'ggtags-init)
;(require 'column-enforce-init)
;(require 'column-marker-init)
(require 'c-init)

;(load-library "transparent-window")
;(load-library "edi-init")
;(load-library "mu4e-init")
;(load-library "indent-buffer")
;(load-library "unbound")
;(load-library "w3m-init")
;(load-library "minimap-init")
;(load-library "multi-term-init")
;(load-library "matchparenthesis")
;(load-library "auto-complete-init")
;(load-library "yasnippet-init")
;(load-library "php-init")
;(load-library "multi-web-mode-init")
;(load-library "sql-init")
;(load-library "yaml-init")
;(load-library "scheme-init")
;(load-library "lisp-init")
;(load-library "python-init")
;(load-library "perl-init")
;(load-library "flyspell-init")
;(load-library "geben-init")
;;(load-library "etags-init")
;;(load-library "etags-table-init")
;(load-library "ecb-init")
;(load-library "org-init")
;(load-library "org-templates")
;(load-library "malabar-init")
;(load-library "ruby-init")
;(load-library "puppet-init")
;(load-library "cider-init")
;(load-library "haskell-init")
;(load-library "json-init")
;(load-library "nix-init")
;(load-library "org-page-init")
;(load-library "emacsclient-init")
;(load-library "cmake-init")
;(load-library "diatheke-init")
;(load-library "smartparens-init")
;(load-library "function-args-init")
;(load-library "environment-init")
;(load-library "cbible-init")
;(load-library "my-funcs")
;(load-library "powerline-init")
;(load-library "projectile-init")
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
(load custom-file)
(require 'terminal-mode-init)
