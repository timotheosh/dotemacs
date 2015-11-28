(use-package function-args
    :init
    (fa-config-default)
    (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
    (add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
    (set-default 'semantic-case-fold t))

