;; Json mode
(use-package json-mode
  :ensure t
  :mode ("\\.json\\'" . json-mode)
  :init
  (require 'programming-init)
  (use-package json-snatcher
    :ensure t)
  (add-hook 'json-mode-hook
            (lambda ()
              (make-local-variable 'js-indent-level)
              (setq js-indent-level 4)))

  (defun js-mode-bindings ()
    "Sets a hotkey for using the json-snatcher plugin"
    (when (string-match  "\\.json$" (buffer-name))
      (local-set-key (kbd "C-c C-g") 'jsons-print-path)))
  (add-hook 'json-mode-hook 'smartparens-mode)
  (add-hook 'json-mode-hook 'js-mode-bindings))
(provide 'json-init)
