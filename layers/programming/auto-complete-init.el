;; Auto-complete
(use-package auto-complete
  :defer t
  :init
  (require 'auto-complete-config)
  (add-to-list
   'ac-dictionary-directories (expand-file-name
                               "~/.emacs.d/ac-dict"))
  (setq ac-comphist-file (expand-file-name
                          "~/.emacs.d/ac-comphist.dat")))
(provide 'auto-complete-init)
