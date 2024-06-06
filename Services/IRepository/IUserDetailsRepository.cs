using PrinceMVCDemo.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PrinceMVCDemo.Services.IRepository
{
    public  interface IUserDetailsRepository
    {
        IEnumerable<UserDetails> GetAllUserDetails();
        UserDetails GetUserDetailsById(int UserID);
        bool AddEditUserDetails(UserDetails userDetails);
        bool DeleteUserDetails(int UserID);
        IEnumerable<DropdownState> GetAllCitiesAndStates();
    }
}
