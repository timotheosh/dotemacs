;; load slime
(setq inferior-lisp-program (expand-file-name "/home/thawes/.nix-profile/bin/sbcl"))
(require 'slime)
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
(slime-setup '(slime-fancy))
