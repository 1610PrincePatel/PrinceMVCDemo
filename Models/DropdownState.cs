using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrinceMVCDemo.Models
{
    public class DropdownState
    {
        public int CityId { get; set; }
        public string CityName { get; set; }
        public int StateId { get; set; }
        public string StateName { get; set; }
    }

    public class DropdownData
    {
        public IEnumerable<State> States { get; set; }
        public IEnumerable<City> Cities { get; set; }
    }
}