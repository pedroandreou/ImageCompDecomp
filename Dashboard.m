function varargout = Dashboard(varargin)
% DASHBOARD MATLAB code for Dashboard.fig
%      DASHBOARD, by itself, creates a new DASHBOARD or raises the existing
%      singleton*.
%
%      H = DASHBOARD returns the handle to a new DASHBOARD or the handle to
%      the existing singleton*.
%
%      DASHBOARD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DASHBOARD.M with the given input arguments.
%
%      DASHBOARD('Property','Value',...) creates a new DASHBOARD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Dashboard_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Dashboard_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Dashboard

% Last Modified by GUIDE v2.5 07-Dec-2021 19:31:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Dashboard_OpeningFcn, ...
                   'gui_OutputFcn',  @Dashboard_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Dashboard is made visible.
function Dashboard_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Dashboard (see VARARGIN)

% Choose default command line output for Dashboard
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.Display_LoadedImageForCompression,'visible','off')
set(handles.Display_CompressedOutputImage,'visible','off')
set(handles.Display_LoadedImageForDecompression,'visible','off')
set(handles.Display_DecompressedOutputImage,'visible','off')
axis off
axis off
axis off
axis off

% Make the Compress button unclickable
global Compress_Pushedbutton;
Compress_Pushedbutton = false;
handles.Compress_Pushedbutton = Compress_Pushedbutton;

% Make the Decompress button unclickable
global Decompress_Pushedbutton;
Decompress_Pushedbutton = false;
handles.Decompress_Pushedbutton = Decompress_Pushedbutton;

% Make the Save button for compressed image unclickable
global SaveCompressedImage_Pushedbutton;
SaveCompressedImage_Pushedbutton = false;
handles.SaveCompressedImage_Pushedbutton = SaveCompressedImage_Pushedbutton;

% Make the Save button for decompressed image unclickable
global SaveDecompressedImage_Pushedbutton;
SaveDecompressedImage_Pushedbutton = false;
handles.SaveDecompressedImage_Pushedbutton = SaveDecompressedImage_Pushedbutton;

% UIWAIT makes Dashboard wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Dashboard_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in LoadImageForCompression_Pushbutton.
function LoadImageForCompression_Pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to LoadImageForCompression_Pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Compress_Pushedbutton;
global selectedFile1;
global sizeInMBs1;

selectedFile1 = uigetfile({'*.bmp';'*.jpeg';'*.jpg';'*.png'},...
                'Select a file');

% handle exception if the user presses Cancel in the Window Prompt for
% loading an image
if selectedFile1 == 0
    return
end

axes(handles.Display_LoadedImageForCompression);
imshow(selectedFile1);

% Make the Compress button clickable
Compress_Pushedbutton = true;

% find the size of the selected image in MBs
fileinfo1 = dir(selectedFile1);
sizeInBytes = fileinfo1.bytes;
sizeInMBs1 = sizeInBytes/1024/1024;

set(handles.LoadedImageForCompressionDisplaySize, 'String', sprintf('%.2f', sizeInMBs1));

handles.selectedFile1 = selectedFile1;
handles.sizeInMBs1 = sizeInMBs1;

% --- Executes on button press in LoadImageForDecompression_Pushbutton.
function LoadImageForDecompression_Pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to LoadImageForDecompression_Pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Decompress_Pushedbutton;
global selectedFile2;
global sizeInMBs2;


[selectedFile2,path] = uigetfile('*.mat',...
                'Select a file');


% handle exception if the user presses Cancel in the Window Prompt for
% loading an image
if isequal(selectedFile2,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,selectedFile2)]);
end


% Open the .mat file
%selectedFile2 = fopen(filename, 'r');

% read the compressed image variable from the .mat file's workspace
mat_file = matfile(selectedFile2);
compressedImage_from_Mat_file = mat_file.compress_img;

