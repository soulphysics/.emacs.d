;;; pandoc-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "pandoc" "pandoc.el" (22757 64847 0 0))
;;; Generated autoloads from pandoc.el

(autoload 'pandoc-antiword "pandoc" "\
Convert `FILE' to DocBook using Antiword.

\(fn FILE)" nil nil)

(autoload 'pandoc-convert-file "pandoc" "\
Convert `FILE-PATH' as `INPUT-FORMAT' to `OUTPUT-FORMAT'.

\(fn FILE-PATH INPUT-FORMAT OUTPUT-FORMAT)" nil nil)

(autoload 'pandoc-convert-stdio "pandoc" "\
Convert `BODY' as `INPUT-FORMAT' to `OUTPUT-FORMAT'.

\(fn BODY INPUT-FORMAT OUTPUT-FORMAT)" nil nil)

(autoload 'pandoc-open-eww "pandoc" "\
Render `FILE' using EWW and Pandoc.

\(fn FILE)" t nil)

(autoload 'pandoc-turn-on-advice-eww "pandoc" "\
When `eww-open-file' using Pandoc if the file is not HTML.

Remove advice if `ENABLE' equals `-1'.

\(fn &optional ENABLE)" nil nil)

;;;***

;;;### (autoloads nil nil ("pandoc-pkg.el") (22757 64847 698341 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; pandoc-autoloads.el ends here
