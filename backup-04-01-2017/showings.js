/* 
 * It will have all js functionality related to showings
 */
//$.jMaskGlobals.watchDataMask = true;

$(".cpointer  ").css("cursor", "pointer");
$(function () {

  if (0 < ($('#showings_list')).length) {

    var selector = '#showings_list', postUrl = "/showings/list";
       // var totalCost = data.additional_fee + data.list_price ;


       var dtCols = [
       {"data": "id", "visible":false, "searchable": false,
       "orderable": false },
       {"title": "Posting Agent", "data": "user_name"},
       {"title": "Showing Date", "data": "post_date"},
       {"title": "Start Time", "data": "start_time"},
       {"title": "End Time", "data": "end_time"},

       {"title": "Amount", "data": "list_price", "searchable": false},

       {"title": "Showings", "data": "house_count", "searchable": false,
       "orderable": false},
       {"title": "", "data": "id",
       "render": function (data, type, row, meta) {


        var editIcon = '<a onclick="viewShowing(' + data + ')"' +
        ' title="View"><i class="fa' +
        ' fa-eye fa-2x text-green"></i></a>';
        return editIcon;
      }, "searchable": false, "orderable": false
    }
    ];

    showingsDataTable = bindDatatable(selector, postUrl, dtCols);
    new $.fn.dataTable.ColReorder(showingsDataTable);
  }

  if ($('#dv_postShowing').is(':visible')) {
        // code to show datepicker (jQuery)
        var today = new Date();
        var tomorrow = new Date();
        tomorrow.setDate(today.getDate() );
        $(".date-picker").datepicker({
          minDate: tomorrow,
          showButtonPanel: true,
          changeMonth: true,
          changeYear: true,
          dateFormat: 'mm/dd/yy',
          onSelect: function(dateText, inst) {
            if ('' !== dateText) {
              var elem = $(this).attr('name');

              $('#frm_postShowingForm')
                        // Get the bootstrapValidator instance
                        .data('bootstrapValidator')
                        // Mark the field as not validated, so it'll be re-validated when the user change date
                        .updateStatus(elem, 'NOT_VALIDATED', null)
                        // Validate the field
                        .validateField(elem);
                      }
                    }
                  });

        // code to show datetimepicker (bootstrap datetimepicker)
        $('.date-time-picker').datetimepicker({
           // format: 'h:00:00',

           format: "HH:00:00 P",
           showMeridian: true,
           pickDate: false,
           startView: 1,
           minView: 2,
           maxView: 1,
           autoclose: true,
           todayBtn: false
         }).on("show", function(ev) {
          $(".glyphicon-arrow-left").css('visibility', 'hidden');
          $(".glyphicon-arrow-right").css('visibility', 'hidden');
          $(".table-condensed .next").css('visibility', 'hidden');
          $(".table-condensed .prev").css('visibility', 'hidden');

          var showingDate = $.trim($('#post_date').val());

      
      if(0 < showingDate.length) {
        var showingDateObj = showingDate.split("/");

                //var timeStr = $.trim(showingDateObj[2] + "-" + showingDateObj[0] + "-" + showingDateObj[1]+ " "+ $(this).val());
                var timeStr = $.trim(showingDateObj[2] + "-" + showingDateObj[0] + "-" + showingDateObj[1]);
         
          var currentDate = $.datepicker.formatDate('yy-mm-dd', new Date());

          var d = new Date(timeStr);
          var date = new Date();
          d.setHours(date.getHours()+2);
          d.setMinutes(date.getMinutes());
         
          if(timeStr==currentDate){

             if(d.getMinutes() >40){
              d.setHours(date.getHours()+3);
              
            }
            $(this).datetimepicker("update", d);
            $(".table-condensed .hour ").addClass("disabled");
            $(".table-condensed .hour ").css("cursor", "not-allowed");
            $(".table-condensed .hour .active").css("cursor", "pointer");
            $(".table-condensed .hour .active").removeClass("disabled");
            $(".table-condensed .hour .active").nextAll().css("cursor", "pointer");
            $(".table-condensed .hour .active").nextAll().removeClass("disabled"); 


          }else{

           $(this).datetimepicker("update", timeStr);  

         }


       }
     });

        // on selecting date time picker, validate the field
        $(".date-time-picker").on("change.dp", function(e) {
          var elem = $(this).attr('name');

          $('#frm_postShowingForm')
                // Get the bootstrapValidator instance
                .data('bootstrapValidator')
                // Mark the field as not validated, so it'll be re-validated when the user change date
                .updateStatus(elem, 'NOT_VALIDATED', null)
                // Validate the field
                .validateField(elem);
              });

        // add the additional fee the user will pay to LMS agent
        $('#additional_fee').keyup(function() {
          var totalPayment = 0;
          var agentPayment = 0;
          var lmsPayment = 0;

          $('.showing-list-price').each(function() {
            var listPrice = $(this).val().match(/-?\d+\.?\d*/);

            if (null !== listPrice) {
              totalPayment = totalPayment + parseFloat(listPrice) + 15;
              agentPayment = agentPayment + parseFloat(listPrice);
            } else {
              totalPayment = totalPayment + 15;
            }

            lmsPayment = lmsPayment + 15;
          });

          var additionalFee = $(this).val().match(/-?\d+\.?\d*/);
          if (null !== additionalFee) {

            var newaddotionalAgent =  (additionalFee*80)/100;
            var newaddotionalLms =  (additionalFee*20)/100;

            lmsPayment = lmsPayment + parseFloat(newaddotionalLms);
            agentPayment = agentPayment + parseFloat(newaddotionalAgent);
            totalPayment = totalPayment + parseFloat(additionalFee);
          }

          $('#dd_totalPayment').html('$' + totalPayment);
          $('#dd_agentPayment').html('$' + agentPayment);
          $('#dd_lmsPayment').html('$' + lmsPayment);
        });

$('.showing-list-price').keyup(function() {
  changeListPrice();
});
}

if((0 < ($('#posted_showings_list')).length) ||
  (0 < ($('#accepted_showings_list')).length)) {
  var listUsersDtCols = [
{"data": "id", "visible": false, "searchable": false,
"orderable": false},
{"title": "Posting Agent", "data": "user_name"},
{"title": "Showing Date", "data": "post_date"},
{"title": "Start Time", "data": "start_time"},
{"title": "End Time", "data": "end_time"},
{"title": "Amount", "data": "list_price", "searchable": false},
{
  "title": "Showings",
  "data": "house_count",
  "searchable": false,
  "orderable": false
},
            // {"title": "", "data": "id",
            //     "render": function (data, type, row, meta) {
            //         var editIcon = '<a href="/showings/edit/' + data + '" title="Edit"><i class="fa' +
            //             ' fa-edit fa-2x text-green"></i></a>';
            //         return editIcon;
            //     }, "searchable": false, "orderable": false
            // }
            // {"title": "", "data": "id",
            //     "render": function (data, type, row, meta) {
            //         var deleteIcon = '<a onclick="deleteShowing(' + data + ')"' +
            //             ' title="Delete"><i class="fa' +
            //             ' fa-trash fa-2x text-red"></i></a>';
            //         return deleteIcon;
            //     }, "searchable": false, "orderable": false
            // }
            ];
                  if (0 < ($('#posted_showings_list')).length) {
              var listUsersPostUrl = '/showings/list-users/posted';

              listUsersDtCols[7] = {"title": "Status", "data": "id",
              "render": function (data, type, row, meta) {

               
                
                var rejected =row.rejected_id;
                var  showingUserId =row.showing_user_id;
                if(rejected && showingUserId == 0 || row.rejected_showing_agent_id == showingUserId ){
                      
                  var editIcon =  '<button style=" width:90%; background-color:#E7E6E6; border-color: #E7E6E6;color:red;cursor:not-allowed; "  type="button" title="Offer Declined" class="btn btn-xs btn-default"> Offer Declined </button>';
                }
                else{

                  if(row.showing_progress == 1){

                   var editIcon =  '<button style="width:90%; background-color:#A5A5A5 " type="button" onclick="acceptedUserData(' + row.showing_user_id + ','+data+')"' + 'title="Offer Submitted" class="btn btn-xs btn-default">Offer Submitted</button> ';

                 }
                 else if(row.showing_progress == 2){

                  var editIcon =  '<button style="width:90%;" type="button" onclick="viewAcceptedUserData(' + row.showing_user_id + ','+data+')"' + 'title="Approved" class="btn btn-xs btn-success">Approved</button>  ';


                }


                else if(row.showing_progress == 4){
                  var editIcon = '<button  style="width:90%; background-color:#A5A5A5 ; padding-left:5px" type="button"  onclick="blockOrReview(' + row.showing_user_id + ','+data+')"' + ' title="Review/Block" class="btn btn-xs btn-default">Review/Block</button>';
                 //  editIcon +=  '<button  style="cursor:not-allowed ;margin-top:-14px; width: 120px;" type="button" title="Payment undone" class="btn btn-xs btn-success">Payment Undone</button>';

               }

               else if(row.showing_progress == 5){
                var editIcon = '<button  style="width:90%;background-color:#A5A5A5; color:white ; cursor:not-allowed ; padding-left:5px" type="button" title="Payment on Hold" class="btn btn-xs btn-default">Payment on Hold</button>';


              }
              else if(row.showing_progress == 6){
               var editIcon =  '<button  style="width:90%; " type="button" onclick="viewCompleteShowings('+ data +')"' + '  title="Payment Done" class="btn btn-xs btn-success">Payment Done</button>';

             }
             else{
              var  editIcon = "";

            }

          }

          return editIcon;
        }, "searchable": "false", "orderable": false


          };

          listUsersDtCols[8] = {"title": "Actions", "data": "id",
          "render": function (data, type, row, meta) {
            var rejected =row.rejected_id;
            if(rejected){


              var  editIcon = '&nbsp<a href="/showings/edit/' + data + '" title="Edit"><i class="fa' +
              ' fa-edit fa-2x text-green"></i></a>';

            }
            else{


             var editIcon = '&nbsp<a href="/showings/edit/' + data + '" title="Edit"><i class="fa' +
             ' fa-edit fa-2x text-green"></i></a>';

           }

           return editIcon;
         }, "searchable": "false", "orderable": false


       };



       var postedShowingsDataTable = bindDatatable('#posted_showings_list', listUsersPostUrl, listUsersDtCols);
     }

     //        if (0 < ($('#block_showings_list')).length) {
     //          var listUsersPostUrl = '/showings/list-users/block';

     //          listUsersDtCols[7] = {"title": "Actions", "data": "id",
     //          "render": function (data, type, row, meta) {    
     //          var editIcon = '<button onclick="blockOrReview(' + row.id + ')" style="width:90%; background-color:#A5A5A5 ;  padding-left:5px" type="button" title="Block / Review " class="btn btn-xs btn-default">Block / Review </button>';
              
     //      return editIcon;
     //    }, "searchable": "false", "orderable": false


     //      };

     //   var postedShowingsDataTable = bindDatatable('#block_showings_list', listUsersPostUrl, listUsersDtCols);
     // }



     if (0 < ($('#accepted_showings_list')).length) {
      var listUsersPostUrl = '/showings/list-users/accepted';
      listUsersDtCols[7] = {"title": "Status", "data": "id",
      "render": function (data, type, row, meta) {

      var rejected =row.rejected_id;
      var  showingUserId =row.showing_user_id;
      
      if(rejected && showingUserId == 0 || currentUserId == row.rejected_showing_agent_id ){

          var editIcon =  '<button style="width:90%;background-color:#E7E6E6 ;border-color: #E7E6E6;color:red; ;cursor:not-allowed ;"  type="button" title="Offer Declined" class="btn btn-xs btn-danger">Offer Declined </button> ';

        }
        
        else{

          if(row.showing_progress == 1){
            var editIcon =  '<button style="width:90%;background-color:#A5A5A5;cursor:not-allowed " type="button"  title="Offer Submitted" class="btn btn-xs btn-default"> Offer Submitted </button> ';

          }
          else if(row.showing_progress == 2){

           var currentDate = $.datepicker.formatDate('mm-dd-yy', new Date());
           if(row.post_date > currentDate  ){

             var editIcon = '<button style="width:90%; background-color:#E7E6E6; border-color: #E7E6E6; color:geen ;width: 120px; color:green" type="button" onclick="getFeedbackForm(' + data + ')"' + 'title="Offer Accepted" class="btn btn-xs btn-default"> Offer Accepted </button> ';
           }
           else{
            var editIcon =  '<button style="width:90%; background-color:#A5A5A5 " type="button" onclick="getFeedbackForm(' + data + ')"' + 'title="Complete Feedback" class="btn btn-xs btn-default"> Complete Feedback </button> ';
          }
        }

         else if(row.showing_progress == 4){

           var editIcon =  '<button style="width:90%; background-color:#A5A5A5 ;cursor:not-allowed;" style="margin-top:-14px;" type="button" title="Payment Pending" class="btn btn-xs btn-default">Payment Pending</button> ';
         }else if (row.showing_progress == 5){
          
          var editIcon =  '<button  style="width:90%;background-color:#A5A5A5 ; color:white "  type="button" onclick="paymentPendingPopup(' + row.showing_user_id + ','+data+')"' + ' title="Payment on Hold" class="btn btn-xs btn-default">Payment on Hold </button> ';

        }
        else {
          
          var editIcon =  '<button  style="width:90%; cursor:not-allowed ; "  type="button" title="Payment Recieved" class="btn btn-xs btn-success">Payment Recieved</button> ';

        }


      }


      return editIcon;
    }, "searchable": "false", "orderable": false
  };
  /* change for status*/
  listUsersDtCols[8] = {"title": "Actions", "data": "id",
  "render": function (data, type, row, meta) {

    var editIcon ="";
    var rejected =row.rejected_id;
    var rejected =row.rejected_id;
    var  showingUserId =row.showing_user_id;
      
    if(rejected && showingUserId == 0 || currentUserId == row.rejected_showing_agent_id ){

      editIcon += '<a style="cursor:pointer" onclick="viewShowingUserRejected(' + data + ')"' +
      ' title="View"><i class="fa' +
      ' fa-eye fa-2x text-green"></i></a>&nbsp&nbsp<i class="fa fa-ellipsis-v fa-2x " aria-hidden="true"></i>&nbsp&nbsp';

    }


    if(row.showing_progress == 2){
      editIcon += '<a style="cursor:pointer" onclick="viewShowingUser(' + data + ')"' +
      ' title="View"><i class="fa' +
      ' fa-eye fa-2x text-green"></i></a>&nbsp&nbsp<i class="fa fa-ellipsis-v fa-2x " aria-hidden="true"></i>&nbsp&nbsp';
    }
    if(row.showing_progress == 4){
      editIcon += '<a style="cursor:pointer" onclick="viewShowingUser(' + data + ')"' +
      ' title="View"><i class="fa' +
      ' fa-eye fa-2x text-green"></i></a>&nbsp&nbsp<i class="fa fa-ellipsis-v fa-2x " aria-hidden="true"></i>&nbsp&nbsp';
    }
    if(row.showing_progress == 5){
      editIcon += '<a style="cursor:pointer" onclick="viewShowingUser(' + data + ')"' +
      ' title="View"><i class="fa' +
      ' fa-eye fa-2x text-green"></i></a>&nbsp&nbsp<i class="fa fa-ellipsis-v fa-2x " aria-hidden="true"></i>&nbsp&nbsp';
    }

    if(row.showing_progress == 6){
      editIcon += '<a style="cursor:pointer" onclick="viewShowingUser(' + data + ')"' +
      ' title="View"><i class="fa' +
      ' fa-eye fa-2x text-green"></i></a>&nbsp&nbsp<i class="fa fa-ellipsis-v fa-2x " aria-hidden="true"></i>&nbsp&nbsp';
    }

    editIcon +='<a style="cursor:pointer"  onclick="deleteShowing(' + data + ')"' +
    ' title="Delete"><i class="fa' +
    ' fa-trash fa-2x text-red"></i></a>';



    return editIcon;
  }, "searchable": "false", "orderable": false
};

/*End change status*/



var postedShowingsDataTable = bindDatatable('#accepted_showings_list', listUsersPostUrl, listUsersDtCols);
}

/*new block by sandeep*/
if (0 < ($('#approved_showings_list_posted')).length) {
  var listUsersPostUrl = '/showings/list-users/accepted';
  listUsersDtCols[7] = {"title": "Actions", "data": "id",
  "render": function (data, type, row, meta) {
   var rejected =row.rejected_id;

   if(rejected){

    var editIcon =  '<button style="cursor:not-allowed;margin-top:-14px;width: 120px;" style="margin-top:-14px;" type="button" title="Showing rejected" class="btn btn-xs btn-danger">Showing rejected </button>&nbsp<i class="fa fa-ellipsis-v fa-2x " aria-hidden="true"></i>  ';

  }
  else{

    if(row.showing_progress == 2){

      var  editIcon = '&nbsp<a style="cursor:pointer" onclick="viewShowingUser(' + data + ')"' +
      ' title="View"><i class="fa' +
      ' fa-eye fa-2x text-green"></i></a>';

    }
  }



  return editIcon;
}, "searchable": "false", "orderable": false
};



listUsersDtCols[8] = {"title": "", "data": "id",
"render": function (data, type, row, meta) {

  var  editIcon = "";



  return editIcon;
}, "searchable": "false", "orderable": false
};




var postedShowingsDataTable = bindDatatable('#approved_showings_list_posted', listUsersPostUrl, listUsersDtCols);
}




if (0 < ($('#accepted_showings_list_posted')).length) {
  var listUsersPostUrl = '/showings/list-users/accepted';
  listUsersDtCols[7] = {"title": "Actions", "data": "id",
  "render": function (data, type, row, meta) {
   var rejected =row.rejected_id;

   if(rejected){

    var editIcon =  '<button style="cursor:not-allowed;margin-top:-14px;width: 120px;" style="margin-top:-14px;" type="button" title="Showing rejected" class="btn btn-xs btn-danger">Showing rejected </button>&nbsp<i class="fa fa-ellipsis-v fa-2x " aria-hidden="true"></i>  ';

  }
  else{

    if(row.showing_progress == 2){

      var  editIcon = '&nbsp<a style="cursor:pointer" onclick="viewShowingUser(' + data + ')"' +
      ' title="View"><i class="fa' +
      ' fa-eye fa-2x text-green"></i></a>';

    }
  }



  return editIcon;
}, "searchable": "false", "orderable": false
};
var postedShowingsDataTable = bindDatatable('#accepted_showings_list_posted', listUsersPostUrl, listUsersDtCols);
}

/*rejected list*/


if (0 < ($('#rejected_showings_list_posted')).length) {

  var listUsersPostUrl = '/showings/list-users/rejected';

  listUsersDtCols[7] = {"title": "Actions", "data": "id",
  "render": function (data, type, row, meta) {
   var rejected =row.rejected_id;

   if(rejected){

    var  editIcon = '&nbsp<a style="cursor:pointer" onclick="viewShowingUserRejected(' + data + ')"' +
    ' title="View"><i class="fa' +
    ' fa-eye fa-2x text-green"></i></a>';
  }

  return editIcon;
}, "searchable": "false", "orderable": false
};


listUsersDtCols[8] = {"title": "", "data": "id",
"render": function (data, type, row, meta) {
 var rejected =row.rejected_id;

 if(rejected){


  var  editIcon = "";
}



return editIcon;
}, "searchable": "false", "orderable": false
};






var postedShowingsDataTable = bindDatatable('#rejected_showings_list_posted', listUsersPostUrl, listUsersDtCols);
}


/* Completed showing for posting agent*/


if (0 < ($('#completed_showings_list_posted')).length) {
  var listUsersPostUrl = '/showings/list-users/completed';
  listUsersDtCols[8] = {"title": "Actions", "data": "id",
  "render": function (data, type, row, meta) {
   var rejected =row.rejected_id;

   if(rejected){

    var  editIcon = '&nbsp<a style="cursor:pointer" onclick="viewShowingUser(' + data + ')"' +
    ' title="View"><i class="fa' +
    ' fa-eye fa-2x text-green"></i></a>';
  }
  else {

   if(row.showing_progress == 4){
     var  editIcon = '&nbsp<a style="cursor:pointer" onclick="viewShowingUser(' + data + ')"' +
     ' title="View"><i class="fa' +
     ' fa-eye fa-2x text-green"></i></a>';
   }

   else if(row.showing_progress == 6){
     var  editIcon = '&nbsp<a  style="cursor:pointer ;" onclick="viewShowingUser(' + data + ')"' +
     ' title="View"><i class="fa' +
     ' fa-eye fa-2x text-green"></i></a>';


   }

 }
 return editIcon;
}, "searchable": "false", "orderable": false
};


listUsersDtCols[7] = {"title": "Status", "data": "id",
"render": function (data, type, row, meta) {

 if(row.showing_progress == 4){ 
  var  editIcon =  '<button ; style=" padding-left:5px;cursor:not-allowed ; width: 120px;" type="button" title="Payment undone" class="btn btn-xs btn-danger">Payment Undone</button>';

}


else if(row.showing_progress == 6){

  var editIcon =  '<button  style="cursor:not-allowed ; " type="button" title="Payment Received" class="btn btn-xs btn-success">Payment Received</button>';
}
return editIcon;
}, "searchable": "false", "orderable": false
};

var postedShowingsDataTable = bindDatatable('#completed_showings_list_posted', listUsersPostUrl, listUsersDtCols);
}


if (0 < ($('#completed_showings_list_both')).length) {
  var listUsersPostUrl = '/showings/list-users/bothcompleted';
  listUsersDtCols[8] = {"title": "Actions", "data": "id",
  "render": function (data, type, row, meta) {
   var rejected =row.rejected_id;

   if(rejected){

    var  editIcon = '&nbsp<a style="cursor:pointer" onclick="viewShowingUser(' + data + ')"' +
    ' title="View"><i class="fa' +
    ' fa-eye fa-2x text-green"></i></a>';
  }
  else {

   if(row.showing_progress == 4){
     var  editIcon = '&nbsp<a style="cursor:pointer" onclick="viewShowingUser(' + data + ')"' +
     ' title="View"><i class="fa' +
     ' fa-eye fa-2x text-green"></i></a>';
   }

   else if(row.showing_progress == 6){
     var  editIcon = '&nbsp<a  style="cursor:pointer ;" onclick="viewShowingUser(' + data + ')"' +
     ' title="View"><i class="fa' +
     ' fa-eye fa-2x text-green"></i></a>';


   }

 }
 return editIcon;
}, "searchable": "false", "orderable": false
};


listUsersDtCols[7] = {"title": "Status", "data": "id",
"render": function (data, type, row, meta) {

 if(row.showing_progress == 4){ 
  var  editIcon =  '<button ; style=" padding-left:5px;cursor:not-allowed ; width: 120px;" type="button" title="Payment undone" class="btn btn-xs btn-danger">Payment Undone</button>';

}

else if(row.showing_progress == 6){

  var editIcon =  '<button  style="width:90%;cursor:not-allowed ; width: 120px;" type="button" title="Payment Done" class="btn btn-xs btn-success">Payment Done</button>';
}
return editIcon;
}, "searchable": "false", "orderable": false
};

var postedShowingsDataTable = bindDatatable('#completed_showings_list_both', listUsersPostUrl, listUsersDtCols);
}


/* End new block*/
}

changeListPrice();

});

