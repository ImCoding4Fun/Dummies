using System.Configuration;

namespace MTCT_Test
{
    public sealed class Consts
    {
        public static readonly string   OutputFolder = ConfigurationManager.AppSettings["output_dir"];
        public static readonly string[] OutputFiles  = { ConfigurationManager.AppSettings["method_1_output_file"] , ConfigurationManager.AppSettings["method_2_output_file"] };
        public static readonly string   ErrorSuffix  = ConfigurationManager.AppSettings["error_suffix"];
        public static readonly string   AdminName    = ConfigurationManager.AppSettings["admin_name"];
        public static readonly string   AdminEmail   = ConfigurationManager.AppSettings["admin_email"];
        public static readonly string   AdminMobile  = ConfigurationManager.AppSettings["admin_mobile"];

    }
}
