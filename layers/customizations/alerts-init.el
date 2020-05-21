(use-package notifications)

(defun get-dbus ()
  "Returns current DBUS"
  (getenv "DBUS_SESSION_BUS_ADDRESS"))

(defun my-on-action-function (id key)
  (message "Message %d, key \"%s\" pressed" id key))

(defun my-on-close-function (id reason)
  (message "Message %d, closed due to \"%s\"" id reason))

(defun this-is-important ()
  (notifications-notify
   :title "Title"
   :body "This is <b>important</b>."
   :actions '("Confirm" "I agree" "Refuse" "I disagree")
   :on-action 'my-on-action-function
   :on-close 'my-on-close-function
   :sound t
   :sound-file "/usr/share/sounds/sound-icons/xylofon.wav"))

(defun my/play-sound (file-path)
  (start-process "play-sound" nil
                 "cvlc" "--play-and-exit" "--no-loop" file-path))


(setq ring-bell-function (lambda ()
                           (my/play-sound "/usr/share/sounds/sound-icons/cembalo-6.wav")))

(add-hook 'initial-buffer-choice)
(this-is-important)
(play-sound-file "/usr/share/sounds/sound-icons/xylofon.wav")
(my/play-sound "/usr/share/sounds/sound-icons/xylofon.wav")
(my/play-sound "/usr/share/sounds/Oxygen-Im-Message-In.ogg")
(my/play-sound "/usr/local/share/sounds/Enchanted/stereo/desktop-login.ogg")
;; (notifications-notify :title "Hellooooo from Emacs!!!" :body "Justa friendly message from Emacs!" :urgency 'critical)
(provide 'alerts-init)