function changeListPrice() {
  var totalPayment = 0;
  var agentPayment = 0;
  var lmsPayment = 0;

  $('.showing-list-price').each(function() {
    var listPrice = $(this).val().match(/-?\d+\.?\d*/);

    if (null !== listPrice) {
      totalPayment = totalPayment + parseFloat(listPrice) + 15;
      agentPayment = agentPayment + parseFloat(listPrice);
    } else {
      totalPayment = totalPayment + 15;
    }

    lmsPayment = lmsPayment + 15  ;


  });

  var additionalFeeStr = $('#additional_fee').val();
  if(typeof(additionalFeeStr) != "undefined" && (additionalFeeStr) !== null) {
    var additionalFee = additionalFeeStr.match(/-?\d+\.?\d*/);
  }
  if (null !== additionalFee) { // If additional fee already set
    var newaddotionalAgent =  (additionalFee*80)/100; //Calculate fee for client 80%
    var newaddotionalLms =  (additionalFee*20)/100; // Calculete fee for LMS 20%
    lmsPayment = lmsPayment + parseFloat(newaddotionalLms);
    agentPayment = agentPayment + parseFloat(newaddotionalAgent);
    totalPayment = totalPayment + parseFloat(additionalFee);
  }

  $('#dd_totalPayment').html('$' + totalPayment);
  $('#dd_agentPayment').html('$' + agentPayment);
  $('#dd_lmsPayment').html('$' + lmsPayment);
}

