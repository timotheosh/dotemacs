;; System is always loading jdee, so no longer encapsulating with use-package
(use-package jdee
  :ensure t
  :init
  (setq jdee-sourcepath '("~/src" "~/programs/src"))  ; TODO Find a
                                        ; way to make this dependent
                                        ; on projectile.
  (setq jdee-server-dir "~/.emacs.d/programs/jdee-server/target")
  (add-to-list 'ac-modes 'jdee-mode)
  (use-package java-imports
    :ensure t
    :init
    (define-key java-mode-map (kbd "M-I") 'java-imports-add-import-dwim)
    (setq java-imports-find-block-function 'java-imports-find-place-sorted-block))
  (use-package javadoc-lookup
    :ensure t)
  (use-package programming-init)
  (use-package smartparens)
  ;; Adds a line when using curly braces for writing classes/methods.
  (sp-local-pair '(jdee-mode)
                 "{" nil :post-handlers
                 '((my/create-newline-format "RET")))
  (javadoc-add-roots "/usr/lib/jvm/java-1.8.0-openjdk-amd64/docs/api/")
  (setq jde-complete-add-space-after-method t)
  (add-hook 'jdee-mode-hook 'auto-complete-mode)
  (add-hook 'jdee-mode-hook 'my-programming-mode)
  (add-hook 'jdee-mode-hook 'linum-mode)
  (add-hook 'jdee-mode-hook 'smartparens-mode)
  (add-hook 'jdee-mode-hook 'java-imports-scan-file))
(provide 'java-init)
