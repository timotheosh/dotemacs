;; Json mode
(use-package json-mode
    :mode ("\\.json\\'" . json-mode)
    :init
    (require 'json-snatcher)
    (add-hook 'json-mode-hook
        (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

    (defun js-mode-bindings ()
        "Sets a hotkey for using the json-snatcher plugin"
        (when (string-match  "\\.json$" (buffer-name))
            (local-set-key (kbd "C-c C-g") 'jsons-print-path)))
    (add-hook 'json-mode-hook 'js-mode-bindings))
(provide 'json-init)