function bindDatatable(selector, postUrl, dtCols, defSortInfo) {
  defSortInfo = ('undefined' == typeof defSortInfo) ? [] : defSortInfo;

  if ($(selector).length) {
    var bindedDatatable = $(selector).dataTable({
      "processing": false,
      "serverSide": true,
      "ajax": {
        "url": postUrl,
        "type": "POST"
      },
      "language": {
        "infoFiltered": ""
      },
      "columns": dtCols,
      "order": defSortInfo
    });
    return bindedDatatable;
  }
}

function viewShowing(id) {
  var postUrl = "/showings/view";
  $.post(postUrl,
  {
    id: id
  },
  function(data) {
    if ('' !== data) {
      $('#dv_viewShowings').html(data).modal("show");
    }
  }
  );
}

function viewShowingUser(id) {
  var postUrl = "/showings/viewUser";
  $.post(postUrl,
  {
    id: id
  },
  function(data) {
    if ('' !== data) {
      $('#dv_viewShowings').html(data).modal("show");
    }
  }
  );
}


function viewShowingUserRejected(id) {
  var postUrl = "/showings/viewShowingRejected";
  $.post(postUrl,
  {
    id: id
  },
  function(data) {
    if ('' !== data) {
      $('#dv_viewShowings').html(data).modal("show");
    }
  }
  );
}

