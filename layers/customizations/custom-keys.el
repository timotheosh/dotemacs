; Keep the second mouse button from moving the cursor while pasting.
(global-set-key [mouse-2] 'yank)

(defun create-text-scratch-buffer nil
  "create a text scratch buffer"
  (interactive)
  (switch-to-buffer (get-buffer-create "*text-scratch*"))
  (text-mode))

(global-set-key [f1] 'dired)
(global-set-key [f3] 'shell)
(global-set-key [f4] 'find-file)
(global-set-key [f5] 'create-text-scratch-buffer)
(global-set-key [f9] 'menu-bar-mode)
(global-unset-key [M-f10])  ; Reserved for projectile-speedbar

(provide 'custom-keys)
