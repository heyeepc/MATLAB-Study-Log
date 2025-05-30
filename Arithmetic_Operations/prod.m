v = [1, 2, 3, 4, 5];
p_v = prod(v);
disp(['向量 [', num2str(v), '] 的乘积是: ', num2str(p_v)]);
% "number to string"，也就是将数字转换为字符串

M = [1, 2, 3;
     4, 5, 6;
     7, 8, 9];
p_col = prod(M);
disp('矩阵每列的乘积是:');
disp(p_col);

p_row = prod(M, 2);
disp('矩阵每行的乘积是:');
disp(p_row);
