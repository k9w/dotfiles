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
'(fill-column 72)
(setq-default auto-fill-function 'do-auto-fill)
(setq confirm-kill-emacs 'yes-or-no-p)
(setq column-number-mode t)
(setq tab-bar-show nil)
(setq indent-tabs-mode nil
    css-indent-offset 2
    js-indent-level 2)
(menu-bar-mode -1)
(split-window-right)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(toggle-frame-fullscreen)

;; Globally enable follow-mode. This works. But it freezes the
;; minibuffer. When I try to exit emacs, it doesn't show the exit
;; confirm until I do Ctrl-G. So I commented it out. Simply specifying
;; (follow-mode) above only works on the *scratch* buffer. Perhaps
;; there's a hook that can be called to turn on follow-mode.
;; https://stackoverflow.com/questions/16048231/how-to-enable-a-non-global-minor-mode-by-default-on-emacs-startup
;; (define-globalized-minor-mode global-follow-mode follow-mode
;;   (lambda () (follow-mode 1)))

;; (global-follow-mode 1)


;; Add MELPA package repo to the default ELPA package repo.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; https://melpa.org/#/getting-started
;; To install a package such as markdown-preview-mode:
;; M-x package-refresh-contents
;; M-x package-install RET markdown-preview-mode
