--Dox List: 
--"0715008499462;0715008685334;0715008271937;0715008742747;0715008686829"

declare @max_index int
       ,@sql nvarchar(2000)

set @sql = 'SELECT @max_index = count(*) - 1 FROM NCO_FATTURAZIONEDETTAGLIO WHERE IDBATCH = 395 and IDCONVENZIONATA = 12040229'
exec sp_executesql @sql, N'@max_index int output', @max_index output

SELECT
 'FAT;' 
+'015;' 
+CONVERT(NVARCHAR(10),FD.ID_FATTURA) + ';'
+'0000000;' 
+'000000001;' 
+CASE WHEN (ROW_NUMBER() OVER(PARTITION BY P.ROW_INDEX ORDER BY P.ROW) - 1) = 0 then '011127259;'  else ';' END 
+CASE WHEN (ROW_NUMBER() OVER(PARTITION BY P.ROW_INDEX ORDER BY P.ROW) - 1) <> 0 then FD.RIFERIMENTO+';' else ';' END
+CASE WHEN (ROW_NUMBER() OVER(PARTITION BY P.ROW_INDEX ORDER BY P.ROW) - 1) <> 0 then FD.DOSSIER+';'  else ';' END 
+CONVERT(VARCHAR(10), FD.DATA_FATTURA, 103) + ' 00:00;' 
+ '                ;' 
+SUBSTRING(P.TIPO_ADDEBITO,0,4) + ';' 
+FD.ATTIVITA + ';' 
+CASE SUBSTRING(P.TIPO_ADDEBITO,0,4) 
	WHEN 'TST' then CONVERT(NVARCHAR(10),CONVERT(numeric(8,2),FD.IMPORTO  * 1.22)) + ';' --Iva
	WHEN 'RE1' then CONVERT(NVARCHAR(10),FD.IMPORTO_SOCC) + ';'
	WHEN 'DEP' then CONVERT(NVARCHAR(10),FD.IMPORTO_DEP) + ';'
	WHEN 'RE3' then CONVERT(NVARCHAR(10),IMPORTO_REC + IMPORTO_SUPPL) + ';'
	else 'NODATA;'
 END --END IMPORTO
+CASE WHEN (ROW_NUMBER() OVER(PARTITION BY P.ROW_INDEX ORDER BY P.ROW) - 1) = 0 then ';;;;;;'  else '' END --TST:  subito dopo il campo “importo” n. 6 campi vuoti 
+CASE WHEN (ROW_NUMBER() OVER(PARTITION BY P.ROW_INDEX ORDER BY P.ROW) - 1) = 0 then ';'  else '22;' END --Aliquota iva
+CASE WHEN (ROW_NUMBER() OVER(PARTITION BY P.ROW_INDEX ORDER BY P.ROW) - 1) = 0 then ';'  else upper(VHL.vchNumberPlate) + ';' END --Targa
+CASE WHEN (ROW_NUMBER() OVER(PARTITION BY P.ROW_INDEX ORDER BY P.ROW) - 1) = 0 then ';' else '1,00;' END --Quantità
+CASE WHEN (ROW_NUMBER() OVER(PARTITION BY P.ROW_INDEX ORDER BY P.ROW) - 1) = 0 then ''  else ';;;' END --DETT: subito dopo il campo “quantità” devono esserci n. 3 campi vuoti
+'                                   ;'+'                                   ;'+'                                   ;'
'ARVEL_TXT'
FROM
(SELECT 
    ROWID
   ,DOSSIER
   ,ROW_NUMBER() OVER(ORDER BY ROWID) AS ROW
   ,ROW_NUMBER() OVER(ORDER BY ROWID) % (1 + @max_index) AS ROW_INDEX
   ,IMPORTO TST
   ,IMPORTO_SOCC RE1
   ,IMPORTO_USC
   ,IMPORTO_KM
   ,IMPORTO_DEP DEP
   ,IMPORTO_REC RE31
   ,IMPORTO_SUPPL RE3
FROM NCO_FATTURAZIONEDETTAGLIO
WHERE 
IDBATCH = 395
and IDCONVENZIONATA = 12040229
) FD
UNPIVOT(SOMMA for TIPO_ADDEBITO in
  (TST
  ,RE1
  ,IMPORTO_USC
  ,IMPORTO_KM
  ,DEP
  ,RE31
  ,RE3)
) AS P
left join NCO_FATTURAZIONEDETTAGLIO FD on P.ROWID = FD.ROWID 
left JOIN NCO_INCARICOCONVENZIONATA IC on IC.ID_DOSSIER = FD.IDDOX and IC.ID_INCARICOCONVENZIONATA = FD.ID_INCARICO
INNER JOIN Incident AS INC
  ON (INC.iIncidentId = FD.IDDENUNCIA)
INNER JOIN Individual AS IND
  ON (FD.IDINTESTATARIO = IND.iIndividualId)
INNER JOIN CSuExtensionRecord AS EX
  ON (INC.iIncidentId = EX.iSystemId
  AND INC.iSiteId = EX.iSiteId
  AND EX.iTableId = 128)
INNER JOIN NCO_Vehicle AS VHL
  ON VHL.iVehicleId = EX.iUserExtension2
WHERE 
FD.IDBATCH = 395
and FD.IDCONVENZIONATA = 12040229
and P.SOMMA > 0
order BY p.ROW