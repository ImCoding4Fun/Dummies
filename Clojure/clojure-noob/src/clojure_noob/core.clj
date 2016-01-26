;SqlServer DB Info.
;SELECT  
;   CONNECTIONPROPERTY('net_transport') AS net_transport,
;   CONNECTIONPROPERTY('protocol_type') AS protocol_type,
;   CONNECTIONPROPERTY('auth_scheme') AS auth_scheme,
;   CONNECTIONPROPERTY('local_net_address') AS local_net_address,
;   CONNECTIONPROPERTY('local_tcp_port') AS local_tcp_port,
;   CONNECTIONPROPERTY('client_net_address') AS client_net_address 

(ns clojure-noob.core
  (:require [clojure.java.jdbc :as jdbc]))

(def db-spec {:classname "com.microsoft.jdbc.sqlserver.SQLServerDriver"
			  :subprotocol "sqlserver"
              :subname "//xxx.xx.xx.xxx:xxx;database=xxxx;user=xx;password=xxxxxx"
        })

(defn -main
  []
    (println "\n\n")
	(
	  jdbc/with-db-connection [connection db-spec]
	  
	  ; query-1
	  (let [rows (jdbc/query connection
	                         ["select top 10 * from sys.tables"])]
	    (doseq [row rows] (println (:name row) )))
	  (println "\n\n")
	  
	  ; query-2
	  (let [rows (jdbc/query connection
	                         ["select * from PR_Version"])]
	    (doseq [row rows] (println row )))
	  (println "\n\n")
	  
	  ; query-3
	  (let [rows (jdbc/query connection
	                         ["select * from PR_Version"])]
	    (doseq [row rows] (println (:id row) )))
	 )
)

