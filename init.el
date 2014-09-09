;; ////////// BWR Custom Emacs Settings \\\\\\\\\\\ ;;

;;; Set location for external packages.
(add-to-list 'load-path "~/.emacs.d")

;; ======== Melpa Package Installer ======== ;;
 (when (>= emacs-major-version 24)
   (require 'package)
   (package-initialize)
   (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
   )

;; ===== Pleasant Emacs Customizations ==== ;;

(setq inhibit-startup-message t) ; no more welcome screen
(global-linum-mode 1) ; linenumbers
(setq linum-format "%d  ") ; linenumber format
(setq-default cursor-type 'bar) ; make cursor a vertical bar
(blink-cursor-mode 1) ; blink the cursor
(add-to-list 'default-frame-alist '(height . 60)) ; window height
(add-to-list 'default-frame-alist '(width . 80)) ; window width
(require 'paren) ; highlight open/closed parentheses
(show-paren-mode 1) ; turn parentheses mode on, always
(setq show-paren-delay 0) ; show the paren match immediately
(setq Tex-auto-global nil) ; for faster load time
(setq Tex-macro-global nil) ; for faster load time
;; custom theme (use melpa to install color-theme package)
(require 'color-theme) ;theme
(color-theme-initialize) ;theme
(load-file "~/.emacs.d/themes/montekai.el") ;theme
(montekai) ;theme
;; scroll up/down a line with meta n/p ;;
(global-set-key [up] (lambda () (interactive) (scroll-down 1)))
(global-set-key [down] (lambda () (interactive) (scroll-up 1)))
;; open recent files with C-x C-r
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 15)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
; Here's a key that command that lets you insert a "pound" £ on an American keyboard. For British keyboards, I recommend changing the keyboard input source to Australian. The only difference is that Shift-3 becomes # and Option-3 will be set to £ by the mapping below. That way you can use these same emacs preferences for both kinds of keyboards.
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "£")))

;; == Easy italics/bold in Latex/Markdown == ;;
(add-hook 'LaTeX-mode-hook
   '(lambda ()
        (define-key LaTeX-mode-map (kbd "s-i") (kbd "\C-c \C-f \C-e"))
	(define-key LaTeX-mode-map (kbd "s-b") (kbd "\C-c \C-f \C-b"))
    )
)
(add-hook 'markdown-mode-hook
   '(lambda ()
        (define-key markdown-mode-map (kbd "s-i") (kbd "\C-c \C-s e"))
	(define-key markdown-mode-map (kbd "s-b") (kbd "\C-c \C-s s"))
    )
)

;; == AucTeX == ;;
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq preview-auto-cache-preamble t) ; stop preview pestering
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode) ; Word wrapping
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t) ; Compile as a PDF
(setq reftex-ref-macro-prompt nil) ; Disable annoying reference prompt screen

;; == FlySpell == ;;
;; easy spell check settings
;; From http://www.emacswiki.org/emacs/FlySpell
;; For some reason I have to set the path to ispell by hand:
(setq-default ispell-program-name "/usr/local/Cellar/ispell/3.3.02/bin/ispell")
(add-hook 'LaTeX-mode-hook 'turn-on-flyspell) ;turn on for latex-mode
(add-hook 'text-mode-hook 'turn-on-flyspell) ; turn on for text-mode
(add-hook 'web-mode-hook 'turn-on-flyspell) ; turn on for web-mode
(global-set-key (kbd "<f8>") 'ispell-word) ; f8 to check current word
(global-set-key (kbd "C-S-<f8>") 'flyspell-mode) ; Ctrl-Shift-f8 to toggle
(global-set-key (kbd "C-M-<f8>") 'flyspell-buffer)
(global-set-key (kbd "C-<f8>") 'flyspell-check-previous-highlighted-word)
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word)
  )
(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)

;; === LatexMK - automatically recompile and run bibtex ===;;
(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("latexmk" "latexmk -pdf -file-line-error %s" TeX-run-TeX nil t
      :help "Run latexmk on file")
    TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

;; === Skim PDF syncing === ;;
;option -b highlights the current line in Skim; option -g opens Skim in the background  
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
     '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b %n %o %b")))
(server-start); start emacs in server mode so that skim can talk to it

;; ==== Yasnippet ==== ;;
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-0.8.0")
(require 'yasnippet)
(yas-global-mode 1)
;; key bindings
(global-set-key "\M-s\M-s" 'yas-insert-snippet) 

;; ==== Markdown ==== ;;
;; Requires installing markdown. Just run in the shell:
;; brew install markdown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.txt\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-hook 'markdown-mode-hook 'visual-line-mode) ; line wrapping

;; ==== Better Web-Mode ==== ;;
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; ==== Bug-Fix: Pop-up windows crash emacs ==== ;;
(defadvice yes-or-no-p (around prevent-dialog activate)
  "Prevent yes-or-no-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
(defadvice y-or-n-p (around prevent-dialog-yorn activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))

;; ===== .app Graphical Display Only Preferences ===== ;;
;; Things that don't work/matter in the Terminal ;;
 (if (display-graphic-p)
     (progn
     ;; Graphic Display Only Code
       (set-face-attribute 'default nil :height 160) ;font-size
       (tool-bar-mode -1) ;no toolbar
       (set-frame-parameter (selected-frame) 'alpha '(92 90)) ;transparency
       (add-to-list 'default-frame-alist '(alpha 92 90)) ;transparency
       ;;get emacs to find the right path to latex
       (setenv "PATH"
          (concat
	    "/usr/texbin" ":"
	    "/usr/local/bin" ":"
	    (getenv "PATH")
	  ))
       (setq exec-path (append exec-path '("/usr/local/bin")))
     )
     ;; else (optional)
)
