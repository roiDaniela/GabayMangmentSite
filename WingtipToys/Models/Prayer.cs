using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;
using System.ComponentModel;

namespace GabayManageSite.Models
{
    public class Prayer
    {
        public int PrayerID { get; set; }
        public string PrayerIDString { get; set; }

        public string PrayerFirstName { get; set; }
        public string PrayerLastName { get; set; }
        public int SynagogeId { get; set; }
    }
}