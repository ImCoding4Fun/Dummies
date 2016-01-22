(import '(java.util Calendar))
(import '(java.util GregorianCalendar Locale))
(import '(java.text SimpleDateFormat))

(defn fatt [n](

   reduce * (range 2 (inc n))
 ))

;(comment
(defn or-and-dummy []

  (println(str "Or-and-dummy - Begin"))
  (def my-vector [false nil 3 3 4 nil 3 4])

  (let [first-truthy-or-last (or my-vector)]
      (println "\tfirst truthy: " first-truthy-or-last)
  )

  (let [first-truthy-or-last (or false nil nil false nil nil false)]
      (println "\tlast: " first-truthy-or-last)
  )

  (let [first-falsey-or-last (and 1 2 3 5 nil false nil 4 nil 2)]
      (println "\tfirst-falsey: " first-falsey-or-last)
  )

  (let [first-falsey-or-last (and 1 2 3 4 5)]
      (println "\tlast: " first-falsey-or-last)
  )

  (println (str "Or-and-dummy - End"))
)

(defn foo[name]

  (println "Nice to meet you " name ". My name is foo!" )
)

(defn anonymous-foo[]

  (println(str "Nice to meet you anonymous user. My name is foo!\n"))
)

(defn dummy-1 [name,num]

    (println "Begin dummy-1\n")
    (println "Hello," name "! This is my first clojure app\n")
    (foo "Bill")
    (anonymous-foo)

    (println num"! =" (fatt num) "\n")
    (or-and-dummy)
    (println "\n[0..9]"  (take 10 (range)))
    (println "[1..10]" (map inc (take 10 (range))))
    (println "\nEnd dummy-1")
)

(defn fatt'[n]

  (reduce * (range 2 (inc n)) )
)

(defn this-year []
  (let [cal (GregorianCalendar.)
        year (.get cal Calendar/YEAR)]
    year)
)

(this-year)

(defn next-xmas []
(.. (SimpleDateFormat. "yyyy-MM-dd HH:mm")
    (parse (str (this-year)"-12-25 00:00:00"))))

(defn now [] (new java.util.Date))

(defn xmas-countdown[]
  (let [msec  (- (.getTime (next-xmas)) (.getTime (now)))
        secs  (int (/ msec 1000))
        mins  (int (/ secs 60))
        hours (int (/ mins 60))
        days  (int (/ hours 24))
        remaining_hours (- hours (* days 24))
        remaining_mins (- mins (* hours 60))
        remaining_secs (- secs (* mins 60))      
       ]
    (println "\nXmas countdown (GMT):")
    (println "days: " days)
    (println "hours: " remaining_hours)
    (println "mins: " remaining_mins)
    (println "secs: " remaining_secs)
  )
)

(defn dummy-2[num]

  (println "Begin dummy-2\n")

  (loop [i 0]
  (when (<= i 10)
    (println i "! =" (reduce * (range 2 (inc i)) ))
    (recur (inc i)); loop i will take this value
  ))

  (xmas-countdown)
)

(dummy-1 "World" 5)
(println "\n\n")
(dummy-2 5)

(read-line)
