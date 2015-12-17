using MTCT_Test.MTCTService;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace MTCT_Test
{
    public static class Service_Ext
    {
        public static string asString(this DettaglioCartaCircolazioneVeicoloResponseType response)
        {
            StringBuilder res = new StringBuilder();
            int i = 0;
            foreach (Type type in response.Items.Select(x => x.GetType()))
                res.AppendLine(Convert.ChangeType(response.Items[i++], type).asString());
            res.Length = res.Length - 1;

            return res.ToString();
        }

        private static List<Type> rootTypes = new List<Type>() { typeof(String), typeof(Int32), typeof(DateTime) };

        public static string asString(this DettaglioAutoveicoloComproprietariResponseType response)
        {
            myResult.Length = 0;
            foreach (var item in response.Items)
            {
                DatiVeicoloComproprietariOutputType dV = ((DatiVeicoloComproprietariOutputType)((DettaglioVeicoloComproprietariOutputType)item).Items[0]);

                for(int i=0; i< dV.GetType().GetProperties(BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public).Count(); i++)
                {
                    foreach (PropertyInfo rt_property in dV.GetType().GetProperties())
                    {
                        myResult.AppendLine( rt_property.Name.asTitle(150) );
                        var root_item = rt_property.GetValue(dV, null);

                        foreach (PropertyInfo l1_property in root_item.GetType().GetProperties())
                        {
                            var root_val = l1_property.GetValue(root_item, null);
                            visitIt(root_val, l1_property.Name);
                        }
                    }
                }
            }

            myResult.Length = myResult.Length - 1;
            return myResult.ToString();
        }

        private static StringBuilder myResult = new StringBuilder();

        public static void visitIt(this object v_root, string p_Name)
        {
            if (v_root == null || rootTypes.Contains(v_root.GetType()))
            {
                myResult.AppendLine(p_Name.asDescription().PadRight(64) + v_root.asSafeString());
                return;
            }
            else
            {
                foreach (PropertyInfo pp in v_root.GetType().GetProperties(BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public))
                {
                    var pp_value = pp.GetValue(v_root, null);
                    if (rootTypes.Contains(pp.PropertyType))
                    {
                        myResult.AppendLine(pp.Name.asDescription().PadRight(64) + pp_value.asSafeString());
                        return;
                    }
                    else
                        visitIt(pp_value, pp.Name);
                }
            }
        }

        public static void dummyWay(DettaglioAutoveicoloComproprietariResponseType response)
        {
            StringBuilder res = new StringBuilder();
            foreach (var item in response.Items)
            {
                DatiVeicoloComproprietariOutputType dV = ((DatiVeicoloComproprietariOutputType)((DettaglioVeicoloComproprietariOutputType)item).Items[0]);
                res.AppendLine("Dati Aggiuntivi Tecnici".PadRight(150, '_'));
                res.AppendLine("Larghezza Veicolo In Metri".PadRight(64) + dV.datiAggiuntiviTecnici.larghezzaVeicoloInMetri.asSafeString());
                res.AppendLine("Lunghezza Veicolo In Metri".PadRight(64) + dV.datiAggiuntiviTecnici.lunghezzaVeicoloInMetri.asSafeString());
                res.AppendLine("Massa Complessiva In KG".PadRight(64) + dV.datiAggiuntiviTecnici.massaComplessivaInKG.asSafeString());
                res.AppendLine("Massa Complessiva Rimorchio In KG".PadRight(64) + dV.datiAggiuntiviTecnici.massaComplessivaRimorchioInKG.asSafeString());
                res.AppendLine("Numero Posti Totali".PadRight(64) + dV.datiAggiuntiviTecnici.numeroPostiTotali.asSafeString());
                res.AppendLine("Tara In KG".PadRight(64) + dV.datiAggiuntiviTecnici.taraInKG.asSafeString());

                res.AppendLine("Dati Carta Circolazione".PadRight(150, '_'));
                res.AppendLine("Data Emissione".PadRight(64) + dV.datiCartaCircolazione.dataEmissione.ToString().asSafeString());
                res.AppendLine("Data Richiesta".PadRight(64) + dV.datiCartaCircolazione.dataRichiesta.ToString().asSafeString());
                res.AppendLine("Numero Carta Circolazione".PadRight(64) + dV.datiCartaCircolazione.numeroCartaCircolazione.asSafeString());
                res.AppendLine("Sigla UMC".PadRight(64) + dV.datiCartaCircolazione.siglaUMC.asSafeString());
                res.AppendLine("Ufficio Operativo".PadRight(64) + dV.datiCartaCircolazione.ufficioOperativo.asSafeString());

                res.AppendLine("Dati Gancio Traino".PadRight(150, '_'));
                res.AppendLine("Codice Antifalsificazione".PadRight(64) + dV.datiGancioTraino.codiceAntifalsificazione.asSafeString());
                res.AppendLine("Data Emissione".PadRight(64) + dV.datiGancioTraino.dataEmissione.asSafeString());
                res.AppendLine("Data Installazione Gancio Traino".PadRight(64) + dV.datiGancioTraino.dataInstallazioneGancioTraino.asSafeString());
                res.AppendLine("Data Richiesta".PadRight(64) + dV.datiGancioTraino.dataRichiesta.asSafeString());
                res.AppendLine("Larghezza Massima Rimorchio In Metri".PadRight(64) + dV.datiGancioTraino.larghezzaMassimaRimorchioInMetri.asSafeString());
                res.AppendLine("Marca Operativa".PadRight(64) + dV.datiGancioTraino.marcaOperativa.asSafeString());
                res.AppendLine("Massa Rimorchiabile In KG".PadRight(64) + dV.datiGancioTraino.massaRimorchiabileInKG.asSafeString());

                res.AppendLine("Dati Impianto FAP".PadRight(150, '_'));
                res.AppendLine("Codice Antifalsificazione".PadRight(64) + dV.datiImpiantoFAP.codiceAntifalsificazione.asSafeString());
                res.AppendLine("Data Emissione".PadRight(64) + dV.datiImpiantoFAP.dataEmissione.asSafeString());
                res.AppendLine("Data Richiesta".PadRight(64) + dV.datiImpiantoFAP.dataRichiesta.asSafeString());
                res.AppendLine("Marca Operativa".PadRight(64) + dV.datiImpiantoFAP.marcaOperativa.asSafeString());

                res.AppendLine("Dati Impianto GPL".PadRight(150, '_'));
                res.AppendLine("Codice Antifalsificazione".PadRight(64) + dV.datiImpiantoGPL.codiceAntifalsificazione.asSafeString());
                res.AppendLine("Data Collaudo Impianto GPL".PadRight(64) + dV.datiImpiantoGPL.dataCollaudoImpiantoGPL.asSafeString());
                res.AppendLine("Data Emissione".PadRight(64) + dV.datiImpiantoGPL.dataEmissione.asSafeString());
                res.AppendLine("Data Richiesta".PadRight(64) + dV.datiImpiantoGPL.dataRichiesta.asSafeString());
                res.AppendLine("Direttiva ECEONU".PadRight(64) + dV.datiImpiantoGPL.direttivaECEONU.asSafeString());
                res.AppendLine("Marca Operativa".PadRight(64) + dV.datiImpiantoGPL.marcaOperativa.asSafeString());
                res.AppendLine("Matricola Serbatoio GPL".PadRight(64) + dV.datiImpiantoGPL.matricolaSerbatoioGPL.asSafeString());
                res.AppendLine("Ubicazione Impianto GPL".PadRight(64) + dV.datiImpiantoGPL.ubicazioneImpiantoGPL.asSafeString());

                res.AppendLine("Ubicazione Impianto GPL".PadRight(64) + dV.datiImpiantoGPL.ubicazioneImpiantoGPL.asSafeString());
            }
        }
        
        public static string asString(this object o)
        {
            StringBuilder res = new StringBuilder();
            Type t = o.GetType();

            res.AppendLine(t.Name.Replace("Type","").asTitle(150));

            foreach (string propertyName in t.GetProperties(BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public).Where(x=>!x.Name.Contains("Specified")).Select(x=>x.Name))
            {
                    string line_prefix = propertyName.asDescription().PadRight(64);
                    string line = line_prefix + t.GetProperty(propertyName).GetValue(o, null).asSafeString();
                    res.AppendLine(line);
            }

            res.Length = res.Length - 1;
            return res.ToString();
        }

        public static string asSafeString(this object o)
        {
            if (o is string)
            {
                string myString = ((string)o).Trim();
                string ret = String.IsNullOrEmpty(myString) ? "N/A" : o.ToString();
            }

            return o == null? "N/A" : o.ToString();
        }

        public static string asDescription(this String propertyName)
        {
            //CO2, NOX bug...
            if (propertyName.ToUpper().Equals(propertyName))
                return propertyName;

            string ret = "" + Char.ToUpper(propertyName[0]);
            int i = 2;

            bool isAcronym = false;
            bool isAcronymFirstChar = true;

            foreach (char c in propertyName.ToCharArray(1,propertyName.Length-1))
            {
                char next_char = propertyName[Math.Min(i, propertyName.Length - 1)];
                isAcronym = Char.IsLetterOrDigit(c) && Char.IsUpper(c) && Char.IsLetterOrDigit(next_char) && Char.IsUpper(next_char);

                if (Char.IsUpper(c) && !isAcronym)
                    ret += " " + c;
                else
                {
                    if (isAcronym && isAcronymFirstChar)
                    { 
                        isAcronymFirstChar = false;
                        ret += " " + c;
                    }
                    else
                        ret += c;
                }

                i++;
            }
            
            return ret;
        }

        public static string asTitle(this string property, int padlenght)
        {
            int spaces = padlenght - property.Length;
            int padLeft = spaces / 2 + property.Length;
            return property.asDescription().PadLeft(padLeft,'_').PadRight(padlenght, '_');
        }

    }
}
