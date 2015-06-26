;; etags-select is useful too
(require 'etags-select)
(require 'etags-table)
(setq etags-table-search-up-depth 10)
(setq etags-table-alist
    (list
      '(".*\\.\\([ch]\\|cpp\\|hpp\\)" "/usr/include/TAGS")
      '("/home/thawes/src/cbible/src/" "/home/thawes/src/TAGS")
))


;; allow you build TAGS file on root of project and move accross definition
;; in project. But if you need jump in different project or in standard
;; headers, just add:
;;
;;(setq etags-table-alist
;;       (list
;;        ;; For jumping to standard headers:
;;        '(".*\\.\\([ch]\\|cpp\\)" "/usr/include/TAGS")
;;        ;; For jumping across project:
;;        '("/home/devel/proj1/" "/home/devel/proj2/TAGS" "/home/devel/proj3/TAGS")
;;        '("/home/devel/proj2/" "/home/devel/proj1/TAGS" "/home/devel/proj3/TAGS")
;;        '("/home/devel/proj3/" "/home/devel/proj1/TAGS" "/home/devel/proj2/TAGS")
;;        ))
;;
;; Or may be you need (add-to-list 'etags-table-alist ...)
