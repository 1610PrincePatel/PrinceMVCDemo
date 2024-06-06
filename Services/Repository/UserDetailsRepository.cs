using Dapper;
using PrinceMVCDemo.Models;
using PrinceMVCDemo.Services.IRepository;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Helpers;

namespace PrinceMVCDemo.Services.Repository
{
    public class UserDetailsRepository : IUserDetailsRepository
    {
        private readonly string connectionString;

        public UserDetailsRepository()
        {
            connectionString = ConfigurationManager.ConnectionStrings["connectionStrig"].ConnectionString;
        }

        public IEnumerable<UserDetails> GetAllUserDetails()
        {
            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                var userDetailsList = connection.Query<UserDetails>("GetAllUserDetails", commandType: System.Data.CommandType.StoredProcedure).ToList();
                return userDetailsList;
            }
        }

        public UserDetails GetUserDetailsById(int UserID)
        {
            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                UserDetails userDetails = connection.QueryFirstOrDefault<UserDetails>("GetUserDetailsById", new { UserID }, commandType: System.Data.CommandType.StoredProcedure);
                return userDetails;
            }
        }

        public bool AddEditUserDetails(UserDetails userDetails)
        {
            AddEditClass detailsToSave = new AddEditClass
            {
                UserID = userDetails.UserID,
                Name = userDetails.Name,
                Email = userDetails.Email,
                PhoneNo = userDetails.PhoneNo,
                Address = userDetails.Address,
                CityId = userDetails.CityId,
                Agree = userDetails.Agree
            };
            using (var connection = new SqlConnection(connectionString))
            {
                string storedProcedure = userDetails.UserID > 0 ? "UpdateUserDetails" : "InsertUserDetails";
                int rowsAffected = connection.Execute(storedProcedure, detailsToSave, commandType: CommandType.StoredProcedure);
                return rowsAffected > 0;
            }
        }

        public bool DeleteUserDetails(int UserID)
        {
            using (var connection = new SqlConnection(connectionString))
            {
                int rowsAffected = connection.Execute("DeleteUserDetails", new { UserID }, commandType: CommandType.StoredProcedure);
                return rowsAffected > 0;
            }
        }

        public IEnumerable<DropdownState> GetAllCitiesAndStates()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                var result = connection.Query<DropdownState>("GetAllCitiesAndStates", commandType: System.Data.CommandType.StoredProcedure);
                return result;
            }
        }

        private class AddEditClass
        {
            public int UserID { get; set; }
            public string Name { get; set; }
            public string Email { get; set; }
            public string PhoneNo { get; set; }
            public string Address { get; set; }
            public int CityId { get; set; }
            public bool Agree { get; set; }
        }
    }
}