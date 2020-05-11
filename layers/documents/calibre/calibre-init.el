(use-package calibre-mode
  :load-path "programs/calibre-mode"
  :init
  (setq sql-sqlite-program "/usr/bin/sqlite3"
        calibre-root-dir (expand-file-name "~/Dropbox/CalibreBooks")))
(provide 'calibre-init)
