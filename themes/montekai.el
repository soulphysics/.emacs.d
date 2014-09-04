;;; Montekai: montekai.el
;;; A fruity latex-friendly emacs theme inspired by Monokai

;; Author: Bryan W. Roberts <http://personal.lse.ac.uk/robert49>
;;
;; Inspired by the Monokai TextMate theme
;; Author: Wimer Hazenberg <http://www.monokai.nl>

;; Depends: color-theme

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

; Color theme support is required.
(require 'color-theme)

; Code start.
(defun montekai ()
  (interactive)
  (color-theme-install
   '(montekai
     ((background-color . "#272821")
      (foreground-color . "#F8F8F2")
      (cursor-color . "#DAD085"))
     (default ((t (nil))))
     (modeline ((t (:background "white" :foreground "black" :box (:line-width 1 :style released-button)))))
     (font-lock-builtin-face ((t (:foreground "#FFEBD6"))))
     (font-lock-comment-face ((t (:italic t :foreground "#75715D"))))
     (font-lock-constant-face ((t (:foreground "#ff00ff"))))
     (font-lock-doc-string-face ((t (:foreground "#ffff99"))))
     (font-lock-string-face ((t (:foreground "#DFD874"))))
     (font-lock-function-name-face ((t (:foreground "#F1266F" :italic t))))
     (font-lock-keyword-face ((t (:foreground "#66D9EF"))))
     (font-lock-type-face ((t (:underline t :foreground "#89BDFF"))))
     (font-lock-variable-name-face ((t (:foreground "#A6E22A"))))
     (font-lock-warning-face ((t (:bold t :foreground "#FD5FF1"))))
     (highlight-80+ ((t (:background "#D62E00"))))
     (hl-line ((t (:background "#1A1A1A"))))
     (region ((t (:background "#6DC5F1"))))
     (ido-subdir ((t (:foreground "#F1266F"))))
     ; latex-specific
     (font-latex-italic-face ((t (:foreground "#ffffc2" :italic t)))) ; italics
     (font-latex-bold-face ((t (:foreground "#ffc2b2" :bold t)))) ; bold
     (font-latex-math-face ((t (:foreground "#00B800")))) ; latex math is green
     (font-latex-string-face ((t (:foreground "#FFAD5C")))) ; quotes - plum
     (font-latex-warning-face ((t (:foreground "#cc0000")))) ; dark scarlet red
     (font-latex-slide-title-face ((t (:foreground "#c4a000")))) ; dark butter
     ; markdown specific
     (markdown-list-face ((t (:foreground "#5454B5")))) ; deep blue
    )
  )
)
(provide 'montekai)
;---------------
; Code end.
