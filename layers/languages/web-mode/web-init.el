(use-package web-mode
  :ensure t
  :mode (("\\.html\\'" . web-mode)
         ("\\.tmpl\\'" . web-mode))
  :bind (("RET" . newline-and-indent))
  :config
  (require 'programming-init)

  (defun sp-web-mode-is-code-context (id action context)
    (and (eq action 'insert)
         (not (or (get-text-property (point) 'part-side)
                  (get-text-property (point) 'block-side)))))

  (defun my-web-mode-hook ()
    (setq web-mode-enable-auto-pairing nil))

  (sp-local-pair 'web-mode "<" nil :when '(sp-web-mode-is-code-context))

  (use-package impatient-mode
    :ensure t
    :config
    ;; For impatient mode.
    (defun start-impatient()
      (interactive)
      (setq port 8078)
      (setq httpd-port port)
      (httpd-start)
      (when (or (not (boundp 'impatient-mode))
                'impatient-mode)
        (impatient-mode))
      (shell-command
       (format "x-www-browser http://localhost:%d/imp/live/%s"
               port (buffer-name))))
    (add-hook 'web-mode-hook  'my-web-mode-hook)
    (add-hook 'web-mode-hook
              '(lambda ()
                 (local-set-key [f5] #'start-impatient)))))
(provide 'web-init)
