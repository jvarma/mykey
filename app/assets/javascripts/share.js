$(function () {
    
    //open the invitation form when a share button is clicked  
    $( ".share a" )  
            .button()
            .click(function() {  
                //assign this specific link element to a variable called "a"  
                var a = this;
                alert("hello"));  
                  
                //Set the title of the Dialog box to display the folder name  
                $("#invitation_form").attr("title", "Share '" + $(a).attr("folder_name") + "' with others" );  
                  
                //Display the different folder names correctly  
                $("#ui-dialog-title-invitation_form").text("Share '" + $(a).attr("folder_name") + "' with others");   
                  
                //Then put the folder_id of the Share link into the hidden field "folder_id" of the invite form  
                $("#folder_id").val($(a).attr("folder_id"));  
                  
                //Add the dialog box loading here
                
                $( "#invitation_form" ).dialog({  
                    height: 300,  
                    width: 600,  
                    modal: true,  
                    buttons: {  
                        //First button  
                        "share": function() {  
            
                        //get the url to post the form data to  
                        var post_url = $("#invitation_form form").attr("action");  
              
                        //serialize the form data and post it to the url
                        $.post(post_url,$("#invitation_form form").serialize(), null, "script");  
              
                        return false;  
            
                        },  
        
                        //Second button  
                        "cancel": function() {  
                            $( this ).dialog( "close" );  
                        }  
                    },  
    
                    close: function() {  
  
                    }     
                });  
                
                return false;  
            });  
    }
);
