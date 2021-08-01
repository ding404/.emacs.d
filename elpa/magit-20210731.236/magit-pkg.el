(define-package "magit" "20210731.236" "A Git porcelain inside Emacs."
  '((emacs "25.1")
    (dash "20210330")
    (git-commit "20210701")
    (magit-section "20210701")
    (transient "20210701")
    (with-editor "20210524"))
  :commit "e8acaa9522fbb3847ba1308c50c0b4b0b9dd957f" :authors
  '(("Marius Vollmer" . "marius.vollmer@gmail.com")
    ("Jonas Bernoulli" . "jonas@bernoul.li"))
  :maintainer
  '("Jonas Bernoulli" . "jonas@bernoul.li")
  :keywords
  '("git" "tools" "vc")
  :url "https://github.com/magit/magit")
;; Local Variables:
;; no-byte-compile: t
;; End:
