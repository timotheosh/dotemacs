(use-package elfeed
  :ensure t
  :init
  (use-package elfeed-goodies
    :ensure t
    :config
    (elfeed-goodies/setup))
  :config
  (setq elfeed-feeds
        '(("http://www.garynorth.com/mysite.xml" economics)
          ("http://feeds.fee.org/FEE-Freeman" economics)
          ("https://www.eff.org/rss" technology politics)
          ("https://emacsredux.com/feed.xml" blog emacs)
          ("http://emacsrocks.com/atom.xml" blog emacs)
          ("http://pragmaticemacs.com/feed/" blog emacs)
          ("https://stackoverflow.com/feeds/tag?tagnames=emacs&sort=newest" stackoverflow emacs)
          ("https://www.reddit.com/r/emacs.rss" reddit technology emacs)
          ("https://www.reddit.com/r/lisp.rss" reddit technology lisp)
          ("https://www.reddit.com/r/clojure.rss" reddit technology lisp clojure)
          ("https://www.reddit.com/r/Racket.rss" reddit technology lisp racket)
          ("https://stevelosh.com/rss.xml" blog technology lisp)
          ("http://planet.lisp.org/rss20.xml" blog technology lisp)
          ("https://lispblog.xach.com/rss" blog technology lisp)
          ("https://lispnews.wordpress.com/rss.xml" blog technology lisp)
          ("https://borretti.me/feed.xml" blog technology)
          ("https://stackoverflow.com/feeds/tag?tagnames=common-lisp&sort=newest" stackoverflow lisp)
          ("https://planet.kde.org/global/atom.xml/" blog desktop kde)
          ("https://www.kdevelop.org/rss.xml" blog desktop kde kdevelop))))
(provide 'elfeed-init)
