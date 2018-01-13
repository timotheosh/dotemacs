;; dotemacs

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Libraries. Packages that get used more than one place. WARNING: No
;; consistent use, yet.
(let ((default-directory  "~/.emacs.d/libraries/"))
  (normal-top-level-add-subdirs-to-load-path))
;; Configuration for specific modes
(let ((default-directory  "~/.emacs.d/layers/"))
  (normal-top-level-add-subdirs-to-load-path))
;; Third-party packages, usually found in github and other sundry places.
(push (expand-file-name "~/.emacs.d/programs") load-path)

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
;; Uncomment to hide menu bar
;;(menu-bar-mode -1)

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

(require 'packages-init)
;; Add packages here
;; Initial packages
(require 'paradox-init)
(require 'cedet-init)
(require 'tramp-init)
(require 'sr-speedbar-init)
(require 'yasnippet-init)

;; Customizations
(require 'custom-keys)
(require 'environment-init)
(require 'powerline-init)

;; Org-mode
(require 'org-init)
(require 'cbible-init)

(setq user-full-name "Tim Hawes")
;; Mu4e Email
(if (string= system-name "scotus")
    (progn
      ;; Email and user's name.
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
      (require 'mu4e-work-init))
  (progn
    ;; Email and user's name.
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
    (require 'mu4e-init)))

;; General Utilities
(require 'flyspell-init)
(require 'flycheck-init)
(require 'ido-init)
(require 'helm-init)
(require 'my-funcs)
(require 'unbound)
(require 'multi-term-init)
(require 'erc-init)

;; Programming Utilities
;;(require 'minimap-init) ;; Minimap is too annoying. Can't get rid of once
                          ;; enabled. No other options work.
(require 'ggtags-init)
(require 'projectile-init)
(require 'auto-complete-init)
(require 'magit-init)
(require 'ansible-init)
(require 'docker-init)

;; Language modes
(require 'html-init)       ;; Editing html files
(require 'elisp-init)      ;; Emacs Lisp
(require 'c-init)          ;; C/C++ and ObjC
(require 'php-init)        ;; PHP
(require 'lisp-init)       ;; Common Lisp
(require 'geiser-init)     ;; repl for scheme/racket
(require 'chicken-init)    ;; Chicken Scheme
(require 'racket-init)     ;; Racket/Scheme
(require 'python-init)     ;; Python
(require 'cython-init)     ;; Cython
(require 'hy-init)         ;; Hy-mode (Lisp for Python)
(require 'java-init)       ;; Java ; Broken package
(require 'perl-init)       ;; Perl
(require 'haskell-init)    ;; Haskell
(require 'ruby-init)       ;; Ruby
(require 'clojure-init)    ;; Clojure
(require 'rust-init)

;; File Formats
(require 'edi-init)
(require 'json-init)
(require 'yaml-init)

;; AWS Mode
(require 'aws-el-init)

;; Reading
(require 'kindly-init)

;; Writing
(require 'input-init) ; For Greek and Hebrew.
;; End Add packages

;; Themes
(use-package darktooth-theme
  :ensure t
  :defer t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;; We want themes only if we are in gui. We need to create a hook
;; as the themes will need to be activated on a per-case basis, while
;; running emacs in server mode.
(defun on-frame-open (frame)
  (if (not (display-graphic-p frame))
      (progn
          (set-face-background 'default "unspecified-bg" frame))
    (progn
        (load-theme 'darktooth t)
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

(set-face-attribute 'default nil
                    :family "Ubuntu Mono"
                    :foundry "DAMA"
                    :slant 'normal
                    :weight 'bold
                    :height 151
                    :width 'normal)
