;; dotemacs

(setq gc-cons-threshold 64000000)
(add-hook 'after-init-hook #'(lambda ()
                               ;; restore after startup
                               (setq gc-cons-threshold 800000)))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Break-glass setting when you see 'bad-signature "archive-contents.sig"'
;;  on start up, after a package upgrade.
;;(setq package-check-signature nil)

;; Libraries. Packages that get used more than one place. WARNING: No
;; consistent use, yet.
(let ((default-directory  (concat user-emacs-directory "libraries/")))
  (normal-top-level-add-subdirs-to-load-path))
;; Configuration for specific modes
(let ((default-directory  (concat user-emacs-directory "layers/")))
  (normal-top-level-add-subdirs-to-load-path))
;; Third-party packages, usually found in github and other sundry places.
(push (expand-file-name (concat user-emacs-directory "programs")) load-path)

;; Some importtant emacs configuration(s)
(setq max-lisp-eval-depth 500)  ;; default is 500
(setq max-specpdl-size 1000)    ;; default is 1000
;; Custom file
(if (string= system-type "cygwin")
    (setq custom-file (concat user-emacs-directory "layers/customizations/cygwin-custom.el"))
  (setq custom-file (concat user-emacs-directory "layers/customizations/custom.el")))

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
(menu-bar-mode -1)

;; Use utf-8 by default
(setq coding-system-for-read 'utf-8
      coding-system-for-write 'utf-8 )

;; Set up for backup files
(defconst my-auto-save-folder (concat user-emacs-directory "recover-files/"))
(defconst my-save-folder (concat user-emacs-directory "saved-files/"))
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
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

;; Open files remotely after sudo'ing as root
(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))

(require 'packages-init)
;; Add packages here
;; Initial packages
(require 'paradox-init)
(require 'emacs-frame-manager-init)
(require 'email-init)
(require 'dired-init)
(require 'ssh-init)
(require 'tramp-init)
(require 'eshell-init)
(require 'neotree-init)
(require 'yasnippet-init)
(require 'web-search-init)

;; Customizations
(require 'environment-init)
(require 'dashboard-init)
(require 'powerline-init)

;; Org-mode
(require 'org-init)
(require 'cbible-init)
(require 'calibre-init)

(setq user-full-name "Tim Hawes")

(require 'web-browser-init)
(require 'elfeed-init)
;;(require 'mu4e-init)
;; General Utilities
(require 'flyspell-init)
(require 'flycheck-init)
(require 'helm-init)
(require 'ivy-init)
(require 'my-funcs)
(require 'unbound)
(require 'vterm-init)
(require 'multi-term-init)
(require 'erc-init)
(require 'shell-pop-init)
(require 'centaur-tabs-init)

;; Programming Utilities
;;(require 'minimap-init) ;; Minimap is too annoying. Can't get rid of once
;; enabled. No other options work.
(require 'ggtags-init)
(require 'projectile-init)
(require 'auto-complete-init)
(require 'company-init)
(require 'magit-init)
(require 'ansible-init)
(require 'docker-init)
(require 'restclient-init)

;; Language server mode
(require 'lsp-init)
;; Language modes
;; Most impotant
(require 'elisp-init)      ;; Emacs Lisp
(require 'lisp-init)       ;; Common Lisp
(require 'rust-init)       ;; Rust-lang
(require 'clojure-init)    ;; Clojure
(require 'python-init)     ;; Python
;; (require 'inf-clojure-init) ;; For use of NodeJs Clojurescript implementation/compiler, Lumo
(require 'racket-init)     ;; Racket/Scheme

;; Meh
(require 'web-init)        ;; web-mode for html/css, templates, etc.
;(require 'c-init)          ;; C/C++ and ObjC
(require 'php-init)        ;; PHP
(require 'geiser-init)     ;; repl for scheme/racket
;;(require 'chicken-init)    ;; Chicken Scheme
(require 'cython-init)     ;; Cython
(require 'hy-init)         ;; Hy-mode (Lisp for Python)
(require 'java-init)       ;; Java ; Broken package
(require 'groovy-init)     ;; Groovy
(require 'perl-init)       ;; Perl
(require 'haskell-init)    ;; Haskell
(require 'ruby-init)       ;; Ruby
(require 'javascript-init) ;; Javascript
(require 'smalltalk-mode-init)
(require 'basic-init)      ;; BASIC Mode

;; File Formats
(require 'edi-init)
(require 'json-init)
(require 'yaml-init)
(require 'markdown-init)

;; AWS Mode
;;(require 'aws-el-init)

;; Writing
(require 'input-init) ; For Greek and Hebrew.
;; End Add packages

;; Themes
;; We want themes only if we are in gui. We need to create a hook
;; as the themes will need to be activated on a per-case basis, while
;; running emacs in server mode.
;; This solves the problem of the theme not getting loaded properly in
;; daemon mode. Found here: https://stackoverflow.com/questions/18904529/after-emacs-deamon-i-can-not-see-new-theme-in-emacsclient-frame-it-works-fr
;;(setq zenburn-override-colors-alist
;;      '(("zenburn-bg" . "#363b41")))
;;(use-package zenburn-theme
;;  :ensure t
;;  :defer t)
(use-package doom-themes
  :ensure t
  :defer t)

(use-package spacemacs-theme
  :ensure t
  :defer t)

(add-to-list 'custom-theme-load-path (concat user-emacs-directory "themes"))

(defvar my:theme 'spacemacs-dark)
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
(require 'custom-keys)
(require 'all-the-icons-fonts-init)
(set-face-attribute 'default nil
                    :family "Source Code Pro for Powerline"
		    :foundry "ADBO"
		    :slant 'normal
		    :weight 'normal
		    :height 102
		    :width 'normal)

(put 'downcase-region 'disabled nil)
