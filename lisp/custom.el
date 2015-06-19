(add-hook 'before-save-hook 'delete-trailing-whitespace)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (wheatgrass)))
 '(display-time-mode t)
 '(ecb-options-version "2.40")
 '(ede-project-directories
   (quote
    ("/home/thawes/src/sources/cbible/include" "/home/thawes/src/sources/cbible/src" "/home/thawes/src/sources/cbible" "/home/hawest/src/sources/AwsConfigMFA" "/home/hawest/src/sources/cl-blog" "/home/hawest/src/sources/cloudformation" "/home/hawest/src/sources/devops" "/home/hawest/src/sources/elasticbrainsurgeon" "/home/hawest/src/sources/hiera-provisioning" "/home/hawest/src/sources/inin-framework" "/home/hawest/src/sources/learnyouahaskell" "/home/hawest/src/sources/llthw" "/home/hawest/src/sources/project-eulor" "/home/hawest/src/sources/provisioning" "/home/hawest/src/sources/re-tools" "/home/hawest/src/sources/SimianArmy" "/home/hawest/src/sources/nixpkgs")))
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote cabal-repl))
 '(haskell-tags-on-save t)
 '(ido-enable-tramp-completion nil)
 '(org-agenda-files
   (quote
    ("~/org/AWSCommandLine.org" "~/org/AgileTraining.org" "~/org/CodeForCary.org" "~/org/CodeForRaleigh.org" "~/org/CommonLisp-FastCGI-Hostmonster.org" "~/org/Contacts.org" "~/org/CoverLetter.org" "~/org/DEVOPS.org" "~/org/HawesResume.org" "~/org/IBM_Streams_presentation.org" "~/org/ININ_Scrum.org" "~/org/ININ_TODO.org" "~/org/ININ_Thing_to_learn.org" "~/org/LogscapeSearchHowTo.org" "~/org/Monitoring.org" "~/org/ReinventMyself.org" "~/org/SciMed.org" "~/org/UpgradeLogscape.org" "~/org/anx.org" "~/org/dev-cloud-email.org" "~/org/easyfreeunix.org" "~/org/history.org" "~/org/home.org" "~/org/pelican-template.org" "~/org/programming.org")))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(cursor ((t (:background "goldenrod1"))))
 '(set-mouse-color "goldenrod1"))
