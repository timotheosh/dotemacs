;; Emacs frontend to mu Maildir mail indexing tool.
;;
;; Set up HTML viewers (Note this has global context)

(require 'mu4e)
(require 'org-mu4e)
(setq
  mu4e-maildir                  "~/Maildir"	;; top-level Maildir
  mu4e-sent-folder              "/INBOX.Sent"	;; folder for sent messages
  mu4e-drafts-folder    "/INBOX.Drafts"		;; unfinished messages
  mu4e-trash-folder             "/INBOX.Trash"	;; trashed messages
  mu4e-refile-folder    "/INBOX.Archives"	;; saved messages
  mu4e-view-prefer-html t                               ;; show html as text by default.
  mu4e-html2text-command "html2text -utf8 -width 72"
  )
;;; View images inline
(setq mu4e-view-show-images t)
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))
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


(add-hook 'mu4e-compose-pre-hook 
    (defun my-set-from-address () 
        "Set the From address based on the To address of the original." 
        (let ((msg mu4e-compose-parent-message)) ;; msg is shorter... 
            (if msg 
                (setq user-mail-address
                    (cond
                        ((mu4e-message-contact-field-matches msg :to "tim.hawes@hzmarketing.com")
                          "tim.hawes@hzmarketing.com")
                        ((mu4e-message-contact-field-matches msg :cc "tim.hawes@hzmarketing.com")
                          "tim.hawes@hzmarketing.com")
                        ((mu4e-message-contact-field-matches msg :to "trhawes@althusius.net")
                          "trhawes@althusius.net")
                        ((mu4e-message-contact-field-matches msg :cc "trhawes@althusius.net")
                          "trhawes@althusius.net")
                        ((mu4e-message-contact-field-matches msg :to "family@althusius.net")
                          "family@althusius.net")
                        ((mu4e-message-contact-field-matches msg :cc "family@althusius.net")
                          "family@althusius.net")
                        ((mu4e-message-contact-field-matches msg :to "tim@selfdidactic.com")
                          "tim@selfdidactic.com")
                        ((mu4e-message-contact-field-matches msg :cc "tim@selfdidactic.com")
                          "tim@selfdidactic.com")
                        ((mu4e-message-contact-field-matches msg :to "tim@hawesresume.com")
                          "tim@hawesresume.com")
                        ((mu4e-message-contact-field-matches msg :cc "tim@hawesresume.com")
                          "tim@hawesresume.com")
                        ((mu4e-message-contact-field-matches msg :to "tim-0EBVIZ@mailbox.insight.ly")
                          "tim-0EBVIZ@mailbox.insight.ly")
                        ((mu4e-message-contact-field-matches msg :cc "tim-0EBVIZ@mailbox.insight.ly")
                          "tim-0EBVIZ@mailbox.insight.ly")
                        (t "tim@easyfreeunix.com")))
                ))))


; (add-hook 'mu4e-view-mode-hook 'longlines-mode)
; (add-hook 'mu4e-view-mode-hook 'mu4e~view-hide-cited)

(setq mu4e-org-contacts-file "~/org/Contacts.org") 
(add-to-list 'mu4e-headers-actions
  '("org-contact-add" . mu4e-action-add-org-contact) t)
(add-to-list 'mu4e-view-actions
  '("org-contact-add" . mu4e-action-add-org-contact) t)
