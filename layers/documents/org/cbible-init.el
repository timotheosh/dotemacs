(use-package cbible
  :load-path "programs/cbible/elisp/"
  :init
  (eval-after-load 'org-mode
    '(progn
       (require 'cbible)
       (add-hook 'org-mode-hook 'cbible-mode))))
(provide 'cbible-init)
