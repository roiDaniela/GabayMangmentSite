﻿using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;
using System.ComponentModel;

namespace WingtipToys.Models
{
    public class Prayer
    {
        public int PrayerID { get; set; }
        public string PrayerFirstName { get; set; }
        public string PrayerLastName { get; set; }
        public int SynagogeId { get; set; }
    }
}