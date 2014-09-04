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

;; == AucTeX == ;;
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode) ; Word wrapping
(add-hook 'LaTeX-mode-hook 'turn-on-flyspell)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t) ; Compile as a PDF
(setq reftex-ref-macro-prompt nil) ; Disable annoying reference prompt screen

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
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.txt\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-hook 'markdown-mode-hook 'visual-line-mode) ; line wrapping

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
	    (getenv "PATH")
	  ))
     )
     ;; else (optional)
)
