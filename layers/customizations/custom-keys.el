; Keep the second mouse button from moving the cursor while pasting.
(global-set-key [mouse-2] 'yank)

(defun create-text-scratch-buffer nil
  "create a text scratch buffer"
  (interactive)
  (switch-to-buffer (get-buffer-create "*text-scratch*"))
  (text-mode))

(global-set-key [f1] 'dired)
;;(global-set-key [f2] 'mu4e)
(global-set-key [f3] 'shell)
(global-set-key [f4] 'find-file)
;; for helm
;;(global-set-key [f4] #'helm-find-files)
;;(global-set-key [f5] 'compile)
(global-set-key [f5] 'create-text-scratch-buffer)
;;(global-set-key [f6] 'kill-this-buffer)
;;(global-set-key [f7] 'make-frame)
(global-set-key [f9] 'menu-bar-mode)

(provide 'custom-keys)
