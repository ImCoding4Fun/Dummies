namespace MTCT_Test
{
    partial class FormMTCT_Test
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.buttonRun = new System.Windows.Forms.Button();
            this.textBoxTarga = new System.Windows.Forms.TextBox();
            this.labelTarga = new System.Windows.Forms.Label();
            this.comboBoxMetodo = new System.Windows.Forms.ComboBox();
            this.labelMetodo = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // buttonRun
            // 
            this.buttonRun.Location = new System.Drawing.Point(407, 29);
            this.buttonRun.Name = "buttonRun";
            this.buttonRun.Size = new System.Drawing.Size(281, 154);
            this.buttonRun.TabIndex = 0;
            this.buttonRun.Text = "Run";
            this.buttonRun.UseVisualStyleBackColor = true;
            this.buttonRun.Click += new System.EventHandler(this.buttonRun_Click);
            // 
            // textBoxTarga
            // 
            this.textBoxTarga.BackColor = System.Drawing.SystemColors.Menu;
            this.textBoxTarga.Location = new System.Drawing.Point(95, 108);
            this.textBoxTarga.Name = "textBoxTarga";
            this.textBoxTarga.Size = new System.Drawing.Size(287, 26);
            this.textBoxTarga.TabIndex = 2;
            // 
            // labelTarga
            // 
            this.labelTarga.AutoSize = true;
            this.labelTarga.Location = new System.Drawing.Point(17, 114);
            this.labelTarga.Name = "labelTarga";
            this.labelTarga.Size = new System.Drawing.Size(50, 20);
            this.labelTarga.TabIndex = 3;
            this.labelTarga.Text = "Targa";
            // 
            // comboBoxMetodo
            // 
            this.comboBoxMetodo.FormattingEnabled = true;
            this.comboBoxMetodo.Items.AddRange(new object[] {
            "",
            "DettaglioCartaCicolazioneAutoveicolo",
            "DettaglioAutoveicoloComproprietari"});
            this.comboBoxMetodo.Location = new System.Drawing.Point(95, 29);
            this.comboBoxMetodo.Name = "comboBoxMetodo";
            this.comboBoxMetodo.Size = new System.Drawing.Size(287, 28);
            this.comboBoxMetodo.TabIndex = 5;
            this.comboBoxMetodo.SelectedIndexChanged += new System.EventHandler(this.comboBoxMetodo_SelectedIndexChanged);
            // 
            // labelMetodo
            // 
            this.labelMetodo.AutoSize = true;
            this.labelMetodo.Location = new System.Drawing.Point(17, 37);
            this.labelMetodo.Name = "labelMetodo";
            this.labelMetodo.Size = new System.Drawing.Size(63, 20);
            this.labelMetodo.TabIndex = 6;
            this.labelMetodo.Text = "Metodo";
            // 
            // FormMTCT_Test
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(707, 224);
            this.Controls.Add(this.labelMetodo);
            this.Controls.Add(this.comboBoxMetodo);
            this.Controls.Add(this.labelTarga);
            this.Controls.Add(this.textBoxTarga);
            this.Controls.Add(this.buttonRun);
            this.Name = "FormMTCT_Test";
            this.Text = "MTCT Service -- Test --";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button buttonRun;
        private System.Windows.Forms.TextBox textBoxTarga;
        private System.Windows.Forms.Label labelTarga;
        private System.Windows.Forms.ComboBox comboBoxMetodo;
        private System.Windows.Forms.Label labelMetodo;
    }
}

