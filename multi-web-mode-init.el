;; This can do mixed PHP files as well, but I don't want/need it right now.
(require 'multi-web-mode)
   (setq mweb-default-major-mode 'html-mode)
   (setq mweb-tags '(
					 (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
					 (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
   (setq mweb-filename-extensions '("htm" "html"))
   (multi-web-global-mode 1)
;; Indent when I press <RETURN>
(add-hook 'multi-web-mode-hook '(lambda ()
    (local-set-key (kbd "RET") 'newline-and-indent)))
