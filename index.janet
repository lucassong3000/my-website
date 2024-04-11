(bagatto/set-output-dir! "out")

(def git-commit-year
  (string/slice (sh/$< git show -s --format=%as) 0 4))

(def data {:config {:attrs {:base-url "https://isaacfreund.com"
                            :git-commit-year git-commit-year}}
           :home {:attrs {:title "Isaac Freund"}}
           :about {:src "content/about.md"
                   :attrs bagatto/parse-mago}
           :blog-index {:attrs {:title "Isaac's Blog"}}
           :blog-posts {:src (bagatto/slurp-* "content/blog/*")
                        :attrs bagatto/parse-mago
                        :transform (bagatto/attr-sorter :date :descending)}
           :software {:src "content/software.md"
                      :attrs bagatto/parse-mago}
           :poetry-index {:src "content/poetry.md"
                          :attrs bagatto/parse-mago}
           :poetry {:src (bagatto/slurp-* "content/poetry/*")
                    :attrs bagatto/parse-mago
                    :transform (bagatto/attr-sorter :date :descending)}
           :404 {:src "content/404.md"
                 :attrs bagatto/parse-mago}
           :static {:src (bagatto/* "static/*")
                    :attrs bagatto/parse-base}
           :licenses {:src (bagatto/* "LICENSES/*")
                      :attrs bagatto/parse-base}})

(def poem->html-peg
  (peg/compile
    '(% (* (constant `<div class="poem"><p><span>`)
           (any (+ (* (at-least 2 "\n") (constant "</span></p><p><span>"))
                   (* "\n" (constant "</span><span>"))
                   (* "<" (constant "&lt;"))
                   (* ">" (constant "&gt;"))
                   (* "&" (constant "&amp;"))
                   '1))
           (constant "</span></p></div>")))))

(defn poem->html [s]
  (in (peg/match poem->html-peg (string/trim s)) 0))

(defn renderer2
  [template item]
  (fn [data] (bagatto/render template data (data item))))

(def site {:home {:dest "index.html"
                  :out (renderer2 "/templates/home" :home)}
           :about {:dest "about/index.html"
                   :out (renderer2 "/templates/page" :about)}
           :blog-index {:dest "blog/index.html"
                        :out (renderer2 "/templates/blog-index" :blog-index)}
           :blog-feed {:dest "blog/feed.xml"
                       :out (bagatto/renderer "/templates/blog-feed")}
           :blog-posts {:each :blog-posts
                        :dest (fn [_ item]
                                (string/format "blog/%s/index.html" (item :slug)))
                        :out (bagatto/renderer "/templates/page")}
           :software {:dest "software/index.html"
                      :out (renderer2 "/templates/page" :software)}
           :poetry-index {:dest "poetry/index.html"
                          :out (renderer2 "/templates/page" :poetry-index)}
           :poetry {:each :poetry
                    :dest (fn [_ item]
                            (string/format "poetry/%s/index.html" (item :slug)))
                    :out (bagatto/renderer "/templates/page")}
           :404 {:dest "404/index.html"
                 :out (renderer2 "/templates/page" :404)}
           :static {:each :static
                    :dest (bagatto/path-copier "")}
           :licenses {:each :licenses
                      :dest (bagatto/path-copier "")}})
