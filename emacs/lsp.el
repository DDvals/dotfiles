;;; -*- lexical-binding: t -*-
;; LSP

;; TypeScript: third-party major mode for .ts/.tsx (not built into Emacs 30),
;; must be installed explicitly — the lsp hooks below reference its modes
(use-package typescript-mode
  :ensure t
  :mode (("\\.ts\\'" . typescript-mode)
         ("\\.tsx\\'" . typescript-tsx-mode)))

(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook ((js-mode . lsp)
         (typescript-mode . lsp)
         (typescript-tsx-mode . lsp))
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq lsp-enable-snippet t
        lsp-prefer-flymake nil ; use flycheck
	lsp-eslint-auto-fix-on-save t
        lsp-completion-provider :none)) ; use corfu/capf, not company

(setq lsp-eslint-enable t)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config
  (add-hook 'lsp-mode-hook #'lsp-ui-mode)
  (setq lsp-ui-doc-enable t
	lsp-ui-doc-position 'at-point)) ; Show documentation near the cursor

;; diagnostics
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; completition
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  (setq corfu-auto-prefix 1) ; Autocomplete after one char (corfu docstring advises >= 2 for load reasons)
  (setq corfu-quit-no-match 'separator) ; Close the menu if there are not matches
  (setq corfu-cycle t) ; Cycle between suggestions
  (setq corfu-auto t)) ; Automatic active the completer


(add-hook 'lsp-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'lsp-format-buffer nil t)))
