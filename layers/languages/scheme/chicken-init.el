(use-package chicken-scheme
  :ensure t
  :mode ("\\.scm$" . scheme-mode)
  :bind (("C-c C-q m" . quack-view-manual)
         ("C-c C-q s" . quack-view-srfi)
         ("C-c C-q t" . quack-tidy-buffer))
  :config
  (add-to-list 'ac-modes 'scheme-mode)
  (use-package flymake-racket
    :ensure t
    :config
    (add-hook 'scheme-mode-hook 'flymake-racket-load))
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
    (add-hook 'scheme-mode-hook 'smartparens-strict-mode)
    (use-package cmuscheme
      :ensure t)
    (setq geiser-chicken-compile-geiser-p nil)
    ;;(setq geiser-mode-start-repl-p t)
    (define-key scheme-mode-map
      (kbd "C-c C-c") 'run-chicken)
    (define-key scheme-mode-map
      (kbd "C-c C-l") 'scheme-load-current-file)
    (define-key scheme-mode-map
      (kbd "C-c C-k") 'scheme-compile-current-file)
    (add-hook 'scheme-mode-hook 'geiser-mode)
    (use-package aggressive-indent
      :ensure t
      :init
      (add-hook 'scheme-mode-hook 'aggressive-indent-mode)
      (add-hook 'gieser-mode-hook 'aggressive-indent-mode))))
(provide 'chicken-init)
