<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index2.aspx.cs" Inherits="FindADocMobileApp.index2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <title> </title>
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.1.1/jquery.mobile-1.1.1.min.css" />
    <link rel="stylesheet" type="text/css" href="includes/stylesheet.css" />
    <script src="http://code.jquery.com/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="http://code.jquery.com/mobile/1.1.1/jquery.mobile-1.1.1.min.js" type="text/javascript"></script>
    <script type='text/javascript' src="http://imakewebthings.github.com/jquery-waypoints/waypoints.min.js"></script>
    <script type="text/javascript" src="http://jquery-ui-map.googlecode.com/svn/trunk/demos/js/modernizr-2.0.6/modernizr.min.js"></script>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/geocode/output?parameters"></script>
    <script type="text/javascript" src="http://jquery-ui-map.googlecode.com/svn/trunk/demos/js/demo.js"></script>
    <script src="mapscripts/jquery.ui.map.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://jquery-ui-map.googlecode.com/svn/trunk/ui/jquery.ui.map.services.js"></script>
    <script type="text/javascript" src="http://jquery-ui-map.googlecode.com/svn/trunk/ui/jquery.ui.map.extensions.js"></script>
    <script type="text/javascript" src="gmap3.min.js"></script>
    <style type="text/css">
        .mainmenu
        {
            margin: 0px 10px 0px 10px;
            padding: 15px 15px 0px 15px;
            border: none;
        }
        .mainmenu li
        {
            background: none;
            border: none;
        }
        .mainmenu li .ui-btn-inner
        {
            background: none;
            border: none;
            margin: 0px;
            padding: 0px 0px 15px 0px;
        }
        .mainmenu li a
        {
            border: 1px solid #fff;
            border-radius: 16px;
            color: #ffffff;
            -moz-border-radius: 10px;
            -webkit-border-radius: 10px;
            text-decoration: none;
            font-weight: bold;
            display: block;
            background: #00539B url(images/mobile_link_arrow.png) no-repeat right 50%;
            font-size: 1.15em;
            margin-top: 0px;
            margin-right: 2px;
            margin-bottom: 4px;
            margin-left: 2px;
            padding-top: 5px;
            padding-right: 15px;
            padding-bottom: 7px;
            padding-left: 40px;
            height: 20px;
        }
        body
        {
            height: 100%;
        }
        
        /*this is what we want the div to look like*/
        div.fullscreen
        {
            display: block; /*set the div in the top-left corner of the screen*/
            position: absolute;
            top: 0;
            left: 0; /*set the width and height to 100% of the screen*/
            width: 100%;
            height: 100%;
        }
    </style>
    <script type="text/javascript">
//declare global variables
        var serviceurl = "https://mhealth.texashealth.org/findadocsvc/FindADoc.svc";   //wcf service url
        var defaultloc = '';
        var defaultboolloc = 0;
        var boolback = 0;
        var address;
        var mapaddress;
        var addtionalmapaddress = '';
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
        var count = 0;
        var clinicaddress = '';
        var additionaladdress = '';
        var locnotfound = "true";
        var addlogitude = '';
        var addlatitude = '';
//end of globle variables declaration

//pageshow function for Direction Map
        $('#directions_map').live('pageshow', function () {
            var fromadressdirection;

            if ($('#zipcode').val() == "") {
                fromadressdirection = defaultloc;

            }
            else {
                fromadressdirection = fromzipcode;
            }

            $('#map_canvas_1').gmap('destroy');
            if ($('#zipcode').val() == "") {
                $('#map_canvas_1').gmap3({ 
                action: 'getRoute',
                options: {
                            origin: new google.maps.LatLng(currentlatitude, currentlongitude),
                            destination: addressdisp,
                            travelMode: google.maps.DirectionsTravelMode.DRIVING

                         },

               callback: function (results){
                                        if (!results) return;
                                        $(this).gmap3({ 
                                             action: 'init',
                                             zoom: 13,
                                             mapTypeId: google.maps.MapTypeId.ROADMAP,
                                             streetViewControl: true,
                                             center: [currentlatitude, currentlongitude]

                                           },

                                    { action: 'addDirectionsRenderer',
                                      options: {
                                                  preserveViewport: true,
                                                  draggable: false,
                                                  directions: results
                                                }
                                    });

                                      }
                                     });
                      }
                      else 
                      {

                $('#map_canvas_1').gmap3(

{ action: 'getRoute',

    options: {

        origin: fromadressdirection,

        destination: addressdisp,

        travelMode: google.maps.DirectionsTravelMode.DRIVING

    },

    callback: function (results) {

        if (!results) return;

        $(this).gmap3(

{ action: 'init',

    zoom: 13,

    mapTypeId: google.maps.MapTypeId.ROADMAP,

    streetViewControl: true,

    center: [addlatitude, addlogitude]

},

{ action: 'addDirectionsRenderer',

    options: {

        preserveViewport: true,

        draggable: false,

        directions: results

    }

}

);

    }

}

);

            }
            //  demo.add('directions_map', $('#map_canvas_1').gmap('get', 'getCurrentPosition')).load('directions_map');

            //            demo.add('map_canvas_1', function () {
            //                $('#map_canvas_1').gmap({ 'center': mobileDemo.center, 'zoom': mobileDemo.zoom, 'disableDefaultUI': false, 'callback': function () {
            //                    var self = this;


            //                    self.displayDirections({ 'origin': fromadressdirection, 'destination': addressdisp, 'travelMode': google.maps.DirectionsTravelMode.DRIVING }, { 'panel': document.getElementById('directions') }, function (response, status) {
            //                        (status === 'OK') ? $('#results').show() : $('#results').hide();
            //                    });
            //                    //self.openInfoWindow({ 'content': mapdocname + ' </br>' + mapaddress }, this);
            //                }
            //                });
            //            }).load('map_canvas_1');
        });


        //        $("#map2").live("pageshow", function (event) {
        //            
        //            // $("#imgmap2").html('<img id="mapimg" src="https://maps.googleapis.com/maps/api/staticmap?center=411 North Belknap Stephenville;zoom=14&amp;size=288x200&amp;markers=411,%20North Belknap Stephenville&amp;sensor=false" height="200" width="288" />')
        //            var stradd = document.getElementById("dispaddress").innerHTML;
        //            var bindurl = "https://maps.googleapis.com/maps/api/staticmap?center=" + stradd + ";zoom=14&amp;size=288x200&amp;markers=Suite 616 7557,%20Rambler Road&amp;sensor=false";
        //            $("#imgmap2").html('<img id="mapimg" src='+bindurl+' height="200" width="288" />')

        //        });


