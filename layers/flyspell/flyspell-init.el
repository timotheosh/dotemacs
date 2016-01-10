(use-package flyspell
    :init
    (flyspell-mode +1)
    (autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
    ;; the default flyspell behaviour
    (put 'LeTex-mode 'flyspell-mode-predicate 'tex-mode-flyspell-verify)
    ;;
    ;; some extra flyspell delayed command
    (mapcar 'flyspell-delay-command	'(scroll-up1 scroll-down1))

    ;; If you use flyspell with aspell instead of ispell you have to this.
    ;; Because the “-l” option mean “--lang” in aspell and the “-l” option
    ;; mean “--list” in ispell. flyspell-buffer, and flyspell-region are
    ;; affected by this problem.
    (setq ispell-list-command "--list")

    ; Useful key bindings
    (defun flyspell-check-next-highlighted-word ()
      "Custom function to spell check next highlighted word"
      (interactive)
      (flyspell-goto-next-error)
      (ispell-word))

    (global-set-key (kbd "C-x <f8>") 'flyspell-check-next-highlighted-word)

    (add-hook 'mu4e-compose-mode-hook 'flyspell-mode)
    (add-hook 'text-mode-hook 'flyspell-mode)
    (add-hook 'Org-mode-hook 'flyspell-mode)
    (add-hook 'prog-mode-hook
      (lambda ()
        (flyspell-prog-mode))))
(provide 'flyspell-init)
