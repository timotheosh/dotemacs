(use-package geiser
  :ensure t
  :config
  (local-set-key (kdb "C-x C-s") #'geiser-repl--write-input-ring)
  (add-to-list 'ac-modes 'geiser-mode)
  (add-hook 'scheme-mode-hook 'geiser-mode))
(provide 'geiser-init)
