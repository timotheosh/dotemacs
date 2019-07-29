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

(setq eshell-history-size 1024)
(setq eshell-prompt-regexp "^[^λ]*[λ] ")

(load "em-hist")           ; So the history vars are defined
(if (boundp 'eshell-save-history-on-exit)
    (setq eshell-save-history-on-exit t)) ; Don't ask, just save
                                        ;(message "eshell-ask-to-save-history is %s" eshell-ask-to-save-history)
(if (boundp 'eshell-ask-to-save-history)
    (setq eshell-ask-to-save-history 'always)) ; For older(?) version
                                        ;(message "eshell-ask-to-save-history is %s" eshell-ask-to-save-history)

(defun eshell/ef (fname-regexp &rest dir) (ef fname-regexp default-directory))


;;; ---- path manipulation

(defun pwd-repl-home (pwd)
  (interactive)
  (let* ((home (expand-file-name (getenv "HOME")))
         (home-len (length home)))
    (if (and
         (>= (length pwd) home-len)
         (equal home (substring pwd 0 home-len)))
        (concat "~" (substring pwd home-len))
      pwd)))

(defun curr-dir-git-branch-string (pwd)
  "Returns current git branch as a string, or the empty string if
PWD is not in a git repo (or the git command is not found)."
  (interactive)
  (when (and (eshell-search-path "git")
             (locate-dominating-file pwd ".git"))
    (let ((git-output (shell-command-to-string (concat "cd " pwd " && git branch | grep '\\*' | sed -e 's/^\\* //'"))))
      (propertize (concat "["
                          (if (> (length git-output) 0)
                              (substring git-output 0 -1)
                            "(no branch)")
                          "]") 'face `(:foreground "green"))
      )))

(setq eshell-prompt-function
      (lambda ()
        (concat
         (propertize ((lambda (p-lst)
                        (if (> (length p-lst) 3)
                            (concat
                             (mapconcat (lambda (elm) (if (zerop (length elm)) ""
                                                        (substring elm 0 1)))
                                        (butlast p-lst 3)
                                        "/")
                             "/"
                             (mapconcat (lambda (elm) elm)
                                        (last p-lst 3)
                                        "/"))
                          (mapconcat (lambda (elm) elm)
                                     p-lst
                                     "/")))
                      (split-string (pwd-repl-home (eshell/pwd)) "/")) 'face `(:foreground "yellow"))
         (or (curr-dir-git-branch-string (eshell/pwd)))
         (propertize "λ " 'face 'default))))

(setq eshell-highlight-prompt nil)

(provide 'eshell-init)
