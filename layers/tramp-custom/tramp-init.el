(use-package tramp
  :init (setq tramp-ssh-controlmaster-options
              "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no"))
(provide 'tramp-init)
