using Newtonsoft.Json.Linq;
using System;
using System.Globalization;
using System.Text;
class NewHebCal : HebrewCalendar
{
    public DateTime AddYears(DateTime date, int n)
    {
        DateTime newDate = base.AddYears(date, n);
        try
        {
            // fix c# bug
            string urlG2H = "http://www.hebcal.com/converter/?cfg=json&gy={0}&gm={1}&gd={2}&g2h=1";
            urlG2H = String.Format(urlG2H, date.Year.ToString(), date.Month.ToString(), date.Day.ToString());
            var wc = new System.Net.WebClient { Encoding = Encoding.UTF8 };
            var contents = wc.DownloadString(urlG2H);
            JObject dateObject = JObject.Parse(contents);
            string hebrewYear = dateObject.GetValue("hy").ToString();
            string hebrewMonth = dateObject.GetValue("hm").ToString();
            string hebrewDay = dateObject.GetValue("hd").ToString();
            // calc bar mitzva
            hebrewYear = (Int32.Parse(hebrewYear) + 13).ToString();
            string urlH2G = "http://www.hebcal.com/converter/?cfg=json&hy={0}&hm={1}&hd={2}&h2g=1";
            urlH2G = String.Format(urlH2G, hebrewYear, hebrewMonth, hebrewDay);
            wc = new System.Net.WebClient { Encoding = Encoding.UTF8 };
            contents = wc.DownloadString(urlH2G);
            dateObject = JObject.Parse(contents);
            string gYear = dateObject.GetValue("gy").ToString();
            string gMonth = dateObject.GetValue("gm").ToString();
            string gDay = dateObject.GetValue("gd").ToString();
            newDate = new DateTime(Int32.Parse(gYear), Int32.Parse(gMonth), Int32.Parse(gDay));
        }
        catch (Exception e)
        {
            System.Diagnostics.Debug.WriteLine(e.Message);
        }

        return newDate;
    }
}