# 🖼️ Image Compression & Decompression

<div align="center">
  <img src="https://github.com/user-attachments/assets/ffb0bc23-b084-4d27-bec6-3e56f09caa20" alt="Image Compression GUI" width="600"/>
</div>

## 📰 Description
A MATLAB-based image compression and decompression tool implementing two powerful algorithms:
- **DCT (Discrete Cosine Transform)**: Fourier-Transform based algorithm for lossy compression
- **Huffman Encoding**: Provides lossless data compression with adaptable input format support

The GUI allows an image to be loaded, displayed, compressed, decompressed, and saved according to user interaction.

## 🏗️ Implementation Details
### File Structure
- `Dashboard.m`: Main script containing GUI code
- `Dashboard.fig`: GUI display file
- `comp.m`: Compression implementation
- `decomp.m`: Decompression implementation

### Error Handling
The application includes comprehensive error handling:
- Enforced operation sequence (Load → Compress/Decompress → Save)
- Warning messages for incorrect operation order
- Graceful handling of cancelled operations
- User-friendly error messages

<div align="center">
  <img src="https://github.com/user-attachments/assets/a5ae92eb-5423-420e-93c3-742ae4804ed6" alt="Error Handling Example" width="600"/>
</div>

## 🛠 Initialization & Setup
```bash
# Clone the repository
git clone https://github.com/pedroandreou/ImageCompDecomp.git
```

## 🚀 Building and Running
Two options to run the application:
1. Run `Dashboard.m` file in MATLAB IDE
2. Double-click `Dashboard.fig` to display the GUI directly

## 👤 Author
<p align="left">
  <a href="https://www.linkedin.com/in/petrosandreou80/">
    <img src="https://img.shields.io/badge/Petros_LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn"/>
  </a>
</p>
