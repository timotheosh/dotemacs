(use-package company
  :ensure t)
(use-package company-quickhelp
  :ensure t)
(company-quickhelp-mode 1)
(setq company-idle-delay 0
      company-minimum-prefix-length 1
      company-selection-wrap-around t
      company-quickhelp-delay 0.7
      company-tooltip-align-annotations t)
(provide 'company-init)
