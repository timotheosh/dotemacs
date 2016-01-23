;; Auto-complete
(use-package auto-complete
  :init
  (require 'auto-complete-config)

  ;; By setting ac-modes to a single mode, Auto-complete will only become
  ;; active when additional modes are explicitly added to the list, even
  ;; when global-auto-complete-mode is true.
  (setq ac-modes '(emacs-lisp-mode))

  (add-to-list
   'ac-dictionary-directories (expand-file-name
                               "~/.emacs.d/ac-dict"))
  (setq ac-comphist-file (expand-file-name
                          "~/.emacs.d/ac-comphist.dat")))
  (global-auto-complete-mode t)
(provide 'auto-complete-init)
