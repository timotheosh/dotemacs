(when (> emacs-major-version 26)
  (use-package centaur-tabs
    :ensure t
    :demand
    :bind
    ("C-<prior>" . centaur-tabs-backward)
    ("C-<next>" . centaur-tabs-forward)
    :config
    (centaur-tabs-mode t)
    (setq centaur-tabs-style "rounded"
          centaur-tabs-height 24
          centaur-tabs-set-icons t
          centaur-tabs-plain-icons nil
          centaur-tabs-gray-out-icons 'buffer
          centaur-tabs-set-bar 'over
          centaur-tabs-set-close-button nil
          entaur-tabs-set-modified-marker t
          centaur-tabs-modified-marker "*"
          centaur-tabs--buffer-show-groups t
          centaur-tabs-cycle-scope 'tabs)

    (defun centaur-tabs-hide-tab (x)
      (let ((name (format "%s" x)))
	(or
	 (string-prefix-p "*epc" name)
	 (string-prefix-p "*helm" name)
	 (string-prefix-p "*Helm" name)
	 (string-prefix-p "*Compile-Log*" name)
	 (string-prefix-p "*lsp" name)
	 (and (string-prefix-p "magit" name)
	      (not (file-name-extension name))))))

    (defun centaur-tabs-buffer-groups ()
      "`centaur-tabs-buffer-groups' control buffers' group rules.

    Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
    All buffer name start with * will group to \"Emacs\".
    Other buffer group by `centaur-tabs-get-group-name' with project name."
      (list
       (cond
        ((derived-mode-p 'eshell-mode)
         "lisp-shell")
        ((or (derived-mode-p 'term-mode)
             (derived-mode-p 'vterm-mode))
         "terminal")
        ((derived-mode-p 'erc-mode)
         "IRC")
	((or (string-equal "*" (substring (buffer-name) 0 1))
	     (memq major-mode '(magit-process-mode
				magit-status-mode
				magit-diff-mode
				magit-log-mode
				magit-file-mode
				magit-blob-mode
				magit-blame-mode
				)))
	 "Emacs")
        ((memq (current-buffer)
               (condition-case nil
                   (projectile-buffers-with-file-or-process (projectile-project-buffers))
                 (error nil)))
         (projectile-project-name)
         )
	((derived-mode-p 'dired-mode)
	 "Dired")
	((memq major-mode '(helpful-mode
			    help-mode))
	 "Help")
	((memq major-mode '(org-mode
			    org-agenda-clockreport-mode
			    org-src-mode
			    org-agenda-mode
			    org-beamer-mode
			    org-indent-mode
			    org-bullets-mode
			    org-cdlatex-mode
			    org-agenda-log-mode
			    diary-mode))
	 "OrgMode")
	(t
	 (centaur-tabs-get-group-name (current-buffer))))))))
(provide 'centaur-tabs-init)
