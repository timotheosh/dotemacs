;; Emacs Code Browser (ECB)
;;
;(add-hook 'ecb-activate-before-layout-draw-hook
;  (lambda () (ecb-hide-ecb-windows)))
(use-package ecb-autoloads
  :init
  (progn
    (add-hook 'ecb-activate-hook
        (lambda ()
          (setq ecb-layout-name "tim-layout1")
          (ecb-hide-ecb-windows)
          (ecb-layout-define "tim-layout1" left nil
                             "This function creates the following layout:

                   -------------------------------------------------------
                   |              |                                      |
                   |              |                                      |
                   |              |                                      |
                   |  Methods     |                                      |
                   |              |                                      |
                   |              |                                      |
                   |              |                                      |
                   |--------------|                 Edit                 |
                   |              |                                      |
                   |              |                                      |
                   |              |                                      |
                   |  Sources     |                                      |
                   |              |                                      |
                   |              |                                      |
                   |              |                                      |
                   -------------------------------------------------------
                   |                                                     |
                   |                    Compilation                      |
                   |                                                     |
                   -------------------------------------------------------

     If you have not set a compilation-window in
     `ecb-compile-window-height' then the layout contains no
     persistent compilation window and the other windows get a
     little more place."

                             (if (fboundp (quote ecb-set-methods-buffer))
                                 (ecb-set-methods-buffer)
                               (ecb-set-default-ecb-buffer))
                             (dotimes (i 2)
                               (other-window 1)
                               (if (equal (selected-window) ecb-compile-window)
                                   (other-window 1)))
                             (ecb-split-ver 0.5 t)
                             (if (fboundp (quote ecb-set-methods-buffer))
                                 (ecb-set-methods-buffer)
                               (ecb-set-default-ecb-buffer))
                             (dotimes (i 1)
                               (other-window 1)
                               (if (equal (selected-window) ecb-compile-window)
                                   (other-window 1)))
                             (if (fboundp (quote ecb-set-sources-buffer))
                                 (ecb-set-sources-buffer)
                               (ecb-set-default-ecb-buffer))
                             (dotimes (i 2)
                               (other-window 1)
                               (if (equal (selected-window) ecb-compile-window)
                                   (other-window 1)))
                             (dotimes (i 2)
                               (other-window 1)
                               (if (equal (selected-window) ecb-compile-window)
                                   (other-window 1))))))
    (setq ecb-tip-of-the-day nil)))
(provide 'ecb-init)
