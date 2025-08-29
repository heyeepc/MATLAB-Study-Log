% 这是一个用于自动构建层次分析法 (AHP) 判断矩阵的MATLAB脚本模板

% -------------------------
% 步骤1: 定义你的元素名称和它们的相对重要性值
% -------------------------
% 将你的元素名称存储在一个元胞数组中
elements = {'A', 'B', 'C', 'D', 'F'};

% 将你给定的相对重要性值存储在一个向量中
% 这里我们假设这些值是相对于第一个元素 'A' 的重要性
relative_values = [1, 2, 3, 6, 9];

% -------------------------
% 步骤2: 自动构建判断矩阵
% -------------------------
n = length(elements);
judgment_matrix = zeros(n, n);

% 遍历所有元素，自动填写矩阵
for i = 1:n
    for j = 1:n
        % 主对角线元素为1（自己和自己的比较）
        if i == j
            judgment_matrix(i, j) = 1;
        % 如果 i>j，根据 AHP 规则，A_ij = A_i / A_j
        % 并且 A_ji = 1 / A_ij
        else
            judgment_matrix(i, j) = relative_values(i) / relative_values(j);
        end
    end
end

% -------------------------
% 步骤3: 显示结果
% -------------------------
fprintf('元素列表:\n');
disp(elements);

fprintf('构建的判断矩阵:\n');
disp(judgment_matrix);

% -------------------------
% 步骤4: 可选 - 验证矩阵的倒数对称性
% -------------------------
fprintf('--- 验证矩阵 --- \n');
% 检查是否满足 a_ji = 1/a_ij
is_reciprocal_ok = true;
for i = 1:n
    for j = 1:n
        if i ~= j
            if abs(judgment_matrix(i, j) - 1/judgment_matrix(j, i)) > 1e-9
                is_reciprocal_ok = false;
                break;
            end
        end
    end
    if ~is_reciprocal_ok
        break;
    end
end

if is_reciprocal_ok
    disp('矩阵构建成功，满足倒数对称性。');
else
    disp('矩阵构建失败，不满足倒数对称性。');
end
