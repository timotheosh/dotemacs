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

(add-to-list 'load-path (expand-file-name "~/.emacs.d/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/programs/"))
(load-library "keys")
(load-library "ido-init")
(load-library "packages-init")
(load-library "column-enforce-init")
(load-library "column-marker-init")
(load-library "edi-init")
(load-library "mu4e-init")
(load-library "indent-buffer")
(load-library "unbound")
(load-library "w3m-init")
(load-library "gtags-init")
(load-library "multi-term-init")
(load-library "matchparenthesis")
(load-library "auto-complete-init")
(load-library "cedet-native-init")
(load-library "yasnippet-init")
(load-library "ecb-init")
(load-library "php-init")
(load-library "multi-web-mode-init")
(load-library "sql-init")
(load-library "yaml-init")
(load-library "slime-init")
(load-library "python-init")
(load-library "perl-init")
(load-library "flyspell-init")
(load-library "org-init")

;; Save desktop on exit, load saved desktop on startup.
(setq desktop-dirname             "~/.emacs.d/desktop/"
  desktop-base-file-name      "emacs24.desktop"
  desktop-base-lock-name      "emacs24.lock"
  desktop-path                (list desktop-dirname)
  desktop-save                t
  desktop-files-not-to-save   "^$" ;reload tramp paths
  desktop-load-locked-desktop nil
)
(desktop-save-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (wheatgrass)))
 '(display-time-mode t)
 '(ecb-options-version "2.40")
 '(ido-enable-tramp-completion nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Luxi Mono" :foundry "b&h" :slant normal :weight normal :height 113 :width normal)))))
