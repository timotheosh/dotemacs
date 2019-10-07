;;; magit-init.el --- Initialize magit for git

;; Copyright (C) 2016 Free Software Foundation, Inc.
;;
;; Author: Tim Hawes <Tim.Hawes@inin.com>
;; Maintainer: Tim Hawes <Tim.Hawes@inin.com>
;; Created: 22 Jan 2016
;; Version: 0.01
;; Keywords

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;;

;; Put this file into your load-path and the following into your ~/.emacs:
;;   (require 'magit-init)

;;; Code:

(eval-when-compile
  (require 'cl))

(use-package magit
  :ensure t
  :init
  (defun magit-push-arguments-maybe-upstream (magit-push-popup-fun &rest args)
    "Enable --set-upstream switch if there isn't a current upstream."
    (let ((magit-push-arguments
           (if (magit-get-remote) magit-push-arguments
             (cons "--set-upstream" magit-push-arguments))))
      (apply magit-push-popup-fun args)))
  (advice-add 'magit-push-popup :around #'magit-push-arguments-maybe-upstream))
(provide 'magit-init)
;;; magit-init.el ends here
