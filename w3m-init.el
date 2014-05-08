(setq browse-url-browser-function 'w3m-browse-url)
 (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
 ;; optional keyboard short-cut
(global-set-key "\C-xm" 'browse-url-at-point)
(setq w3m-use-cookies t)
(setq browse-url-browser-function 'browse-url-generic
	        browse-url-generic-program "firefox")

(global-set-key (kbd "C-c C-v")  'browse-url-of-buffer)
