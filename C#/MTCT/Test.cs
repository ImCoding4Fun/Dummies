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
        }

        private void comboBoxMetodo_SelectedIndexChanged(object sender, EventArgs e)
        {
            string []targhe = {"", "AJ307EY", "AJ307EY" };
            textBoxTarga.Text = targhe[comboBoxMetodo.SelectedIndex];
            textBoxTarga.Enabled = String.IsNullOrEmpty(textBoxTarga.Text);
        }

        private void buttonRun_Click(object sender, EventArgs e)
        {
            MTCTServiceClient service = new MTCTService.MTCTServiceClient();

            if (comboBoxMetodo.SelectedIndex > 0)
            {
                string result = "";
                string output_file = "";
                if (comboBoxMetodo.SelectedIndex == 1)
                {
                   DettaglioCartaCircolazioneVeicoloResponseType response = service.DettaglioCartaCicolazioneAutoveicolo(textBoxTarga.Text);

                   result = response.asString();
                   output_file = @"C:\vm\DettaglioCartaCircolazioneVeicolo.txt";
                }
                else
                {
                    DettaglioAutoveicoloComproprietariResponseType response = service.dettaglioAutoveicoloComproprietari(textBoxTarga.Text);
                   
                    result = response.asString();
                    output_file = @"C:\vm\DettaglioAutoveicoloComproprietari.txt";
                }

                File.WriteAllText(output_file, result);
                Process.Start("notepad.exe", output_file);
            }
        }
    }
}
;