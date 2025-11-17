//Macro for saving images from a square selection for Averaging images at a centered foci
//edited: JL 111023 --> JL 111423

//This one is specifically for an image with 2 channels of interest (one with foci, one of interest in enrichment)

//Add folder name where you want to save files - works better on Desktop/Local
path ='/Users/danielguan/Desktop/090425_EdU647_WT/PGi/TOP1/Foci'
path = '/Users/danielguan/Desktop/090425_EdU647_WT/DMSO/TOP1cc/Foci'

//Need to first make a square selection in the ROI Manager
//Can do this by going to ROI Manager --> More --> Specify - I usually do 50x50 -- 30x30 worked well for your images
//Also remove all positions on ROI Manager

//Click Run on each image
//I modified it so that the 4th channel is the foci channel
Stack.setActiveChannels("0001");
Stack.setChannel(3);
//run("yellow");
waitForUser; 

//move the ROI selection now to center at one of your foci
//Then click OK

//Saves image as TIFF
//Channels to duplicate are the ones of your interest (Not including DAPI here)
//Change number in "" for the # foci you are focusing on

//I set it so that it saves the red, pink, and yellow channels
run("Duplicate...", "duplicate channels=1-3");
name = getTitle();
saveAs("Tiff", path + name + "2" + ".tiff");
//close();

//Each channel will be saved as tiff
//CHANGE THE NUMBER HERE AND ABOVE FOR EACH PATH NAME FOR EACH FOCI IF THEY ARE ON THE SAME IMAGE
run("Split Channels");
name = getTitle();
saveAs("Tiff", path + name + "10" + ".tiff");
close();
name = getTitle();
saveAs("Tiff", path + name + "10" + ".tiff");
close();
name = getTitle();
saveAs("Tiff", path + name + "10" + ".tiff");
close();
close();

//This part is manual sorry: 

//To actually average the images, go to File--> Import --> Image Sequence (import all your images for each channel)
//Each channel will be labeled C1 or C2
//Image → Stacks → Z Project… (Projection type: average intensity)
//Save image as a jpeg or tiff

//use "plot profile" to create the graph and copy the data out onto prism/excel

