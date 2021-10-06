(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package general
  :ensure t
  :config
  (general-create-definer custom-leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
  (custom-leader-keys
    "a" '(:ignore a :which-key "appearance")
    "at" '(consult-theme :which-key "choose theme")
    "as" '(text-scale-adjust :which-key "adjust text size")

    "w" '(:ignore a :which-key "window")
    "wd" '(ace-delete-window :which-key "delete")
    "ws" '(ace-swap-window :which-key "swap")
    "wj" '(ace-select-window :which-key "select")
    "wb" '(split-window-below :which-key "new window below")
    "wr" '(split-window-right :which-key "new window to the right")
    "wo" '(ace-delete-other-windows :which-key "close all except")

    ;; This are keys to find something (with an UNKOWN location)
    "f" '(:ignore s :which-key "find")
    "fl" '(consult-line :which-key "line")
    "ff" '(project-find-file :which-key "file")

    ;; This are keys to jump fast to some KNOWN location
    ;; NOTE could also rename to "go to"
    "s" '(:ignore s :which-key "switch to")
    "sc" '(avy-goto-char :which-key "character")
    "sl" '(avy-goto-line :which-key "line")
    "sw" '(avy-goto-word-0 :which-key "word")
    "sb" '(consult-buffer :which-key "buffer")
    "sp" '(project-switch-project :which-key "project")
    ;; TODO open file vertically or horicontally
    "sf" '(project-find-file :which-key "file")))

(use-package evil
  :ensure t
  :custom
  (evil-want-keybinding nil) ; will use evil-collection for this
  (evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  ;; Start following modes in normal mode
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (general-def "<escape>" 'keyboard-escape-quit)
  (general-def 'insert "ö" 'hydra-insert-cmds/body)
  (general-def 'motion
    ;; Move through soft wrapped lines as if they where hard wrapped
    "j" 'evil-next-visual-line
    "k" 'evil-previous-visual-line)
  (general-def 'normal
    ":" 'evil-repeat
    "." 'evil-ex
    "C-i" 'evil-jump-forward
    "C-p" 'consult-buffer))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

(use-package avy
  :ensure t
  :commands (avy-goto-char avy-goto-word-0 avy-goto-line))

(use-package ace-window
  :ensure t
  :custom
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (aw-scope 'frame)
  (aw-minibuffer-flag t)
  (aw-dispatch-always t)
  (aw-dispatch-alist
   '(
     (?x aw-delete-window "delete")
     (?m aw-swap-window "swap")
     (?M aw-move-window "move")
     (?n aw-flip-window "aw-flip-window")
     (?u aw-switch-buffer-other-window "switch buffer other window")
     (?f aw-split-window-fair "split fair")
     (?v aw-split-window-vert "split vertical")
     (?r aw-split-window-horz "split horizontal (to the _r_ight)")
     (?o aw-delete-other-windows "delete other windows")
     (?? aw-show-dispatch-help "help"))
   "List of actions for `aw-dispatch-default`.")
  :bind ("M-o" . ace-window))

(use-package hydra :ensure t)

(defhydra hydra-insert-cmds ()
  "Commands"
  ("ö" (insert "ö") "insert (leader) ö" :exit t)
  ("e" execute-extended-command "execute" :exit t)
  ("." evil-ex "evil ex" :exit t)
  ("C-d" evil-window-delete "close window" :exit t)
  ("wc" evil-window-delete "close window" :exit t)
  ("o" evil-window-next "next window")
  ("j" hydra-jump/body "Jump" :exit t)
  ("f" nil "finished" :exit t))
(defhydra hydra-jump ()
  "jump"
  ("c" avy-goto-char "to character" :exit t)
  ("w" avy-goto-word-0 "to word" :exit t)
  ("l" avy-goto-line "to line" :exit t)
  ("f" nil "finished" :exit t))

(use-package vertico
  :ensure t
  :init
  (vertico-mode)
  (setq vertico-cycle t))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless)))

(use-package marginalia
  :ensure t
  :init (marginalia-mode))

(use-package consult
  :ensure t
  :defer t)

(use-package consult-dir
  :ensure t
  :after consult
  :custom
  (consult-dir-default-command 'project-find-file)
  :config
  (recentf-mode)
  :general
  (:keymaps 'insert
            "C-x C-d" 'consult-dir)
  (:keymaps 'vertico-map
            "C-x C-d" 'consult-dir
            "C-x C-j" 'consult-dir-jump-file))

(use-package corfu
  :ensure t
  :init (corfu-global-mode)
  :custom
  (corfu-cycle t)
  :general
  (general-def 'insert "C-n" 'completion-at-point)
  (:keymaps 'corfu-map
            [remap completion-at-point] 'corfu-next
            [remap evil-complete-next] 'corfu-next
            [remap evil-complete-previous] 'corfu-previous
            "C-n"  'corfu-next
            "C-p"  'corfu-previous))

;; (use-package embark)
;; (use-package embark-consult)

(use-package helpful
  :general
  ([remap describe-function] 'helpful-function)
  ([remap describe-symbol] 'helpful-command)
  ([remap describe-variable] 'helpful-variable)
  ([remap describe-key] 'helpful-key))

(use-package which-key
  :ensure t
  :init (which-key-mode)
  :diminish which-key-mode
  :custom
  (which-key-idle-delay 0.1))



(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package direnv
  :ensure t
  :config
  (direnv-mode))

(use-package wgrep
  :defer 2
  :ensure t)

(use-package magit
  :defer 2
  :ensure t
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package eglot
  :ensure t
  :ghook
  ('go-mode-hook #'eglot-ensure)
  ('nix-mode-hook #'eglot-ensure))

(use-package consult-eglot
  :ensure t
  :after eglot)

(use-package go-mode
  :ensure t
  :mode
  ("\\.go\\'" . go-mode)
  :interpreter
  ("go" . go-mode)
  )

(use-package nix-mode
  :ensure t
  :mode
  ("\\.nix\\'" . nix-mode)
  :interpreter
  ("rnix-lsp" . nix-mode))

(defun load-org-tempo ()
  (require 'org-tempo))

(use-package org
  :ensure t
  :mode
  ("\\.org\\'" . org-mode)
  :interpreter
  ("org" . org-mode)
  :custom
  (org-ellipsis " ▼")
  (org-log-done 'time)
  (org-log-into-drawer t)
  (org-confirm-babel-evaluate nil)
  (org-structure-template-alist
   '(
     ;; custom
     ("sh" . "src shell")
     ("el" . "src emacs-lisp")
     ;; default
     ("a" . "export ascii")
     ("c" . "center")
     ("C" . "comment")
     ("e" . "example")
     ("E" . "export")
     ("h" . "export html")
     ("l" . "export latex")
     ("q" . "quote")
     ("s" . "src")
     ("v" . "verse")))
  :gfhook
  #'visual-line-mode
  #'load-org-tempo
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell . t))))

(setq ring-bell-function 'ignore)   ; Disable alarm bell
(setq inhibit-startup-message t)    ; Remove startup message
(setq initial-scratch-message "Ready for work? Use C-h for help.")
(setq cursor-type 'hbar)

(menu-bar-mode -1)      ; Disable the menu bar
(tool-bar-mode -1)      ; Disable the toolbar
(scroll-bar-mode -1)    ; Disable visible scrollbar
(tooltip-mode -1)       ; Disable tooltips
(set-fringe-mode 10)    ; Give some breathing room

(use-package all-the-icons)

(use-package doom-themes
  :ensure t
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :config
  (load-theme 'doom-gruvbox t))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode t))

;; Display the cursor column in modeline
(column-number-mode t)

(dolist (mode '(prog-mode-hook
                text-mode-hook))
  (add-hook mode '(lambda()
                    (set-fill-column 78)
                    (auto-fill-mode)
                    (display-fill-column-indicator-mode))))

;; Enable line numbers
(global-display-line-numbers-mode t)
;; Disable line numbers for some modes
(dolist (mode '(term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package rainbow-delimiters
  :ensure t
  :ghook
  'prog-mode-hook)

(setq epg-pinentry-mode 'loopback)

;; (use-package password-store) ; auth-source-pass

;; (use-package hercules)

(use-package esup
  :ensure t
  :custom
  ;; Work around a bug where esup tries to step into the byte-compiled
  ;; version of `cl-lib', and fails horribly.
  ;; Ref: https://github.com/jschaf/esup/issues/54#issuecomment-651247749
  esup-depth 0)
