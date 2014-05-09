;; Emacs Code Browser (ECB)
;;
;(add-hook 'ecb-activate-before-layout-draw-hook
;  (lambda () (ecb-hide-ecb-windows)))
(require 'ecb-autoloads)
(add-hook 'ecb-activate-hook
    (lambda ()
	  (ecb-hide-ecb-windows)))
(setq ecb-tip-of-the-day nil)
(ecb-minor-mode 1)
