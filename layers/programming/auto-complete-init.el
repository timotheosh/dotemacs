;; Auto-complete
(use-package auto-complete
  :init
  (require 'auto-complete-config)
  (add-to-list
   'ac-dictionary-directories (expand-file-name
                               "~/.emacs.d/ac-dict"))
  (setq ac-comphist-file (expand-file-name
                          "~/.emacs.d/ac-comphist.dat")))
  (global-auto-complete-mode t)
(provide 'auto-complete-init)
