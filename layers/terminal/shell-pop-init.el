(use-package shell-pop
  :bind (("<f3>" . shell-pop))
  :ensure t
  :config
  (setq shell-pop-shell-type (quote ("eshell" "*eshell*" (lambda nil (eshell shell-pop-term-shell)))))
  ;; need to do this manually or not picked up by `shell-pop'
  (shell-pop--set-shell-type 'shell-pop-shell-type shell-pop-shell-type))
(provide 'shell-pop-init)
