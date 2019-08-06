;; Eshell help
(use-package esh-help
  :ensure t
  :init
  (setup-esh-help-eldoc))

;; Custom functions for use in eshell
(defun eshell/mgit (&rest args)
  (eshell-eval-using-options
   "mgit" args
   '((?s "status" t status "")
     (?l "log" t log "Show git log for all branches")
     (nil "help" nil nil "Show this usage information")
     :show-usage)
   (eshell-do-eval
    (eshell-parse-command
     (cond
      (status "magit-status")
      (log "magit-log-all-branches")))
    t)))

(defun eshell/deb (&rest args)
  (eshell-eval-using-options
   "deb" args
   '((?f "find" t find "list available packages matching a pattern")
     (?i "installed" t installed "list installed debs matching a pattern")
     (?l "list-files" t list-files "list files of a package")
     (?s "show" t show "show an available package")
     (?v "version" t version "show the version of an installed package")
     (?w "where" t where "find the package containing the given file")
     (nil "help" nil nil "show this usage information")
     :show-usage)
   (eshell-do-eval
    (eshell-parse-command
     (cond
      (find
       (format "apt-cache search %s" find))
      (installed
       (format "dlocate -l %s | grep '^.i'" installed))
      (list-files
       (format "dlocate -L %s | sort" list-files))
      (show
       (format "apt-cache show %s" show))
      (version
       (format "dlocate -s %s | egrep '^(Package|Status|Version):'" version))
      (where
       (format "dlocate %s" where))))
    t)))

(defun eshell/ef (fname-regexp &rest dir)
  (ef fname-regexp default-directory))

(setq eshell-history-size 1024)

(load "em-hist")           ; So the history vars are defined
(if (boundp 'eshell-save-history-on-exit)
    (setq eshell-save-history-on-exit t)) ; Don't ask, just save
                                        ;(message "eshell-ask-to-save-history is %s" eshell-ask-to-save-history)
(if (boundp 'eshell-ask-to-save-history)
    (setq eshell-ask-to-save-history 'always)) ; For older(?) version
                                        ;(message "eshell-ask-to-save-history is %s" eshell-ask-to-save-history)

(require 'esh-module) ;; load tramp functions into eshell

(use-package eshell-prompt-extras
  :ensure t
  :pin melpa
  :config
  ;; for virtualenvwrapper stuff
  (with-eval-after-load "esh-opt"
    (autoload 'epe-theme-lambda "eshell-prompt-extras")
    (setq eshell-highlight-prompt nil
          eshell-prompt-function 'epe-theme-lambda
          epe-show-python-info t
          epe-path-style 'single)))

(add-to-list 'eshell-modules-list 'eshell-tramp 'esh-opt)
(setq eshell-prefer-lisp-functions t)
(setq eshell-prefer-lisp-variables t)

(setq password-cache t) ; enable password caching
(setq password-cache-expiry 180) ; for 3 minutes (time in secs)

;; Uses the default Emacs completion package for tab-complete in eshell.
(add-hook 'eshell-mode-hook
          (lambda ()
            (define-key eshell-mode-map (kbd "<tab>")
              (lambda () (interactive) (pcomplete-std-complete)))))

(provide 'eshell-init)
