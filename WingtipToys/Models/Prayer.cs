namespace WingtipToys.Models
{
	internal class Prayer : Product
	{
		public int PrayerID { get; set; }
		public string PrayerFirstName { get; set; }
		public string PrayerLastName { get; set; }
		public int CategoryID { get; set; }
	}
}