function changeHouseCount() {
  $currentHouseCountObj = $('#hid_houseCount');

  var selectedCount = parseInt($('#house_count option:selected').val());
  var currentHouseCount = parseInt($currentHouseCountObj.val());

  if (currentHouseCount < selectedCount) {
    var totalPayment = $('#dd_totalPayment').html().match(/-?\d+\.?\d*/);
    var agentPayment = $('#dd_agentPayment').html().match(/-?\d+\.?\d*/);
    var lmsPayment = $('#dd_lmsPayment').html().match(/-?\d+\.?\d*/);

    for (var i=currentHouseCount; i < selectedCount; i++) {
      var newCount = parseInt(i) + 1;
      $clonedObj = $('#dv_houseDetails' + i).clone();

      $clonedObj.attr('id', 'dv_houseDetails' + newCount);
      $('input', $clonedObj).val('');
      $(".panel-heading a", $clonedObj).attr('href', '#dv_houseCount' + newCount);
      $(".panel-heading .sp_houseCount", $clonedObj).html(newCount);
      $("#dv_houseCount" + i, $clonedObj).attr('id', 'dv_houseCount' + newCount)
      .removeClass('in');
      $currentHouseCountObj.val(newCount);
      $('input[name="list_price[]"]', $clonedObj).val('$20');

      $clonedObj.appendTo('#dv_accordionCat');

      lmsPayment = parseFloat(lmsPayment) + 15;
      agentPayment = parseFloat(agentPayment) + 20;
      totalPayment = lmsPayment + agentPayment;
    }

    $('#dd_totalPayment').html('$' + totalPayment);
    $('#dd_agentPayment').html('$' + agentPayment);
    $('#dd_lmsPayment').html('$' + lmsPayment);

    $('.showing-list-price').keyup(function() {
      changeListPrice();
    });
  } else {
    for (var i=currentHouseCount; i > selectedCount; i--) {
      $('#dv_houseDetails' + i).remove();
      $currentHouseCountObj.val(i-1);
    }
    changeListPrice();
  }
}
//Showing accept functionality
function acceptShowing(id) {

  bootbox.dialog({
    message: "Are you sure to accept this showing?",
    buttons: {
      success: {
        label: "Yes",
        className: "btn-success",
        callback: function() {

          var btn = $('#fat-btn')
          btn.button('loading');

          $.ajax({
            "url": "/showings/accept",
            "dataType": "json",
            "type": "POST",
            "cache": false,
            "data": {id: id},
            "success": function(response) {
              if('1' == response) {
                bootbox.dialog({
                  message: "Showing accepted successfully.",
                  buttons: {
                    success: {
                      label: " OK ",
                      className: "btn-success",
                      callback: function() {
                        var btn1 = $('#fat-btn')
                        btn.button('reset');
                        window.location.reload();
                      }
                    }
                  }
                });
              } else {
                bootbox.alert( "Error detected on server, Please try again." );
              }
            },
            "error": function () {
              bootbox.alert( "Error detected on server, Please try again." );
            }
          });
}
},
danger: {
  label: "No",
  className: "btn-danger"
}
}
});
}

