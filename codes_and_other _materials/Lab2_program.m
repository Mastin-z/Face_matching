%% Task1
%Loading database of eigenfaces
load('data_for_eignfaces.mat') 

%Convert the pixel matrix to a vector(Dimension reduction)
[r,c,n]=size(eignfaces_blk);   

%Verify that these eigenfaces are orthogonal%
e=zeros(c,c,n);
x=zeros(1,n);
y=ones(1,n);
    %Generate diagonal matrix
    for i=1:n
        ef=eignfaces_blk(:,:,i);
        e(:,:,i)=rref(ef'*ef);
    end
    %Determine whether the diagonal matrix is E
    for i=1:n
        if isdiag(e(:,:,i))==1
            x(i)=1;
        else 
            x(i)=0;
        end
    end
    
    if x==y
        fprintf ('These eigenfaces are orthogonal\n');
    else
        fprintf('These eigenfaces are not orthogonal\n');
    
    end

%Orthonormal basis
eignfaces_blk_norm=zeros(c,c,n);
for i=1:100
eignfaces_blk_norm(:,:,i)=orth(e(:,:,i));
end

%Verify that these eigenfaces are orthonormal
a=zeros(1,n);
b=ones(1,n);
%Determine whether the diagonal matrix is orthonormal basis
for i=1:100
    if e(:,:,i)==eignfaces_blk_norm(:,:,i)
            a(i)=1;
    else 
            b(i)=0;
    end
end

if a==b
    fprintf ('These eigenfaces are orthonormal\n');
else
    fprintf('These eigenfaces are not orthonormal\n');

end

%% Task2
%Loading database of eigenfaces
load("data_for_eignfaces.mat","eignfaces_blk")

%Call the function get_face_weights
weights_of_face=get_face_weights('find_id.jpg',eignfaces_blk);

%Plot these weighting parameters. 
figure;
plot(weights_of_face);
legend('weight of face');
xlabel('serial number');
ylabel('weights of face');

%% Task3
%Loading database of eigenfaces
load("data_for_eignfaces.mat","eignfaces_blk")
load("weights_of_face.mat")
%Faces are generated according to different number of eigenfaces and weight parameters
img_20=generate_face_from_weights(weights_of_face(1,1:20), eignfaces_blk(:,:,1:20));
img_40=generate_face_from_weights(weights_of_face(1,1:40), eignfaces_blk(:,:,1:40));
img_60=generate_face_from_weights(weights_of_face(1,1:60), eignfaces_blk(:,:,1:60));
img_80=generate_face_from_weights(weights_of_face(1,1:80), eignfaces_blk(:,:,1:80));
img_100=generate_face_from_weights(weights_of_face(1,1:100), eignfaces_blk(:,:,1:100));

%Calculate psnr and display images
figure;
im1=imread('find_id.jpg');
psnr1=psnr(im1,img_20);
psnr2=psnr(im1,img_40);
psnr3=psnr(im1,img_60);
psnr4=psnr(im1,img_80);
psnr5=psnr(im1,img_100);
subplot(2,3,1),imshow(img_20),title(['20',',psnr=',num2str(psnr1)]);
subplot(2,3,2),imshow(img_40),title(['40',',psnr=',num2str(psnr2)]);
subplot(2,3,3),imshow(img_60),title(['60',',psnr=',num2str(psnr3)]);
subplot(2,3,4),imshow(img_80),title(['80',',psnr=',num2str(psnr4)]);
subplot(2,3,5),imshow(img_100),title(['100',',psnr=',num2str(psnr5)]);
subplot(2,3,6),imshow(im1),title('find_id');

%% Task4
%Loading database of eigenfaces
load("data_for_eignfaces.mat","eignfaces_blk")
load("data_for_eignfaces.mat","employees_DB")

    %Recognize employee ID based on her/his face(find_id)
    im='find_id.jpg';
    ID=get_employees_ID_from_DB (im, employees_DB, eignfaces_blk);
    %Make use of that the weight value of the matched ID in the dataset to generate face 
    i=ID;
    db=employees_DB(i).weights;
    img_ID=generate_face_from_weights(db, eignfaces_blk);
    img_ID=uint8(img_ID);

    %Recognize employee ID based on her/his face(face)
    im2='find_id2.jpg';
    ID2=get_employees_ID_from_DB (im2, employees_DB, eignfaces_blk);
    %Make use of that the weight value of the matched ID in the dataset to generate face 
    i=ID2;
    db=employees_DB(i).weights;
    img_ID2=generate_face_from_weights(db, eignfaces_blk);
    img_ID2=uint8(img_ID2);

%Display results
figure;
subplot(2,2,1),imshow(im),title('Scanned face');
subplot(2,2,2),imshow(img_ID),title(['Match with employee ID ',num2str(ID)]);
subplot(2,2,3),imshow(im2),title('Scanned face');
subplot(2,2,4),imshow(img_ID2),title(['Match with employee ID ',num2str(ID2)]);