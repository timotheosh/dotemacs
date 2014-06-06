;; GNU global ggtags
(autoload 'ggtags-mode "gtags" "" t)
(add-hook 'ggtags-mode-hook
  (lambda()
    (local-set-key (kbd "M-.") 'ggtags-find-tag)   ; find a tag, also M-.
    (local-set-key (kbd "M-,") 'ggtags-find-rtag)))  ; reverse tag

;; GNU Global incremental update
   (defun gtags-root-dir ()
    "Returns GTAGS root directory or nil if doesn't exist."
    (with-temp-buffer
      (if (zerop (call-process "global" nil t nil "-pr"))
          (buffer-substring (point-min) (1- (point-max)))
        nil)))

  (defun gtags-update ()
    "Make GTAGS incremental update"
    (call-process "global" nil nil nil "-u"))

  (defun gtags-update-hook ()
    (when (gtags-root-dir)
      (gtags-update)))

  (add-hook 'after-save-hook #'gtags-update-hook)
