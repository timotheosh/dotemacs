(use-package chicken-scheme
  :ensure t
  :mode ("\\.scm$" . scheme-mode)
  :config
  (add-to-list 'ac-modes 'scheme-mode)
  (add-to-list 'ac-modes 'geiser-mode)
  :init
  (progn
    (defun scheme-load-current-file (&optional switch)
      (interactive "P")
      (let ((file-name (buffer-file-name)))
        (comint-check-source file-name)
        (setq scheme-prev-l/c-dir/file (cons (file-name-directory    file-name)
                                             (file-name-nondirectory file-name)))
        (comint-send-string (scheme-proc) (concat "(load \""
                                                  file-name
                                                  "\"\)\n"))
        (if switch
            (switch-to-scheme t)
          (message "\"%s\" loaded." file-name))))

    (defun scheme-compile-current-file (&optional switch)
      (interactive "P")
      (let ((file-name (buffer-file-name)))
        (comint-check-source file-name)
        (setq scheme-prev-l/c-dir/file (cons (file-name-directory    file-name)
                                             (file-name-nondirectory file-name)))
        (message "compiling \"%s\" ..." file-name)
        (comint-send-string (scheme-proc) (concat "(compile-file \""
                                                  file-name
                                                  "\"\)\n"))
        (if switch
            (switch-to-scheme t)
          (message "\"%s\" compiled and loaded." file-name))))
    (require 'programming-init)
    (require 'geiser-init)
    (use-package cmuscheme
      :ensure t)
    (setq geiser-active-implementations '(chicken))
    (setq geiser-chicken-compile-geiser-p nil)
    ;;(setq geiser-mode-start-repl-p t)
    (define-key scheme-mode-map
      (kbd "C-c C-c") 'run-chicken)
    (define-key scheme-mode-map
      (kbd "C-c C-l") 'scheme-load-current-file)
    (define-key scheme-mode-map
      (kbd "C-c C-k") 'scheme-compile-current-file)
    (add-hook 'scheme-mode-hook 'my-programming-hooks)
    (add-hook 'scheme-mode-hook 'geiser-mode)))
(provide 'chicken-init)
