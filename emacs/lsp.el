;;; -*- lexical-binding: t -*-
;; LSP

;; Tree-sitter modes for JavaScript and TypeScript (preferred: richer,
;; syntax-tree-based highlighting; grammars install with
;; M-x treesit-install-language-grammar on first use). The auto-mode
;; entries below are added after typescript-mode's so tree-sitter wins.
(require 'subr-x)

(setq treesit-language-source-alist
      '((javascript "https://github.com/tree-sitter/tree-sitter-javascript")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

;; TypeScript: third-party major mode for .ts/.tsx (classic fallback
;; when the tree-sitter grammars are not installed)
(use-package typescript-mode
  :ensure t
  :mode (("\\.ts\\'" . typescript-mode)
         ("\\.tsx\\'" . typescript-tsx-mode)))

(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook ((js-mode . lsp)
         (js-ts-mode . lsp)
         (typescript-mode . lsp)
         (typescript-ts-mode . lsp)
         (typescript-tsx-mode . lsp)
         (tsx-ts-mode . lsp))
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
