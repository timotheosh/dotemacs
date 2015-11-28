(use-package org-page
  :init
  (setq op/repository-directory (expand-file-name "~/org/Selfdidactic.com"))
  (setq op/site-domain "http://selfdidactic.com/")
;;; for commenting, you can choose either disqus or duoshuo
  (setq op/personal-disqus-shortname "timotheosh")
                                        ;(setq op/personal-duoshuo-shortname "your_duoshuo_shortname")
;;; the configuration below are optional
  (setq op/personal-google-analytics-id "UA-9488542-1")
  (setq op/site-main-title "Self Didactic")
  (setq op/site-sub-title "Self Didactic is dedicated to equipping anyone and everyone who wants to learn on their own. This is the contra-University!")
  (setq op/repository-org-branch "source") ;; default is "source"
  (setq op/repository-html-branch "master")  ;; default is "master"
  ;; Have a github account? It's cool:
  (setq op/personal-github-link "")
  (setq op/repository-html-branch "master")
  (setq op/theme (quote phaer))
  (setq op/theme-root-directory "/home/thawes/.emacs.d/programs/org-page-themes/"))
