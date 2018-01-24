(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'" . js2-mode)
  :config
  ;; Setup according to this article:
  ;; https://emacs.cafe/emacs/javascript/setup/2017/04/23/emacs-setup-javascript.html
  (add-hook 'js2-mode-hook #'js2-imenu-extras-mode)

  (use-package js2-refactor
    :ensure t)

  (use-package xref-js2
    :ensure t)

  (add-hook 'js2-mode-hook #'js2-refactor-mode)
  (js2r-add-keybindings-with-prefix "C-c C-r")
  (define-key js2-mode-map (kbd "C-k") #'js2r-kill)

  ;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
  ;; unbind it.
  (define-key js-mode-map (kbd "M-.") nil)

  (add-hook 'js2-mode-hook
            (lambda ()
              (add-hook 'xref-backend-functions
                        #'xref-js2-xref-backend nil t)))

  ;; Setup according to this article:
  ;; https://emacs.cafe/emacs/javascript/setup/2017/05/09/emacs-setup-javascript-2.html

  ;; auto-complete
  (use-package company
    :ensure t)

  (use-package company-tern
    :ensure t)

  (add-to-list 'company-backends 'company-tern)
  (add-hook 'js2-mode-hook (lambda ()
                             (tern-mode)
                             (company-mode)))

  ;; Disable completion keybindings, as we use xref-js2 instead
  (define-key tern-mode-keymap (kbd "M-.") nil)
  (define-key tern-mode-keymap (kbd "M-,") nil))
(provide 'javascript-init)