axes(handles.Display_LoadedImageForDecompression);
imshow(compressedImage_from_Mat_file);

% Make the Compress button clickable
Decompress_Pushedbutton = true;


% to find the size we need to have the compressed image of the .mat file in our current dir
imwrite(mat_file.compressed_png, 'temporaryCompressedImage.png');

% find the size of the compressed image in the .mat file in MBs
fileinfo2 = dir('temporaryCompressedImage.png');
sizeInBytes = fileinfo2.bytes;
sizeInMBs2 = sizeInBytes/1024/1024;


% remove from the current dir, the compressed img from the .mat file
delete('temporaryCompressedImage.png');


set(handles.LoadedImageForDecompressionDisplaySize, 'String', sprintf('%.2f', sizeInMBs2));

handles.selectedFile2 = selectedFile2;
handles.sizeInMBs2 = sizeInMBs2;


% Update handles structure
%guidata(hObject, handles);


% --- Executes on button press in CompressImage_Pushbutton.
function CompressImage_Pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to CompressImage_Pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selectedFile1;
global sizeInMBs1;

global Compress_Pushedbutton;
global SaveCompressedImage_Pushedbutton;

global compressed_image;


if Compress_Pushedbutton == false
    errordlg('Select an image first');
else
    % Call the function by passing the image selected from the user for
    % compressing it
    compressed_image = comp(selectedFile1);

    
    
    % Print the returned compressed image to the axis
    axes(handles.Display_CompressedOutputImage);
    imshow(compressed_image)


    % Display the size of the compressed image
    fileinfo = dir('temporaryImageForMeasuringBytesComp.png');
    sizeInBytes = fileinfo.bytes;
    sizeInMBs = sizeInBytes/1024/1024;
    set(handles.CompressedImageDisplaySize, 'String', sprintf('%.2f', sizeInMBs));

    % Delete the temporary picture
    delete('temporaryImageForMeasuringBytesComp.png');

    % Delete the temporary compressed png picture
    delete('temporaryCompressedImage.png');

    % Display the Compression Ratio
    compressed_ratio = sizeInMBs1/sizeInMBs;
    set(handles.CompressionRatioDisplayNumber, 'String', sprintf('%.2f', compressed_ratio));

    % Set the Save button for saving the compressed image to disk to true
    % So the user can press the button as the Compression is done
    SaveCompressedImage_Pushedbutton = true;

    handles.compressed_image = compressed_image;
end

% Update handles structure
%guidata(hObject, handles); 


% --- Executes on button press in DecompressImage_Pushbutton.
function DecompressImage_Pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to DecompressImage_Pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selectedFile2;
global sizeInMBs2;

global Decompress_Pushedbutton;
global SaveDecompressedImage_Pushedbutton;

global decompressed_image;


if Decompress_Pushedbutton == false
    errordlg('Select an image first');
else
    % Call the function by passing the image selected from the user for
    % decompressing it
    decompressed_image = decomp(selectedFile2);
    
    % Print the returned compressed image to the axis
    axes(handles.Display_DecompressedOutputImage);
    imshow(decompressed_image)
    
    % Display the size of the decompressed image
    fileinfo = dir('temporaryImageForMeasuringBytesDecomp.png');
    sizeInBytes = fileinfo.bytes;
    sizeInMBs = sizeInBytes/1024/1024;
    set(handles.DecompressedImageDisplaySize, 'String', sprintf('%.2f', sizeInMBs));

    
    % Delete the temporary picture
    delete('temporaryImageForMeasuringBytesDecomp.png')

    % Display the Decompression Ratio
    decompressed_ratio = sizeInMBs2/sizeInMBs;
    set(handles.DecompressionRatioDisplayNumber, 'String', sprintf('%.2f', decompressed_ratio));

    % Set the Save button for saving the compressed image to disk to true
    % So the user can press the button as the Decompression is done
    SaveDecompressedImage_Pushedbutton = true;

    handles.decompressed_image = decompressed_image;
