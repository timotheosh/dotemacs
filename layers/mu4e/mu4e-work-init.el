;; Emacs frontend to mu Maildir mail indexing tool.
;;
;; Set up HTML viewers (Note this has global context)

;; I use mu from nix packages.
(use-package mu4e
  :load-path "~/.nix-profile/share/emacs/site-lisp/mu4e"
  :bind  ("<f2>" . mu4e)
  :config
  (use-package org-mu4e)

  (setq
   mu4e-mu-binary               "~/.nix-profile/bin/mu"
   mu4e-maildir			"~/IninMaildir"	;; top-level Maildir
   mu4e-sent-folder		"/Sent Items"	;; folder for sent messages
   mu4e-drafts-folder	"/Drafts"		;; unfinished messages
   mu4e-trash-folder		"/Trash"		;; trashed messages
   mu4e-refile-folder	"/Archives"		;; saved messages
   mu4e-view-prefer-html t				;; show html as text by default.
                                        ; mu4e-html2text-command "html2text -utf8 -width 72"
   mu4e-html2text-command "iconv -f utf-8 -t utf-8 -c -|sed -e 's/\&nbsp;/ /g'|vilistextum -w 72 -r -c -s -x - - 2>/dev/null"
   mu4e-compose-signature "Tim Hawes
DevOps Engineer
Interactive Intelligence
Tim.Hawes@inin.com
Cell: 919-656-2135
"
   )
;;; View images inline
  (setq mu4e-view-show-images t)
  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))
;;; convert org mode to HTML automatically
  (setq org-mu4e-convert-to-html t)
;;; message view action in a web browser option
  (defun mu4e-msgv-action-view-in-browser (msg)
    "View the body of the message in a web browser."
    (interactive)
    (let ((html (mu4e-msg-field (mu4e-message-at-point t) :body-html))
          (tmpfile (format "%s/%d.html" temporary-file-directory (random))))
      (unless html (error "No html part for this message"))
      (with-temp-file tmpfile
        (insert
         "<html>"
         "<head><meta http-equiv=\"content-type\""
         "content=\"text/html;charset=UTF-8\">"
         html))
      (setq browse-url-browser-function 'browse-url-generic
            browse-url-generic-program "x-www-browser")
      (browse-url (concat "file://" tmpfile))))
  (add-to-list 'mu4e-view-actions
               '("View in browser" . mu4e-msgv-action-view-in-browser) t)

                                        ; (add-hook 'mu4e-view-mode-hook 'longlines-mode)
                                        ; (add-hook 'mu4e-view-mode-hook 'mu4e-view-hide-cited)

  ;; Bookmarks
  (add-to-list 'mu4e-bookmarks
               '("maildir:\"/CoudWatch Alerts\" flag:unread OR maildir:\"/Cron Alerts\" flag:unread OR maildir:\"/Dynamo Alerts\" flag:unread OR maildir:/Jenkins flag:unread OR maildir:/Alerts flag:unread OR maildir:\"Junk E-Mail\" flag:unread"  "Unread Alerts"   ?a))
  (add-to-list 'mu4e-bookmarks
               '("maildir:/INBOX flag:unread"       "Unread INBOX"     ?i))

  ;; Signature
  (setq mu4e-compose-signature-auto-include t)
  ;; org-mail should use org-mu4e
  (defalias 'org-mail 'org-mu4e-compose-org-mode)
  ;; don't keep message buffers around
  (setq message-kill-buffer-on-exit t))
(provide 'mu4e-work-init)
