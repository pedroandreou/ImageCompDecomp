function imageDecompressed = decomp(filename)

    % read the mat file
    mat_file = matfile(filename);

    % find the variables of the mat file
    comp1 = mat_file.comp1;
    dict = mat_file.dict;
    m = mat_file.m;
    n = mat_file.n;
    B2 = mat_file.B2;
    invdct = mat_file.invdct;

    block_size=8;

    % Decode Huffman vector

    decomp1 = uint8(huffmandeco(comp1,dict));       % recode into vector
    decoded_array=reshape(decomp1,m,n);             % Reshape array
    
    % Reapply inverse DCT & Show the results
    
    decoded_compressed_img = blockproc(B2,[block_size block_size], invdct);

    % the returned argument
    imageDecompressed = decoded_compressed_img;

    
    % save the imageDecompressed
    % so it can be used by the dir function to find the corresponding ratio
    imwrite(imageDecompressed,'temporaryImageForMeasuringBytesDecomp.png');

end