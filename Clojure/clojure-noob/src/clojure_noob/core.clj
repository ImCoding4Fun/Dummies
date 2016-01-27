; sql server auth: 
; :subname "//server-name:port;database=database-name;user=sql-authentication-user-name;password=password"
	;SELECT  
	;   CONNECTIONPROPERTY('local_net_address') AS server_name,
	;   CONNECTIONPROPERTY('local_tcp_port') AS port

;windows auth: 
; copy Microsoft SQL Server JDBC Driver 3.0\sqljdbc_3.0\enu\auth\x64\sqljdbc_auth.dll to C:\Windows\System32
; :subname "//127.0.0.1:port;database=AdventureWorks2014;integratedSecurity=true"
; How to get "port": Open Windows configuration manager (Or Task Manager, "Services" tab) and check the process id (PID) of SQLEXPRESS service.
; Run "netstat -ano" from a command or powershell console and check the port number corresponding to the above-mentioned PID.

(ns clojure-noob.core
  (:require [clojure.java.jdbc :as jdbc])
  (:require [clojure.string :as string]))

(def db-spec {:classname "com.microsoft.jdbc.sqlserver.SQLServerDriver"
			  :subprotocol "sqlserver"
              ;:subname "//172.20.99.243:1217;database=PlugAndReport;user=sa;password=123456"  ;sql server auth.
              :subname "//127.0.0.1:60745;database=AdventureWorks2014;integratedSecurity=true" ;windows auth.
        })

(defn -main
  []
    (
	  jdbc/with-db-connection [connection db-spec]
	  
	  (let [rows (jdbc/query connection
	                         ["select CountryRegionCode, Name from Person.CountryRegion"])]
	    (doseq [row rows]  (println (:countryregioncode row) "\t" (string/upper-case (:name row)) ))	
	  )
    )
)