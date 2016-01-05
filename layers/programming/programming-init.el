;; Add hooks to the major-mode this is called from.
;; Should be just major-modes for programming.

(defun my-hooks-to-add ()
  (lambda ()
    (interactive)
    (linum-mode 1)
    (when (derived-mode-p 'c-mode 'c++-mode 'java)
      (ggtags-mode 1))
    (column-marker-1 80)
    (column-enforce-mode 1)))

(dolist (hook '(my-hooks-to-add))
  (add-hook major-mode hook))
(provide 'programming-init)
