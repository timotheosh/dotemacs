;; Helm config
(use-package helm
  :ensure helm
  :init
  (require 'helm-config)
  (setq helm-ff-transformer-show-only-basename nil
	helm-adaptive-history-file             (concat user-emacs-directory "helm-history")
	helm-yank-symbol-first                 t
	helm-move-to-line-cycle-in-source      t
	helm-buffers-fuzzy-matching            t
	helm-ff-auto-update-initial-value      t)

  (autoload 'helm-descbinds      "helm-descbinds" t)
  (autoload 'helm-eshell-history "helm-eshell"    t)
  (autoload 'helm-esh-pcomplete  "helm-eshell"    t)
  (helm-adaptive-mode t)

  (global-set-key (kbd "C-h i")    #'helm-info)
  (global-set-key (kbd "C-h b")    #'helm-descbinds)

  (add-hook 'eshell-mode-hook
	    #'(lambda ()
		(define-key eshell-mode-map (kbd "TAB")     #'helm-esh-pcomplete)
		(define-key eshell-mode-map (kbd "C-c C-l") #'helm-eshell-history)))

  (global-set-key (kbd "C-x r l") #'helm-filtered-bookmarks)
  (global-set-key (kbd "M-y")     #'helm-show-kill-ring)
  (global-set-key (kbd "C-x c!")   #'helm-calcul-expression)
  (global-set-key (kbd "C-x c:")   #'helm-eval-expression-with-eldoc)
  (define-key helm-map (kbd "M-o") #'helm-previous-source))
(provide 'helm-init)
