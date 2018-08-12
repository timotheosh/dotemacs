;; dotemacs

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Break-glass setting when you see 'bad-signature "archive-contents.sig"'
;;  on start up, after a package upgrade.
;; (setq package-check-signature nil)

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

;; Use utf-8 by default
(setq coding-system-for-read 'utf-8
      coding-system-for-write 'utf-8 )

;; Set up for backup files
(defconst my-auto-save-folder "~/Dropbox/Emacs/recover-files/")
(defconst my-save-folder "~/Dropbox/Emacs/saved-files/")
(setq
 backup-by-copying t  ; don't clobber symlinks
 backup-directory-alist
 `((".*" . ,my-save-folder))  ; don't litter my fs tree
 auto-save-file-name-transforms
 `((".*" ,my-auto-save-folder t))  ; No, I mean, REALLY don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t) ; use versioned backups

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
(require 'neotree-init)
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
(require 'helm-init)
(require 'ivy-init)
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
(require 'web-init)        ;; web-mode for html/css, templates, etc.
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
(require 'groovy-init)     ;; Groovy
(require 'perl-init)       ;; Perl
(require 'haskell-init)    ;; Haskell
(require 'ruby-init)       ;; Ruby
(require 'javascript-init) ;; Javascript
(require 'clojure-init)    ;; Clojure
;; (require 'inf-clojure-init) ;; For use of NodeJs Clojurescript implementation/compiler, Lumo
(require 'rust-init)
(require 'smalltalk-mode-init)
(require 'basic-init)      ;; BASIC Mode

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
;; We want themes only if we are in gui. We need to create a hook
;; as the themes will need to be activated on a per-case basis, while
;; running emacs in server mode.
;; This solves the problem of the theme not getting loaded properly in
;; daemon mode. Found here: https://stackoverflow.com/questions/18904529/after-emacs-deamon-i-can-not-see-new-theme-in-emacsclient-frame-it-works-fr
(use-package darktooth-theme
  :ensure t
  :defer t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(defvar my:theme 'darktooth)
(defvar my:terminal-theme)
(defvar my:theme-window-loaded nil)
(defvar my:theme-terminal-loaded nil)

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (select-frame frame)
                (if (window-system frame)
                    (unless my:theme-window-loaded
                      (if my:theme-terminal-loaded
                          (enable-theme my:theme)
                        (load-theme my:theme t))
                      (setq my:theme-window-loaded t))
                  (unless my:theme-terminal-loaded
                    (if my:theme-window-loaded
                        (enable-theme my:theme)
                      (load-theme my:theme t))
                    (setq my:theme-terminal-loaded t)))))
  (progn
    (load-theme my:theme t)
    (if (display-graphic-p)
        (progn
          (load-theme 'org-beautify t)
          (setq my:theme-window-loaded t))
      (progn
        (setq my:theme-terminal-loaded t)
        (set-face-background 'default "unspecified-bg" frame)))))

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
(put 'dired-find-alternate-file 'disabled nil)
