function [img] = generate_face_from_weights(weights_of_face, eignfaces_blk)
    n=size(eignfaces_blk,3);%Read the dimensions of the third dimension of the dataset
    
    %Faces are generated according to eigenfaces and weight parameters
    img=0;
    for i=1:n
        ef=eignfaces_blk(:,:,i);
        w=weights_of_face(1,i);
        img=img+ef*w;
    end
    %Uniformly increase gray values and eliminate negative pixel values
    img=img+128;
    img=uint8(img);
end
