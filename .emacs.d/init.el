;; started 08-05-2021

;; Some variables or symbols need to be set within the
;; custom-set-variables block, not by themselves. This can be done using
;; the Customize option, or by hand when I find using the variable
;; outside the block generates an error for non-declaration.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes '(manoj-dark))

;; Only works on the initial frame. Ask how to apply it to all frames.
 '(fringe-mode 0 nil (fringe))
 '(package-selected-packages '(markdown-preview-mode))
)

;; Set the fill-column from default 70 to 72.
'(fill-column 72)

;; Change default indent from tab to nil. Set indent level to 2 spaces.
;; Works for HTML, CSS, JavaScript, and likely other modes too.
;; https://emacs.stackexchange.com/questions/48177/how-to-control-javascript-indentation
;; https://emacs.stackexchange.com/questions/25044/how-do-i-set-up-indentation-to-2-spaces-in-web-mode/47272#47272
(setq indent-tabs-mode nil
      js-indent-level 2)

;; Display the column number next to the line number in the Mode Line.
(setq column-number-mode t)

;; Set the default frame to be fullscreen and set the resize default
;; to also be fullscreen.
(setq default-frame-alist
    '((fullscreen . fullboth)
      (fullscreen-restore . fullheight)))

;; Disable the scroll-bars and tool-bar. Text terminals don't have
;; these.
(scroll-bar-mode -1)
(tool-bar-mode -1)


;; Disable the menu-bar and inhibit showing the tab-bar with new tab.
(menu-bar-mode -1)
(setq tab-bar-show nil) ;; tab-bar-show is a variable and needs setq.


;; Add MELPA package repo to the default ELPA package repo.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; https://melpa.org/#/getting-started

;; To install a package such as markdown-preview-mode:
;; M-x package-refresh-contents
;; M-x package-install RET markdown-preview-mode

;; https://stackoverflow.com/questions/11373826/how-to-disable-fringe-in-emacs/11480217
;; (setq set-fringe-mode 0)
;; (setq fringe-mode no-fringes)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
