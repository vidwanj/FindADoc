using System;
using System.Collections.Generic;
using System.Data.Services;
using System.Data.Services.Common;
using System.Linq;
using System.ServiceModel.Web;
using System.Web;
using Geocoder;
namespace FindADocService
{
    [JSONPSupportBehavior]
    public class FindADoc : DataService<ThrCon8491123Entities>
    {
        float ParamLatitude;
        float ParamLongitude;
        // This method is called only once to initialize service-wide policies.
        public static void InitializeService(DataServiceConfiguration config)
        {
            // TODO: set rules to indicate which entity sets and service operations are visible, updatable, etc.
            // Examples:
            config.SetEntitySetAccessRule("*", EntitySetRights.AllRead);
            config.SetServiceOperationAccessRule("searchDoctorForMobileAppPaging", ServiceOperationRights.All);
            config.SetServiceOperationAccessRule("getinsuranceList", ServiceOperationRights.All);
            config.SetServiceOperationAccessRule("getSearchListHospitalAffiliations", ServiceOperationRights.All);
            config.SetServiceOperationAccessRule("getSearchListLanguages", ServiceOperationRights.All);
           config.SetServiceOperationAccessRule("getSearchListSpecialties", ServiceOperationRights.All);
           config.SetServiceOperationAccessRule("getPhysicianOffices", ServiceOperationRights.All);
            config.DataServiceBehavior.MaxProtocolVersion = DataServiceProtocolVersion.V2;
        }

        [WebGet]
        public System.Data.Objects.ObjectResult<GetPhysician_View> searchDoctorForMobileAppPaging(string lname, string fname, string degree, string gender, string agemin, string agemax, string lang, string spec, string sameday, string apptavail, string hospaffil, string insur, string zip, string distancezipcode, string distance, string StartFrom, string NumberOfRecords, string currentlatitude, string currentlongitude)
        {
            decimal latitude;
            decimal longitude;
            if (gender == "undefined")
            {
                gender = "";
            }
            if (sameday == "undefined")
            {
                sameday = "";
            }

            if (currentlatitude == "undefined")
            {
                currentlatitude = "0.0";
            }

            if (currentlongitude == "undefined")
            {
                currentlongitude = "0.0";
            }
            
            if (distancezipcode != "")
            {
                GeoCode gc = new GeoCode();

                Coordinate coordinate = gc.GetCoordinates(distancezipcode);

                latitude = coordinate.Latitude;
                longitude = coordinate.Longitude;
                ParamLatitude = (float)latitude;
                ParamLongitude = (float)longitude;

            }
            else
            {

               
                ParamLatitude =float.Parse(currentlatitude);
                ParamLongitude = float.Parse(currentlongitude);
            
            }

          
               // return CurrentDataSource.getPhysicianListwithPaging(lname, fname, degree, gender, Convert.ToInt32(agemin), Convert.ToInt32(agemax), lang, spec, sameday, Convert.ToInt32(apptavail), hospaffil, Convert.ToInt32(insur), zip, ParamLatitude, ParamLongitude, Convert.ToInt32(distance), Convert.ToInt32(StartFrom), Convert.ToInt32(NumberOfRecords));


            return CurrentDataSource.getPhysicianListwithPaging(lname, fname, degree, gender, Convert.ToInt32(agemin), Convert.ToInt32(agemax), lang, spec, sameday, Convert.ToInt32(apptavail), hospaffil, Convert.ToInt32(insur), zip, ParamLatitude, ParamLongitude, Convert.ToInt32(distance), Convert.ToInt32(StartFrom), Convert.ToInt32(NumberOfRecords));
         

        }



        [WebGet]
        public System.Data.Objects.ObjectResult<GetInsuranceList_View> getinsuranceList()
        {
            return CurrentDataSource.getinsuranceList();
        }



        [WebGet]
        public System.Data.Objects.ObjectResult<HospitalAffiliationsList_View> getSearchListHospitalAffiliations()
        {
            return CurrentDataSource.getSearchListHospitalAffiliations();
        }


        

        [WebGet]
        public System.Data.Objects.ObjectResult<med_physdirectory_languages> getSearchListLanguages()
        {
            return CurrentDataSource.getSearchListLanguages();
        }

        [WebGet]
        public System.Data.Objects.ObjectResult<med_physdirectory_Specialty> getSearchListSpecialties()
        {
            return CurrentDataSource.getSearchListSpecialties();
        }
        [WebGet]
        public System.Data.Objects.ObjectResult<Med_Physdirectory_Offices_View> getPhysicianOffices(string ids)
        {

            return CurrentDataSource.getPhysicianOffices(ids);
        }
       
        
    }

}
