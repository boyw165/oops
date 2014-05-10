(defvar test-list '(1 2 3 4 5 6 7 8 9)
  "variable.")
(setq test-list '(1 2 3 4 5 6 7 8 9))
(last test-list)
(butlast test-list)

(defun test-next ()
  (interactive)
  (setq test-list (nconc (cdr test-list)
                         (list (car test-list))))
  (pp test-list)
  )

(defun test-prev ()
  (interactive)
  (setq test-list (nconc (last test-list)
                         (butlast test-list)))
  (pp test-list)
  )

(test-next)
(test-prev)
