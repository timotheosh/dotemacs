(use-package helm
  :ensure t
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (require 'helm-projectile)
    (setq helm-candidate-number-limit 100)
    (helm-adaptive-mode t)
    (helm-projectile-on)
    (autoload 'helm-descbinds      "helm-descbinds" t)
    (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
          helm-input-idle-delay 0.01  ; this actually updates things
                                        ; reeeelatively quickly.
          helm-yas-display-key-on-candidate t
          helm-quick-update t
          helm-ff-skip-boring-files t
	  helm-ff-transformer-show-only-basename nil
	  helm-adaptive-history-file             "~/.emacs.d/helm-history"
	  helm-yank-symbol-first                 t
	  helm-move-to-line-cycle-in-source      t
	  helm-buffers-fuzzy-matching            t
	  helm-ff-auto-update-initial-value      t
	  helm-projectile-sources-list (cons 'helm-source-projectile-files-list
					     (remove 'helm-source-projectile-files-list 
						     helm-projectile-sources-list)))
    (define-key projectile-mode-map (kbd "C-c p /")
      #'(lambda ()
	  (interactive)
	  (helm-ag (projectile-project-root))))

    (helm-mode))
  :bind (("C-c h" . helm-mini)
         ("C-h a" . helm-apropos)
	 ("C-h i" . helm-info-emacs)
	 ("C-h b" . helm-descbinds)
         ("C-x C-b" . helm-buffers-list)
         ("C-x b" . helm-buffers-list)
         ("M-y" . helm-show-kill-ring)
	 ("C-x C-r" . helm-recentf)
	 ("C-x c!" . helm-calcul-expression)
	 ("C-x c:" . helm-eval-expression-with-eldoc)
	 ("C-x r l" . helm-filtered-bookmarks)
         ("C-x c o" . helm-occur)
         ("C-x c s" . helm-swoop)
         ("C-x c y" . helm-yas-complete)
         ("C-x c Y" . helm-yas-create-snippet-on-region)
         ("C-x c b" . my/helm-do-grep-book-notes)
         ("C-x c SPC" . helm-all-mark-rings)
	 ("M-o" . helm-previous-source)
	 ("M-s s" . helm-ag)
	 ("M-s o" . helm-swoop)
	 ("M-s /" . helm-multi-swoop)
	 ("M-y" . helm-show-kill-ring)))

(provide 'helm-init)
