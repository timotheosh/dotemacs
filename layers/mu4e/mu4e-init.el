;; Mu4e Email
(if (string= system-name "dunscotus")
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
    (require 'mu4e-home)))
(provide 'mu4e-init)
