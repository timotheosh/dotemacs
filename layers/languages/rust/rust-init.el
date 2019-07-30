;;; rust-init.el --- Initialize rust-mode

;; Copyright (C) 2016 Free Software Foundation, Inc.
;;
;; Author: Tim Hawes <tim@easyfreeunix.com>
;; Maintainer: Tim Hawes <tim@easyfreeunix.com>
;; Created: 06 Feb 2016
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
;;   (require 'rust-init)

;;; Code:

(eval-when-compile
  (require 'cl))

(use-package rust-mode
  :ensure t
  :mode (("\\.rs\\'" . rust-mode)
         ("\\.toml\\'" . rust-mode))
  :init
  (use-package programming-init
    :init
    (add-hook 'rust-mode-hook
              (lambda ()
                (setq comment-prefix-start "///")
                (setq comment-prefix-continue "/// ")
                (local-set-key (kbd "C-m") 'my/return-key)))
    (add-hook 'rust-mode-hook 'my-programming-hooks))
  (use-package cargo
    :ensure t)
  (use-package flycheck-rust
    :ensure t)
  (autoload 'rust-mode "rust-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
  (add-hook 'rust-mode-hook 'cargo-minor-mode))

(provide 'rust-init)
;;; rust-init.el ends here
