(use-package fortune
  :config
  (setq fortune-dir "/usr/share/games/fortunes")
  (setq fortune-file "/usr/share/games/fortunes/computers")
  (defun my/fortune()
    (fortune)))

(require 'cbible-init)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-navigator t)
  (setq dashboard-set-init-info t)

  (setq show-week-agenda-p t)

  (setq dashboard-footer-messages (list (fortune-to-signature)))
  (setq dashboard-items '((agenda . 5)
                          (projects . 5)
                          (recents  . 5)
                          (bookmarks . 5)
                          (registers . 5)))

  ;;(defun dashboard-random-footer ()
  ;;  "Overrides original dashboard function to use Emacs fortune, instead."
  ;;  (fortune-to-signature)))

  (setq scripture-list'("Joshua 1:9"
                        "Lamentations 3:22-23"
                        "Proverbs 3:5-6"
                        "Proverbs 18:10"
                        "Psalm 16:8"
                        "Psalm 23:4"
                        "Psalm 31:24"
                        "Psalm 46:7"
                        "Psalm 55:22"
                        "Psalm 62:6"
                        "Psalm 118:14-16"
                        "Psalm 119:114-115"
                        "Psalm 119:50"
                        "Psalm 120:1"
                        "Isaiah 26:3"
                        "Isaiah 40:31"
                        "Isaiah 41:10"
                        "Isaiah 43:2"
                        "Matthew 11:28"
                        "Mark 10:27"
                        "John 16:33"
                        "2 Corinthians 1:3-4"
                        "1 Thessalonians 5:11"
                        "Philippians 4:19"
                        "1 Peter 5:7"
                        "Deuteronomy 31:6"
                        "Joshua 1:7"
                        "Nahum 1:7"
                        "Psalm 27:4"
                        "Psalm 34:8"
                        "Proverbs 17:17"
                        "Isaiah 26:3"
                        "John 15:13"
                        "Romans 8:28"
                        "Romans 8:31"
                        "Romans 8:38-39"
                        "Romans 15:13"
                        "1 Corinthians 13:12"
                        "1 Corinthians 15:58"
                        "1 Corinthians 16:13"
                        "2 Corinthians 4:16-18:  "
                        "Ephesians 3:17-19-21"
                        "Philippians 3:7-9"
                        "Hebrews 10:19-23"
                        "Hebrews 12:1-2"
                        "1 Peter 2:9-10"
                        "1 Peter 2:11"
                        "James 1:2-4"
                        "1 John 3:1-3"
                        "1 John 3:22"
                        "Exodus 15:2"
                        "1 Chronicles 29:12"
                        "Zephaniah 3:17"
                        "Nehemiah 8:10"
                        "Psalm 8:2"
                        "Psalm 18:1-2"
                        "Psalm 27:1"
                        "Psalm 37:39"
                        "Psalm 46:1-3"
                        "Psalm 71:16"
                        "Psalm 119:28"
                        "Psalm 138:3"
                        "Isaiah 12:2"
                        "Isaiah 40:28-31"
                        "Habakkuk 3:19"
                        "Matthew 6:34"
                        "Matthew 19:26"
                        "Mark 12:30"
                        "Acts 1:8"
                        "2 Corinthians 4:16"
                        "2 Corinthians 12:9-10"
                        "Ephesians 3:16"
                        "Ephesians 6:10"
                        "Philippians 4:13"
                        "2 Timothy 1:7"))

  (setq bibleversion "NASB")

  (defun dashboard-random-footer ()
    "Return a random scripture reference from `scripture-list'."
    (let ((verse (nth (random (length scripture-list)) scripture-list)))
      (format "%s [%s %s]" (cbible-reference verse bibleversion) verse bibleversion)))
  (setq dashboard-init-info (dashboard-random-footer))
  (setq dashboard-footer-icon
        (all-the-icons-fileicon "emacs"
                                :height 1.1
                                :v-adjust -0.05
                                :face 'font-lock-keyword-face)))

(provide 'dashboard-init)
