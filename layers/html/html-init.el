(use-package web-mode
  :mode ("\\.html\\'" . web-mode)
  :bind (("RET" . newline-and-indent))
  :config
  (require 'programming-init)

  (defun sp-web-mode-is-code-context (id action context)
    (and (eq action 'insert)
         (not (or (get-text-property (point) 'part-side)
                  (get-text-property (point) 'block-side)))))

  (defun my-web-mode-hook ()
    (setq web-mode-enable-auto-pairing nil))

  (add-hook 'web-mode-hook  'my-web-mode-hook)

  (sp-local-pair 'web-mode "<" nil :when '(sp-web-mode-is-code-context)))
(provide 'html-init)
