# ImageJ/Fiji Macros for Nuclear Segmentation, Intensity Quantification, and Foci-Centered ROI Extraction

This repository contains two ImageJ/Fiji macros used for analyzing fluorescence microscopy images. These scripts were developed for single-cell analysis of transcription-associated DNA repair, EdU incorporation, and foci-centered enrichment profiling. The macros support batch processing, reproducible intensity measurement, and extraction of foci-centered regions for averaging.

---

## Included Macros

### 1. Nuclear_Masking_EdU_Measurement.ijm
**Purpose:**  
Automates batch processing of images to perform:
- Nuclear segmentation using channel C4 (e.g., DAPI/Hoechst)
- Measurement of EdU or IF intensity in any selected channel (C1–C4)
- Export of per-nucleus measurements to a CSV file
- Saving of processed images with ROIs overlaid

**Input Requirements:**
- Multichannel fluorescence images (supports .tif/.tiff, .jpg/.jpeg, .png)
- Channel 4 (C4) must contain the nuclear marker
- Measurement channel (EdU or IF signal) is chosen by the user

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
- `IF_density_summary.csv` — Contains Filename, ROI#, Area, Mean Intensity, Integrated Density
- For each image: `filename-processed.tif` with ROIs overlaid

---
### 2. AveragingCenteredonFoci-111023.ijm

### Purpose
This ImageJ macro extracts square ROIs centered on nuclear foci and saves:
- Cropped multichannel TIFFs  
- Individual channel TIFFs  

These outputs can be averaged or profiled to quantify mean focus intensity, spatial signatures, and spatial spread around MS2, LacO, TOP1cc, or EdU foci.

---

### Use Cases
- Generating averaged MS2 or DNA repair focus intensity maps  
- Extracting LacO or TOP1cc foci for spatial quantification  
- Performing radial or line-scan profiling  
- Preparing ROI-centered stacks for downstream single-focus quantification  

---

### How to Use
1. Open your multichannel image in Fiji/ImageJ.  
2. Open **ROI Manager** (`Analyze → Tools → ROI Manager`).  
3. Create a **square ROI**: ROI Manager → **More → Specify** (e.g., 30×30 or 50×50 px).  
4. Ensure **only one ROI** is present in ROI Manager.  
5. Run the macro.  
6. When the script pauses (`waitForUser`), move the ROI to center on a focus and click **OK**.  
7. For each ROI, the macro will:
   - Duplicate channels 1–3 inside the ROI  
   - Save a cropped multichannel TIFF  
   - Split and save each channel as separate TIFFs  

Repeat the process for each focus in the same image.

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
- This macro was **adapted from and inspired by analysis code developed by Jane Lee**, whose averaging-based foci quantification approach shaped the workflow implemented here.  
- These macros support workflows involving transcription-coupled DNA repair imaging, MS2 reporter visualization, TOP1cc quantification, and EdU-based cell cycle segmentation.

---

# Citation

If you use this macro in published work, please cite the paper introducing the foci-averaging analysis framework developed by Jane Lee:

### **Primary Reference**
So, C.L., Lee, J., et al. *TFE3 fusion oncoprotein condensates drive transcriptional reprogramming and cancer progression in translocation renal cell carcinoma.* **Cell Reports** (2025).  
https://doi.org/10.1016/j.celrep.2025.115539

```bibtex
@article{SoLee2025TFE3,
  title   = {TFE3 fusion oncoprotein condensates drive transcriptional reprogramming and cancer progression in translocation renal cell carcinoma},
  author  = {So, C. L. and Lee, J. and others},
  journal = {Cell Reports},
  year    = {2025},
  volume  = {45},
  pages   = {115539},
  doi     = {10.1016/j.celrep.2025.115539}
}
