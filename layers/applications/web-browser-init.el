(progn
  (setq browse-url-generic-program "/usr/local/bin/next")
  (setq browse-url-default-browser 'eww-browse-url)
  (setq shr-external-browser 'browse-url-generic)
  (setq
   browse-url-browser-function
   '(
     ("youtube\\.com" . browse-url-generic)
     ("vimeo\\.com" . browse-url-generic)
     ("facebook\\.com" . browse-url-firefox)
     ("reddit\\.com" . browse-url-firefox)
     ("." . eww-browse-url)
     )))
(provide 'web-browser-init)
