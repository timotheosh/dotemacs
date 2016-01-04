;; Setting up some Environment variables
(setenv "PROGRAMS" (expand-file-name "~/programs"))
(setenv "PATH"
	(format "%s:%s:%s"
		(concat (getenv "PROGRAMS") "/bin")
		(concat (getenv "HOME") "/.nix-profile/bin")
		(getenv "PATH")))
(provide 'environment-init)
