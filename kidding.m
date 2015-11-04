function [ output ] = kidding( in )
%RGBTOLAB Summary of this function goes here
%   Detailed explanation goes here
    in = im2double(in);

    %R = double(in(:,:,1));
    %G = double(in(:,:,2));
    %B = double(in(:,:,3));
    
    R = (in(:,:,1));
    G = (in(:,:,2));
    B = (in(:,:,3));

    [rows, columns, numberOfColorChannels] = size(in);
    disp(rows);
    %R = double(R);
    %G = double(G);
    %B = double(B);

    imgSize = rows * columns;

    % Conjure up RGB matrix
    RGB = [reshape(R,1,imgSize);reshape(G,1,imgSize);reshape(B,1,imgSize)];

    %reverse ok
    %Rr = reshape(R, rows, columns);
    %Gr = reshape(G, rows, columns);
    %Br = reshape(B, rows, columns);
    %plastic = cat(3, Rr, Gr, Br);
    %imshow(plastic);
    
    
    % Matrix Given
    mat = [0.3811 0.5783 0.0402; 0.1967 0.7244 0.0782; 0.0241 0.1288 0.8444];

    % Conjure up LMS matrix
    LMS = mat * RGB;
    disp(size(LMS));
    L = LMS(1,:);
    M = LMS(2,:);
    S = LMS(3,:);

    
    % reverse ok
%     RRR = mat \ LMS;
%     Rr = RRR(1,:);
%     Gr = RRR(2,:);
%     Br = RRR(3,:);
%     Rr = reshape(Rr,rows,columns);
%     Gr = reshape(Gr,rows,columns);
%     Br = reshape(Br,rows,columns);
%     plastic = cat(3, Rr, Gr, Br);
%     imshow(plastic);
    
    
    % From LMS to log-LMS
    L = log(max(eps,L));
    M = log(max(eps,M));
    S = log(max(eps,S));
    
    
    % reverse ok
%     Lr = exp(L);
%     Mr = exp(M);
%     Sr = exp(S);
%     RRR = mat \ [Lr; Mr; Sr];
%     Rr = RRR(1,:);
%     Gr = RRR(2,:);
%     Br = RRR(3,:);
%     Rr = reshape(Rr,rows,columns);
%     Gr = reshape(Gr,rows,columns);
%     Br = reshape(Br,rows,columns);
%     plastic = cat(3, Rr, Gr, Br);
%     imshow(plastic);
    
    
    % Conjure up LAB matrix
    mat2 = [1/sqrt(3) 0 0; 0 1/sqrt(6) 0; 0 0 1/sqrt(2)];
    mat3 = [1 1 1; 1 1 -2; 1 -1 0];
    LAB = mat2 * mat3 * [L;M;S];

    lamb = LAB(1,:);
    alpha = LAB(2,:);
    beta = LAB(3,:);
    
    % reverse ok
%     LLL = [lamb; alpha; beta];
%     LMSr = (mat2 * mat3) \ LLL;
%     Lrr = LMSr(1,:);
%     Mrr = LMSr(2,:);
%     Srr = LMSr(3,:);
%     Lr = exp(L);
%     Mr = exp(M);
%     Sr = exp(S);
%     RRR = mat \ [Lr; Mr; Sr];
%     Rr = RRR(1,:);
%     Gr = RRR(2,:);
%     Br = RRR(3,:);
%     Rr = reshape(Rr,rows,columns);
%     Gr = reshape(Gr,rows,columns);
%     Br = reshape(Br,rows,columns);
%     plastic = cat(3, Rr, Gr, Br);
%     imshow(plastic);    
    

    

    %output1 = [lamb; alpha; beta];
    
    lamb = reshape(lamb, rows, columns);
    alpha = reshape(alpha, rows, columns);
    beta = reshape(beta, rows, columns);
    
    output = cat(3,lamb, alpha, beta);
    %imshow(output);
    
    %reverse ok
%     omg = output;
%     Lambrrr = omg(:,:,1);
%     Alpharrr = omg(:,:,2);
%     Betarrr = omg(:,:,3);
%     [rowss, columnss, fuck] = size(omg);
%     Lambrrrr = reshape(Lambrrr, 1, rowss * columnss);
%     Alpharrrr = reshape(Alpharrr, 1, rowss * columnss);
%     Betarrrr = reshape(Betarrr, 1, rowss * columnss);
%     LLL = [Lambrrrr; Alpharrrr; Betarrrr];
%     LMSr = (mat2 * mat3) \ LLL;
%     Lrr = LMSr(1,:);
%     Mrr = LMSr(2,:);
%     Srr = LMSr(3,:);
%     Lr = exp(L);
%     Mr = exp(M);
%     Sr = exp(S);
%     RRR = mat \ [Lr; Mr; Sr];
%     Rr = RRR(1,:);
%     Gr = RRR(2,:);
%     Br = RRR(3,:);
%     Rr = reshape(Rr,rows,columns);
%     Gr = reshape(Gr,rows,columns);
%     Br = reshape(Br,rows,columns);
%     plastic = cat(3, Rr, Gr, Br);
%     imshow(plastic);


end