function getFeedbackForm(id) {
  var postUrl = "/showings/feedback-form";
  $.post(postUrl,
  {
    id: id
  },
  function(data) {
    if ('' !== data) {
      $('#dv_viewShowings').html(data).modal("show");
    }
  }
  );
}

//Showing accept functionality
function feedbackShowing(id) {

  bootbox.dialog({
    message: "Are you sure to submit feedback for this showing?",
    buttons: {
      success: {
        label: "Yes",
        className: "btn-success",
        callback: function() {
          $('#frm_feedbackForm').submit();
        }
      },
      danger: {
        label: "No",
        className: "btn-danger"
      }
    }
  });
}

//Delete showing functionality
function deleteShowing(id) {

  bootbox.dialog({
    message: "Are you sure to delete this showing?",
    buttons: {
      success: {
        label: "Yes",
        className: "btn-success",
        callback: function() {
          window.location = "/showings/delete/" + id;
        }
      },
      danger: {
        label: "No",
        className: "btn-danger"
      }
    }
  });
}


$(document).ready(function(){


  var modal = document.getElementById('myModal');

// Get the button that opens the modal
var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
$("#myBtn").click(function() {
  modal.style.display = "block";
});

// When the user clicks on <span> (x), close the modal
$(span).click(function() {
  modal.style.display = "none";
});
$("#myclose").click(function() {
  modal.style.display = "none";
});

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}


 


});


