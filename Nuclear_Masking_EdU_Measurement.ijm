

// --------------------【Parameter_Setting】--------------------
Dialog.create("Parameter ");
Dialog.addChoice("Image_Format：", newArray("All","tif/tiff","jpg/jpeg","png"), "All");
Dialog.addNumber("Gaussian Blur σ (Pixel)：", 10);
Dialog.addChoice("Threshold：", newArray(
    "Huang","Default","Intermodes","IsoData","Li","MaxEntropy",
    "Mean","MinError","Minimum","Moments","Otsu","Percentile",
    "RenyiEntropy","Shanbhag","Triangle","Yen"
), "Huang");
Dialog.addNumber("MinArea (Pixel)：", 80);
Dialog.addChoice("MeasureingChannel：", newArray("Magenta (C1)","Red (C2)","Yellow (C3)","Blue (C4)"), "Magenta (C1)");
Dialog.show();

chosenFormat  = Dialog.getChoice();
sigmaVal      = Dialog.getNumber();
threshMethod  = Dialog.getChoice();
minSize       = Dialog.getNumber();
chosenChannel = Dialog.getChoice();

// --------------------【Folder】--------------------
inputDir = getDirectory("Choose_Folder");
fileList = getFileList(inputDir);

// --------------------【result_CSV】--------------------
outputCSV = inputDir + "IF_density_summary.csv";
File.open(outputCSV);
File.append("Filename,ROI,Area,Mean,IntDen", outputCSV);

// --------------------【Bath_Process】--------------------
function selectChannel(title) {
    if (chosenChannel == "Magenta (C1)") selectImage("C1-" + title);
    else if (chosenChannel == "Red (C2)") selectImage("C2-" + title);
    else if (chosenChannel == "Yellow (C3)") selectImage("C3-" + title);
    else if (chosenChannel == "Blue (C4)") selectImage("C4-" + title);
}

// --------------------【Batch_Process】--------------------
for (f = 0; f < fileList.length; f++) {
    processFile = false;
    filename = fileList[f];
    filenameLower = toLowerCase(filename);

    // 
    if (chosenFormat == "All") {
        processFile = endsWith(filenameLower, ".tif") || endsWith(filenameLower, ".tiff") ||
                      endsWith(filenameLower, ".jpg") || endsWith(filenameLower, ".jpeg") ||
                      endsWith(filenameLower, ".png");
    } else if (chosenFormat == "tif/tiff") {
        processFile = endsWith(filenameLower, ".tif") || endsWith(filenameLower, ".tiff");
    } else if (chosenFormat == "jpg/jpeg") {
        processFile = endsWith(filenameLower, ".jpg") || endsWith(filenameLower, ".jpeg");
    } else if (chosenFormat == "png") {
        processFile = endsWith(filenameLower, ".png");
    }

    if (processFile) {
        fullPath = inputDir + filename;
        open(fullPath);
        originalTitle = getTitle();
        run("Split Channels");

        // Nuclear_Segmentation = C4
        selectImage("C4-" + originalTitle);
        run("8-bit");
        run("Gaussian Blur...", "sigma=" + sigmaVal);
        setAutoThreshold(threshMethod + " dark no-reset");
        run("Convert to Mask");
        run("Fill Holes");
        run("Watershed");
        run("Analyze Particles...", "size=" + minSize + "-Infinity display exclude clear summarize add");

        // Measuring_Signal
        selectChannel(originalTitle);
        roiManager("Show All without labels");
        run("Clear Results");
        roiManager("Measure");
        run("Flatten");
        saveAs("Tiff", inputDir + filename + "-processed");

        // --------------------【Write_CSV】--------------------
        roiCount = roiManager("count");
        for (r = 0; r < roiCount; r++) {
            area   = getResult("Area", r);
            mean   = getResult("Mean", r);
            intden = getResult("IntDen", r);
            roiNumber = r + 1;
            File.append(filename + "," + roiNumber + "," + d2s(area,3) + "," + d2s(mean,3) + "," + d2s(intden,3), outputCSV);
        }

        close("*");
    }
}

// --------------------【End】--------------------
print("Batch_Processing_Done");
print("File_Saved_At：" + outputCSV);




msg = "Batch_DOne！\n\n" +
      "File_Saved_At：\n" + outputCSV + "\n\n" +





showMessage("Done", msg);



