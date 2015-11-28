;; Setting up the minimap

(use-package minimap
    ;:init
    ;(custom-set-variables
    ;  '(minimap-dedicated-window nil)
    ;  '(minimap-hide-scroll-bar t)
    ;  '(minimap-window-location (quote right)))
)
(global-set-key [f7] 'minimap-toggle)
