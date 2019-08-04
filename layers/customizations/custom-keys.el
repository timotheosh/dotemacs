; Keep the second mouse button from moving the cursor while pasting.
(global-set-key [mouse-2] 'yank)

(defun create-text-scratch-buffer nil
  "create a text scratch buffer"
  (interactive)
  (switch-to-buffer (get-buffer-create "*text-scratch*"))
  (text-mode))

;; isearch replacement
(use-package swiper
  :ensure t)

;; Useful for showing recent choices.
(use-package smex
  :ensure t
  :init
  (smex-initialize))

;; Useful for showing key options.
(use-package which-key
  :ensure t
  :diminish (which-key-mode . "")
  :init (which-key-mode 1))

(use-package general
  :ensure t
  :config
  (general-define-key "C-s" 'swiper))

(global-set-key [f1] 'projectile-switch-project)
(global-set-key [f2] 'projectile-switch-open-project)
(global-set-key [f4] 'find-file)
(global-set-key [f9] 'menu-bar-mode)

(provide 'custom-keys)
