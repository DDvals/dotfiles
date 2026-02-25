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

(setq lsp-javascript-server-command '("typescript-language-server" "--stdio"))
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
  (setq corfu-min-length 1) ; Autocompleter after one char
  (setq corfu-quit-no-match 'separator) ; Close the menu if there are not matches
  (setq corfu-cycle t) ; Cycle between suggestions
  (setq corfu-auto t)) ; Automatic active the completer


(add-hook 'lsp-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'lsp-format-buffer nil t)))
