(use-package ido
    :init
    (ido-mode t)

    ;; Stop annoying ido bug whan I want to go remote
    (custom-set-variables
        '(ido-enable-tramp-completion nil)))

(provide 'ido-init)
