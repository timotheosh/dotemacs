;; Setting up the minimap
;;;###autoload
(use-package minimap
  :ensure minimap
  :defer t
  :bind ("<f7>" . minimap-toggle)
  :config
  (defun minimap-toggle ()
    "Toggle minimap for current buffer."
    (interactive)
    (if (or (not (boundp 'minimap-bufname))
            (null minimap-bufname))
        (minimap-create)
      (minimap-kill)))
  :init
  (require 'minimap)
  (custom-set-variables
   '(minimap-dedicated-window nil)
   '(minimap-recreate-window nil)
   '(minimap-hide-scroll-bar t)
   ;; '(minimap-major-modes nil)
   '(minimap-window-location (quote right))))
(provide 'minimap-init)
