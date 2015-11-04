%in = imread('ocean_day.jpg');
in = imread('2.png');
%in = im2double(in);

[rows, columns, dumb] = size(in);


lab = kidding(in);



lamb = lab(:,:,1);
alpha = lab(:,:,2);
beta =  lab(:,:,3);

%lamb = reshape(lamb, 1, rows * columns);
%lab = reshape(lab, 1, rows * columns);
%beta = reshape(beta, 1, rows * columns);

% delta is a 2mxn matrix
% initialization here, fill everything with 0
delta = zeros(2 * rows * columns, 1);
disp('before');
disp(size(delta));
% for i = 1:rows
% 	for j = 1:columns
% 	
% 		pL = lamb(i,j);
% 		pA = alpha(i,j);
% 		pB = beta(i,j);
%         
%         if (i == rows)
%             q1L = lamb(i, j);
%             q1A = alpha(i, j);
%             q1B = beta(i, j);
%         else
%        		q1L = lamb(i+1, j);
%             q1A = alpha(i+1, j);
%             q1B = beta(i+1, j);
%         end
% 
%         if (j == columns)
%             q2L = lamb(i, j);
%             q2A = alpha(i, j);
%             q2B = beta(i, j);
%         else
%             q2L = lamb(i, j+1);
%             q2A = alpha(i, j+1);
%             q2B = beta(i, j+1);
%         end
%         
% 		% part x
% 		first = (pL - q1L)^2;
% 		second = (pA - q1A)^2;
% 		third = (pB - q1B)^2;
% 		answer1 = (sqrt(first + second + third));
%         if ((pL-q1L)<0)
%             answer1 = -answer1;
%         end
%         delta((j-1) * (rows) + i,1) = answer1;
%         disp((j-1) * (rows) + i);
% 		% part y
% 		first = (pL - q2L)^2;
% 		second = (pA - q2A)^2;
% 		third = (pB - q2B)^2;
% 		answer2 = (sqrt(first + second + third));
%         if ((pL-q2L)<0)
%             answer2 = -answer2;
%         end
%         delta(rows*columns + (j-1) * (rows) + i,1) = answer2;
% 	end
% end


for i=1:columns
    for j=1:rows
        pL = lamb(j,i);
		pA = alpha(j,i);
		pB = beta(j,i);
        
        if (j >= rows)
            q1L = lamb(j, i);
            q1A = alpha(j, i);
            q1B = beta(j, i);
        else
       		q1L = lamb(j+1, i);
            q1A = alpha(j+1, i);
            q1B = beta(j+1, i);
        end

        if (i >= columns)
            q2L = lamb(j, i);
            q2A = alpha(j, i);
            q2B = beta(j, i);
        else
            q2L = lamb(j, i+1);
            q2A = alpha(j, i+1);
            q2B = beta(j, i+1);
        end
        
        % part x
		first = (pL - q1L)^2;
		second = (pA - q1A)^2;
		third = (pB - q1B)^2;
		answer1 = (sqrt(first + second + third));
        if ((pL-q1L)<0)
            answer1 = -answer1;
        end
        
        
		
        % part y
		first = (pL - q2L)^2;
		second = (pA - q2A)^2;
		third = (pB - q2B)^2;
		answer2 = (sqrt(first + second + third));
        if ((pL-q2L)<0)
            answer2 = -answer2;
        end
        
        delta((i-1) * (rows) + j,1)=answer1;
        delta(rows*columns+(i-1) * (rows) + j,1)=answer2;
    end
end

% disp('wow');
% disp(delta(4,1));
% disp(delta);

% make the matrix A, a 2mn x mn matrix
% initialize A here, fill everything with 0
%A = zeros(2 * rows * columns, rows * columns);
BRow = [];
BColumn = [];
BValue = [];
for i = 1:columns
	for j = 1:rows
		%upper half
%         A(i * (rows-1) + j, i * (rows-1) + j)= 1;
%         if (j ~= rows)
%             A(i * (rows-1) + j, i * (rows-1) + (j+1))= -1;
%         end
        %disp((i-1) * (rows) + j);
        %disp((i-1) * (rows) + (j+1));
        BRow(end + 1) = (i-1) * (rows) + j;
        BColumn(end + 1) = (i-1) * (rows) + j;
        BValue(end + 1) = 1;
        
        if (j ~= rows)
            BRow(end + 1) = (i-1) * (rows) + j;
            BColumn(end + 1) = (i-1) * (rows) + (j+1);
            BValue(end + 1) = -1;
        end
        
        %lower half
%         A(rows*columns + i * (rows-1) + j, i * (rows-1) + j)=1;
%         if (i ~= column)
%             A(rows*columns + i * (rows-1) + j, (i+1) * (rows-1) + j)= -1;
%         end
        
        BRow(end + 1) = rows*columns + (i-1) * (rows) + j;
        BColumn(end + 1) = (i-1) * (rows) + j;
        BValue(end + 1) = 1;
        
        if (i ~= columns)
            BRow(end + 1) = rows*columns + (i-1) * (rows) + j;
            BColumn(end + 1) = (i) * (rows) + (j);
            BValue(end + 1) = -1;
        end
        
	end
end

A=sparse(BRow, BColumn,BValue,2*rows*columns,rows*columns);
%disp(A);
disp('rows');
disp(rows);
disp('columns');
disp(columns);
disp('rows* columns');
disp(rows* columns);
disp('2 * rows * columns');
disp(2 * rows * columns);
disp('A');
disp(size(A));
disp('delta');
disp(size(delta));
G  = (A) \ delta;

G = reshape(G, rows, columns);

imshow(G);  