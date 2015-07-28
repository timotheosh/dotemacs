;; Setting up some Environment variables
(setenv "PROGRAMS" (expand-file-name "~/programs"))
(setenv "PATH"
        (concat
         (concat (getenv "PROGRAMS") "/bin") ":"
         (getenv "PATH")
         )
        )
