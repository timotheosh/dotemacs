; Keep the second mouse button from moving the cursor while pasting.
(global-set-key [mouse-2] 'yank)

(global-set-key [f1] 'dired)
(global-set-key [f2] 'mu4e)
(global-set-key [f3] 'shell)
(global-set-key [f4] 'find-file)
; for helm
;(global-set-key [f4] #'helm-find-files)
;(global-set-key [f5] 'compile)
;(global-set-key [f6] 'kill-this-buffer)
;(global-set-key [f7] 'make-frame)
(global-set-key [f9] 'menu-bar-mode)
(global-set-key [f10] 'ecb-toggle-ecb-windows)

;;  WindowMaker uses f11 and f12 by default

;; For working with WebDX
(defun my-html-mode-hook ()
  "My HTML mode configuration."
  (local-set-key (kbd "M-RET")
                 (lambda ()
                   (interactive)
                   (shell-command "/home/hawest/bin/sync_webdx")))
)
(add-hook 'php-mode-hook 'my-php-mode-hook)
(add-hook 'html-mode-hook 'my-html-mode-hook)
(add-hook 'js-mode-hook 'my-html-mode-hook)

(defun ecb-mode-hook ()
  "Key binding for starting and stopping ecb mode.
   Convenient for emacs running in terminal."
	 (local-set-key (kbd "C-x x")
					'ecb-toggle-ecb-windows))

(add-hook 'php-mode-hook 'ecb-mode-hook)
(add-hook 'html-mode-hook 'ecb-mode-hook)
(add-hook 'js-mode-hook 'ecb-mode-hook)
(provide 'custom-keys)
