;; Contains functions that are used by other functions.

(defun region-selected()
  "Returns true if a region is selected. False otherwise."
  (and mark-active transient-mark-mode))

(defun uniq(list)
  "Given a list it returns that list but with unique elements."
  (let ((temp))
    (dolist (element list)
      (unless (find element temp)
        (add-to-list 'temp element)))
    temp))

(defun keys(alist)
  "Returns a list of all keys in the alist."
  (let ((temp))
    (dolist (element alist)
      (add-to-list 'temp (car element)))
    temp))

(defun values(alist)
  "Returns a list of all values in the alist."
  (let ((temp))
    (dolist (element alist)
      (add-to-list 'temp (cdr element)))
    temp))

(defun empty(list)
  "Returns true if list contains no elements. nil otherwise."
  (= (length list) 0))

(defun mark-whole-lines-region()
  "Marks whole lines in the selected region."
  (if (< (point) (mark))
      (beginning-of-line)
    (end-of-line))
  (exchange-point-and-mark)
  (if (< (point) (mark))
      (beginning-of-line)
    (end-of-line))
  (exchange-point-and-mark))

(defun mark-current-line()
  "Marks the current line. Mark is lower than point."
  (set-mark (line-beginning-position))
  (end-of-line))

(defun mark-current-line-or-whole-lines-region()
  "Selects whole lines in region if any region is selected.
Otherwise current line is selected."
  (if (region-selected)
      (mark-whole-lines-region)
    (mark-current-line)))

(defun delete-back-to-period()
  "Deletes back to period (.). This can be usefull if you
want to delete a method name that is called on and object or class."
  (interactive)
  (while (not (string= (char-to-string (char-before)) "."))
    (backward-delete-char-untabify 1)))