(use-package alert
  :ensure t
  :config
  (alert-add-rule :status   '(buried visible idle)
                  :severity '(moderate high urgent)
                  :predicate
                  #'(lambda (info)
                      info)
                  :persistent
                  #'(lambda (info)
                      info)
                  :style 'fringe
                  :continue t))

(alert "testing")
alert-user-configuration
(provide 'alerts-init)
(let ((name "there"))
  (alert (format "hello, %s" name) :severity 'high :title "DISASTER!!!" :persistent t :data ))
(notifications-notify :title "Hellooooo from Emacs!!!" :body "Justa friendly message from Emacs!" :urgency 'critical :bus :system)


(dbus-init-bus my-dbus-address)
(defun my-on-action-function (id key)
  (message "Message %d, key \"%s\" pressed" id key))

(defun my-on-close-function (id reason)
  (message "Message %d, closed due to \"%s\"" id reason))

(notifications-notify
 :title "Title"
 :body "This is <b>important</b>."
 :actions '("Confirm" "I agree" "Refuse" "I disagree")
 :on-action 'my-on-action-function
 :on-close 'my-on-close-function
 :bus my-dbus-address)
(dbus--init-bus :system)
(require 'notifications)

(defun dbus-capable ()
  "Check if dbus is available"
  (unwind-protect
      (let (retval)
        (condition-case ex
            (setq retval (dbus-ping :system "org.freedesktop.Notifications"))
          ('error
           (message (format "Error: %s - No dbus" ex))))
        retval)))
(dbus-capable)
