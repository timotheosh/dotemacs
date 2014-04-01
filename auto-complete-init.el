;; Auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/hawest/.emacs.d/plugins/ac-dict")
(ac-config-default)

(require 'auto-complete)
(global-auto-complete-mode t)
