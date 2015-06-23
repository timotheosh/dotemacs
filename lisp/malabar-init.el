(add-hook 'after-init-hook (lambda ()
  (message "activate-malabar-mode")
  (activate-malabar-mode)))

(add-hook 'malabar-java-mode-hook 'flycheck-mode)
(add-hook 'malabar-groovy-mode-hook 'flycheck-mode)

;; Auto-populate an empty java file
;; http://software-ninja-ninja.blogspot.com/2014/03/using-malabar-mode-to-auto-populate-new.html
(add-hook 'malabar-mode-hook
      '(lambda ()
         (when (= 0 (buffer-size))
           (malabar-codegen-insert-class-template)))) 
