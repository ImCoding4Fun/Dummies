using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Channels;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MTCT_Test.MTCTService;
using System.IO;
using System.Diagnostics;

namespace MTCT_Test
{
    public partial class FormMTCT_Test : Form
    {
        public FormMTCT_Test()
        {
            InitializeComponent();
            comboBoxMetodo.SelectedIndex = 0;
        }

        private void comboBoxMetodo_SelectedIndexChanged(object sender, EventArgs e)
        {
            string []targhe = {"AJ307EY", "AJ307EY" };
            textBoxTarga.Text = targhe[comboBoxMetodo.SelectedIndex];
            textBoxTarga.Enabled = String.IsNullOrEmpty(textBoxTarga.Text);
        }

        private void buttonRun_Click(object sender, EventArgs e)
        {
            MTCTServiceClient service = new MTCTService.MTCTServiceClient();

            string result = "Nothing to show. An error occurred.";
            string output_file = Consts.OutputFolder + "\\";
            try
            {
                output_file = Path.Combine(Consts.OutputFolder, Consts.OutputFiles[comboBoxMetodo.SelectedIndex]);
                if (comboBoxMetodo.SelectedIndex == 0)
                {
                    DettaglioCartaCircolazioneVeicoloResponseType response = service.DettaglioCartaCicolazioneAutoveicolo(textBoxTarga.Text);
                    result = response.asString();
                }
                if(comboBoxMetodo.SelectedIndex == 1)
                {
                    DettaglioAutoveicoloComproprietariResponseType response = service.dettaglioAutoveicoloComproprietari(textBoxTarga.Text);
                    result = response.asString();
                }
            }
            catch (Exception ex)
            {
                result += Environment.NewLine + ex.Message;
                if (ex is FaultException)
                    result += string.Format("##For further information please contact:#{0}#{1}#Mobile: {2}", Consts.AdminName, Consts.AdminEmail, Consts.AdminMobile).Replace("#", ""+Environment.NewLine);

                output_file = output_file.Replace(".txt", Consts.ErrorSuffix + ".txt");
            }
            finally
            { 
                File.WriteAllText(output_file, result);
                Process.Start("notepad.exe", output_file);
            }
        }
        
    }
}
;