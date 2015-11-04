function [ plastic ] = right( output )
    mat = [0.3811 0.5783 0.0402; 0.1967 0.7244 0.0782; 0.0241 0.1288 0.8444];
    mat2 = [1/sqrt(3) 0 0; 0 1/sqrt(6) 0; 0 0 1/sqrt(2)];
    mat3 = [1 1 1; 1 1 -2; 1 -1 0];
    omg = output;
    Lambrrr = omg(:,:,1);
    Alpharrr = omg(:,:,2);
    Betarrr = omg(:,:,3);
    [rowss, columnss, fuck] = size(omg);
    Lambrrrr = reshape(Lambrrr, 1, rowss * columnss);
    Alpharrrr = reshape(Alpharrr, 1, rowss * columnss);
    Betarrrr = reshape(Betarrr, 1, rowss * columnss);
    LLL = [Lambrrrr; Alpharrrr; Betarrrr];
    LMSr = (mat2 * mat3) \ LLL;
    Lrr = LMSr(1,:);
    Mrr = LMSr(2,:);
    Srr = LMSr(3,:);
    Lr = exp(Lrr);
    Mr = exp(Mrr);
    Sr = exp(Srr);
    RRR = mat \ [Lr; Mr; Sr];
    Rr = RRR(1,:);
    Gr = RRR(2,:);
    Br = RRR(3,:);
    Rr = reshape(Rr,rowss,columnss);
    Gr = reshape(Gr,rowss,columnss);
    Br = reshape(Br,rowss,columnss);
    plastic = cat(3, Rr, Gr, Br);
    %imshow(plastic);


end

