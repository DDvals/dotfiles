(setq inhibit-startup-message t)

(scroll-bar-mode -1)                 ; Disable visible scrollbar
(tool-bar-mode -1)                   ; Disable the toolbar
(tooltip-mode -1)                    ; Disable tooltips
(set-fringe-mode 10)                 ; Give some breathing room
(menu-bar-mode -1)                   ; Disable the menu bar
(which-key-mode 1)                   ; which-key mode
(ido-mode 1)                         ; autocompleter for files and buffers
(global-display-line-numbers-mode 1) ; show line numbers
(global-auto-revert-mode 1)          ; Revert buffers when the underlying file has changed

;; Set up the visible bell
(setq visible-bell t)
;; Switch off sounds
(setq ring-bell-function 'ignore)

(set-face-attribute 'default nil :font "Hack Nerd Font Mono" :height 110)

(load-theme 'wombat)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)
 
;; Revert Dired and other buffers
(setq global-auto-revert-non-file-buffers t)

;; IDO config
(setq ido-enable-flex-matching t
      ido-everywhere t)

;; Initialize package sources
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

(use-package command-log-mode)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)

  :custom ((doom-modeline-height 5)))

;; LSP
(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook ((js-mode . lsp)
         (typescript-mode . lsp))
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq lsp-enable-snippet t
        lsp-prefer-flymake nil ; use flycheck
	lsp-eslint-auto-fix-on-save t))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;; diagnostics
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; completition
(use-package corfu
  :ensure t
  :init (global-corfu-mode))

(add-hook 'lsp-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'lsp-format-buffer nil t)))


