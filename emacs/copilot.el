(use-package copilot
  :ensure t
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . copilot-accept-completion)
              ("TAB" . copilot-accept-completion)
              ("C-<tab>" . copilot-accept-completion-by-word)
              ("C-TAB" . copilot-accept-completion-by-word)
              ("C-n" . copilot-next-completion)
              ("C-p" . copilot-previous-completion))
  :config
  (setq copilot-indentation-alist
        '((prog-mode 2)
          (emacs-lisp-mode 2)
          (python-mode 4)
          (python-ts-mode 4)
          (js-mode 2)
          (js-ts-mode 2)
          (typescript-mode 2)
          (typescript-ts-mode 2)
          (c-mode 4)
          (c++-mode 4)
          (java-mode 4)
          (sh-mode 2)
          (yaml-mode 2)
          (json-mode 2)
          (text-mode 2)
          (org-mode 2))))

;; copilot-mode is hooked via the use-package :hook above

;; NES (next edit suggestions) is experimental and only exists in recent
;; versions of copilot.el — guard so startup doesn't break on older versions
(when (fboundp 'copilot-nes-mode)
  (add-hook 'prog-mode-hook #'copilot-nes-mode))

;; Silence "Request was canceled" noise (-32800 is JSON-RPC RequestCancelled,
;; expected when typing faster than completions arrive)
(require 'warnings)
(add-to-list 'warning-suppress-types '(copilot))
