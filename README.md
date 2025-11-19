# ImageJ/FiJi Macros for Foci-Centered enrichment profiling

This pipeline contains two ImageJ/FiJi macros used for ROI Extraction, Nuclear Segmentation, and single cell Intensity Quantification of fluorescence microscopy images. These macros were developed for single-cell analysis of transcription-associated DNA repair, and support batch processing, reproducible intensity measurement, and extraction of foci-centered regions for averaging. For support, please contact [Tianyi Guan](tguan6@jh.edu). 

--- 

### 1. Foci_Centered_Enrichment_Profiling.ijm
### Input Requirement
This macro requires a multichannel TIFF image containing a single cell, typically obtained by cropping from a parent file such as a .czi, .lif, .nd2, or other microscope-specific format.
- The TIFF must contain all relevant fluorescent channels (e.g., YFP-MCP, AF594, Hoechst).
- Images may be Z-stacks or single planes; Z-stacks will be processed plane-by-plane.

### Purpose
This ImageJ macro extracts square ROIs centered on nuclear foci and saves:
- Cropped multichannel TIFFs  
- Individual channel TIFFs  

These outputs can be averaged or profiled to quantify mean focus intensity, spatial signatures, and spatial spread around MS2, LacO, TOP1cc, or EdU foci.

---

### How to Use
1. Open your multichannel .tif/.tiff image in Fiji/ImageJ.  
2. Open **ROI Manager** (`Analyze → Tools → ROI Manager`).  
3. Create a **square ROI**: ROI Manager → **More → Specify** (We used 58x58 px ROI, the size can be adjusted to fit different purposes).  
4. Ensure **only one ROI** is present in ROI Manager.  
5. Run the macro.  
6. When the script pauses (`waitForUser`), move the ROI to center on a focus and click **OK**.  
7. For each ROI, the macro will:
   - Duplicate channels 1–3 inside the ROI  
   - Save a cropped multichannel TIFF  
   - Split and save each channel as separate TIFFs  

Repeat the process for focus in all the images and save cropped single channel image into seperate folders

---

### Averaging Foci
1. Gather all cropped TIFFs for a given channel.  
2. Import them as a sequence: **File → Import → Image Sequence**.  
3. Generate an average map: **Image → Stacks → Z Project → Average Intensity**.  
4. Save averaged images.  
5. Use **Plot Profile** or **Radial Profile** plugins for quantitative analysis.

---

## Notes
- Requires Fiji/ImageJ (ImageJ 1.53+ recommended).  
- Record ROI size, imaging settings, and channel order for reproducibility.  
- These macros support workflows involving transcription-coupled DNA repair imaging, MS2 reporter visualization, TOP1cc quantification, and EdU-based cell cycle segmentation.

---

## Citation

- This macro was adapted from and inspired by analysis code developed by Jane Lee, whose averaging-based foci quantification approach shaped the workflow implemented here. If you use this macro in published work, please cite the paper introducing the foci-averaging analysis framework developed by Jane Lee:

### **Reference**
So, C.L., Lee, J., et al. *TFE3 fusion oncoprotein condensates drive transcriptional reprogramming and cancer progression in translocation renal cell carcinoma.* **Cell Reports** (2025).  
https://doi.org/10.1016/j.celrep.2025.115539

### **Optional** 2. Nuclear_Masking&Intensity_Measurement.ijm

**Input Requirements:**
- Multichannel fluorescence images (supports .tif/.tiff, .jpg/.jpeg, .png)
- Must contain the nuclear marker in one of the channel
- Measurement channel (Cell-cycle marker or target of interset) is chosen by the user

**Purpose:**  
Automates batch processing of images to perform:
- Nuclear segmentation using channel C4 (e.g., DAPI/Hoechst)
- Measurement of EdU or IF intensity in any selected channel (C1–C4)
- Export of per-nucleus measurements to a CSV file
- Saving of processed images with ROIs overlaid

**How to Use:**
1. Run the macro in Fiji.  
2. Choose parameters in the dialog:
   - Image format to process
   - Gaussian blur sigma
   - Thresholding method
   - Minimum nuclear area
   - Channel to measure (C1–C4)
3. Select the folder containing your images.
4. The macro automatically:
   - Splits channels
   - Segments nuclei
   - Measures intensities
   - Saves results

**Output:**
- `Intensity_summary.csv` — Contains Filename, ROI#, Area, Mean Intensity
- For each image: `filename-processed.tif` with ROIs overlaid

**Citation**

- Guan.T, Shi. Y, Lee. T.H, Oberdoerffer.P. *Visualizing DNA repair factor recruitment at sites of transcription in single cells*, **Chromosome Research** (2025). 
