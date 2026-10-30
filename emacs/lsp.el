;; Tree-sitter modes for JavaScript and TypeScript.
(require 'subr-x)

(setq treesit-language-source-alist
      '((javascript "https://github.com/tree-sitter/tree-sitter-javascript")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

;; Expose the active nvm toolchain to Emacs subprocesses.
(when (and (eq system-type 'gnu/linux)
           (file-directory-p (expand-file-name "~/.nvm")))
  (let* ((node-path (string-trim (shell-command-to-string "zsh -ic 'nvm which current'")))
         (node-bin (and (file-executable-p node-path)
                        (file-name-directory node-path))))
    (when node-bin
      (add-to-list 'exec-path node-bin)
      (setenv "PATH" (concat node-bin path-separator (getenv "PATH"))))))

;; LSP
(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook ((js-mode . lsp)
         (typescript-mode . lsp)
         (js-ts-mode . lsp)
         (typescript-ts-mode . lsp)
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
  (setq corfu-min-length 1) ; Autocompleter after one char
  (setq corfu-quit-no-match 'separator) ; Close the menu if there are not matches
  (setq corfu-cycle t) ; Cycle between suggestions
  (setq corfu-auto t)) ; Automatic active the completer


(add-hook 'lsp-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'lsp-format-buffer nil t)))
