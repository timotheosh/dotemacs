(use-package powerline
  :ensure powerline
  :init
  (defcustom powerline-default-separator 'wave
    "The separator to use for the default theme."
    :group 'powerline
    :type '(choice (const alternate)
                   (const arrow)
                   (const arrow-fade)
                   (const bar)
                   (const box)
                   (const brace)
                   (const butt)
                   (const chamfer)
                   (const contour)
                   (const curve)
                   (const rounded)
                   (const roundstub)
                   (const slant)
                   (const wave)
                   (const zigzag)
                   (const nil)))
  (powerline-default-theme))
(provide 'powerline-init)
