function [ID] = get_employees_ID_from_DB (im, employees_DB, eignfaces_blk)
    n=size(eignfaces_blk,3);%Read the dimensions of the third dimension of the dataset
    weights_of_face=get_face_weights(im,eignfaces_blk);%Calculate weights_of_face
    euclid=zeros(1,n);

    %Make use of Euclidean distance to calculate the mindistance between the two weights
    for i=1:n
        diff=(employees_DB(i).weights - weights_of_face);
        euclid(1,i)=sqrt(sum(diff.^2));
        min_euclid=min(euclid,[],2);
    end

    %Make use of calculated minimum distance to match the ID
    for i=1:n
        diff=(employees_DB(i).weights - weights_of_face);
        ID_euclid=sqrt(sum(diff.^2));
        if ID_euclid==min_euclid %Matching condition
            ID=i;
        end
    end
    fprintf('The employee ID of find_id is %.0f\n', ID)
end