/**
 * The title ID of our download manager channel ("OSCD").
 */
 var downloaderChannelID = "0x000100084f534344";
 var downloaderChannelTicketID = "0x0001000000000000";
 
 /**
  * Whether an existing download operation is ongoing.
  */
 var startingDownload = false;
 
 /**
  * Begins downloading for the passed title ID.
  * 
  * @param {string} titleId The title ID to begin downloading  
  */
 function startDownload(titleId) {
     if (!startingDownload) {
        startingDownload = true;

        // TODO: ensure download manager is installed

        // Our download manager reads the persistent value "titleId".
        ec.setPersistentValue('titleId', titleId);
        setTimeout(function(){
            ec.launchTitle(downloaderChannelID, downloaderChannelTicketID);
        }, 2000);
     }
 } 
 