  

        var address;
        var mapaddress;
        var valid;
        var jsonObj = [];
        var addressjsonObj = [];
        var latitude;
        var longitude;
        var mobileDemo;
        var mapdocname;
        var tozipcode = '';
        var fromzipcode = '';
        var lname = '';
        var fname = '';
        var degree = '';
        var gender = '';
        var agemin = '';
        var agemax = '';
        var lang = '';
        var spec = '';
        var sameday = '';
        var apptavail = '';
        var hospaffil = '';
        var insur = '';
        var zip = '';
        var distancezipcode = '';
        var distance = '';
        var currentlatitude;
        var currentlongitude;
        var checkpage = '1';
        var addressdisp = '';
   

        //        $("#page2").live("pageshow", function (event) {
        //            
        //            $('#specility').selectmenu({ nativeMenu: true });
        //            $.mobile.selectmenu.prototype.options.nativeMenu = true;
        //        });

        if (navigator.geolocation) {
             // This is the location marker that we will be using
            // on the map. Let's store a reference to it here so
            // that it can be updated in several places.
            var locationMarker = null;


            // Get the location of the user's browser using the
            // native geolocation service. When we invoke this method
            // only the first callback is requied. The second
            // callback - the error handler - and the third
            // argument - our configuration options - are optional.

            navigator.geolocation.getCurrentPosition(function (position) {
               
                // Check to see if there is already a location.
                // There is a bug in FireFox where this gets
                // invoked more than once with a cahced result.
                if (locationMarker) {
                    return;
                }
                currentlatitude = position.coords.latitude;
                currentlongitude = position.coords.longitude;
                 var geocoder1;
                geocoder1 = new google.maps.Geocoder();
                var latlng = new google.maps.LatLng(currentlatitude, currentlongitude);
                geocoder1.geocode({ 'latLng': latlng }, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        fromzipcode = results[1].formatted_address;
                       }
                });


            },
				function (error) {
				    console.log("Something went wrong: ", error);
				},
				{
				    timeout: (5 * 1000),
				    maximumAge: (1000 * 60 * 15),
				    enableHighAccuracy: true
				}
			);



            var positionTimer = navigator.geolocation.watchPosition(
				function (position) {
				 
				    // Log that a newer, perhaps more accurate
				    // position has been found.
				    //console.log("Newer Position Found");
				 
				    // Set the new position of the existing marker.
				    currentlatitude = position.coords.latitude;
				    currentlongitude = position.coords.longitude;
				    var geocoder2;
				    geocoder2 = new google.maps.Geocoder();
				    var latlng2 = new google.maps.LatLng(currentlatitude, currentlongitude);
				    geocoder2.geocode({ 'latLng': latlng2 }, function (results, status) {
				        if (status == google.maps.GeocoderStatus.OK) {
				            fromzipcode = results[1].formatted_address;
				        }
				    });
				 

				}
			);


            // If the position hasn't updated within 5 minutes, stop
            // monitoring the position for changes.
            setTimeout(
				function () {
				    
				    // Clear the position watcher.
				    navigator.geolocation.clearWatch(positionTimer);
				},
				(1000 * 60 * 5)
			);

        }





        $("#map").live("pageshow", function (event) {

            //  $("#mapimg").attr("src", "second.jpg");
            MapDisplay(mapdocname);


        });
        $('#AdvanceSearch').live('pageshow', function () {
            $("#norecordfound").html('');

        });
        $('#page2').live('pageshow', function () {
            $("#norecordfoundforadvansearch").html('');

        });
      
        
        $('#Div1').live('pageshow', function () {
            $("#norecordfound").html('');
            $("#norecordfoundforadvansearch").html('');
        });
        $('#directions_map').live('pageshow', function () {
            debugger;
            $('#map_canvas_1').gmap('destroy');
            //  demo.add('directions_map', $('#map_canvas_1').gmap('get', 'getCurrentPosition')).load('directions_map');
            demo.add('map_canvas_1', function () {
                $('#map_canvas_1').gmap({ 'center': mobileDemo.center, 'zoom': mobileDemo.zoom, 'disableDefaultUI': false, 'callback': function () {
                    var self = this;


                    self.displayDirections({ 'origin': fromzipcode, 'destination': addressdisp, 'travelMode': google.maps.DirectionsTravelMode.DRIVING }, { 'panel': document.getElementById('directions') }, function (response, status) {
                        (status === 'OK') ? $('#results').show() : $('#results').hide();
                    });
                    //self.openInfoWindow({ 'content': mapdocname + ' </br>' + mapaddress }, this);
                }
                });
            }).load('map_canvas_1');
        });


        //        $("#map2").live("pageshow", function (event) {
        //            
        //            // $("#imgmap2").html('<img id="mapimg" src="https://maps.googleapis.com/maps/api/staticmap?center=411 North Belknap Stephenville;zoom=14&amp;size=288x200&amp;markers=411,%20North Belknap Stephenville&amp;sensor=false" height="200" width="288" />')
        //            var stradd = document.getElementById("dispaddress").innerHTML;
        //            var bindurl = "https://maps.googleapis.com/maps/api/staticmap?center=" + stradd + ";zoom=14&amp;size=288x200&amp;markers=Suite 616 7557,%20Rambler Road&amp;sensor=false";
        //            $("#imgmap2").html('<img id="mapimg" src='+bindurl+' height="200" width="288" />')

        //        });

        $("#details").live("pageshow", function (event) {



            for (var i = 0; i < jsonObj.length; i++) {

                if (valid == jsonObj[i].docid) {
                    $("#dispname").html(jsonObj[i].fname + ' ' + jsonObj[i].lname + ',&nbsp;' + jsonObj[i].qualification);
                    var detailshtml = " <table border='0' cellpadding='5px' cellspacing='0'>";


                    //detailshtml += "<tr><td >"+jsonObj[i].fname + ' ' + jsonObj[i].lname + ',&nbsp;' + jsonObj[i].qualification+"</td><td></td></tr>";

                    tozipcode=jsonObj[i].zipcode;
                   
                    addressdisp = jsonObj[i].add1 + ' ' + jsonObj[i].add2;
                    if (jsonObj[i].city != "") {
                        addressdisp += ",&nbsp;" + jsonObj[i].city;
                    }
                    if (jsonObj[i].state != "") {
                        addressdisp += ",&nbsp;" + jsonObj[i].state + "&nbsp;,";
                    }

                    if (jsonObj[i].zip != "") {
                        addressdisp += jsonObj[i].zipcode;
                    }
                    var trimaddress = addressdisp.replace(/^\s+|\s+$/g, '');
                    if (trimaddress != "") {
                        detailshtml += "<tr><td class='detailsclass' style='vertical-align: top;'>Address:</td><td>" + addressdisp + "</td></tr>";

                    }

                    detailshtml += "<tr><td class='detailsclass'></td><td><span><a href='#basic_map' data-transition='slide'>Map</a>&nbsp;&nbsp;&nbsp;<a href='#directions_map' data-transition='slide'>Get Directions</a></span></td></tr>";

                    if (jsonObj[i].phoneno != "") {
                        detailshtml += "<tr><td class='detailsclass'>Phone No:</td><td><a class='mapclass' style='text-decoration:none;' href='tel:" + jsonObj[i].phoneno + "'>" + jsonObj[i].phoneno + "</a> </td></tr>";

                    }
                    if (jsonObj[i].fax != "") {
                        detailshtml += "<tr><td class='detailsclass'>Fax:</td><td>" + jsonObj[i].fax + "</td></tr>";

                    }

                    if (jsonObj[i].distance != "") {
                        detailshtml += "<tr><td class='detailsclass'>Distance:</td><td>" + jsonObj[i].distance + "</td></tr>";

                    }

                    if (jsonObj[i].age != "") {
                        detailshtml += "<tr><td class='detailsclass'>Age:</td><td>" + jsonObj[i].age + "</td></tr>";

                    }

                    if (jsonObj[i].gender != "") {
                        detailshtml += "<tr><td class='detailsclass'>Gender:</td><td>" + jsonObj[i].gender + "</td></tr>";

                    }

                    //                    if (jsonObj[i].city != "") {
                    //                        detailshtml += "<tr><td class='detailsclass'>City:</td><td>" + jsonObj[i].city + "</td></tr>";

                    //                    }




                    //                    if (jsonObj[i].zipcode != "") {
                    //                        detailshtml += "<tr><td class='detailsclass'>Zip Code:</td><td>" + jsonObj[i].zipcode + "</td></tr>";

                    //                    }
                    if (jsonObj[i].specility != "") {
                        detailshtml += "<tr><td class='detailsclass'>Specilities:</td><td>" + jsonObj[i].specility + "</td></tr>";

                    }

                    if (jsonObj[i].certification != "") {
                        detailshtml += "<tr><td class='detailsclass'>Board Certification:</td><td>" + jsonObj[i].certification + "</td></tr>";

                    }


                    if (jsonObj[i].sameday != "") {
                        detailshtml += "<tr><td class='detailsclass' style='vertical-align: top;'>Same Day Appointment? </td><td>" + jsonObj[i].sameday + "</td></tr>";

                    }

                    if (jsonObj[i].primaryhospital != "") {
                        detailshtml += "<tr><td class='detailsclass'>Primary Hospital:</td><td>" + jsonObj[i].primaryhospital + "</td></tr>";

                    }

                    if (jsonObj[i].secondaryhospital != "") {
                        detailshtml += "<tr><td class='detailsclass'>Secondary Hospitals:</td><td>" + jsonObj[i].secondaryhospital + "</td></tr>";

                    }
                    if (jsonObj[i].practicetype != "") {
                        detailshtml += "<tr><td class='detailsclass'>Practice Type:</td><td>" + jsonObj[i].practicetype + "</td></tr>";

                    }


                    if (jsonObj[i].medical_school != "") {
                        detailshtml += "<tr><td class='detailsclass'>Medical Education:</td><td>" + jsonObj[i].medical_school + "</td></tr>";

                    }
                    if (jsonObj[i].residency != "") {
                        detailshtml += "<tr><td class='detailsclass'>Residency:</td><td>" + jsonObj[i].residency + "</td></tr>";

                    }
                    if (jsonObj[i].fellowship != "") {
                        detailshtml += "<tr><td class='detailsclass'>Fellowship:</td><td>" + jsonObj[i].fellowship + "</td></tr>";

                    }


                    if (jsonObj[i].email != "") {
                        detailshtml += "<tr><td class='detailsclass'>Website:</td><td>" + jsonObj[i].email + "</td></tr>";

                    }
                    detailshtml += "</table>";
                    $("#dispdetails").html(detailshtml);

                    //                    $("#dispcity").html(jsonObj[i].city);
                    //                    $("#dispphoneno").html('<a class="mapclass" style="text-decoration:none;" href="tel:' + jsonObj[i].phoneno + '">' + jsonObj[i].phoneno + '</a>');
                    //                    $("#dispemail").html('<a href="' + jsonObj[i].email + '">' + jsonObj[i].email + '</a>');
                    //                    $("#dispzipcode").html(jsonObj[i].zipcode);
                    //                    //$("#dispQualif").html(jsonObj[i].qualification);
                    //                    $("#dispcertify").html(jsonObj[i].city);
                    //                    $("#dispsameday").html(jsonObj[i].sameday);
                    //                    $("#dispage").html(jsonObj[i].age);
                    //                    $("#disphospital1").html(jsonObj[i].primaryhospital);
                    //                    $("#disphospital2").html(jsonObj[i].secondaryhospital);
                    //                    $("#disppracticetype").html(jsonObj[i].practicetype);
                    //                    $("#dispfax").html(jsonObj[i].fax);
                    //                    $("#dispgender").html(jsonObj[i].gender);
                    //                    if (jsonObj[i].distance == '') {
                    //                        $("#trdistance").hide();
                    //                    }
                    //                    else {
                    //                        $("#trdistance").show();
                    //                        $("#dispdistance").html(jsonObj[i].distance);
                    //                    }
                    mapdocname = document.getElementById("dispname").innerHTML;
                    var geocoder = new google.maps.Geocoder();
                    mapaddress = jsonObj[i].add1 + ' ' + jsonObj[i].add2 + ', ' + jsonObj[i].city + ' ' + jsonObj[i].zipcode;

                    geocoder.geocode({ 'address': mapaddress }, function (results, status) {

                        if (status == google.maps.GeocoderStatus.OK) {
                            latitude = results[0].geometry.location.lat();
                            longitude = results[0].geometry.location.lng();

                        }
                    });

                }
            }
            mobileDemo = { 'center': '' + latitude + ',' + longitude + '', 'zoom': 14 };

        });


        $('#basic_map').live('init', function () {


        });

        $('#basic_map').live('pageshow', function () {
            //

            MapDisplay(mapdocname);
            // $('#map_canvas').gmap('clear', 'markers');
            //$('#map_canvas').gmap('addMarker', { 'position': new google.maps.LatLng(latitude, longitude), 'bounds': true, 'zoom': 10 });
            //            
        });
        function MapDisplay(mapdocname) {
            
            mobileDemo = { 'center': '' + latitude + ',' + longitude + '', 'zoom': 14 };
            $('#map_canvas').gmap('destroy');

            $('#map_canvas').gmap({ 'center': new google.maps.LatLng(latitude, longitude), 'zoom': mobileDemo.zoom, 'disableDefaultUI': false, 'callback': function () {
                var self = this;
                self.addMarker({ 'position': this.get('map').getCenter() }).click(function () {
                    self.openInfoWindow({ 'content': mapdocname + ' </br>' + mapaddress }, this);
                });
            }
            });
        }

        $(document).ready(
    function () {
        $("#btnSearch").click(function () {
            // Build OData query
            checkpage = '1';
            lname = '';
            fname = '';
            degree = '';
            gender = '';
            agemin = '';
            agemax = '';
            lang = '';
            spec = '';
            sameday = '';
            apptavail = '';
            hospaffil = '';
            insur = '';
            zip = '';
            distancezipcode = '';
            distance = '';
            fname = $("#firstname").val();
            lname = $("#lastname").val();
            spec = $("#specility").val();
            distancezipcode = $("#zipcode").val();

            distance = $("#distance").val();
            agemin = '1';
            agemax = '100';
            insur = '0';
            apptavail = '-1';
            StartFrom = 1;
            //            if (distancezipcode != "") {

            //                if (distance == "") {
            //                    $("#errormsg").html('* Distance Required');
            //                    return false;
            //                }
            //            }

            //            if (distance != "") {

            //                if (distancezipcode == "") {
            //                    $("#errormsg").html('* Zip code Required');
            //                    return false;
            //                }
            //            }

            if ($("#zipcode").val() != "") {
                fromzipcode = $("#zipcode").val();
            }

            if (spec == "") {
                spec = '';
            }

            if (distance == "") {
                distance = '0';
            }
            // http: //115.119.102.250:8010/findadocwebservice/FindADoc_ODataService.svc
            //            var query = "http://localhost:55363/FindADoc_ODataService.svc" // netflix base url
            //            + "/searchDoctorForMobileAppPaging?fname='" + escape(firstname) + "'&lname='" + escape(lastname) + "'&specialization='" + escape(specility) + "'&zipcode='" + zipcode + "'&distance='" + distance + "'&StartFrom='" + escape(StartFrom) + "'&NumberOfRecords='" + escape(NumberOfRecords) + "'" // top-level resource

            //            + "&$callback=callback" // jsonp request
            //            + "&$format=json"; // json request

            //            // Make JSONP call to Netflix
            //            $.ajax({
            //                dataType: "jsonp",
            //                url: query,

            //                jsonpCallback: "callback",
            //                success: callback
            //            });

            FetchData(1);
          

        });

        jQuery.ajaxSetup({
            beforeSend: function () {
                $("#pager").html('');
                $('#doctordetails').html('<img src="images/mainl.gif" style="padding-left:140px; padding-top:180px;" height="50px" width="50px" />');
            }
        });
        $("#zipcode").keydown(function (event) {
            // Allow: backspace, delete, tab, escape, and enter
            if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
            // Allow: Ctrl+A
            (event.keyCode == 65 && event.ctrlKey === true) ||
            // Allow: home, end, left, right
            (event.keyCode >= 35 && event.keyCode <= 39)) {
                // let it happen, don't do anything
                return;
            }
            else {
                // Ensure that it is a number and stop the keypress
                if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                    event.preventDefault();
                }
            }
        });




        //////////////////////////////////////////////////////
        ////////////Advance Search//////////////////////////

        $("#btnAdvanceSearch").click(function () {
            // Build OData query
            checkpage = '2';
            lname = '';
            fname = '';
            degree = '';
            gender = '';
            agemin = '';
            agemax = '';
            lang = '';
            spec = '';
            sameday = '';
            apptavail = '';
            hospaffil = '';
            insur = '';
            zip = '';

            fname = $("#firstname").val();
            lname = $("#lastname").val();
            spec = $("#specility").val();
            distancezipcode = $("#zipcode").val();
            distance = $("#distance").val();
            degree = $("#degree").val();
            gender = $('input:radio[name=gender]:checked').val();
            agemin = $("#agemin").val();
            agemax = $("#agemax").val();
            lang = $("#lang").val();
            hospaffil = $("#hospaffil").val();
            sameday = $('input:radio[name=sameday]:checked').val();
            insur = $("#insurance").val();
            apptavail = $("#apptavail").val();
            if (apptavail == "") {
                apptavail = '-1';
            }
            if (sameday === undefined) {
                sameday = '';
            }
            if (gender === undefined) {
                gender = '';
            }


            //            if (distancezipcode != "") {

            //                if (distance == "") {
            //                    distancezipcode = '';
            //                }
            //            }

            //            if (distance != "") {

            //                if (distancezipcode == "") {
            //                    distance = '0';
            //                }
            //            }

            if (agemin == '') {
                agemin = '1';

            }
            if (agemax == '') {
                agemax = '100';
            }
            if (distance == "") {
                distance = '0';
            }
            FetchData(1);
        });

        jQuery.ajaxSetup({
            beforeSend: function () {
                $("#pager").html('');
                $('#doctordetails').html('<img src="images/mainl.gif" style="padding-left:100px; padding-top:150px;" height="40px" width="40px" />');
            }
        });

        //numric validation for zipcode, agemin and agemax
        $("#zipcode").keydown(function (event) {
            // Allow: backspace, delete, tab, escape, and enter
            if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
            // Allow: Ctrl+A
            (event.keyCode == 65 && event.ctrlKey === true) ||
            // Allow: home, end, left, right
            (event.keyCode >= 35 && event.keyCode <= 39)) {
                // let it happen, don't do anything
                return;
            }
            else {
                // Ensure that it is a number and stop the keypress
                if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                    event.preventDefault();
                }
            }
        });
        $("#zipcode").blur(function (event) {
            if ($("#zipcode").val() != "") {
                if ($("#zipcode").val().length != '5') {
                    $("#errormsg").html('Enter Wrong zipcode');


                }
                else {

                    $('#btnSearch .ui-btn-text').text("Search Near Zipcode");

                }
            }
            else {
                $('#btnSearch .ui-btn-text').text("Search Near Me");
            }
        });

        // --------------------------------------------------------------------------------------------------------------
        $("#agemin").keydown(function (event) {
            // Allow: backspace, delete, tab, escape, and enter
            if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
            // Allow: Ctrl+A
            (event.keyCode == 65 && event.ctrlKey === true) ||
            // Allow: home, end, left, right
            (event.keyCode >= 35 && event.keyCode <= 39)) {
                // let it happen, don't do anything
                return;
            }
            else {
                // Ensure that it is a number and stop the keypress
                if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                    event.preventDefault();
                }
            }
        });

        //---------------------------------------------------------------------------------------------------------------------
        $("#agemax").keydown(function (event) {
            // Allow: backspace, delete, tab, escape, and enter
            if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
            // Allow: Ctrl+A
            (event.keyCode == 65 && event.ctrlKey === true) ||
            // Allow: home, end, left, right
            (event.keyCode >= 35 && event.keyCode <= 39)) {
                // let it happen, don't do anything
                return;
            }
            else {
                // Ensure that it is a number and stop the keypress
                if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                    event.preventDefault();
                }
            }
        });

        $('#agemax').blur(function () {
            if ($('#agemin').val() != "" && $('#agemax').val() != "") {
                if ($('#agemax').val() <= $('#agemin').val()) {
                    //$("#errormsgforage").html('Max Age should be Greater than Min Age');
                    document.getElementById('errormsgforage').innerHTML = 'Max Age should be Greater than Min Age';


                }

            }

        });




        $('#agemax').focus(function () {
            document.getElementById('errormsgforage').innerHTML = '';
        });
        //------------------------------------------------------------------------------------


        ///////////////////////////////////////////////////END VALIDATION////////////////////////////////////
        var querylang = serviceurl // netflix base url
            + "/med_physdirectory_languages?" // top-level resource

            + "$callback=callbacklanguage" // jsonp request
            + "&$format=json"; // json request

        // Make JSONP call to Netflix
        $.ajax({
            dataType: "jsonp",
            url: querylang,

            jsonpCallback: "callbacklanguage",
            success: callbacklanguage
        });

        var queryinsurance = serviceurl// netflix base url
            + "/getinsuranceList?" // top-level resource

            + "$callback=callbackInsurance" // jsonp request
            + "&$format=json"; // json request

        // Make JSONP call to Netflix
        $.ajax({
            dataType: "jsonp",
            url: queryinsurance,

            jsonpCallback: "callbackInsurance",
            success: callbackInsurance
        });





        var queryspec = serviceurl // netflix base url
            + "/med_physdirectory_Specialty?" // top-level resource

            + "$callback=callbackspec" // jsonp request
            + "&$format=json"; // json request
        $.ajax({
            dataType: "jsonp",
            url: queryspec,

            jsonpCallback: "callbackspec",
            success: callbackspec
        });


        var queryhospitalaff = serviceurl // netflix base url
            + "/getSearchListHospitalAffiliations?" // top-level resource

            + "$callback=callbackhospitals" // jsonp request
            + "&$format=json"; // json request
        $.ajax({
            dataType: "jsonp",
            url: queryhospitalaff,

            jsonpCallback: "callbackhospitals",
            success: callbackhospitals
        });


    });


   
         function callbackhospitals(result) {

            var $e = $("#hospaffil");
            $('#hospaffil').empty()
            $e.append("<option value=''>-select-</option>");
            if (result.d.length > 0) {
                for (var i = 0; i < result.d.length; i++) {
                    if (result.d[i].description != "") {
                        var tmp = "<option value='" + result.d[i].description + "'>" + result.d[i].description + "</option>";
                        $e.append(tmp);
                    }
                }
               
            }

        }
 
        function callbackInsurance(result) {

            var $e = $("#insurance");
            $('#insurance').empty()
            $e.append("<option value='0'>-select-</option>");
            if (result.d.length > 0) {
                for (var i = 0; i < result.d.length; i++) {
                    var tmp = "<option value='" + result.d[i].id + "'>" + result.d[i].description + "</option>";
                    $e.append(tmp);
                }
              
            }

        }

        function callbacklanguage(result) {

            var $e = $("#lang");
            $('#lang').empty()
            $e.append("<option value=''>-select-</option>");
            if (result.d.length > 0) {
                result.d.sort(SortByName);
                for (var i = 0; i < result.d.length; i++) {
                    var tmp = "<option value='" + result.d[i].keyvalue + "'>" + result.d[i].keyvalue + "</option>";
                    $e.append(tmp);
                }
               
            }


        }

        function SortByName(x, y) {
            return ((x.keyvalue == y.keyvalue) ? 0 : ((x.keyvalue > y.keyvalue) ? 1 : -1));
        }

        // Call Sort By Name
        

        function callbackspec(result) {
            var $e = $("#specility");
            $('#specility').empty()
            $e.append("<option value=''>-select-</option>");
            if (result.d.length > 0) {
                result.d.sort(SortByName);
                for (var i = 0; i < result.d.length; i++) {
                    var tmp = "<option value='" + result.d[i].keyvalue + "'>" + result.d[i].keyvalue + "</option>";
                    $e.append(tmp);
                }
            
            }


        }
        function callback(result) {

            if (result.d.length == 0) {
                if (checkpage == '1') {
                    $("#norecordfound").html('<div style=" color:red;">No records found</div>');
                }
                else {
                    $("#norecordfoundforadvansearch").html('<div style=" color:red;">No records found</div>');
                }
               
                window.history.back();       
        
             }
           
            
            var html = "";
            var sindex = StartFrom + NumberOfRecords;
            var endindex = StartFrom - NumberOfRecords;
            var docids = ''; 

            if (result.d.length > 0) {
                $("#norecordfound").html('');
                $("#norecordfoundforadvansearch").html('');
                if (result.d.length < 9) {
                    if (StartFrom != '1') {
                        var pagernext = '<a href="#"  onclick="FetchData(' + endindex + '); " ><img src="../images/backbutton.jpg" /></a> <a href="#"><img class="disble" src="../images/nextbutton.jpg" /></a>';
                        $("#pager").html(pagernext);
                        document.getElementById("pager").innerHTML = pagernext;
                    }
                    else {

                        var pagernext = '<a href="#" class="disble"   ><img src="../images/backbutton.jpg" /></a> <a href="#"><img class="disble" src="../images/nextbutton.jpg" /></a>';
                        $("#pager").html(pagernext);
                        document.getElementById("pager").innerHTML = pagernext;
                    }
                }
                else if (StartFrom == 1) {
                    var pagernext = '<a href="#"  ><img class="disble" src="../images/backbutton.jpg" /></a> <a href="#" onclick="FetchData(' + sindex + ');"><img src="../images/nextbutton.jpg" /></a>';
                    $("#pager").html(pagernext);
                    document.getElementById("pager").innerHTML = pagernext;
                }
                else {
                    var pagernext = '<a href="#" onclick="FetchData(' + endindex + ');">  <img src="../images/backbutton.jpg" /> </a> <a  onclick="FetchData(' + sindex + ');" href="#"><img src="../images/nextbutton.jpg" /></a>';
                    $("#pager").html(pagernext);
                    document.getElementById("pager").innerHTML = pagernext;
                }
                for (var i = 0; i < result.d.length; i++) {

                  
                    var phoneno;
                    var tempphone = result.d[i].Phone.replace(/[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi, '');
                    if (tempphone.length == "10") {
                        phoneno = '(' + tempphone.substring(0, 3) + ')&nbsp;' + tempphone.substring(3, 6) + '-' + tempphone.substring(6, 10);
                    }
                    else {
                        phoneno = '';
                    }

                    var midistance = '';
                    
                        midistance = Math.round(result.d[i].miles_from_here) + '&nbsp;mi&nbsp;&nbsp;';
                   
                    
                    var samedayappt;
                    if (result.d[i].samedayappt == "F") {
                        samedayappt = "No";
                    }
                    else {
                        samedayappt = "Yes";
                    }
                  
                    docids+="#"+result.d[i].id;

                    jsonObj.push({ docid: result.d[i].id, fname: result.d[i].FirstName, lname: result.d[i].LastName, specility: result.d[i].specialty1, add1: result.d[i].Street, add2: result.d[i].street2, phoneno: result.d[i].Phone, city: result.d[i].City, zipcode: result.d[i].Zip, email: result.d[i].websiteurl, gender: result.d[i].gender, qualification: result.d[i].Degree, distance: midistance, fax: result.d[i].fax, sameday: samedayappt, certification: result.d[i].certification, primaryhospital: result.d[i].primaryhospital, secondaryhospital: result.d[i].secondaryhospital, practicetype: result.d[i].practicetype, age: result.d[i].age, medical_school: result.d[i].medical_school, residency: result.d[i].residency, fellowship: result.d[i].fellowship, state: result.d[i].State });


                    var showaddress = result.d[i].Street + '&nbsp;'

                    if (result.d[i].street2 != "") {
                        showaddress += result.d[i].street2;
                    }
                    if (result.d[i].City != "") {
                        showaddress += ',&nbsp;' + result.d[i].City;
                    }
                    if (result.d[i].Zip != "") {
                        showaddress += ',&nbsp;' + result.d[i].State;
                    }
                    if (result.d[i].Zip != "") {
                        showaddress += ',&nbsp;' + result.d[i].Zip;
                    }
                   


                    if (i % 2 == 0) {

                        //            html += '<div class="even">';

                        //            html += '<div style="padding:10px;  border-bottom:1px solid gray;"><a href="#Map" data-icon="arrow-r" data-iconpos="right">' + result.d[i].ZFIRSTNAME + '  ' + result.d[i].ZLASTNAME + '</a> </div>';
                        //            html += '<div>' + result.d[i].ZADDRESS1 + '&nbsp;' + result.d[i].ZADDRESS2 + '</div>';
                        //         html += '<div>khsgfjdhf</div>';
                        //         html += '</div>';


                        html += '<div class="even" data-theme="a"> <table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td width="15%"> <span class="headerCss">Name:</span></td><td class="Detailsclass" width="65%"><span><a onclick="SetValue(' + result.d[i].id + ')" href="#details" data-transition="slide">' + result.d[i].FirstName + '  ' + result.d[i].LastName + '</a></span></td><td align="right" width="20%" style="font-size:12px;">' + midistance + '</td></tr><tr><td style="vertical-align:top;"> <span class="headerCss"  >Address:</span></td><td class="Detailsclass">' + showaddress + '</td></tr><tr><td><span class="headerCss">Phone: </span> </td><td class="Detailsclass"><a class="mapclass" style="text-decoration:none;" href="tel:' + result.d[i].Phone + '">' + result.d[i].Phone + '</a></td></tr></table></div><div style="height:5px; width:20px;"></div>';
                    }

                    else {
                        //                        html += '<div class="odd">';

                        //                        html += '<div style="padding:10px;  border-bottom:1px solid gray;"><a href="#Map" data-icon="arrow-r" data-iconpos="right">' + result.d[i].ZFIRSTNAME + '  ' + result.d[i].ZLASTNAME + '</a> </div>';
                        //                        html += '<div>' + result.d[i].ZADDRESS1 + '&nbsp;' + result.d[i].ZADDRESS2 + '</div>';
                        //                        html += '<div>khsgfjdhf</div>';
                        //                        html += '</div>';
                        //   html += '<div class="odd" data-theme="a"><div> <span class="headerCss">Name:&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;</span>' + result.d[i].ZFIRSTNAME + '  ' + result.d[i].ZLASTNAME + '</div> <div><span class="headerCss">Address:&nbsp;&nbsp; &nbsp;</span>' + result.d[i].ZADDRESS1 + '&nbsp;' + result.d[i].ZADDRESS2 + '</div><div><span class="headerCss">Phone:&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</span> ' + result.d[i].ZPHONE + '</div><div><span class="headerCss">Email:&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><a href=mailto:' + result.d[i].ZEMAIL + '>' + result.d[i].ZEMAIL + '</a></div></div><div style="height:5px;"></div>';
                        // html += '<div class="odd" data-theme="a"> <table cellpadding="0" cellspacing="0" border="0"><tr><td> <span class="headerCss">Name:</span></td><td class="Detailsclass"><span>' + result.d[i].ZFIRSTNAME + '  ' + result.d[i].ZLASTNAME + '</span></td></tr><tr><td> <span class="headerCss">Address:</span></td><td class="Detailsclass">' + result.d[i].ZADDRESS1 + '&nbsp;' + result.d[i].ZADDRESS2 + '</td></tr><tr><td><span class="headerCss">Phone: </span> </td><td class="Detailsclass">' + result.d[i].ZPHONE + '</td></tr><tr><td><span class="headerCss">Email:</span></td><td class="Detailsclass"><a href=mailto:' + result.d[i].ZEMAIL + '>' + result.d[i].ZEMAIL + '</a></td></tr></table></div><div style="height:5px;"></div>';
                        // html += '<div class="odd" data-theme="a"> <table cellpadding="0" cellspacing="0" border="0"><tr><td> <span class="headerCss">Name:</span></td><td class="Detailsclass"><span><a onclick="SetValue(' + result.d[i].ZDOC_ID + ')" href="#details">' + result.d[i].ZFIRSTNAME + '  ' + result.d[i].ZLASTNAME + '</a></span></td></tr><tr><td style="vertical-align:top;"> <span class="headerCss">Address:</span></td><td class="Detailsclass">' + showaddress + '</td></tr><tr><td><span class="headerCss">Phone: </span> </td><td class="Detailsclass">' + phoneno + '</td></tr><tr><td><span class="headerCss">Email:</span></td><td class="Detailsclass"><a href=mailto:' + result.d[i].ZEMAIL + '>' + result.d[i].ZEMAIL + '</a></td></tr></table></div><div style="height:5px; width:20px;"></div>';
                       // html += '<div class="odd" data-theme="a"> <table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td width="15%"> <span class="headerCss">Name:</span></td><td class="Detailsclass" width="65%"><span><a onclick="SetValue(' + result.d[i].id + ')" href="#details">' + result.d[i].FirstName + '  ' + result.d[i].LastName + '</a></span></td><td align="right" width="20%" style="font-size:12px;">' + midistance + '</td></tr><tr><td style="vertical-align:top;"> <span class="headerCss"  >Address:</span></td><td class="Detailsclass">' + showaddress + '</td></tr><tr><td><span class="headerCss">Phone: </span> </td><td class="Detailsclass"><a class="mapclass" style="text-decoration:none;" href="tel:' + result.d[i].Phone + '">' + result.d[i].Phone + '</a></td></tr><tr><td><span class="headerCss">Website:</span></td><td class="Detailsclass"><a href=' + result.d[i].websiteurl + '>' + result.d[i].websiteurl + '</a></td></tr></table></div><div style="height:5px; width:20px;"></div>';
                        html += '<div class="odd" data-theme="a"> <table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td width="15%"> <span class="headerCss">Name:</span></td><td class="Detailsclass" width="65%"><span><a onclick="SetValue(' + result.d[i].id + ')" href="#details" data-transition="slide">' + result.d[i].FirstName + '  ' + result.d[i].LastName + '</a></span></td><td align="right" width="20%" style="font-size:12px;">' + midistance + '</td></tr><tr><td style="vertical-align:top;"> <span class="headerCss"  >Address:</span></td><td class="Detailsclass">' + showaddress + '</td></tr><tr><td><span class="headerCss">Phone: </span> </td><td class="Detailsclass"><a class="mapclass" style="text-decoration:none;" href="tel:' + result.d[i].Phone + '">' + result.d[i].Phone + '</a></td></tr></table></div><div style="height:5px; width:20px;"></div>';
                   
                    }
                }
            }
            else {
                if (endindex >= 1) {
                    var pagernext1 = '<a onclick="FetchData(' + endindex + ');" href="#"><img src="../images/backbutton.jpg" /></a> <a href="#" ><img class="disble" src="../images/nextbutton.jpg" /></a>';
                    $("#pager").html(pagernext1);
                }
              
               // html += '<div style=" color:red;">No records found</div>';
            }
       
            
                //calloffice(docids);
           

            $("#doctordetails").html(html);
            document.getElementById("doctordetails").innerHTML = html;

        }


        function RemoveErrorMsg() {
            $("#errormsg").html('');
        }
        function RemoveErrorMsg2() {
            $("#errormsg2").html('');
        }

        function backfunction() {

            window.history.back();

        }

        function mapdisplay1(oblat, objlog, objname, objaddress) {
           
            // var geocoder = new google.maps.Geocoder();
            mapaddress = objaddress;
            //            
            //          geocoder.geocode({ 'address': objaddress }, function (results, status) {
            //               if (status == google.maps.GeocoderStatus.OK) {
            //                    latitude = results[0].geometry.location.lat();
            //                    longitude = results[0].geometry.location.lng();
            //              }
            //                   });
            latitude = oblat;
            longitude = objlog;
            mapdocname = objname;


        }
        function SetValue(id) {
            valid = id;

        }
        function calloffice(id) {
            var temp = 1;
            var queryoffice = serviceurl// netflix base url
            + "/getPhysicianOffices?ids='" + temp + "'" // top-level resource

            + "&$callback=callbackoffice" // jsonp request
            + "&$format=json"; // json request

            // Make JSONP call to Netflix
            $.ajax({
                dataType: "jsonp",
                url: queryoffice,

                jsonpCallback: "callbackoffice",
                success: callbackoffice
            });
        }

        function callbackoffice(result) {
            debugger;
            //addressjsonObj.push({ ref: result.d[i].ref, primaryoffice: result.d[i].primaryoffice, locationname: result.d[i].locationname, address1: result.d[i].address1, address2: result.d[i].address2, phoneno: result.d[i].phone, city: result.d[i].City, zipcode: result.d[i].zip, fax: result.d[i].fax, state: result.d[i].State, hours: result.d[i].hours });

        }
        function FetchData(startindex) {
           
            if (startindex < 1) {
                var sindex = StartFrom + NumberOfRecords;
                var pagernext = '<a href="#">  <img src="../images/backbutton.jpg" class="disble" /> </a> <a  onclick="FetchData(' + sindex + ');" href="#"><img src="../images/nextbutton.jpg" /></a>';
                $("#pager").html(pagernext);
                return false;
            }

            StartFrom = startindex;
            NumberOfRecords = 10;


            var query = serviceurl // netflix base url
            + "/searchDoctorForMobileAppPaging?lname='" + escape(lname) + "'&fname='" + escape(fname) + "'&degree='" + escape(degree) + "'&gender='" + escape(gender) + "'&agemin='" + escape(agemin) + "'&agemax='" + escape(agemax) + "'&lang='" + escape(lang) + "'&spec='" + escape(spec) + "'&sameday='" + escape(sameday) + "'&apptavail='" + escape(apptavail) + "'&hospaffil='" + escape(hospaffil) + "'&insur='" + escape(insur) + "'&zip='" + zip + "'&distancezipcode='" + distancezipcode + "'&distance='" + distance + "'&StartFrom='" + escape(StartFrom) + "'&NumberOfRecords='" + escape(NumberOfRecords) + "'&currentlatitude='" + currentlatitude + "'&currentlongitude='" + currentlongitude + "'" // top-level resource

            + "&$callback=callback" // jsonp request
            + "&$format=json"; // json request


            // Make JSONP call to Netflix
            $.ajax({
                dataType: "jsonp",
                url: query,

                jsonpCallback: "callback",
                success: callback
            });
        } 

      