;;; ansible-init.el --- Initialize ansible-mode

;; Copyright (C) 2016 Free Software Foundation, Inc.
;;
;; Author: Tim Hawes <tim@easyfreeunix.com>
;; Maintainer: Tim Hawes <tim@easyfreeunix.com>
;; Created: 09 Feb 2016
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
;;   (require 'ansible-init)

;;; Code:

(eval-when-compile
  (require 'cl))

(use-package ansible
  :ensure t
  :defer t
  :init
  (require 'ansible)
  (use-package company
    :ensure t
    :config
    (eval-after-load 'company
      '(add-to-list 'company-backends 'company-ansible)))
  (add-hook 'ansible-mode-hook 'company-mode)
  (add-hook 'ansible-mode-hook 'ansible-doc-mode-hook))
(provide 'ansible-init)
;;; ansible-init.el ends here
