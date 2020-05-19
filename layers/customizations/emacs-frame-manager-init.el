;;; emacs-frame-manager-init.el --- Functions for opening Emacs frames with emacsclient.

;; Copyright (C) 2020 Tim Hawes <thawes@origen>
;; Maintainer: Tim Hawes
;; Created: 15 May 2020
;; Version: 0.01
;; Keywords

;;; Commentary:

;;

;; Put this file into your load-path and the following into your ~/.emacs:
;;   (require 'emacs-frame-manager-init)

;;; Code:

(defvar efm/frame-name "emacs-frame-manager997")
(defvar efm/shell-name "emacs-frame-manager335")
(defvar efm/org-name "emacs-frame-manager919")
(defvar efm/legit-frames (list efm/frame-name efm/shell-name efm/org-name "F1"))

(defvar efm/mapped-commands '((ibuffer . "*ibuffer*")))

(defun efm/find-frame (frame-name)
  "Returns a list of frames with frame-name."
  (remove-if-not
   (lambda (x)
     (string= (frame-parameter x 'name) frame-name))
   (frame-list)))

(defun efm/list-illegite-frames ()
  "Lists visible illegitimate frames"
  (remove-if
   (lambda (x)
     (seq-find (lambda (y)
                 (string= y
                          (frame-parameter x 'name))) efm/legit-frames))
   (remove-if-not 'frame-visible-p (frame-list))))

(defun efm/kill-illegite-frames ()
  (dolist (buf (efm/list-illegite-frames))
    (delete-frame buf)))

(defun efm/frame-visible-p (frame-name)
  "Returns a list of visible frames with frame-name."
  (remove-if
   'null
   (mapcar 'frame-visible-p (efm/find-frame frame-name))))

(defun efm/frame-focused-p (frame-name)
  "Returns a list of focused frames with frame-name."
  (remove-if
   'null
   (mapcar 'frame-focus-state (efm/find-frame frame-name))))

(defun efm/maximized-p (frame)
  "Returns true if frame is maximized or fullboth."
  (cdr (assoc 'fullscreen (frame-parameters frame))))

(defun efm/create-frame (frame-name frame-title)
  "Creates a maximized frame, raised and in focus."
  (make-frame-on-display (getenv "DISPLAY") `((name . ,frame-name)
                                              (title . ,frame-title)
                                              (fullscreen . maximized)
                                              (window-system . x)))
  (let ((frame (car (efm/find-frame name))))
    (frame-focus frame)
    (x-focus-frame frame)))

(defun efm/raise-frame (frame)
  "Raises a frame and puts it in focus."
  (raise-frame frame)
  (select-frame frame)
  (x-focus-frame frame))

(defun efm/frame-focus-maximize (frame &optional command)
  "Raise, focus, and maximize a frame."
  (efm/raise-frame frame)
  (modify-frame-parameters frame '((fullscreen . maximized)))
  (when command
    (eval (list (intern command)))))

(defun efm/start-client-with-command (name title &optional command skip-taskbar)
  "Create a new frame, executing command."
  (efm/create-frame name title)
  (if command
      (eval (list (intern command)))
    (switch-to-buffer "*dashboard*"))
  (when skip-taskbar
    (modify-frame-parameters (car (efm/find-frame name)) '((skip-taskbar t)
                                                           (undecorated t)))))

(defun efm/raise-or-start (name title &optional command toggle skip-taskbar)
  "If frame with name does not exist, create it, otherwise raise, focus and maximize the existing frame."
  (let ((frame (car (efm/find-frame name))))
    (if frame
        (if (and (frame-focus-state frame)
                 (efm/maximized-p frame)
                 (or (and (null command) (null toggle))
                     (and (not (null command)) (not (null toggle)))))
            (progn (select-frame frame)
                   (suspend-frame))
          (efm/frame-focus-maximize frame command))
      (efm/start-client-with-command name title command skip-taskbar))))

(defun efm/buffer-focus-p (buffer-or-name)
  "Returns true if buffer is already open."
  (when (get-buffer-window-list buffer-or-name)
    t))

(defun efm/get-dashboard ()
  (switch-to-buffer "*dashboard*"))

(provide 'emacs-frame-manager-init)
;;; emacs-frame-manager-init.el ends here
