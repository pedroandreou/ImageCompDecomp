function imageCompressed = comp(filename)
    
    warning('off');
    
    % check if the image is already grayscale
    % Get the number of rows and columns, 
    % and, most importantly, the number of color channels.
    originalImage = imread(filename);
    [rows, columns, numberOfColorChannels] = size(originalImage);

    if numberOfColorChannels > 1
    % It's a true color RGB image.  We need to convert to gray scale.
    original_image = rgb2gray(imresize(imread(filename),0.5));
    else
    % It's already gray scale.  No need to convert.
    original_image = imresize(imread(filename),0.5);
    end
    
    block_size=8;
    % An error is flagged if the image size is not divisible by the block
    % size (8)
    DTC_image = im2double(original_image);
    dctMatrix = dctmtx(block_size); % DCT Matrix of size 8x8
    dct_func = @(block_struct) dctMatrix * block_struct.data * dctMatrix';
        
    % blockproc will break up DTC_image into blocks, and apply 'dct_func' to
    % each block
    B = blockproc(DTC_image,[block_size block_size], dct_func);
        
    % 1 - (1/blocksize^2) % of coefficients will be zeroed out
    % blocksize = 8 therefore removes ~95% of DCT coefficients
    mask = zeros(block_size);
    mask(1,1)=1; 
        
    % Apply the mask to each block
    B2 = blockproc(B,[block_size block_size],@(block_struct) mask * block_struct.data);
    % Inverse DCT blockproc function
    invdct = @(block_struct) dctMatrix' * block_struct.data * dctMatrix;
    % Apply the inverse dctf to view image
    compress_img = blockproc(B2,[block_size block_size], invdct);
    
    % Huffman encoding
    
    [m,n]=size(B2);                                 % Get size of original image
    Totalcount=m*n;
    cnt=1;
    for i=0:255                                     % get the probability of each
      k=uint8(B2)==i;                               % grey level
      count(cnt)=sum(k(:));
      pro(cnt)=count(cnt)/Totalcount;
      cnt=cnt+1;
    end
    
    symbols = [0:255];                              
    dict = huffmandict(symbols,pro);                % Build the dictionary
    
    B2_vector_string=uint8(B2(:));                  % Convert to Uint8 & Vector
    comp1 = huffmanenco(B2_vector_string,dict);     % Huffman Encode

    % temporary png compressed image
    % so it can be saved as a variable in the .mat file
    imwrite(compress_img,'temporaryCompressedImage.png');
    compressed_png = imread('temporaryCompressedImage.png');

    % Save to a .mat file
    save('dct_huffman_image.mat','comp1','dict','m','n', 'B2','invdct', 'compress_img', 'compressed_png')

    
    % the returned argument
    imageCompressed = compress_img;

    % save the imageCompressed
    % so it can be used by the dir function to find the corresponding ratio
    imwrite(imageCompressed,'temporaryImageForMeasuringBytesComp.png');

end