end


function LoadedImageForCompressionDisplaySize_Callback(hObject, eventdata, handles)
% hObject    handle to LoadedImageForCompressionDisplaySize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LoadedImageForCompressionDisplaySize as text
%        str2double(get(hObject,'String')) returns contents of LoadedImageForCompressionDisplaySize as a double


% --- Executes during object creation, after setting all properties.
function LoadedImageForCompressionDisplaySize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LoadedImageForCompressionDisplaySize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function CompressedImageDisplaySize_Callback(hObject, eventdata, handles)
% hObject    handle to CompressedImageDisplaySize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CompressedImageDisplaySize as text
%        str2double(get(hObject,'String')) returns contents of CompressedImageDisplaySize as a double


% --- Executes during object creation, after setting all properties.
function CompressedImageDisplaySize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CompressedImageDisplaySize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function LoadedImageForDecompressionDisplaySize_Callback(hObject, eventdata, handles)
% hObject    handle to LoadedImageForDecompressionDisplaySize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LoadedImageForDecompressionDisplaySize as text
%        str2double(get(hObject,'String')) returns contents of LoadedImageForDecompressionDisplaySize as a double


% --- Executes during object creation, after setting all properties.
function LoadedImageForDecompressionDisplaySize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LoadedImageForDecompressionDisplaySize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DecompressedImageDisplaySize_Callback(hObject, eventdata, handles)
% hObject    handle to DecompressedImageDisplaySize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DecompressedImageDisplaySize as text
%        str2double(get(hObject,'String')) returns contents of DecompressedImageDisplaySize as a double


% --- Executes during object creation, after setting all properties.
function DecompressedImageDisplaySize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DecompressedImageDisplaySize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function DecompressionRatioDisplayNumber_Callback(hObject, eventdata, handles)
% hObject    handle to DecompressionRatioDisplayNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DecompressionRatioDisplayNumber as text
%        str2double(get(hObject,'String')) returns contents of DecompressionRatioDisplayNumber as a double


% --- Executes during object creation, after setting all properties.
function DecompressionRatioDisplayNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DecompressionRatioDisplayNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CompressionRatioDisplayNumber_Callback(hObject, eventdata, handles)
% hObject    handle to CompressionRatioDisplayNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CompressionRatioDisplayNumber as text
%        str2double(get(hObject,'String')) returns contents of CompressionRatioDisplayNumber as a double


% --- Executes during object creation, after setting all properties.
function CompressionRatioDisplayNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CompressionRatioDisplayNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SaveCompressedImage.
function SaveCompressedImage_Callback(hObject, eventdata, handles)
% hObject    handle to SaveCompressedImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SaveCompressedImage_Pushedbutton;
global compressed_image;

% Check if the Save Pushbutton is false which means that the user hasn't
% compressed an image yet
if SaveCompressedImage_Pushedbutton == false
    errordlg('Compress an image first');
else
    % save the compressed image to disk
    imwrite(compressed_image, 'compressed_image.png');
end


% --- Executes on button press in SaveDecompressedImage.
function SaveDecompressedImage_Callback(hObject, eventdata, handles)
% hObject    handle to SaveDecompressedImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SaveDecompressedImage_Pushedbutton;
global decompressed_image;

% Check if the Save Pushbutton is false which means that the user hasn't
% decompressed an image yet
if SaveDecompressedImage_Pushedbutton == false
    errordlg('Decompress an image first');
else
    % save the decompressed image to disk
    imwrite(decompressed_image, 'decompressed_image.png');
end



function CompressionMSE_Callback(hObject, eventdata, handles)
% hObject    handle to CompressionMSE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of CompressionMSE as text
%        str2double(get(hObject,'String')) returns contents of CompressionMSE as a double


% --- Executes during object creation, after setting all properties.
function CompressionMSE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CompressionMSE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
