(use-package haskell-mode
  :ensure t
  :mode (("\\.has\\'" . haskell-mode)
         ("\\.hs\\'" . haskell-mode))
  :init
  (use-package auto-complete-init
    :config
    (add-to-list 'ac-modes 'haskell-mode))
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
  (setenv "PATH" (concat "~/.cabal/bin:" (getenv "PATH")))
  (add-to-list 'exec-path "~/.cabal/bin")

  (custom-set-variables
   '(haskell-tags-on-save t)
   '(haskell-process-suggest-remove-import-lines t)
   '(haskell-process-auto-import-loaded-modules t)
   '(haskell-process-log t))
  ;; Will only work if cabal version is >= 1.18
  (custom-set-variables '(haskell-process-type 'cabal-repl))

  (eval-after-load 'haskell-mode
    '(progn
       (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
       (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
       (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
       (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
       (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
       (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
       (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)
       (define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile)))

  (eval-after-load 'haskell-cabal
    '(progn
       (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
       (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
       (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
       (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)
       (define-key haskell-cabal-mode-map (kbd "C-c C-o") 'haskell-compile))))
    ;; Get the latest Haskell and cabal from nixpkgs by installing the following:
    ;; nix-env -iA nixpkgs.haskellPlatform
    ;; nixpkgs.haskellPackages.ghc
    ;; nixpkgs.haskellPackages.cabalInstall
    ;; nixpkgs.haskellPackages.hasktags
    ;; nixpkgs.haskellPackages.stylishHaskell
    ;; nixpkgs.haskellPackages.present
(provide 'haskell-init)
