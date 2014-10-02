;; Copyright (C) 2014
;;
;; Author: BoyW165
;; Version: 0.0.1
;; Compatibility: GNU Emacs 22.x, GNU Emacs 23.x, GNU Emacs 24.x
;;
;; This file is NOT part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;;; Commentary:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;; 2014-08-01 (0.0.1)
;;    Initial release.

(require 'font-lock)

(require 'hl-faces)

(defcustom prj-grep-mode-hook `(linum-mode
                                hl-line-mode
                                font-lock-mode)
  "Hook run when entering `prj-grep-mode' mode."
  :type 'hook
  :group 'prj-group)

(defvar prj-grep-mode-map
  (let ((map (make-sparse-keymap)))
    (suppress-keymap map t)
    (when (featurep 'sos)
      (define-key map [return] 'sos-goto-definition))
    map))

(defvar prj-grep-mode-font-lock-keywords
  '((("^\\([[:alnum:] $_\/.+-]+\\):\\([0-9]+\\):.*$" (1 'hl-file-face) (2 'hl-number-face))
     ("^\\(>>>>>\\s-\\)\\(.+\\)$" (1 'hl-title-3-face) (2 'hl-symbol-face))
     ("^\\(<<<<<\\)$" (1 'hl-title-3-face)))
    t nil))

(defvar prj-grep-mode-header-line
  `(,(format "  Tips: %s and %s to navigate; %s to open file; %s or %s to delete item;"
             (propertize "UP" 'face 'tooltip)
             (propertize "DOWN" 'face 'tooltip)
             (propertize "ENTER" 'face 'tooltip)
             (propertize "DEL" 'face 'tooltip)
             (propertize "q" 'face 'tooltip))))

;;;###autoload
(define-derived-mode prj-grep-mode nil "prj:grep"
  "Major mode for search buffers."
  :group 'prj-group
  ;; TODO: highlight words behind ">>>>>".
  ;; (use-local-map prj-grep-mode-map)
  ;; (font-lock-add-keywords nil prj-grep-mode-font-lock-keywords)
  (remove-overlays)
  (setq font-lock-defaults prj-grep-mode-font-lock-keywords
        truncate-lines t
        ;; Header line.
        header-line-format prj-grep-mode-header-line))

(provide 'prj-grep)
