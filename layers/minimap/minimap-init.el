;; Setting up the minimap

(use-package minimap
  :bind ("<f7>" . minimap-toggle)
  :init
  (require 'minimap)
  (custom-set-variables
   '(minimap-dedicated-window nil)
   '(minimap-hide-scroll-bar t)
   '(minimap-window-location (quote right))))
(provide 'minimap-init)