$("#page3").live("pageshow", function (event) {
   
            if (locnotfound == "false") {

                $("#Span1").hide();
                $("#Span2").hide();
                $("#Span3").hide();
                $("#Span4").hide();
                $("#Span5").hide();
                $("#Span6").hide();
                $("#Span7").hide();
                $("#Span8").hide();
                $("#Span9").hide();
                $("#Span10").hide();
                $("#Span11").hide();
                $("#Span12").hide();
                $("#Span13").hide();
                $("#Span14").hide();
                $("#Span15").hide();
            }


        });
        $("#map").live("pageshow", function (event) {

            //  $("#mapimg").attr("src", "second.jpg");
            MapDisplay(mapdocname);


        });
        $('#AdvanceSearch').live('pageshow', function () {
            $("#norecordfound").html('');
            $("#refind").hide();
            $("#refind1").hide();
        });
        $('#page2').live('pageshow', function () {
            //-------------------------------------------------------------------------------------------------------------------------
            // Get the location of the user's browser using the
            // native geolocation service. When we invoke this method
            // only the first callback is requied. The second
            // callback - the error handler - and the third
            // argument - our configuration options - are optional.
            if (navigator.geolocation) {
                var locationMarker = null;
                navigator.geolocation.getCurrentPosition(function (position) {

                    // Check to see if there is already a location.
                    // There is a bug in FireFox where this gets
                    // invoked more than once with a cahced result.
                    if (locationMarker) {
                        return;
                    }

                    //GPS Search geolocation
                    currentlatitude = position.coords.latitude;
                    currentlongitude = position.coords.longitude;
                    var geocoder1;
                    geocoder1 = new google.maps.Geocoder();
                    var latlng = new google.maps.LatLng(currentlatitude, currentlongitude);
                    geocoder1.geocode({ 'latLng': latlng }, function (results, status) {
                        if (status == google.maps.GeocoderStatus.OK) {
                            defaultloc = results[1].formatted_address;
                           

                            $("#errorMsgForWifi").html('<span style="color:green">Current location: ' + results[1].formatted_address + '</span>');
                            defaultboolloc = '1';
                            //  $("#errormsg").html("Current location from navigator: " + defaultloc);
                        }
                    }); //end geocode function
                },
			   function (error) {
			       locnotfound = "false";
			       $("#errorMsgForWifi").html('<span style="color:#0000FF">Enable location services to get direction and distance information.</span>');
			   },
			   {
			       timeout: (5 * 1000),
			       maximumAge: (1000 * 60 * 15),
			       enableHighAccuracy: true
			   }); //end of getCurrentPosition function 


                //ISP geolocation search 
                if (locnotfound == "false") {
                    locnotfound = "true";
                    var positionTimer = navigator.geolocation.watchPosition(
			        function (position) {
			            currentlatitude = position.coords.latitude;
			            currentlongitude = position.coords.longitude;
			            var geocoder2;
			            geocoder2 = new google.maps.Geocoder();
			            var latlng2 = new google.maps.LatLng(currentlatitude, currentlongitude);
			            geocoder2.geocode({ 'latLng': latlng2 }, function (results, status) {
			                if (status == google.maps.GeocoderStatus.OK) {
			                    defaultloc = results[1].formatted_address;
			                    defaultboolloc = '1';
			                    $("#errorMsgForWifi").html('<span style="color:green">Current location: ' + results[1].formatted_address + '</span>');
			                }
			            },

				function (error) {
				    locnotfound = "false";
				    $("#errorMsgForWifi").html('<span style="color:#0000FF">Enable location services to get direction and distance information.</span>');
				});
			        });

                    // If the position hasn't updated within 5 minutes, stop
                    // monitoring the position for changes.
                    setTimeout(function () {
                        navigator.geolocation.clearWatch(positionTimer); // Clear the position watcher.
                    }, (1000 * 60 * 5));
                }
            }
            //end  get current location code
            //------------------------------------------------------------------------------------------
            // alert(defaultloc);
            $("#norecordfoundforadvansearch").html('');
            $("#refind").hide();
            $("#refind1").hide();

            if (defaultloc != "") {

                //$("#errorMsgForWifi").html('<span style="color:green">Current location: ' + defaultloc + '</span>');
            }
            else if (locnotfound == "false") {
                $("#errorMsgForWifi").html('<span style="color:#0000FF">Enable location services to get direction and distance information.</span>');
            }

        });
        $('#allmap').live('pageshow', function () {


            // $("#allmap_canvas").gMap({ 'markers': markers, 'zoom': mobileDemo.zoom });


        });

        $('#Div1').live('pageshow', function () {
            $("#norecordfound").html('');
            $("#norecordfoundforadvansearch").html('');
        });

        $("#details").live("pageshow", function (event) {


            for (var i = 0; i < jsonObj.length; i++) {

                if (valid == jsonObj[i].docid) {
                    $("#dispname").html(jsonObj[i].fname + ' ' + jsonObj[i].lname + ',&nbsp;' + jsonObj[i].qualification);
                    var detailshtml = " <table border='0' cellpadding='5px' cellspacing='0'>";


                    addlogitude = jsonObj[i].ziplogitude;
                    addlatitude = jsonObj[i].ziplatitude;
                    tozipcode = jsonObj[i].zipcode;

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
                        detailshtml += "<tr><td class='detailsclass' style='vertical-align: top;'>Clinic or Practice Name:</td><td>" + addressdisp + "</td></tr>";
                        if (locnotfound == "false" && $("#zipcode").val() == "") {
                            detailshtml += "<tr><td class='detailsclass'></td><td><span><a href='#basic_map' data-transition='slide' onclick='setmapaddress(1)'>Map</a></span></td></tr>";
                        }
                        else {
                            detailshtml += "<tr><td class='detailsclass'></td><td><span><a href='#basic_map' data-transition='slide' onclick='setmapaddress(1)'>Map</a>&nbsp;&nbsp;&nbsp;<a href='#directions_map' onclick='setmapaddress(1)' data-transition='slide'>Get Directions</a></span></td></tr>";

                        }
                    }

                    if (jsonObj[i].phoneno != "") {
                        detailshtml += "<tr><td class='detailsclass'>Phone No:</td><td><a class='mapclass' style='text-decoration:none;' href='tel:" + jsonObj[i].phoneno + "'>" + jsonObj[i].phoneno + "</a> </td></tr>";

                    }



                    for (var a = 0; a < addressjsonObj.length; a++) {
                        if (addressjsonObj[a].userrecordref == valid) {

                            clinicaddress = '';
                            additionaladdress = '';
                            //                            if (addressjsonObj[a].primaryoffice == 'T') {
                            //                                if (addressjsonObj[a].locationname != '') {
                            //                                    clinicaddress += addressjsonObj[a].locationname + ',&nbsp;';
                            //                                }
                            //                                if (addressjsonObj[a].address1 != '') {
                            //                                    clinicaddress += addressjsonObj[a].address1 + ',&nbsp;';
                            //                                }
                            //                                if (addressjsonObj[a].address2 != '') {
                            //                                    clinicaddress += addressjsonObj[a].address2 + ',&nbsp;';
                            //                                }
                            //                                if (addressjsonObj[a].city != '') {
                            //                                    clinicaddress += addressjsonObj[a].city + ',&nbsp;';
                            //                                }
                            //                                if (addressjsonObj[a].state != '') {
                            //                                    clinicaddress += addressjsonObj[a].state + ',&nbsp;';
                            //                                }
                            //                                if (addressjsonObj[a].zipcode != '') {
                            //                                    clinicaddress += addressjsonObj[a].zipcode + ',&nbsp;';
                            //                                }
                            //                                detailshtml += "<tr><td class='detailsclass' style='vertical-align: top;'>Clinic or Practice Name:</td><td>" + addressjsonObj[a].locationname + '' + addressjsonObj[a].address1 + '' + addressjsonObj[a].address2 + '' + addressjsonObj[a].city + '' + addressjsonObj[a].state + '' + addressjsonObj[a].zipcode + "</td></tr>";
                            //                                detailshtml += "<tr><td class='detailsclass' style='vertical-align: top;'>Additional Office:</td><td>" + clinicaddress + "</td></tr>";
                            //                                detailshtml += "<tr><td class='detailsclass'></td><td><span><a href='#basic_map' data-transition='slide'>Map</a>&nbsp;&nbsp;&nbsp;<a href='#directions_map' data-transition='slide'>Get Directions</a></span></td></tr>";

                            //                                detailshtml += "<tr><td class='detailsclass' style='vertical-align: top;'>Phone No:</td><td>" + addressjsonObj[a].phoneno + "</td></tr>";

                            //                            }

                            if (addressjsonObj[a].primaryoffice == 'F') {
                                if (addressjsonObj[a].locationname != '') {
                                    additionaladdress += addressjsonObj[a].locationname + ',&nbsp;';
                                }
                                if (addressjsonObj[a].address1 != '') {
                                    additionaladdress += addressjsonObj[a].address1 + ',&nbsp;';
                                }
                                if (addressjsonObj[a].address2 != '') {
                                    additionaladdress += addressjsonObj[a].address2 + ',&nbsp;';
                                }
                                if (addressjsonObj[a].city != '') {
                                    additionaladdress += addressjsonObj[a].city + ',&nbsp;';
                                }
                                if (addressjsonObj[a].state != '') {
                                    additionaladdress += addressjsonObj[a].state + ',&nbsp;';
                                }
                                if (addressjsonObj[a].zipcode != '') {
                                    additionaladdress += addressjsonObj[a].zipcode + ',&nbsp;';
                                }
                                addtionalmapaddress = additionaladdress;
                                if (addtionalmapaddress != "") {
                                    detailshtml += "<tr><td class='detailsclass' style='vertical-align: top;'>Additional Office:</td><td>" + additionaladdress + "</td></tr>";
                                    if (locnotfound == "false" && $("#zipcode").val() == "") {
                                        detailshtml += "<tr><td class='detailsclass'></td><td><span><a href='#basic_map' data-transition='slide' onclick='setmapaddress(2)'>Map</a></span></td></tr>";
                                    }
                                    else {
                                        detailshtml += "<tr><td class='detailsclass'></td><td><span><a href='#basic_map' data-transition='slide' onclick='setmapaddress(2)'>Map</a>&nbsp;&nbsp;&nbsp;<a href='#directions_map' data-transition='slide' onclick='setmapaddress(2)'>Get Directions</a></span></td></tr>";

                                    }
                                }
                                detailshtml += "<tr><td class='detailsclass'>Phone No:</td><td><a class='mapclass' style='text-decoration:none;' href='tel:" + addressjsonObj[a].phoneno + "'>" + addressjsonObj[a].phoneno + "</a> </td></tr>";

                            }

                        }
                    }


                    if (jsonObj[i].fax != "") {
                        detailshtml += "<tr><td class='detailsclass'>Fax:</td><td>" + jsonObj[i].fax + "</td></tr>";

                    }

                    if (jsonObj[i].distance != "") {
                        if (locnotfound == "true" || $("#zipcode").val() != "") {
                            detailshtml += "<tr><td class='detailsclass'>Distance:</td><td>" + jsonObj[i].distance + "</td></tr>";
                        }
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
                    addlogitude = jsonObj[i].ziplogitude;
                    addlatitude = jsonObj[i].ziplatitude;
                    geocoder.geocode({ 'address': fromzipcode }, function (results, status) {

                        if (status == google.maps.GeocoderStatus.OK) {
                            latitude = results[0].geometry.location.lat();
                            longitude = results[0].geometry.location.lng();

                        }
                    });
                    latitude = jsonObj[i].ziplatitude;
                    longitude = jsonObj[i].ziplogitude;
                }
            }
            mobileDemo = { 'center': '' + latitude + ',' + longitude + '', 'zoom': 14 };

        });
        function setmapaddress(id) {

            if (id == '1') {
                mapaddress = mapaddress;
                addressdisp = mapaddress;
            }
            else {
                mapaddress = additionaladdress;
                addressdisp = additionaladdress;
            }

        }


        $('#basic_map').live('pageshow', function () {
            //


            MapDisplay(mapdocname);

            // $('#map_canvas').gmap('clear', 'markers');
            //$('#map_canvas').gmap('addMarker', { 'position': new google.maps.LatLng(latitude, longitude), 'bounds': true, 'zoom': 10 });
            //            
        });
        function MapDisplay(mapdocname) {

            $('#map_canvas').gmap('destroy');
            var nameadress = '';
            if (locnotfound == "false" && $("#zipcode").val() == "") {
                nameadress = '<div><a onclick="SetValue(' + valid + ')" href="#details" data-transition="slide">' + mapdocname + ' </a></div><div>' + mapaddress + '</div>';
            }
            else {
                nameadress = '<div><a onclick="SetValue(' + valid + ')" href="#details" data-transition="slide">' + mapdocname + ' </a></div><div>' + mapaddress + '</div><div><a href="#directions_map" onclick="getmapaddress(' + valid + ');" data-transition="slide">Get Directions</a></div>';
            
            }
            $('#map_canvas').gmap3({ action: 'init',
                options: {
                    center: [latitude, longitude],
                    zoom: 14
                }
            },
{ action: 'addMarkers',
    markers: [
{ lat: latitude, lng: longitude, data: nameadress },

],
    marker: {
        options: {
            draggable: false
        },
        events: {
            click: function (marker, event, data) {

                infoWindowOpen(this, marker, data)
            }
        }
    }
}
);
            //            mobileDemo = { 'center': '' + latitude + ',' + longitude + '', 'zoom': 14 };
            //            $('#map_canvas').gmap('destroy');

            //            $('#map_canvas').gmap({ 'center': new google.maps.LatLng(latitude, longitude), 'zoom': mobileDemo.zoom, 'disableDefaultUI': false, 'callback': function () {
            //                var self = this;
            //                self.addMarker({ 'position': this.get('map').getCenter() }).click(function () {
            //                    self.openInfoWindow({ 'content': mapdocname + ' </br>' + mapaddress }, this);
            //                   
            //                });
            //            }
            //            });
        }

        var infoWindow = null;

        function infoWindowOpen($this, marker, data) {
            if (infoWindow) {
                var map = $this.gmap3('get'); // returns google Map object
                infoWindow.open(map, marker);
            } else {
                // create info window above marker
                $this.gmap3({ action: 'addInfoWindow', anchor: marker });
                // get google InfoWindow object 
                infoWindow = $this.gmap3({ action: 'get', name: 'infoWindow' });
            }
            infoWindow.setContent(data);
        }




        $(document).ready(
    function () {
        $("#btnSearch").click(function () {
            // Build OData query
            UpdateCurrentLocation();
            checkpage = '1';
            boolback = 0;
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
            fname = jQuery.trim($("#firstname").val());
            lname = jQuery.trim($("#lastname").val());
            spec = jQuery.trim($("#specility").val());
            lname = lname.replace(/[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi, '');
            fname = fname.replace(/[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi, '');
            distancezipcode = jQuery.trim($("#zipcode").val());

            distance = $("#distance").val();

            //check all can't blank 

            if (fname == "" && lname == "" && spec == "") {
                $("#norecordfound").html('<div style=" color:red;">Enter physician name or specialty</div>');
                // window.history.back();
                return false;
            }

            //-------------------------------------
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
                if ($("#zipcode").val().length < 5) {
                    $("#errormsg").html('* Please enter correct zipcode');
                    return false;
                }
                defaultboolloc = 2;
            }
            //            else if (locnotfound == "false") {
            //                $("#errormsg").html('* Zip code required');
            //                return false;
            //            }


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


        //////////////////////////////////////////////////////
        ////////////Advance Search//////////////////////////

        $("#btnAdvanceSearch").click(function () {
            // Build OData query
            checkpage = '2';
            boolback = 0;
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

        var markersArray = [];

        function deleteOverlays() {
            if (markersArray) {
                for (i in markersArray) {
                    markersArray[i].setMap(null);
                }
                markersArray.length = 0;
            }
        }

        ////////////////////////////////////////////////////////////////////////////////////////
        $("#btnallmap").click(function () {

            $("#maplodingimgid").show();
            if (jsonObj.length > 0) {
                var centerelement = Math.floor(jsonObj.length / 2);
                latitude = jsonObj[centerelement].ziplatitude;
                longitude = jsonObj[centerelement].ziplogitude;
            }
            else {
                latitude = 32.795355714148336;
                longitude = -96.8170166015625;
            }
            var myaddress = '';
            var msgonmap = '';
            if ($("#zipcode").val() == "") {
                msgonmap = "Current Location";
                myaddress = defaultloc;
            }
            else {
                myaddress = $("#zipcode").val();
                msgonmap = $("#zipcode").val();
            }
            mobileDemo = { 'center': '' + latitude + ',' + longitude + '', 'zoom': 10 };
            $('#allmap_canvas').gmap('destroy');

            //  $('#allmap_canvas').gMap({ 'center': new google.maps.LatLng(latitude, longitude), 'zoom': mobileDemo.zoom, 'disableDefaultUI': false });
            //                var self = this;
            //                self.addMarker({ 'position': this.get('map').getCenter() }).click(function () {
            //                    self.openInfoWindow({ 'content': mapdocname + ' </br>' + mapaddress }, this);

            //                });
            // }

            if (locnotfound == "true" || $("#zipcode").val() != "") {

                $('#allmap_canvas').gmap3({ action: 'addMarker',
                    address: myaddress,
                    map: {
                        center: true,
                        zoom: 10
                    },
                    marker: {
                        options: {
                            draggable: false,
                            icon: new google.maps.MarkerImage('http://maps.gstatic.com/mapfiles/icon_green.png')
                        },
                        events: {
                            click: function (marker, event, data) {
                                //alert(data);
                                infoWindowOpen(this, marker, msgonmap)
                            }
                        }
                    }
                });


            }




            var markers = [];
            for (i = 0; i < jsonObj.length; i++) {
                var alladdressdisp = jsonObj[i].add1 + ' ' + jsonObj[i].add2;
                if (jsonObj[i].city != "") {
                    alladdressdisp += ",&nbsp;" + jsonObj[i].city;
                }
                if (jsonObj[i].state != "") {
                    alladdressdisp += ",&nbsp;" + jsonObj[i].state + "&nbsp;,";
                }

                if (jsonObj[i].zip != "") {
                    alladdressdisp += jsonObj[i].zipcode;
                }
                var trimaddress = alladdressdisp.replace(/^\s+|\s+$/g, '');
                var docname = jsonObj[i].fname + ' ' + jsonObj[i].lname;
                var tempadd = '';
                if (locnotfound == "false" && $("#zipcode").val() == "") {
                    tempadd = '<div><a onclick="SetValue(' + jsonObj[i].docid + ')" href="#details" data-transition="slide">' + docname + '</a></div><div>' + trimaddress + '</div>';

                }
                else {
                    tempadd = '<div><a onclick="SetValue(' + jsonObj[i].docid + ')" href="#details" data-transition="slide">' + docname + '</a></div><div>' + trimaddress + '</div><div><a href="#directions_map" onclick="getmapaddress(' + jsonObj[i].docid + ');" data-transition="slide">Get Directions</a></div>';

                }
                markers.push({ lat: jsonObj[i].ziplatitude, lng: jsonObj[i].ziplogitude, data: tempadd });

                $(function () {


                    $('#allmap_canvas').gmap3(
                          { action: 'init',
                              options: {
                                  center: [32.795355714148336, -96.8170166015625],
                                  zoom: 10,
                                  mapTypeId: google.maps.MapTypeId.ROADMAP
                              }
                          },
                          { action: 'addMarkers',
                              radius: 100,
                              markers: markers,

                              marker: {

                                  events: {
                                      click: function (marker, event, data) {
                                          infoWindowOpen(this, marker, data)

                                      }

                                  }
                              }
                          }
                        );
                });
                //                $('#allmap_canvas').gmap('addMarker', { 'bounds': true, 'position': new google.maps.LatLng(42.345573, -71.098326), 'animation': google.maps.Animation.DROP }, function (map, marker) {
                //                    $('#allmap_canvas').gmap('addInfoWindow', { 'position': marker.getPosition(), 'content': 'TEXT_AND_HTML_IN_INFOWINDOW' }, function (iw) {
                //                        $(marker).click(function () {
                //                            iw.open(map, marker);
                //                            map.panTo(marker.getPosition());
                //                        });
                //                    });
                //                });

                ///$('#allmap_canvas').gmap({ 'center': new google.maps.LatLng(42.345573, -71.098326) });

                //                $('#allmap_canvas').gmap('addMarker', { 'bounds': true, 'position': new google.maps.LatLng(jsonObj[i].ziplatitude, jsonObj[i].ziplogitude), 'animation': google.maps.Animation.DROP }, function (map, marker) {
                //                    $('#allmap_canvas').gmap('addInfoWindow', { 'position': marker.getPosition(), 'content': 'TEXT_AND_HTML_IN_INFOWINDOW' 
                //                        
                //                    });
                //                });




                //                $('#allmap_canvas').gmap('addMarker', {
                //                    'position': new google.maps.LatLng(jsonObj[i].ziplatitude, jsonObj[i].ziplogitude),
                //                    'bounds': true
                //                }).click(function (add1) {
                //                    return function () {
                //                        $('#allmap_canvas').gmap('openInfoWindow', { 'content': add1 }, this);
                //                    }
                //                }(trimaddress));

                //               
                // $('#allmap_canvas').gmap('addMarker', { 'position': new google.maps.LatLng(jsonObj[i].ziplatitude, jsonObj[i].ziplogitude), 'bounds': true, 'title': trimaddress, 'callback': callback123 });
                //  $('#allmap_canvas').gmap('addInfoWindow', { 'position': new google.maps.LatLng(jsonObj[i].ziplatitude, jsonObj[i].ziplogitude), 'content': 'TEXT_AND_HTML_IN_INFOWINDOW' });
                //  $('#allmap_canvas').gmap('addMarker', { 'position': new google.maps.LatLng(jsonObj[i].ziplatitude, jsonObj[i].ziplogitude) });
                //                var marker = new google.maps.Marker({
                //                    position: new google.maps.LatLng(jsonObj[i].ziplatitude, jsonObj[i].ziplogitude),
                //                    title: "Hello World!"



                //                $('#allmap_canvas').gmap('addMarker', { 'position': new google.maps.LatLng(jsonObj[i].ziplatitude, jsonObj[i].ziplogitude) }, function (map, marker) {
                //                    $('#dialog').append('yogesh');
                //                }).click(function () {
                //                    openDialog(this);
                //                });






            }
            var t = setTimeout("$('#maplodingimgid').hide()", eval(jsonObj.length) * 10)

        });
        ///////////////////////////////////////////////////////////////////////
        jQuery.ajaxSetup({
            beforeSend: function () {
                $("#pager").html('');
                $('#doctordetails').html('<div align="center"><img src="images/mainl.gif" style="padding-top:130px;" height="40px" width="40px" /></div>');
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
        $("#zipcode").keyup(function (event) {

            if ($("#zipcode").val() != "") {
                if ($("#zipcode").val().length == '5') {
                    // $("#errormsg").html('Enter Wrong zipcode');
                    $('#btnSearch .ui-btn-text').text("Search Near Zipcode");

                }

                else {
                    $('#btnSearch .ui-btn-text').text("Search Near Me");
                }
            }
        });
        $("#zipcode").blur(function (event) {

            if ($("#zipcode").val() == "") {

                //$("#errormsg").html('Enter Wrong zipcode');
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
        //        var querylang = serviceurl // netflix base url
        //            + "/med_physdirectory_languages?" // top-level resource

        //            + "$callback=callbacklanguage1" // jsonp request
        //            + "&$format=json"; // json request

        //        // Make JSONP call to Netflix
        //        $.ajax({
        //            dataType: "jsonp",
        //            url: querylang,

        //            jsonpCallback: "callbacklanguage1",
        //            success: callbacklanguage
        //        });

        //        var queryinsurance = serviceurl// netflix base url
        //            + "/getinsuranceList?" // top-level resource

        //            + "$callback=callbackInsurance1" // jsonp request
        //            + "&$format=json"; // json request

        //        // Make JSONP call to Netflix
        //        $.ajax({
        //            dataType: "jsonp",
        //            url: queryinsurance,

        //            jsonpCallback: "callbackInsurance1",
        //            success: callbackInsurance
        //        });





        var queryspec = serviceurl // netflix base url
            + "/med_physdirectory_Specialty?" // top-level resource

            + "$callback=callbackspec1" // jsonp request
            + "&$format=json"; // json request
        $.ajax({
            dataType: "jsonp",
            url: queryspec,

            jsonpCallback: "callbackspec1",
            success: callbackspec
            
        });


        //        var queryhospitalaff = serviceurl // netflix base url
        //            + "/getSearchListHospitalAffiliations?" // top-level resource

        //            + "$callback=callbackhospitals1" // jsonp request
        //            + "&$format=json"; // json request
        //        $.ajax({
        //            dataType: "jsonp",
        //            url: queryhospitalaff,

        //            jsonpCallback: "callbackhospitals1",
        //            success: callbackhospitals
        //        });


    });



//        function callbackhospitals(result) {

//            var $e = $("#hospaffil");
//            $('#hospaffil').empty()
//            $e.append("<option value=''>-select-</option>");
//            if (result.d.length > 0) {
//                for (var i = 0; i < result.d.length; i++) {
//                    if (result.d[i].description != "") {
//                        var tmp = "<option value='" + result.d[i].description + "'>" + result.d[i].description + "</option>";
//                        $e.append(tmp);
//                    }
//                }

//            }

//        }

//        function callbackInsurance(result) {

//            var $e = $("#insurance");
//            $('#insurance').empty()
//            $e.append("<option value='0'>-select-</option>");
//            if (result.d.length > 0) {
//                for (var i = 0; i < result.d.length; i++) {
//                    var tmp = "<option value='" + result.d[i].id + "'>" + result.d[i].description + "</option>";
//                    $e.append(tmp);
//                }

//            }

//        }

//        function callbacklanguage(result) {

//            var $e = $("#lang");
//            $('#lang').empty()
//            $e.append("<option value=''>-select-</option>");
//            if (result.d.length > 0) {
//                result.d.sort(SortByName);
//                for (var i = 0; i < result.d.length; i++) {
//                    var tmp = "<option value='" + result.d[i].keyvalue + "'>" + result.d[i].keyvalue + "</option>";
//                    $e.append(tmp);
//                }

//            }


//        }

        function SortByName(x, y) {
            return ((x.keyvalue == y.keyvalue) ? 0 : ((x.keyvalue > y.keyvalue) ? 1 : -1));
        }

        // Call Sort By Name


        function callbackspec(result) {
            var $e = $("#specility");
            $('#specility').empty()
            $e.append("<option value=''  selected='selected'>-select-</option>");
            if (result.d.length > 0) {
                result.d.sort(SortByName);
                for (var i = 0; i < result.d.length; i++) {
                    var tmp = "<option value='" + result.d[i].keyvalue + "'>" + result.d[i].keyvalue + "</option>";
                    $e.append(tmp);
                }

            }


        }
        function callback(result) {

            boolback = boolback + 1;
            var pagernext = '';
            var html = "";
            var sindex = StartFrom + NumberOfRecords;
            var endindex = StartFrom - NumberOfRecords;
            var docids = '';
            jsonObj = [];
            if (result.d.length == 0) {

                if (checkpage == '1') {
                    $("#norecordfound").html('<div style=" color:red;">No records found</div>');

                }
                else {
                    $("#norecordfoundforadvansearch").html('<div style=" color:red;">No records found</div>');

                }
                // if (boolback == 2) {
                window.history.back();

                //}

            }



            if (result.d.length > 0) {


                $("#norecordfound").html('');
                $("#norecordfoundforadvansearch").html('');
                if (result.d.length < 9) {
                    if (StartFrom != '1') {
                        var pagernext = '<a href="#"  onclick="FetchData(' + endindex + '); " ><img src="images/backbutton.jpg" /></a> <a href="#"><img class="disble" src="images/nextbutton.jpg" /></a>';

                    }
                    else {

                        var pagernext = '<a href="#" class="disble"   ><img src="images/backbutton.jpg" /></a> <a href="#"><img class="disble" src="images/nextbutton.jpg" /></a>';

                    }
                }
                else if (StartFrom == 1) {
                    var pagernext = '<a href="#"  ><img class="disble" src="images/backbutton.jpg" /></a> <a href="#" onclick="FetchData(' + sindex + ');"><img src="images/nextbutton.jpg" /></a>';

                }
                else {
                    var pagernext = '<a href="#" onclick="FetchData(' + endindex + ');">  <img src="images/backbutton.jpg" /> </a> <a  onclick="FetchData(' + sindex + ');" href="#"><img src="images/nextbutton.jpg" /></a>';

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

                    docids += "," + result.d[i].id;

                    jsonObj.push({ docid: result.d[i].id, fname: result.d[i].FirstName, lname: result.d[i].LastName, specility: result.d[i].specialty1, add1: result.d[i].Street, add2: result.d[i].street2, phoneno: result.d[i].Phone, city: result.d[i].City, zipcode: result.d[i].Zip, email: result.d[i].websiteurl, gender: result.d[i].gender, qualification: result.d[i].Degree, distance: midistance, fax: result.d[i].fax, sameday: samedayappt, certification: result.d[i].certification, primaryhospital: result.d[i].primaryhospital, secondaryhospital: result.d[i].secondaryhospital, practicetype: result.d[i].practicetype, age: result.d[i].age, medical_school: result.d[i].medical_school, residency: result.d[i].residency, fellowship: result.d[i].fellowship, state: result.d[i].State, ziplatitude: result.d[i].addr_latitude, ziplogitude: result.d[i].addr_longitude });


                    var showaddress = result.d[i].Street

                    if (result.d[i].street2 != "") {
                        showaddress += '&nbsp;' + result.d[i].street2;
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

                        if (showaddress != "") {
                            if (locnotfound == "false" && $("#zipcode").val() == "") {
                                html += '<div class="even" data-theme="a"> <table width="100%" cellpadding="0" cellspacing="0" border="0"><tr></td><td class="Detailsclass" width="80%"><span><a onclick="SetValue(' + result.d[i].id + ')" href="#details" data-transition="slide">' + result.d[i].FirstName + '  ' + result.d[i].LastName + '</a></span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a class="mapclass" style="text-decoration:none;" href="tel:' + result.d[i].Phone + '">' + result.d[i].Phone + '</a></td><td align="right" width="20%" style="font-size:12px;"></td></tr><tr><td class="Detailsclass" COLSPAN="2"><a href="#basic_map" onclick="getmapaddress(' + result.d[i].id + ');" data-transition="slide" style="text-decoration:none; color:black;">' + showaddress + '&nbsp;(<span style="font-size:11px; text-decoration:underline;">Map</span>)</a></td></tr></table></div><div style="height:5px; width:20px;"></div>';
                            }
                            else {


                                html += '<div class="even" data-theme="a"> <table width="100%" cellpadding="0" cellspacing="0" border="0"><tr></td><td class="Detailsclass" width="80%"><span><a onclick="SetValue(' + result.d[i].id + ')" href="#details" data-transition="slide">' + result.d[i].FirstName + '  ' + result.d[i].LastName + '</a></span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a class="mapclass" style="text-decoration:none;" href="tel:' + result.d[i].Phone + '">' + result.d[i].Phone + '</a></td><td align="right" width="20%" style="font-size:12px;"><a href="#directions_map" onclick="getmapaddress(' + result.d[i].id + ');" data-transition="slide"  style="text-decoration:underline; color:black;">' + midistance + '>></a></td></tr><tr><td class="Detailsclass"><a href="#basic_map" onclick="getmapaddress(' + result.d[i].id + ');" data-transition="slide" style="text-decoration:none; color:black;">' + showaddress + '&nbsp;(<span style="font-size:11px; text-decoration:underline;">Map</span>)</a></td></tr></table></div><div style="height:5px; width:20px;"></div>';
                            }
                        }
                        else {
                            html += '<div class="even" data-theme="a"> <table width="100%" cellpadding="0" cellspacing="0" border="0"><tr></td><td class="Detailsclass" width="80%"><span><a onclick="SetValue(' + result.d[i].id + ')" href="#details" data-transition="slide">' + result.d[i].FirstName + '  ' + result.d[i].LastName + '</a></span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a class="mapclass" style="text-decoration:none;" href="tel:' + result.d[i].Phone + '">' + result.d[i].Phone + '</a></td></tr></table></div><div style="height:5px; width:20px;"></div>';

                        }
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
                        if (showaddress != "") {
                            if (locnotfound == "false" && $("#zipcode").val() == "") {
                                html += '<div class="odd" data-theme="a"> <table width="100%" cellpadding="0" cellspacing="0" border="0"><tr></td><td class="Detailsclass" width="80%"><span><a onclick="SetValue(' + result.d[i].id + ')" href="#details" data-transition="slide">' + result.d[i].FirstName + '  ' + result.d[i].LastName + '</a></span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a class="mapclass" style="text-decoration:none;" href="tel:' + result.d[i].Phone + '">' + result.d[i].Phone + '</a></td><td align="right" width="20%" style="font-size:12px;"></td></tr><tr><td class="Detailsclass" COLSPAN="2"><a href="#basic_map" onclick="getmapaddress(' + result.d[i].id + ');" data-transition="slide" style="text-decoration:none; color:black;">' + showaddress + '&nbsp;(<span style="font-size:11px; text-decoration:underline;">Map</span>)</a></td></tr></table></div><div style="height:5px; width:20px;"></div>';
                            }
                            else {
                                html += '<div class="odd" data-theme="a"> <table width="100%" cellpadding="0" cellspacing="0" border="0"><tr></td><td class="Detailsclass" width="80%"><span><a onclick="SetValue(' + result.d[i].id + ')" href="#details" data-transition="slide">' + result.d[i].FirstName + '  ' + result.d[i].LastName + '</a></span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a class="mapclass" style="text-decoration:none;" href="tel:' + result.d[i].Phone + '">' + result.d[i].Phone + '</a></td><td align="right" width="20%" style="font-size:12px;"><a href="#directions_map" onclick="getmapaddress(' + result.d[i].id + ');" data-transition="slide"  style="text-decoration:underline; color:black;">' + midistance + '>></a></td></tr><tr><td class="Detailsclass"><a href="#basic_map" onclick="getmapaddress(' + result.d[i].id + ');" data-transition="slide" style="text-decoration:none; color:black;">' + showaddress + '&nbsp;(<span style="font-size:11px; text-decoration:underline;">Map</span>)</a></td></tr></table></div><div style="height:5px; width:20px;"></div>';
                            }
                        }
                        else {
                            html += '<div class="odd" data-theme="a"> <table width="100%" cellpadding="0" cellspacing="0" border="0"><tr></td><td class="Detailsclass" width="80%"><span><a onclick="SetValue(' + result.d[i].id + ')" href="#details" data-transition="slide">' + result.d[i].FirstName + '  ' + result.d[i].LastName + '</a></span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a class="mapclass" style="text-decoration:none;" href="tel:' + result.d[i].Phone + '">' + result.d[i].Phone + '</a></td></tr></table></div><div style="height:5px; width:20px;"></div>';

                        }
                        // if (showaddress != "") {
                        //  html += '<div class="odd" data-theme="a"> <table width="100%" cellpadding="0" cellspacing="0" border="0"><tr></td><td class="Detailsclass" width="5%"><span><a onclick="SetValue(' + result.d[i].id + ')" href="#details" data-transition="slide">' + result.d[i].FirstName + '  ' + result.d[i].LastName + '</a></span></td><td width="15%"><a class="mapclass" style="text-decoration:none;" href="tel:' + result.d[i].Phone + '">' + result.d[i].Phone + '</a></td><td align="right" width="20%" style="font-size:12px;"><a href="#directions_map" onclick="getmapaddress(' + result.d[i].id + ');" data-transition="slide"  style="text-decoration:underline; color:black;">' + midistance + '>></a></td></tr><tr><td class="Detailsclass"><a href="#basic_map" onclick="getmapaddress(' + result.d[i].id + ');" data-transition="slide" style="text-decoration:none; color:black;">' + showaddress + '&nbsp;(<span style="font-size:11px; text-decoration:underline;">Map</span>)</a></td></tr></table></div><div style="height:5px; width:20px;"></div>';
                        //  }
                        // else {
                        // html += '<div class="odd" data-theme="a"> <table width="100%" cellpadding="0" cellspacing="0" border="0"><tr></td><td class="Detailsclass" width="5%"><span><a onclick="SetValue(' + result.d[i].id + ')" href="#details" data-transition="slide">' + result.d[i].FirstName + '  ' + result.d[i].LastName + '</a></span></td><td width="15%"><a class="mapclass" style="text-decoration:none;" href="tel:' + result.d[i].Phone + '">' + result.d[i].Phone + '</a></td><td align="right" width="20%" style="font-size:12px;"></td></tr></table></div><div style="height:5px; width:20px;"></div>';

                        //  }
                    }
                }
            }
            else {
                if (endindex >= 1) {
                    pagernext = '<a onclick="FetchData(' + endindex + ');" href="#"><img src="images/backbutton.jpg" /></a> <a href="#" ><img class="disble" src="images/nextbutton.jpg" /></a>';

                }

                // html += '<div style=" color:red;">No records found</div>';
            }


            if (result.d.length > 0) {

                calloffice(docids);
            }

            if (result.d.length >= 30) {
                $("#refind").show();
                $("#refind1").show();
            }
            else {
                $("#refind").hide();
                $("#refind1").hide();
            }

            $("#doctordetails").html(html);
            document.getElementById("doctordetails").innerHTML = html;
            $("#pager").html(pagernext);
            document.getElementById("pager").innerHTML = pagernext;

        }


        function RemoveErrorMsg() {
            $("#errormsg").html('');
        }
        function RemoveErrorMsg2() {
            $("#errormsg2").html('');
        }

        function backfunction() {

            window.history.back();
            //  if ($("#norecordfound").html() == '') {

            //}
            //$("#norecordfoundforadvansearch").html('');

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
            addressdisp = objaddress;

        }
        function SetValue(id) {

            valid = id;

        }
        function calloffice(id) {


            var queryoffice = serviceurl
            + "/getPhysicianOffices?ids='" + id + "'"
            + "&$callback=callbackoffice1"
            + "&$format=json";
            $.ajax({
                dataType: "jsonp",
                url: queryoffice,
                jsonpCallback: "callbackoffice1",
                success: callbackoffice
            });
        }

        function callbackoffice(result) {

            addressjsonObj = [];
            for (var i = 0; i < result.d.length; i++) {
                addressjsonObj.push({ ref: result.d[i].ref, userrecordref: result.d[i].userrecordref, primaryoffice: result.d[i].primaryoffice, locationname: result.d[i].locationname, address1: result.d[i].address1, address2: result.d[i].address2, phoneno: result.d[i].phone, city: result.d[i].city, zipcode: result.d[i].zip, fax: result.d[i].fax, state: result.d[i].state, hours: result.d[i].hours });
            }
        }
        function FetchData(startindex) {

            if (startindex < 1) {
                var sindex = StartFrom + NumberOfRecords;
                var pagernext = '<a href="#">  <img src="images/backbutton.jpg" class="disble" /> </a> <a  onclick="FetchData(' + sindex + ');" href="#"><img src="images/nextbutton.jpg" /></a>';
                $("#pager").html(pagernext);
                return false;
            }

            StartFrom = startindex;
            NumberOfRecords = 30;
          
            var query = serviceurl // netflix base url
            + "/searchDoctorForMobileAppPaging?lname='" + escape(lname) + "'&fname='" + escape(fname) + "'&degree='" + escape(degree) + "'&gender='" + escape(gender) + "'&agemin='" + escape(agemin) + "'&agemax='" + escape(agemax) + "'&lang='" + escape(lang) + "'&spec='" + escape(spec) + "'&sameday='" + escape(sameday) + "'&apptavail='" + escape(apptavail) + "'&hospaffil='" + escape(hospaffil) + "'&insur='" + escape(insur) + "'&zip='" + zip + "'&distancezipcode='" + distancezipcode + "'&distance='" + distance + "'&StartFrom='" + escape(StartFrom) + "'&NumberOfRecords='" + escape(NumberOfRecords) + "'&currentlatitude='" + currentlatitude + "'&currentlongitude='" + currentlongitude + "'" // top-level resource

            + "&$callback=callback1" // jsonp request
            + "&$format=json"; // json request


            // Make JSONP call to Netflix
            $.ajax({
                dataType: "jsonp",
                url: query,
                timeout: 12000,
                jsonpCallback: "callback1",
                success: callback,
                error: function (x, t, m) {
                    if (t === "timeout") {
                        if (checkpage == '1') {
                            $("#norecordfound").html('<div style=" color:red;">Operation timed out please refine your search</div>');
                            
                        }
                        else {
                            $("#norecordfoundforadvansearch").html('<div style=" color:red;">Operation timed out please refine your search</div>');
                          
                        }
                        window.history.back();
                        return false;

                    }
                    else {

                        alert("Network error, Try after some time");

                        //window.location = "index2.aspx";


                    }


                }
            });
        }

        function getmapaddress(docid) {

            for (var i = 0; i < jsonObj.length; i++) {

                if (docid == jsonObj[i].docid) {

                    mapdocname = jsonObj[i].fname + ' ' + jsonObj[i].lname;
                    var geocoder = new google.maps.Geocoder();
                    addressdisp = jsonObj[i].add1 + ' ' + jsonObj[i].add2 + ', ' + jsonObj[i].city + ' ' + jsonObj[i].zipcode;
                    mapaddress = jsonObj[i].add1 + ' ' + jsonObj[i].add2 + ', ' + jsonObj[i].city + ' ' + jsonObj[i].zipcode;
                    addlogitude = jsonObj[i].ziplogitude;
                    addlatitude = jsonObj[i].ziplatitude;
                    geocoder.geocode({ 'address': mapaddress }, function (results, status) {

                        if (status == google.maps.GeocoderStatus.OK) {
                            latitude = results[0].geometry.location.lat();
                            longitude = results[0].geometry.location.lng();

                        }
                    });
                }
            }
            valid = docid;
            mobileDemo = { 'center': '' + latitude + ',' + longitude + '', 'zoom': 14 };

        }

        //-----------------------------------------------------------------------
        function UpdateCurrentLocation() {
            //-------------------------------------------------------------------------------------------------------------------------
            // Get the location of the user's browser using the
            // native geolocation service. When we invoke this method
            // only the first callback is requied. The second
            // callback - the error handler - and the third
            // argument - our configuration options - are optional.
            if (navigator.geolocation) {
                var locationMarker = null;
                navigator.geolocation.getCurrentPosition(function (position) {

                    // Check to see if there is already a location.
                    // There is a bug in FireFox where this gets
                    // invoked more than once with a cahced result.
                    if (locationMarker) {
                        return;
                    }

                    //GPS Search geolocation
                    currentlatitude = position.coords.latitude;
                    currentlongitude = position.coords.longitude;
                    var geocoder1;
                    geocoder1 = new google.maps.Geocoder();
                    var latlng = new google.maps.LatLng(currentlatitude, currentlongitude);
                    geocoder1.geocode({ 'latLng': latlng }, function (results, status) {
                        if (status == google.maps.GeocoderStatus.OK) {
                            defaultloc = results[1].formatted_address;
                            defaultboolloc = '1';
                            //  $("#errormsg").html("Current location from navigator: " + defaultloc);
                        }
                    }); //end geocode function
                },
			   function (error) {
			       locnotfound = "false";
			   },
			   {
			       timeout: (5 * 1000),
			       maximumAge: (1000 * 60 * 15),
			       enableHighAccuracy: true
			   }); //end of getCurrentPosition function 


                //ISP geolocation search 
                if (locnotfound == "false") {
                    locnotfound = "true";
                    var positionTimer = navigator.geolocation.watchPosition(
			        function (position) {
			            currentlatitude = position.coords.latitude;
			            currentlongitude = position.coords.longitude;
			            var geocoder2;
			            geocoder2 = new google.maps.Geocoder();
			            var latlng2 = new google.maps.LatLng(currentlatitude, currentlongitude);
			            geocoder2.geocode({ 'latLng': latlng2 }, function (results, status) {
			                if (status == google.maps.GeocoderStatus.OK) {
			                    defaultloc = results[1].formatted_address;
			                    defaultboolloc = '1';

			                }
			            },

				function (error) {
				    locnotfound = "false";
				  
				});
			        });

                    // If the position hasn't updated within 5 minutes, stop
                    // monitoring the position for changes.
                    setTimeout(function () {
                        navigator.geolocation.clearWatch(positionTimer); // Clear the position watcher.
                    }, (1000 * 60 * 5));
                }
            }
            //end  get current location code
            //------------------------------------------------------------------------------------------
        }

    </script>
    <%--    
<script type='text/javascript'>//<![CDATA[
    $(window).load(function () {
        // load test data initially
        for (i = 0; i < 20; i++) {
            $("#list").append($("<li><a href=\"index.html\"><h3>" + i + "</h3><p>z</p></a></li>"));
        }
        //$("#list").listview('refresh');


        // load new data when reached at bottom
        $('#footer').waypoint(function (a, b) {
            
            $("#list").append($("<li><a href=\"index.html\"><h3>" + i++ + "</h3><p>z</p></a></li>"));
            $("#list").listview('refresh');
            $('#footer').waypoint({
                offset: '100%'
            });
        }, {
            offset: '100%'
        });
    });//]]>  
    
</script>--%>
</head>
<body>
    <form id="form1" runat="server">
    <div data-role="page" id="Div1">
        <div class="heading" style="background: url(images/backgroundinner.png) repeat-x;">
            <div align="center" style="height: 70px;">
                <img alt="mainbanner" style="height: 70px;" src="images/innerbanner.png" />
            </div>
        </div>
        <div data-role="content">
            <div align="center" style="padding-top: 30px;">
                <ul data-role="listview" class="mainmenu">
                    <li><a style="padding: 7px; text-align: center; text-shadow: 0 0 0px rgba(0,0,0,0);
                        border: 0px solid black; -moz-border-radius: 10px; border-radius: 10px; color: White;
                        height: 20px;" href="#page2" data-transition="slide" onclick="UpdateCurrentLocation();">Find A Physician</a></li>
                    <li><a style="padding: 7px; text-align: center; text-shadow: 0 0 0px rgba(0,0,0,0);
                        border: 0px solid black; -moz-border-radius: 10px; border-radius: 10px; color: White;
                        height: 20px;" href="#page3" data-transition="slide"  onclick="UpdateCurrentLocation();">Locations</a></li>
                    <%--    <li><a style="padding: 7px; padding-left: 50px; text-shadow: 0 0 0px rgba(0,0,0,0);
                        border: 0px solid black; -moz-border-radius: 10px; border-radius: 10px; color: White;
                        height: 20px;" href="#news">News</a></li>
                    <li><a style="padding: 7px; padding-left: 50px; text-shadow: 0 0 0px rgba(0,0,0,0);
                        border: 0px solid black; -moz-border-radius: 10px; border-radius: 10px; color: White;
                        height: 20px;" href="#aboutus">About Us</a></li>--%>
                </ul>
            </div>
        </div>
        <div align="center" style="text-align: center; color: black; font-size: 12px; margin-left: 20%;
            position: absolute; bottom: 3px;">
            &copy;2012 &bull; Texas Health Resources®
        </div>
    </div>
    <div data-role="page" id="page2">
        <div class="heading" style="background: url(images/backgroundinner.png) repeat-x;">
            <div align="center" style="height: 70px;">
                <a href="javascript:backfunction()" data-icon="arrow-l" data-rel="back" data-transition="slide">
                    <img src="includes/images/back.png" style="position: absolute; height: 30px; width: 30px;
                        top: 20px; left: 15px;" />
                </a><a href="#Div1" style="text-decoration: none;" data-transition="slide">
                    <img alt="mainbanner" style="height: 70px;" src="images/innerbanner.png" />
                </a>
                <br />
                <div align="left" style="padding-left:8px;">
                    <span id="errorMsgForWifi" style="font-size: 10px; padding-left: 6px; padding-top: 10px;">
                    </span>
                </div>
            </div>
        </div>
        <div data-role="content">
            <div align="left"  id="norecordfound" style="color: Red; margin-left:0px; font-size: 11px;">
            </div>
            <br />
            <%--   <span style="font-size: 15px; color: Gray"><strong>Search<br />
            </strong></span>--%>
            <%--    <span style="font-size: 11px; text-shadow: 0 0 0px rgba(0,0,0,0);">Find a Physician
                Use any of the fields below to find a physician on the medical staff of a facility
                in the Texas Health Resources family of hospitals, or choose <a href="#AdvanceSearch">
                    Advanced Search</a> for still more options — including a clinic or practice
                name.</span>--%>
            <table>
                <tr>
                    <td>
                        Last Name
                    </td>
                    <td>
                        First Name
                    </td>
                </tr>
                <tr>
                    <td style="padding-right: 5px;">
                        <input id="lastname" name="lastname" type="text" value="" />
                    </td>
                    <td>
                        <input id="firstname" name="firstname" type="text" value="" />
                    </td>
                </tr>
            </table>
            <%--  <div>
                Last Name</div>
            
            <div>
                First Name</div>--%>
            <div>
                Primary Specialty</div>
            <div style="margin-left: 5px; width: 98%;">
                <select style="font-size: 12px;" name="specility" id="specility" data-theme="d">
                </select></div>
            <table>
                <tr>
                    <td>
                        Your Zip Code(Opt)
                    </td>
                    <td>
                        Search Distance
                    </td>
                </tr>
                <tr>
                    <td style="width: 40%; padding-right: 5px;">
                        <input name="zipcode" id="zipcode" onfocus="RemoveErrorMsg()" type="text" maxlength="5" />
                    </td>
                    <td style="width: 40%;">
                        <select style="font-size: 12px;" name="distance" id="distance" data-theme="d">
                            <option value="0">All</option>
                            <option value="2">2</option>
                            <option value="5">5</option>
                            <option value="10">10</option>
                            <option value="15">15</option>
                            <option value="20" selected="selected">20</option>
                            <option value="30">30</option>
                            <option value="40">40</option>
                            <option value="50">50</option>
                        </select>
                    </td>
                </tr>
            </table>
            <%--  <div style="width: 280px;">
                <div style="float: left; width: 100px;">
                    Zip Code
                    <br />
                    <input name="zipcode" id="zipcode" onfocus="RemoveErrorMsg()" type="text" maxlength="5"/></div>
                <div style="float: right; width: 160px;">
                    Search Distance
                    <br />
                    <select style="font-size: 12px;" name="distance" id="distance" data-theme="d">
                        <option value="0">0</option>
                        <option value="2">2</option>
                        <option value="5">5</option>
                        <option value="10">10</option>
                        <option value="15">15</option>
                        <option value="20" selected="selected">20</option>
                        <option value="30">30</option>
                        <option value="40">40</option>
                        <option value="50">50</option>
                    </select>
                    <%--  <input type="range" onfocus="RemoveErrorMsg()" style="width: 20%; -moz-box-sizing: border-box;
                        -webkit; box-sizing: border-box; box-sizing: border-box;" name="distance" id="distance"
                        value="" min="0" max="20" data-highlight="true" data-mini="true" /></div>
                <div style="clear: both;">
                </div>
            </div>--%>
            <%-- <span id="errormsg2" style="color: Red; font-size: 10px; padding-left: 80px;"> </span>--%>
            <span id="errormsg" style="color: Red; font-size: 10px; padding-left: 6px;"></span>
            <%--     <div align="center">
                <a href="#AdvanceSearch" style="font-size: 11px;" data-transition='slide'>Advanced Search</a></div>--%>
            <a id="btnSearch" data-role="button" data-transition="fade" data-theme="a" href="#page6"
                data-transition="slide">Search Near Me </a>
        </div>
    </div>
    <div data-role="page" id="page3">
        <div class="heading" style="background: url(images/backgroundinner.png) repeat-x;">
            <div align="center" style="height: 70px;">
                <a href="javascript:backfunction()" data-icon="arrow-l" data-iconpos="notext" data-transition="slide">
                    <img src="includes/images/back.png" style="position: absolute; height: 30px; width: 30px;
                        top: 20px; left: 15px;" />
                </a><a href="#Div1" style="text-decoration: none;" data-transition="slide">
                    <img alt="mainbanner" style="height: 70px;" src="images/innerbanner.png" />
                </a>
            </div>
        </div>
        <div data-role="content" style="font-size: 13px;">
            <span style="font-size: 20px; color: Gray"><strong>Locations</strong></span>
            <div class="even">
                <div style="font-size: 13px;">
                    <strong>Texas Health Allen</strong></div>
                <div style="font-size: 12px;">
                    1105 Central Expressway, Allen,<br />
                    TX 75013&nbsp;|&nbsp;<a class="mapclass" onclick="mapdisplay1(33.11628370,-96.67425329999999,'Texas Health Allen','1105 Central Expressway, Allen, TX, 75013');"
                        href="#basic_map" data-transition='slide'>Map</a><span id="Span1">&nbsp;|&nbsp;<a class="mapclass"
                            onclick="mapdisplay1(33.11628370,-96.67425329999999,'Texas Health Allen','1105 Central Expressway, Allen, TX, 75013');"
                            href="#directions_map" data-transition='slide'>Direction</a></span><br />
                    Ph:<a href="tel:(972)747-1000">(972)747-1000</a></div>
            </div>
            <div style="height: 5px;">
            </div>
            <div class="odd">
                <div style="font-size: 13px;">
                    <strong>Texas Health Arlington Memorial</strong></div>
                <div style="font-size: 12px;">
                    800 West Randol Mill Road, Arlington,<br />
                    TX 76012&nbsp;|&nbsp;<a onclick="mapdisplay1(32.74952870,-97.11639339999999,'Texas Health Arlington Memorial','800 West Randol Mill Road, Arlington, TX, 76012');"
                        href="#basic_map" data-transition='slide'>Map</a><span id="Span2">&nbsp;|&nbsp;<a onclick="mapdisplay1(32.74952870,-97.11639339999999,'Texas Health Arlington Memorial','800 West Randol Mill Road, Arlington, TX, 76012');"
                            href="#directions_map" data-transition='slide'>Direction</a></span><br />
                    Ph: <a href="tel:(817)960-6100">(817)960-6100</a></div>
            </div>
            <div style="height: 5px;">
            </div>
            <div class="even">
                <div style="font-size: 13px;">
                    <strong>Texas Health Azle</strong></div>
                <div style="font-size: 12px;">
                    108 Denver Trail, Azle,<br />
                    TX 76020&nbsp;|&nbsp;<a onclick="mapdisplay1(32.8810830,-97.53327399999999,'Texas Health Azle','108 Denver Trail, Azle,TX 76020');"
                        href="#basic_map" data-transition='slide'>Map</a><span id="Span3">&nbsp;|&nbsp;<a onclick="mapdisplay1(32.8810830,-97.53327399999999,'Texas Health Azle','108 Denver Trail, Azle,TX 76020');"
                            href="#directions_map" data-transition='slide'>Direction</a></span><br />
                    Ph: <a href="tel:(817)444-8600">(817)444-8600</a></div>
            </div>
            <div style="height: 5px;">
            </div>
            <div class="odd">
                <div style="font-size: 13px;">
                    <strong>Texas Health Burleson</strong></div>
                <div style="font-size: 12px;">
                    2750 S.W. Wilshire Blvd., Burleson,<br />
                    TX 76028&nbsp;|&nbsp;<a onclick="mapdisplay1(32.49772340,-97.36788559999999,'Texas Health Burleson','2750 S.W. Wilshire Blvd., BurlesonTX 76028');"
                        href="#basic_map" data-transition='slide'>Map</a> <span id="Span4">&nbsp;|&nbsp;<a onclick="mapdisplay1(32.49772340,-97.36788559999999,'Texas Health Burleson','2750 S.W. Wilshire Blvd., BurlesonTX 76028');"
                            href="#directions_map" data-transition='slide'>Direction</a></span><br />
                    Ph: <a href="tel:(817)782-8000">(817) 782-8000</a></div>
            </div>
            <div style="height: 5px;">
            </div>
            <div class="even">
                <div style="font-size: 13px;">
                    <strong>Texas Health Cleburne</strong></div>
                <div style="font-size: 12px;">
                    201 Walls Drive, Cleburne,<br />
                    TX 76033&nbsp;|&nbsp;<a onclick="mapdisplay1(32.33346830 , -97.43662080'Texas Health Cleburne','201 Walls Drive, Cleburne,TX 76033');"
                        href="#basic_map" data-transition='slide'>Map</a><span id="Span5">&nbsp;|&nbsp;<a onclick="mapdisplay1(32.33346830 , -97.43662080'Texas Health Cleburne','201 Walls Drive, Cleburne,TX 76033');"
                            href="#directions_map" data-transition='slide'>Direction</a></span><br />
                    Ph: <a href="tel:(817)641-2551">(817)641-2551</a></div>
            </div>
            <div style="height: 5px;">
            </div>
            <div class="odd">
                <div style="font-size: 13px;">
                    <strong>Texas Health Craig</strong></div>
                <div style="font-size: 12px;">
                    Ranch 7850 Collin McKinney Parkway, McKinney,
                    <br />
                    TX 75070&nbsp;|&nbsp;<a onclick="mapdisplay1(33.1429720,-96.71657990,'Texas Health Craig','Ranch 7850 Collin McKinney Parkway McKinney,TX 75070');"
                        href="#basic_map" data-transition='slide'>Map</a><span id="Span6"> &nbsp;|&nbsp;<a onclick="mapdisplay1(33.1429720,-96.71657990,'Texas Health Craig','Ranch 7850 Collin McKinney Parkway McKinney,TX 75070');"
                            href="#directions_map" data-transition='slide'>Direction</a></span>
                    <br />
                    Ph: <a href="tel:(469)854-8989">(469)854-8989</a></div>
            </div>
            <div style="height: 5px;">
            </div>
            <div class="even">
                <div style="font-size: 13px;">
                    <strong>Texas Health Dallas</strong></div>
                <div style="font-size: 12px;">
                    8200 Walnut Hill Lane, Dallas,<br />
                    TX 75231&nbsp;|&nbsp;<a onclick="mapdisplay1(32.8807580,-96.76225699999999,'Texas Health Dallas','8200 Walnut Hill Lane Dallas, TX, 75231');"
                        href="#basic_map" data-transition='slide'>Map</a><span id="Span7"> &nbsp;|&nbsp;<a onclick="mapdisplay1(32.8807580,-96.76225699999999,'Texas Health Dallas','8200 Walnut Hill Lane Dallas, TX, 75231');"
                            href="#directions_map" data-transition='slide'>Direction</a></span>
                    <br />
                    Ph: <a href="tel:(214)345-6789">(214)345-6789</a></div>
            </div>
            <div style="height: 5px;">
            </div>
            <div class="odd">
                <div style="font-size: 13px;">
                    <strong>Texas Health Denton</strong></div>
                <div style="font-size: 12px;">
                    3000 North I-35, Denton,
                    <br />
                    TX 76201&nbsp;|&nbsp;<a onclick="mapdisplay1( 33.2171650,-97.16715599999999,'Texas Health Denton','3000 North I-35 Denton, TX, 76201');"
                        href="#basic_map" data-transition='slide'>Map</a> <span id="Span8">&nbsp;|&nbsp;<a onclick="mapdisplay1( 33.2171650,-97.16715599999999,'Texas Health Denton','3000 North I-35 Denton, TX, 76201');"
                            href="#directions_map" data-transition='slide'>Direction</a></span>
                    <br />
                    Ph: <a href="tel:(940) 898-7000">(940) 898-7000</a></div>
            </div>
            <div style="height: 5px;">
            </div>
            <div class="even">
                <div style="font-size: 13px;">
                    <strong>Texas Health Fort Worth</strong></div>
                <div style="font-size: 12px;">
                    1301 Pennsylvania Avenue, Fort Worth,<br />
                    TX 76104&nbsp;|&nbsp;<a onclick="mapdisplay1(32.73778990,-97.3389760,'Texas Health Fort Worth','1301 Pennsylvania Avenue Fort Worth, TX, 76104');"
                        href="#basic_map" data-transition='slide'>Map</a> <span id="Span9">&nbsp;|&nbsp;<a onclick="mapdisplay1(32.73778990,-97.3389760,'Texas Health Fort Worth','1301 Pennsylvania Avenue Fort Worth, TX, 76104');"
                            href="#directions_map" data-transition='slide'>Direction</a></span><br />
                    Ph: <a href="tel:(817)250-2000">(817)250-2000</a></div>
            </div>
            <div style="height: 5px;">
            </div>
            <div class="odd">
                <div style="font-size: 13px;">
                    <strong>Texas Health Hurst-Euless-Bedford</strong></div>
                <div style="font-size: 12px;">
                    1600 Hospital Parkway, Bedford,
                    <br />
                    TX 76022&nbsp;|&nbsp;<a onclick="mapdisplay(32.83478610,-97.12427970,'Texas Health Hurst-Euless-Bedford','1600 Hospital Parkway Bedford, TX, 76022');"
                        href="#basic_map" data-transition='slide'>Map</a><span id="Span10"> &nbsp;|&nbsp;<a onclick="mapdisplay(32.83478610,-97.12427970,'Texas Health Hurst-Euless-Bedford','1600 Hospital Parkway Bedford, TX, 76022');"
                            href="#directions_map" data-transition='slide'>Direction</a></span><br />
                    Ph:<a href="tel:(817)848-4000">(817)848-4000</a>
                </div>
            </div>
            <div style="height: 5px;">
            </div>
            <div class="even">
                <div style="font-size: 13px;">
                    <strong>Texas Health Kaufman</strong></div>
                <div style="font-size: 12px;">
                    850 Ed Hall Drive, Kaufman,<br />
                    TX 75142&nbsp;|&nbsp;<a onclick="mapdisplay(32.5908330,-96.31473899999999,'Texas Health Kaufman','850 Ed Hall Drive Kaufman, TX, 75142');"
                        href="#basic_map" data-transition='slide'>Map</a><span id="Span11"> &nbsp;|&nbsp;<a onclick="mapdisplay(32.5908330,-96.31473899999999,'Texas Health Kaufman','850 Ed Hall Drive Kaufman, TX, 75142');"
                            href="#directions_map" data-transition='slide'>Direction</a></span>
                    <br />
                    Ph: <a href="tel:(972) 932-7200">(972) 932-7200</a></div>
            </div>
            <div style="height: 5px;">
            </div>
            <div class="odd">
                <div style="font-size: 13px;">
                    <strong>Texas Health Plano </strong>
                </div>
                <div style="font-size: 12px;">
                    6200 West Parker Road, Plano,<br />
                    TX 75093&nbsp;|&nbsp;<a onclick="mapdisplay(33.04404900000001,-96.8385320,'Texas Health Plano','6200 West Parker Road Plano, TX, 75093');"
                        href="#basic_map" data-transition='slide'>Map</a> <span id="Span12">&nbsp;|&nbsp;<a onclick="mapdisplay(33.04404900000001,-96.8385320,'Texas Health Plano','6200 West Parker Road Plano, TX, 75093');"
                            href="#directions_map" data-transition='slide'>Direction</a><br />
                    Ph: <a href="(972)981-8000">(972)981-8000</a></div>
            </div>
            <div style="height: 5px;">
            </div>
            <div class="even">
                <div style="font-size: 13px;">
                    <strong>Texas Health Southwest Fort Worth</strong></div>
                <div style="font-size: 12px;">
                    6100 Harris Parkway, Fort Worth,<br />
                    TX 76132&nbsp;|&nbsp;<a onclick="mapdisplay(32.65817890,-97.4207770,'Texas Health Southwest Fort Worth','6100 Harris Parkway Fort Worth, TX, 76132');"
                        href="#basic_map" data-transition='slide'>Map</a><span id="Span13">&nbsp;|&nbsp;<a onclick="mapdisplay(32.65817890,-97.4207770,'Texas Health Southwest Fort Worth','6100 Harris Parkway Fort Worth, TX, 76132');"
                            href="#directions_map" data-transition='slide'>Direction</a></span><br />
                    Ph: <a href="tel:(817)433-5000">(817)433-5000</a>(817) 433-5000</div>
            </div>
            <div style="height: 5px;">
            </div>
            <div class="odd">
                <div style="font-size: 13px;">
                    <strong>Texas Health Specialty Hospital</strong></div>
                <div style="font-size: 12px;">
                    1301 Pennsylvania Avenue, Fort Worth,
                    <br />
                    TX 76104&nbsp;|&nbsp;<a onclick="mapdisplay( 32.73778990,-97.3389760,'Texas Health Specialty Hospital','1301 Pennsylvania Avenue Fort Worth, TX, 76104');"
                        href="#basic_map" data-transition='slide'>Map</a> <span id="Span14">&nbsp;|&nbsp;<a onclick="mapdisplay( 32.73778990,-97.3389760,'Texas Health Specialty Hospital','1301 Pennsylvania Avenue Fort Worth, TX, 76104');"
                            href="#directions_map" data-transition='slide'>Direction</a></span>
                    <br />
                    Ph:<a href="tel:(817)250-5500">(817)250-5500</a> (817) 250-5500</div>
            </div>
            <div style="height: 5px;">
            </div>
            <div class="even">
                <div style="font-size: 13px;">
                    <strong>Texas Health Stephenville </strong>
                </div>
                <div style="font-size: 12px;">
                    411 North Belknap, Stephenville,<br />
                    TX 76401&nbsp;|&nbsp;<a onclick="mapdisplay(32.22218730, -98.20419899999999,'Texas Health Stephenville','411 North Belknap Stephenville, TX, 76401');"
                        href="#basic_map" data-transition='slide'>Map</a><span id="Span15"> &nbsp;|&nbsp;<a onclick="mapdisplay(32.22218730, -98.20419899999999,'Texas Health Stephenville','411 North Belknap Stephenville, TX, 76401');"
                            href="#directions_map" data-transition='slide'>Direction</a></span>
                    <br />
                    Ph: <a href="tel:(254)965-1500">(254)965-1500</a></div>
            </div>
        </div>
    </div>
    <div data-role="page" id="page6">
        <div class="heading" style="background: url(images/backgroundinner.png) repeat-x;
            position: fixed; width: 100%;">
            <div align="center" style="height: 70px;">
                <a href="javascript:backfunction()" data-icon="arrow-l" data-iconpos="notext" data-transition="slide">
                    <img src="includes/images/back.png" style="position: absolute; height: 30px; width: 30px;
                        top: 20px; left: 15px;" />
                </a><a href="#Div1" style="text-decoration: none;" data-transition="slide">
                    <img alt="mainbanner" style="height: 70px;" src="images/innerbanner.png" />
                </a>
            </div>
            <div data-role="navbar" style="margin: 0px; padding: 0px;">
                <ul>
                    <li style="border: none;"><a href="#" class="ui-btn-active ui-state-persist" style="border: none;">
                        Physicians</a></li>
                    <li style="border: none;"><a id="btnallmap" href="#allmap" data-transition="slide"
                        style="border: none;">Map</a></li>
                </ul>
            </div>
        </div>
        <div style="height: 104px;">
        </div>
        <div data-role="content" style="text-align: center; text-align: left;">
            
            <div id="refind1" align="center" style="padding-bottom: 8px; font-size: 12px; display: none;">
                <a data-transition="slide" href="#" style="text-decoration: underline;" onclick="backfunction();">
                    Too many records found, Refine your search</a></div>
            <div style="text-align: left;" id="doctordetails">
            </div>
            <div align="center" style="display: none;" id="pager">
            </div>
            <div id="refind" align="center" style="padding-top: 5px; font-size: 12px; display: none;">
                <a data-transition="slide" href="#" style="text-decoration: underline;" onclick="backfunction();">
                    Too many records found, Refine your search</a></div>
        </div>
    </div>
    <div data-role="page" id="AdvanceSearch">
        <div class="heading" style="background: url(images/backgroundinner.png) repeat-x;">
            <div align="center" style="height: 70px;">
                <a href="javascript:backfunction()" data-icon="arrow-l" data-iconpos="notext" data-transition="slide">
                    <img src="includes/images/back.png" style="position: absolute; height: 30px; width: 30px;
                        top: 20px; left: 15px;" />
                </a><a href="#Div1" style="text-decoration: none;" data-transition="slide">
                    <img alt="mainbanner" style="height: 70px;" src="images/innerbanner.png" />
                </a>
            </div>
        </div>
        <div data-role="content">
            <div align="center">
                <span style="font-size: 15px; color: Gray"><strong>Advanced Search </strong></span>
            </div>
            <div id="norecordfoundforadvansearch" style="color: Red; font-size: 11px;">
            </div>
            <div>
                Medical Degree</div>
            <select id="degree" name="degree" data-theme="d">
                <option value="">-select-</option>
                <option>MD</option>
                <option>DO</option>
                <option>DPM</option>
                <option>DDS</option>
                <option>DMD</option>
                <option>DDS, MD</option>
                <option>DO, PhD</option>
                <option>MD, MPH</option>
                <option>MD, PhD</option>
            </select>
            <div>
                Gender:</div>
            <fieldset data-role="controlgroup" data-type="horizontal" data-role="fieldcontain">
                <input type="radio" name="gender" id="male" value="Male" />
                <label for="male">
                    Male</label>
                <input type="radio" name="gender" id="female" value="Female" />
                <label for="female">
                    Female</label>
            </fieldset>
            <div>
                Age Between</div>
            <div class="ui-grid-c">
                <div class="ui-block-a" style="padding-right: 10px;">
                    Min<input id="agemin" name="agemin" type="text" value=""></div>
                <div class="ui-block-b">
                    Max<input id="agemax" name="agemax" type="text" value=""></div>
            </div>
            <div id="errormsgforage" style="color: Red; font-size: 10px; padding-left: 6px;">
            </div>
            <div>
                Language</div>
            <select id="lang" name="lang" data-theme="d">
            </select>
            <div>
                Insurance Accepted</div>
            <select id="insurance" name="insurance" data-theme="d">
            </select>
            <div>
                Same Day Appointment</div>
            <fieldset data-role="controlgroup" data-type="horizontal" data-role="fieldcontain">
                <input type="radio" name="sameday" id="samedayno" value="F" />
                <label for="samedayno">
                    No</label>
                <input type="radio" name="sameday" id="samedayyes" value="T" />
                <label for="samedayyes">
                    Yes</label>
            </fieldset>
            <div>
                Hospital Affiliation</div>
            <select id="hospaffil" name="hospaffil" data-theme="d">
            </select>
            <div>
                <label for="apptavail">
                    Appointment Availability</label></div>
            <input type="range" name="apptavail" id="apptavail" value="" min="0" max="30" step="1" /><br />
            <a id="btnAdvanceSearch" data-role="button" data-transition="fade" data-theme="a"
                href="#page6" data-transition='slide'>Search Near Me </a>
        </div>
    </div>
    <div data-role="page" id="aboutus">
        <div class="heading" style="background: url(images/backgroundinner.png) repeat-x;">
            <div align="center" style="height: 70px;">
                <a href="javascript:backfunction()" data-icon="arrow-l" data-iconpos="notext" data-transition="slide">
                    <img src="includes/images/back.png" style="position: absolute; height: 30px; width: 30px;
                        top: 20px; left: 15px;" />
                </a><a href="#Div1" style="text-decoration: none;" data-transition="slide">
                    <img alt="mainbanner" style="height: 70px;" src="images/innerbanner.png" />
                </a>
            </div>
        </div>
        <div class="ui-body ui-body-d">
            <h2>
                About</h2>
            <div class="icon">
                <h5>
                    About Texas Health Resources</h5>
                <p>
                    <img src="images/32-iphone.png" alt="iphone" />
                    <small>Texas Health Resources is one of the largest faith-based, nonprofit health care
                        delivery systems in the United States and the largest in North Texas in terms of
                        patients served. The system's primary service area consists of 16 counties in north
                        central Texas, home to more than 6.2 million people. </small>
                </p>
            </div>
            <div data-role="collapsible" data-collapsed="true" data-content-theme="d" data-theme="b">
                <h5>
                    Founded in 1997</h5>
                <div class="icon">
                    <p>
                        <img src="images/137-presentation.fw.png" alt="presentation" />
                        <small>Texas Health was formed in 1997 with the assets of Fort Worth-based Harris Methodist
                            Health System and Dallas-based Presbyterian Healthcare Resources. Later that year,
                            Arlington Memorial Hospital joined the Texas Health system. </small>
                    </p>
                </div>
            </div>
            <div data-role="collapsible" data-collapsed="true" data-content-theme="d" data-theme="b"
                id="about-list1">
                <div class="icon">
                    <h5>
                        Healing Hands.Caring Hearts</h5>
                    <p>
                        <img src="images/hh.fw.png" alt="Healing Hands" />
                        <small>Texas Health has 25 acute-care and short-stay hospitals that are owned, operated,
                            joint-ventured or affiliated with the system. It has more than 3,800 licensed beds,
                            more than 21,100 employees of fully-owned/operated facilities plus 1,400 employees
                            of consolidated joint ventures, and counts more than 5,500 physicians* with active
                            staff privileges at its hospitals. </small>
                    </p>
                </div>
            </div>
            <div data-role="collapsible" data-collapsed="true" data-content-theme="d" data-theme="b"
                id="about-list2">
                <h3>
                    Mission, Vision and Values</h3>
                <p style="font-weight: bold">
                    Mission</p>
                To improve the health of the people in the communities we serve.
                <p style="font-weight: bold">
                    Values Vision</p>
                Texas Health Resources, a faith-based organization joining with physicians, will
                be the health care system of choice.
                <p style="font-weight: bold">
                    Values Respect</p>
                Respecting the dignity of all persons, fostering a corporate culture characterized
                by teamwork, diversity and empowerment.
                <p style="font-weight: bold">
                    Integrity</p>
                Conduct our corporate and personal lives with integrity; Relationships based on
                loyalty, fairness, truthfulness and trustworthiness.
                <p style="font-weight: bold">
                    Compassion</p>
                Sensitivity to the whole person, reflective of God's compassion and love, with particular
                concern for the poor.
                <p style="font-weight: bold">
                    Excellence</p>
                Continuously improving the quality of our service through education, research, competent
                and innovative personnel, effective leadership and responsible stewardship of resources.
                <p style="font-weight: bold">
                    Diversity Statement</p>
                We will provide and maintain a fair and equitable environment for all by valuing
                and respecting individual differences for our enrichment and that of the communities
                we serve. </p>
            </div>
            <div data-role="collapsible" data-collapsed="true" data-content-theme="d" data-theme="b">
                <h3>
                    Resources Data</h3>
                <p style="font-weight: bold">
                    Texas Health Resources Data</p>
                <p>
                    &#8226;21,100 employees of fully-owned/operated facilities plus 1,400 employees
                    of consolidated joint ventures
                </p>
                <p>
                    &#8226;More than 5,500 physicians* with staff privileges
                </p>
                <p>
                    &#8226;25 acute-care, transitional, rehabilitation and short-stay hospitals
                </p>
                <p>
                    &#8226;18 outpatient facilities and more than 250 other community access points
                </p>
                <p>
                    &#8226;More than 3,800 licensed hospital beds
                </p>
                <p>
                    &#8226;Tobacco-Free Policy</p>
                All campuses in the Texas Health Resources family of hospitals are tobacco-free.
                This policy applies to all patients, employees, visitors and physicians on the medical
                staff.
                <p style="font-weight: bold">
                    Corporate Office</p>
                <p>
                    Your questions, comments or requests for more information are always welcome.</p>
                Texas Health Resources<br>
                612 E. Lamar Boulevard<br>
                Arlington, TX 76011 682-236-7900
            </div>
        </div>
    </div>
    <div data-role="page" id="news">
        <div class="heading" style="background: url(images/backgroundinner.png) repeat-x;">
            <div align="center" style="height: 70px;">
                <a href="javascript:backfunction()" data-icon="arrow-l" data-iconpos="notext" data-transition="slide">
                    <img src="includes/images/back.png" style="position: absolute; height: 30px; width: 30px;
                        top: 20px; left: 15px;" />
                </a><a href="#Div1" style="text-decoration: none;" data-transition="slide">
                    <img alt="mainbanner" style="height: 70px;" src="images/innerbanner.png" />
                </a>
            </div>
        </div>
        <div data-role="content">
            <br />
            <span style="font-size: 25px; color: Gray">News</span><br />
            <span style="font-size: 15px; color: Gray">User can access online newsroom, to read
                and learn more about THR. User can subscribe to a news feed.
                <br />
            </span>
            <br />
            <a href="#">News Releases</a>
            <div style="font-size: 13px;">
                Read, search or subscribe to News Releases generated by the Texas Health Public
                Relations staff.
            </div>
            <br />
            <strong>
                <img alt="rss" class="style1" src="images/rss.png" /><span style="font-size: 14px;
                    color: Gray"> RSS feed </span></strong>
            <br />
            <br />
            <a href="#">'The Business of Healthcare Report'</a>
            <div style="font-size: 13px;">
                Read, listen or subscribe to The Business of Healthcare Report with Texas Health
                CEO Doug Hawthorne, broadcast weekly on NewsRadio 1080, KRLD.
            </div>
            <strong>
                <img alt="rss" class="style1" src="images/rss.png" />
                <span style="font-size: 14px; color: Gray">RSS feed </span>
                <br />
            </strong>
            <br />
            <a href="#">Texas Health in the News</a>
            <div style="font-size: 13px;">
                Browse or search a comprehensive collection of links and descriptions about the
                accomplishments of Texas Health Resources, as reported by local, state and national
                news media outlets.
            </div>
            <strong>
                <img alt="rss" class="style1" src="images/rss.png" />
                <span style="font-size: 14px; color: Gray">RSS feed </span></strong>
        </div>
    </div>
    <div data-role="page" id="map">
        <div class="heading" style="background: url(images/backgroundinner.png) repeat-x;">
            <div align="center" style="height: 70px;">
                <a href="#Div1" style="text-decoration: none;"><a href="javascript:backfunction()"
                    data-icon="arrow-l" data-iconpos="notext">
                    <img src="images/button_back.png" style="padding-bottom: 20px;" /></a>
                    <img alt="mainbanner" style="height: 70px;" src="images/innerbanner.png" /></a>
            </div>
        </div>
        <div data-role="content" style="font-size: 12px;">
            <br />
            <div id="imgmap">
            </div>
        </div>
    </div>
    <div id="basic_map" data-role="page">
        <div class="heading" style="background: url(images/backgroundinner.png) repeat-x;">
            <div align="center" style="height: 70px;">
                <a href="javascript:backfunction()" data-icon="arrow-l" data-iconpos="notext" data-transition="slide">
                    <img src="includes/images/back.png" style="position: absolute; height: 30px; width: 30px;
                        top: 20px; left: 15px;" />
                </a><a href="#Div1" style="text-decoration: none;" data-transition="slide">
                    <img alt="mainbanner" style="height: 70px;" src="images/innerbanner.png" />
                </a>
            </div>
        </div>
        <div data-role="content" style="margin: 0px; padding: 0px;">
            <div>
                <div id="map_canvas" style="margin: 0; width: 100%; height: 85%; position: absolute;
                    vertical-align: center;">
                </div>
            </div>
        </div>
    </div>
    <div data-role="page" id="details">
        <div class="heading" style="background: url(images/backgroundinner.png) repeat-x;">
            <div align="center" style="height: 70px;">
                <a href="javascript:backfunction()" data-icon="arrow-l" data-iconpos="notext" data-transition="slide">
                    <img src="includes/images/back.png" style="position: absolute; height: 30px; width: 30px;
                        top: 20px; left: 15px;" />
                </a><a href="#Div1" style="text-decoration: none;" data-transition="slide">
                    <img alt="mainbanner" style="height: 70px;" src="images/innerbanner.png" />
                </a>
            </div>
        </div>
        <div data-role="content" style="font-size: 11px;">
            <div style="height: 3px;">
            </div>
            <div>
                <span id="dispname" style="font-size: 16px; color: Gray;"></span>
            </div>
            <div id="dispdetails" style="font-size: 11px;">
                <%-- <table border="0" cellpadding="5px" cellspacing="0">
                    <tr>
                        <td align="left" style="vertical-align: top;">
                            <strong>Address :</strong>
                        </td>
                        <td id="dispaddress">
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <strong>Zip Code :</strong>
                        </td>
                        <td id="dispzipcode">
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <strong>City :</strong>
                        </td>
                        <td id="dispcity">
                        </td>
                    </tr>
                    <tr id="trdistance">
                        <td align="left">
                            <strong>Distance :</strong>
                        </td>
                        <td id="dispdistance">
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <span><a href="#basic_map">Map</a></span>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <strong>Phone :</strong>
                        </td>
                        <td id="dispphoneno">
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <strong>Fax :</strong>
                        </td>
                        <td id="dispfax">
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <strong>Age :</strong>
                        </td>
                        <td id="dispage">
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <strong>Gender :</strong>
                        </td>
                        <td id="dispgender">
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <strong>Specialties :</strong>
                        </td>
                        <td id="dispspecility">
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <strong>Board Certification :</strong>
                        </td>
                        <td id="dispcertify">
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <strong>Same Day Appointment? :</strong>
                        </td>
                        <td id="dispsameday">
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <strong>Primary Hospital :</strong>
                        </td>
                        <td id="disphospital1">
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <strong>Secondary Hospital :</strong>
                        </td>
                        <td id="disphospital2">
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <strong>Practice Type :</strong>
                        </td>
                        <td id="disppracticetype">
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <strong>Website :</strong>
                        </td>
                        <td id="dispemail">
                        </td>
                    </tr>
                </table>--%>
            </div>
            <div style="padding-bottom: 2px; padding-top: 5px;">
                (Please contact this physician to determine whether he or she is accepting new patients.)
            </div>
        </div>
    </div>
    <div id="directions_map" data-role="page">
        <div class="heading" style="background: url(images/backgroundinner.png) repeat-x;">
            <div align="center" style="height: 70px;">
                <a href="javascript:backfunction()" data-icon="arrow-l" data-iconpos="notext" data-transition="slide">
                    <img src="includes/images/back.png" style="position: absolute; height: 30px; width: 30px;
                        top: 20px; left: 15px;" />
                </a><a href="#Div1" style="text-decoration: none;" data-transition="slide">
                    <img alt="mainbanner" style="height: 70px;" src="images/innerbanner.png" />
                </a>
            </div>
        </div>
        <div data-role="content" style="margin: 0px; padding: 0px;">
            <div>
                <div id="map_canvas_1" style="margin: 0; width: 100%; height: 85%; position: absolute;
                    vertical-align: center;">
                </div>
            </div>
        </div>
    </div>
    <div id="allmap" data-role="page">
        <div class="heading" style="background: url(images/backgroundinner.png) repeat-x;">
            <div align="center" style="height: 70px;">
                <a href="javascript:backfunction()" data-icon="arrow-l" data-iconpos="notext" data-transition="slide">
                    <img src="includes/images/back.png" style="position: absolute; height: 30px; width: 30px;
                        top: 20px; left: 15px;" />
                </a><a href="#Div1" style="text-decoration: none;" data-transition="slide">
                    <img alt="mainbanner" style="height: 70px;" src="images/innerbanner.png" />
                </a>
            </div>
        </div>
        <div data-role="content" style="margin: 0px; padding: 0px;">
            <div>
                <div id="allmap_canvas" style="margin: 0; width: 100%; height: 85%; position: absolute;
                    vertical-align: center;">
                </div>
                <div align="center" id="maplodingimgid" class="fullscreen" style="height: 90%; margin-top: 75px;
                    display: none; width: 100%; background: white; color: white">
                    <img src="images/mainl.gif" style="padding-top: 150px;" height="40px" width="40px" />
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<%--   <ul data-role="listview">
			<li style=" border:none;font-size:14px;" >Specility: <span style="font-size:12px; font-style:normal;" id="dispspecility"></span></li>
            <div style="height:20px;"></div>
				<li  style=" border:none; font-size:14px;">Address: <span  style="font-size:12px; font-style:normal;" id="dispaddress"></span> </li>
                <div style="height:20px;"></div>
				<li  style=" border:none;font-size:14px;">Call: <span  style="font-size:12px; font-style:normal;" id="dispphone"></span> </li>
                 <div style="height:20px;"></div>
				<li  style=" border:none;font-size:14px;">Get Direction <span class="ui-li-count">></span></li>
                 <div style="height:20px;"></div>
				<li  style=" border:none;font-size:14px;">Notes <span class="ui-li-count">></span></li>
                <div style="height:20px;"></div>
                <li  style=" border:none;"><div class="ui-grid-a" style="font-size:14px;">
	<div class="ui-block-a">Add to Contact <span class="ui-li-count">></span></div>
	<div class="ui-block-b">view <span class="ui-li-count">></span></div></div>
    </li>
		</ul>--%>