;;; kindly-init.el --- Init for Kindly-mode. Kindle like viewer in Emacs

;; Copyright (C) 2016 Free Software Foundation, Inc.
;;
;; Author: Tim Hawes <Tim.Hawes@inin.com>
;; Maintainer: Tim Hawes <Tim.Hawes@inin.com>
;; Created: 27 Jan 2016
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
;;   (require 'kindly-init)

;;; Code:

(eval-when-compile
  (require 'cl))

(use-package kindly-mode
  :load-path "~/.emacs.d/programs/kindly-mode/"
  :init
  (require 'kindly-mode))


(provide 'kindly-init)
;;; kindly-init.el ends here
