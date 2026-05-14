(use-package copilot
  :ensure t
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . copilot-accept-completion)
              ("TAB" . copilot-accept-completion)
              ("C-<tab>" . copilot-accept-completion-by-word)
              ("C-TAB" . copilot-accept-completion-by-word)
              ("C-n" . copilot-next-completion)
              ("C-p" . copilot-previous-completion)))

(add-hook 'prog-mode-hook 'copilot-mode)
(add-hook 'prog-mode-hook #'copilot-nes-mode)

;; Silence "Request was canceled" noise (-32800 is JSON-RPC RequestCancelled,
;; expected when typing faster than completions arrive)
(require 'warnings)
(add-to-list 'warning-suppress-types '(copilot))
