function [weights_of_face]= get_face_weights(im,eignfaces_blk)
    im=imread(im);
    im=double(im(:));          %Convert data types and reduce dimensions
    n=size(eignfaces_blk,3);   %Read the dimensions of the third dimension of the dataset
    weights_of_face=zeros(1,n);
    
    %The weight values of 100 eignfaces were calculated in for loop
    for i=1:n
        ef=eignfaces_blk(:,:,i);
        ef=ef(:);                                     %reduce dimensions
        weights_of_face(1,i)=mean(im.*ef);            %Calculate the weights of face
        save('weights_of_face.mat','weights_of_face');%Rearrange the resulting data.
    end
end