function showMessa() {


             // $('#dv_viewShowings').html("You do not have permission to post a showing and please update your profile by entering a credit card. Only then you will be able to access “post a showing” page.").modal("show");


           }

           function blockShowing() {
            $("button[data-number=2]").click(function(){
            $('#myModalBlockPost').modal('hide');
            });

            $('#myModalBlockPost').modal("show");

          }

          function submitBlockComment(btn) {
            $btn = $(btn);
            var showing_id = $("#showing_id").val();
            var fdbck = $('.feedback').val();

            if(!showing_id){
              return false;
            }

            if(!fdbck || fdbck  == ''){
             $("#myModalBlockPost .modal-body .error-div").remove();
             $("#myModalBlockPost .modal-body #errmsg").append("<span class='error-div text-danger'>Provide feedback</span>")

             return false;
           }
           $btn.button("loading");
           $.ajax({
            url:BASE_URL+"showings/blockPost",
            type:"POST",
            data:{feedback:fdbck,showing_id:showing_id},
            dataType:"JSON",
            success:function(obj){
              $btn.button("reset");
              if(obj.status == "success"){
                $("#myModalBlockPost").modal("hide");
                window.location.href = "/home";
              }else{
                $("#myModalBlockPost .modal-body .error-div").remove();
                $("#myModalBlockPost .modal-body #errmsg").append("<span class='error-div text-danger'>"+obj.msg+"</span>")
              }
            },
            error:function(err){


            }
          });


         }

         function reviewShowing() {
                  /*!
         * bootstrap-star-rating v4.0.2
         * http://plugins.krajee.com/star-rating
         *
         * Author: Kartik Visweswaran
         * Copyright: 2014 - 2016, Kartik Visweswaran, Krajee.com
         *
         * Licensed under the BSD 3-Clause
         * https://github.com/kartik-v/bootstrap-star-rating/blob/master/LICENSE.md
         */!function(e){"use strict";"function"==typeof define&&define.amd?define(["jquery"],e):"object"==typeof module&&module.exports?module.exports=e(require("jquery")):e(window.jQuery)}(function(e){"use strict";e.fn.ratingLocales={},e.fn.ratingThemes={};var t,a,n,r,i,l,s,o,c,u,h;t=".rating",a=0,n=5,r=.5,i=function(t,a){return null===t||void 0===t||0===t.length||a&&""===e.trim(t)},l=function(e,t){return e?" "+t:""},s=function(e,t){e.removeClass(t).addClass(t)},o=function(e){var t=(""+e).match(/(?:\.(\d+))?(?:[eE]([+-]?\d+))?$/);return t?Math.max(0,(t[1]?t[1].length:0)-(t[2]?+t[2]:0)):0},c=function(e,t){return parseFloat(e.toFixed(t))},u=function(e,a,n,r){var i=r?a:a.split(" ").join(t+" ")+t;e.off(i).on(i,n)},h=function(t,a){var n=this;n.$element=e(t),n._init(a)},h.prototype={constructor:h,_parseAttr:function(e,t){var l,s,o,c,u=this,h=u.$element,d=h.attr("type");if("range"===d||"number"===d){switch(s=t[e]||h.data(e)||h.attr(e),e){case"min":o=a;break;case"max":o=n;break;default:o=r}l=i(s)?o:s,c=parseFloat(l)}else c=parseFloat(t[e]);return isNaN(c)?o:c},_setDefault:function(e,t){var a=this;i(a[e])&&(a[e]=t)},_listenClick:function(e,t){return e.stopPropagation(),e.preventDefault(),e.handled===!0?!1:(t(e),void(e.handled=!0))},_starClick:function(e){var t,a=this;a._listenClick(e,function(e){return a.inactive?!1:(t=a._getTouchPosition(e),a._setStars(t),a.$element.trigger("change").trigger("rating.change",[a.$element.val(),a._getCaption()]),void(a.starClicked=!0))})},_starMouseMove:function(e){var t,a,n=this;!n.hoverEnabled||n.inactive||e&&e.isDefaultPrevented()||(n.starClicked=!1,t=n._getTouchPosition(e),a=n.calculate(t),n._toggleHover(a),n.$element.trigger("rating.hover",[a.val,a.caption,"stars"]))},_starMouseLeave:function(e){var t,a=this;!a.hoverEnabled||a.inactive||a.starClicked||e&&e.isDefaultPrevented()||(t=a.cache,a._toggleHover(t),a.$element.trigger("rating.hoverleave",["stars"]))},_clearClick:function(e){var t=this;t._listenClick(e,function(){t.inactive||(t.clear(),t.clearClicked=!0)})},_clearMouseMove:function(e){var t,a,n,r,i=this;!i.hoverEnabled||i.inactive||!i.hoverOnClear||e&&e.isDefaultPrevented()||(i.clearClicked=!1,t='<span class="'+i.clearCaptionClass+'">'+i.clearCaption+"</span>",a=i.clearValue,n=i.getWidthFromValue(a)||0,r={caption:t,width:n,val:a},i._toggleHover(r),i.$element.trigger("rating.hover",[a,t,"clear"]))},_clearMouseLeave:function(e){var t,a=this;!a.hoverEnabled||a.inactive||a.clearClicked||!a.hoverOnClear||e&&e.isDefaultPrevented()||(t=a.cache,a._toggleHover(t),a.$element.trigger("rating.hoverleave",["clear"]))},_resetForm:function(e){var t=this;e&&e.isDefaultPrevented()||t.inactive||t.reset()},_setTouch:function(e,t){var a,n,r,l,s,o,c,u=this,h="ontouchstart"in window||window.DocumentTouch&&document instanceof window.DocumentTouch;h&&!u.inactive&&(a=e.originalEvent,n=i(a.touches)?a.changedTouches:a.touches,r=u._getTouchPosition(n[0]),t?(u._setStars(r),u.$element.trigger("change").trigger("rating.change",[u.$element.val(),u._getCaption()]),u.starClicked=!0):(l=u.calculate(r),s=l.val<=u.clearValue?u.fetchCaption(u.clearValue):l.caption,o=u.getWidthFromValue(u.clearValue),c=l.val<=u.clearValue?o+"%":l.width,u._setCaption(s),u.$filledStars.css("width",c)))},_initTouch:function(e){var t=this,a="touchend"===e.type;t._setTouch(e,a)},_initSlider:function(e){var t=this;i(t.$element.val())&&t.$element.val(0),t.initialValue=t.$element.val(),t._setDefault("min",t._parseAttr("min",e)),t._setDefault("max",t._parseAttr("max",e)),t._setDefault("step",t._parseAttr("step",e)),(isNaN(t.min)||i(t.min))&&(t.min=a),(isNaN(t.max)||i(t.max))&&(t.max=n),(isNaN(t.step)||i(t.step)||0===t.step)&&(t.step=r),t.diff=t.max-t.min},_initHighlight:function(e){var t,a=this,n=a._getCaption();e||(e=a.$element.val()),t=a.getWidthFromValue(e)+"%",a.$filledStars.width(t),a.cache={caption:n,width:t,val:e}},_getContainerCss:function(){var e=this;return"rating-container"+l(e.theme,"theme-"+e.theme)+l(e.rtl,"rating-rtl")+l(e.size,"rating-"+e.size)+l(e.animate,"rating-animate")+l(e.disabled||e.readonly,"rating-disabled")+l(e.containerClass,e.containerClass)},_checkDisabled:function(){var e=this,t=e.$element,a=e.options;e.disabled=void 0===a.disabled?t.attr("disabled")||!1:a.disabled,e.readonly=void 0===a.readonly?t.attr("readonly")||!1:a.readonly,e.inactive=e.disabled||e.readonly,t.attr({disabled:e.disabled,readonly:e.readonly})},_addContent:function(e,t){var a=this,n=a.$container,r="clear"===e;return a.rtl?r?n.append(t):n.prepend(t):r?n.prepend(t):n.append(t)},_generateRating:function(){var t,a,n,r=this,i=r.$element;a=r.$container=e(document.createElement("div")).insertBefore(i),s(a,r._getContainerCss()),r.$rating=t=e(document.createElement("div")).attr("class","rating").appendTo(a).append(r._getStars("empty")).append(r._getStars("filled")),r.$emptyStars=t.find(".empty-stars"),r.$filledStars=t.find(".filled-stars"),r._renderCaption(),r._renderClear(),r._initHighlight(),a.append(i),r.rtl&&(n=Math.max(r.$emptyStars.outerWidth(),r.$filledStars.outerWidth()),r.$emptyStars.width(n))},_getCaption:function(){var e=this;return e.$caption&&e.$caption.length?e.$caption.html():e.defaultCaption},_setCaption:function(e){var t=this;t.$caption&&t.$caption.length&&t.$caption.html(e)},_renderCaption:function(){var t,a=this,n=a.$element.val(),r=a.captionElement?e(a.captionElement):"";if(a.showCaption){if(t=a.fetchCaption(n),r&&r.length)return s(r,"caption"),r.html(t),void(a.$caption=r);a._addContent("caption",'<div class="caption">'+t+"</div>"),a.$caption=a.$container.find(".caption")}},_renderClear:function(){var t,a=this,n=a.clearElement?e(a.clearElement):"";if(a.showClear){if(t=a._getClearClass(),n.length)return s(n,t),n.attr({title:a.clearButtonTitle}).html(a.clearButton),void(a.$clear=n);a._addContent("clear",'<div class="'+t+'" title="'+a.clearButtonTitle+'">'+a.clearButton+"</div>"),a.$clear=a.$container.find("."+a.clearButtonBaseClass)}},_getClearClass:function(){return this.clearButtonBaseClass+" "+(this.inactive?"":this.clearButtonActiveClass)},_getTouchPosition:function(e){var t=i(e.pageX)?e.originalEvent.touches[0].pageX:e.pageX;return t-this.$rating.offset().left},_toggleHover:function(e){var t,a,n,r=this;e&&(r.hoverChangeStars&&(t=r.getWidthFromValue(r.clearValue),a=e.val<=r.clearValue?t+"%":e.width,r.$filledStars.css("width",a)),r.hoverChangeCaption&&(n=e.val<=r.clearValue?r.fetchCaption(r.clearValue):e.caption,n&&r._setCaption(n+"")))},_init:function(t){var a=this,n=a.$element.addClass("hide");return a.options=t,e.each(t,function(e,t){a[e]=t}),(a.rtl||"rtl"===n.attr("dir"))&&(a.rtl=!0,n.attr("dir","rtl")),a.starClicked=!1,a.clearClicked=!1,a._initSlider(t),a._checkDisabled(),a.displayOnly&&(a.inactive=!0,a.showClear=!1,a.showCaption=!1),a._generateRating(),a._listen(),n.removeClass("rating-loading")},_listen:function(){var t=this,a=t.$element,n=a.closest("form"),r=t.$rating,i=t.$clear;return u(r,"touchstart touchmove touchend",e.proxy(t._initTouch,t)),u(r,"click touchstart",e.proxy(t._starClick,t)),u(r,"mousemove",e.proxy(t._starMouseMove,t)),u(r,"mouseleave",e.proxy(t._starMouseLeave,t)),t.showClear&&i.length&&(u(i,"click touchstart",e.proxy(t._clearClick,t)),u(i,"mousemove",e.proxy(t._clearMouseMove,t)),u(i,"mouseleave",e.proxy(t._clearMouseLeave,t))),n.length&&u(n,"reset",e.proxy(t._resetForm,t)),a},_getStars:function(e){var t,a=this,n='<span class="'+e+'-stars">';for(t=1;t<=a.stars;t++)n+='<span class="star">'+a[e+"Star"]+"</span>";return n+"</span>"},_setStars:function(e){var t=this,a=arguments.length?t.calculate(e):t.calculate(),n=t.$element;return n.val(a.val),t.$filledStars.css("width",a.width),t._setCaption(a.caption),t.cache=a,n},showStars:function(e){var t=this,a=parseFloat(e);return t.$element.val(isNaN(a)?t.clearValue:a),t._setStars()},calculate:function(e){var t=this,a=i(t.$element.val())?0:t.$element.val(),n=arguments.length?t.getValueFromPosition(e):a,r=t.fetchCaption(n),l=t.getWidthFromValue(n);return l+="%",{caption:r,width:l,val:n}},getValueFromPosition:function(e){var t,a,n=this,r=o(n.step),i=n.$rating.width();return a=n.diff*e/(i*n.step),a=n.rtl?Math.floor(a):Math.ceil(a),t=c(parseFloat(n.min+a*n.step),r),t=Math.max(Math.min(t,n.max),n.min),n.rtl?n.max-t:t},getWidthFromValue:function(e){var t,a,n=this,r=n.min,i=n.max,l=n.$emptyStars;return!e||r>=e||r===i?0:(a=l.outerWidth(),t=a?l.width()/a:1,e>=i?100:(e-r)*t*100/(i-r))},fetchCaption:function(e){var t,a,n,r,l,s=this,u=parseFloat(e)||s.clearValue,h=s.starCaptions,d=s.starCaptionClasses;return u&&u!==s.clearValue&&(u=c(u,o(s.step))),r="function"==typeof d?d(u):d[u],n="function"==typeof h?h(u):h[u],a=i(n)?s.defaultCaption.replace(/\{rating}/g,u):n,t=i(r)?s.clearCaptionClass:r,l=u===s.clearValue?s.clearCaption:a,'<span class="'+t+'">'+l+"</span>"},destroy:function(){var t=this,a=t.$element;return i(t.$container)||t.$container.before(a).remove(),e.removeData(a.get(0)),a.off("rating").removeClass("hide")},create:function(e){var t=this,a=e||t.options||{};return t.destroy().rating(a)},clear:function(){var e=this,t='<span class="'+e.clearCaptionClass+'">'+e.clearCaption+"</span>";return e.inactive||e._setCaption(t),e.showStars(e.clearValue).trigger("change").trigger("rating.clear")},reset:function(){var e=this;return e.showStars(e.initialValue).trigger("rating.reset")},update:function(e){var t=this;return arguments.length?t.showStars(e):t.$element},refresh:function(t){var a=this,n=a.$element;return t?a.destroy().rating(e.extend(!0,a.options,t)).trigger("rating.refresh"):n}},e.fn.rating=function(t){var a=Array.apply(null,arguments),n=[];switch(a.shift(),this.each(function(){var r,l=e(this),s=l.data("rating"),o="object"==typeof t&&t,c=o.theme||l.data("theme"),u=o.language||l.data("language")||"en",d={},g={};s||(c&&(d=e.fn.ratingThemes[c]||{}),"en"===u||i(e.fn.ratingLocales[u])||(g=e.fn.ratingLocales[u]),r=e.extend(!0,{},e.fn.rating.defaults,d,e.fn.ratingLocales.en,g,o,l.data()),s=new h(this,r),l.data("rating",s)),"string"==typeof t&&n.push(s[t].apply(s,a))}),n.length){case 0:return this;case 1:return void 0===n[0]?this:n[0];default:return n}},e.fn.rating.defaults={theme:"",language:"en",stars:5,filledStar:'<i class="glyphicon glyphicon-star"></i>',emptyStar:'<i class="glyphicon glyphicon-star-empty"></i>',containerClass:"",size:"md",animate:!0,displayOnly:!1,rtl:!1,showClear:!0,showCaption:!0,starCaptionClasses:{.5:"label label-danger",1:"label label-danger",1.5:"label label-warning",2:"label label-warning",2.5:"label label-info",3:"label label-info",3.5:"label label-primary",4:"label label-primary",4.5:"label label-success",5:"label label-success"},clearButton:'<i class="glyphicon glyphicon-minus-sign"></i>',clearButtonBaseClass:"clear-rating",clearButtonActiveClass:"clear-rating-active",clearCaptionClass:"label label-default",clearValue:null,captionElement:null,clearElement:null,hoverEnabled:!0,hoverChangeCaption:!0,hoverChangeStars:!0,hoverOnClear:!0},e.fn.ratingLocales.en={defaultCaption:"{rating} Stars",starCaptions:{.5:"Half Star",1:"One Star",1.5:"One & Half Star",2:"Two Stars",2.5:"Two & Half Stars",3:"Three Stars",3.5:"Three & Half Stars",4:"Four Stars",4.5:"Four & Half Stars",5:"Five Stars"},clearButtonTitle:"Clear",clearCaption:"Not Rated"},e.fn.rating.Constructor=h,e(document).ready(function(){var t=e("input.rating");t.length&&t.removeClass("rating-loading").addClass("rating-loading").rating()})});

           
           $("button[data-number=1]").click(function(){
              $('#myModalReviewPost').modal('hide');
            });
          $('#myModalReviewPost').modal("show");
         }


         function submitReviewComment(btn) {
          $btn = $(btn);
          var showing_id = $("#newshowing_id").val();
          var fdbck = $('.revfeedback').val();
          var userRating = $("#input-1").val();

          if(!showing_id){
            return false;
          }

          if(!fdbck || fdbck  == ''){
            $("#myModalReviewPost .modal-body .error-div").remove();
            $("#myModalReviewPost .modal-body #errmesssg").append("<span class='error-div text-danger'>Please enter comments</span>")
            return false;
          }
          $btn.button("loading");
          $.ajax({
            url:BASE_URL+"showings/reviewPost",
            type:"POST",
            data:{feedback:fdbck,showing_id:showing_id,rating:userRating},
            dataType:"JSON",
            success:function(obj){
              $btn.button("reset");
              if(obj.status == "success"){
                $("#myModalReviewPost").modal("hide");
                //location.reload();
                window.location.href = "/home";
              }else{
                $("#myModalReviewPost .modal-body .error-div").remove();
                $("#myModalReviewPost .modal-body #errmesssg").append("<span class='error-div text-danger'>"+obj.msg+"</span>")
              }
            },
            error:function(err){


            }
          });


        }


        function errorShowing() {
         $('#myModalerrorBlock').modal("show");

       }


       function acceptedUserData(id, showing_id ) {
        var user_id = id;
        var showingId =showing_id;
        $.ajax({    
          type: "GET",
          url:BASE_URL+"showings/showingUser/"+user_id,   
          data:{id:user_id},        
        //dataType: "html",             
        success: function(html){  

         $("#acceptedUserList .modal-body").html(html);
         $('#showing_id').attr('value', showingId);
         $('#rejectShowing').attr('value', showingId);
       }

     });
        $('#acceptedUserList').modal("show");

      }

      function approveShowing() {

        var showing_id =  $('#showing_id').val();


        bootbox.dialog({
          message: "Are you sure to approve this agent",
          buttons: {
            success: {
              label: "Yes",
              className: "btn-success",
              callback: function() {
                var btn = $('#newApprove')
                btn.button('loading');

                $.ajax({    
                  type: "POST",
                  url:BASE_URL+"showings/approve/"+showing_id,   
                  data:{id:showing_id},        
                //dataType: "html",             
                success: function(html){ 
                 bootbox.dialog({
                  message: "Agent approved successfully.",
                  buttons: {
                    success: {
                      label: " OK ",
                      className: "btn-success",
                      callback: function() {
                       var btn1 = $('#newApprove')
                       btn.button('reset');

                       window.location.reload();
                     }
                   }
                 }
               });

               }

             });

              }
            },
            danger: {
              label: "No",
              className: "btn-danger"
            }
          }
        });
}


