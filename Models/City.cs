using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrinceMVCDemo.Models
{
    public class City
    {
        public int Id { get; set; } 
        public string CityName { get; set; }
        public int StateId { get; set; }
    }
}