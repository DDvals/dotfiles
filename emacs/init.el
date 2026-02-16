(setq inhibit-startup-message t)

(scroll-bar-mode -1)                 ; Disable visible scrollbar
(tool-bar-mode -1)                   ; Disable the toolbar
(tooltip-mode -1)                    ; Disable tooltips
(set-fringe-mode 10)                 ; Give some breathing room
(menu-bar-mode -1)                   ; Disable the menu bar
(which-key-mode 1)                   ; which-key mode
(global-display-line-numbers-mode 1) ; show line numbers
(global-auto-revert-mode 1)          ; Revert buffers when the underlying file has changed

;; Set up the visible bell
(setq visible-bell t)
;; Switch off sounds
(setq ring-bell-function 'ignore)

(set-face-attribute 'default nil :font "Hack Nerd Font Mono" :height 110)

;(load-theme 'wombat)
;; Configure the Modus Themes' appearance
(setq modus-themes-custom-auto-reload t
      modus-themes-bold-constructs t
      modus-themes-italic-constructs t
      modus-themes-fringes 'subtle
      modus-themes-paren-match '(bold intense)
      modus-themes-prompts '(bold intense)
      modus-themes-region '(bg-only)
      modus-themes-scale-headings t
      modus-themes-headings
      '((1 . (overline background bold 1.4))
        (2 . (background 1.3))
        (3 . (bold 1.2))
        (t . (semilight 1.1))))

(load-theme 'modus-vivendi-deuteranopia t)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)
 
;; Revert Dired and other buffers
(setq global-auto-revert-non-file-buffers t)

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

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;(use-package doom-modeline
;  :ensure t
;  :init (doom-modeline-mode 1)
;  :custom ((doom-modeline-height 5)))
