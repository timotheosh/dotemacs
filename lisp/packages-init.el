;; Had to require explicitly for cask to load
(require 'eieio)
(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
        "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives 
    '("MELPA" .
        "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
     '("gnu" .
        "http://elpa.gnu.org/packages/"))
(package-initialize)
(pallet-mode t)