function rejectShowing() {

  var showing_id =  $('#rejectShowing').val();


  bootbox.dialog({
    message: "Are you sure to reject this agent",
    buttons: {
      success: {
        label: "Yes",
        className: "btn-success",
        callback: function() {
         var btn = $('#rejectShowing')
         btn.button('loading');

         $.ajax({    
          type: "POST",
          url:BASE_URL+"showings/reject/"+showing_id,   
          data:{id:showing_id},        
                //dataType: "html",             
                success: function(html){ 
                  bootbox.dialog({
                    message: "Agent rejected successfully.",
                    buttons: {
                      success: {
                        label: " OK ",
                        className: "btn-success",
                        callback: function() {
                          var btn1 = $('#rejectShowing')
                          btn.button('reset');
                          window.location.reload();
                        }
                      }
                    }
                  });                  

                }

              });

       }
     },
     danger: {
      label: "No",
      className: "btn-danger"
    }
  }
});
}

function viewAcceptedUserData(id, showing_id ) {
  var user_id = id;
  var showingId =showing_id;
  $('#mybutton').hide();
  $("#closebutton").css("display","block"); 



  $.ajax({    
    type: "GET",
    url:BASE_URL+"showings/showingUser/"+user_id,   
    data:{id:user_id},        
        //dataType: "html",             
        success: function(html){  

         $("#acceptedUserList .modal-body").html(html);
         $('#showing_id').attr('value', showingId);
         $('#rejectShowing').attr('value', showingId);

       }

     });
  $('#acceptedUserList').modal("show");

}


function paymentPendingPopup() {

  bootbox.alert("Payment for your showing is currently on hold. Please contact LMS Agent Support at <a  style='color:#337aa9' href='mailto:support@lastminuteshowings.com'>support@lastminuteshowings.com</a> for further details.");

 
}

function blockOrReview(a,showing_id){


        $.ajax({    
          type: "GET",
          url:BASE_URL+"showings/blockshowings/"+showing_id,   
          data:{id:showing_id},        
        //dataType: "html",             
        success: function(html){  
          console.log(html);
         $("#block_review .modal-body").html(html);
        
       }

     });
       $('#block_review').modal("show");

}
function viewCompleteShowings(showing_id){
 

        $.ajax({    
          type: "GET",
          url:BASE_URL+"showings/completed/"+showing_id,   
          data:{id:showing_id},        
        //dataType: "html",             
        success: function(html){  
         
            $("#complete-Showings-feedback .modal-body").html(html);
        
       }
     });
    $('#complete-Showings-feedback').modal("show");

}
