(add-to-list 'default-frame-alist '(foreground-color . "wheat1"))
(add-to-list 'default-frame-alist '(background-color . "#161616"))
(add-to-list 'default-frame-alist '(cursor-color . "coral"))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(truncate-lines t)
 '(backup-by-copying-when-mismatch t)
 '(case-fold-search t)
 '(column-number-mode t)
 '(delete-selection-mode t)
 '(desktop-save-mode t)
 '(display-time-day-and-date t)
 '(display-time-mode t nil (time))
 '(display-time-use-mail-icon t)
 '(frame-background-mode (quote dark))
 '(global-font-lock-mode t nil (font-lock))
 '(global-hl-line-mode t nil (hl-line))
 '(gnus-mouse-face (quote highlight))
 '(indicate-empty-lines t)
 '(inverse-video t)
 '(mode-line-inverse-video t)
 '(mouse-wheel-mode t nil (mwheel))
 '(scroll-all-mode nil nil (scroll-all))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(menu-bar-mode nil)
 '(server-mode t)
 '(terminal-redisplay-interval 2500)
 '(tooltip-mode t nil (tooltip))
 '(transient-mark-mode t)
 '(column-number-mode 1)
 '(line-number-mode 1)
)

;; chande window dimentions Shift+Ctrl+Arrow-key 
(global-set-key (kbd "C-S-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-S-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-S-<down>") 'shrink-window)
(global-set-key (kbd "C-S-<up>") 'enlarge-window)
;; jump to buffer with Alt+Arrow-key
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<left>") 'windmove-left)

;;F12 switch to ansi-term
(defun switch-to-ansi-term ()
  ;;"If ansi-term is not existed, start a new one, otherwise switch to it"
  (interactive)
  (if (get-buffer "*ansi-term*")
      (switch-to-buffer "*ansi-term*")
    (ansi-term "/bin/bash")))

(global-set-key [f12] 'switch-to-ansi-term)
