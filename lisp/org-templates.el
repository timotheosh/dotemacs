(global-set-key "\C-cu" 'org-jira-get-issues)
(global-set-key "\C-cc" 'org-capture)
(setq org-capture-templates
      `(
        ("t" "Todo" entry (file+datetree "~/org/GTD/newgtd.org" "Tasks")
             "* TODO %?\nEntered on %U\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
             "* %?\nEntered on %U\n  %i\n  %a")
        ("p" "New blog post" plain
         (file (capture-pelican-draft-file "~/src/sources/new_pelican_site/org"))
         ,pelican-md-header)
        )
      )
