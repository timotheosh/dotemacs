;; Column Marker
;;Other init file suggestions (examples):
;;Highlight column 80 in foo mode.
;; (add-hook 'foo-mode-hook (lambda () (interactive) (column-marker-1 80)))
(use-package column-marker
    :init
    (add-hook 'php-mode-hook (lambda () (interactive) (column-marker-1 80))))
