;; started 08-05-2021

;; Some variables or symbols need to be set within the
;; custom-set-variables block, not by themselves.

(custom-set-variables
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes '(manoj-dark))

;; Only works on the initial frame. Ask how to apply it to all frames.
 '(fringe-mode 0 nil (fringe))
 '(inhibit-startup-screen t)
 '(package-selected-packages '(markdown-preview-mode))
)

(server-start)
(setq confirm-kill-emacs 'yes-or-no-p)
'(fill-column 72)
(setq indent-tabs-mode nil
    css-indent-offset 2
    js-indent-level 2)
(setq column-number-mode t)
(menu-bar-mode -1)
(setq tab-bar-show nil)
(split-window-right)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(toggle-frame-fullscreen)
(setq-default auto-fill-function 'do-auto-fill)

;; Add MELPA package repo to the default ELPA package repo.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; https://melpa.org/#/getting-started
;; To install a package such as markdown-preview-mode:
;; M-x package-refresh-contents
;; M-x package-install RET markdown-preview-mode
