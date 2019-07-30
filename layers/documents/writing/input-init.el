;; For writing in Biblical letters/languages

(defun my-change-font-according-to-input-method ()
  (face-remap-add-relative 'default
                           :family (cond ((string= current-input-method "greek") "Romans")
                                         ((string= current-input-method "hebrew-biblical-sil") "Ezra SIL")
                                         (t "Consolas"))
                           :height 120))

(defun my-switch-to-default-font ()
  (when (and (eq this-command 'toggle-input-method)
             current-input-method)
    (face-remap-add-relative 'default
                             :family "Ubuntu"
                             :height 120)))

(add-hook 'input-method-activate-hook #'my-change-font-according-to-input-method)
(add-hook 'input-method-deactivate-hook #'my-switch-to-default-font)
(provide 'input-init)
