% --- 1. 定义数据 ---

% 原始决策矩阵
% 每一行代表一个方案（比如汽车A, B, C）
% 每一列代表一个指标（比如价格, 续航, 耗油量）
% 假设有3个方案和3个指标
data_matrix = [
    20,  500, 7;
    15,  450, 6;
    25,  600, 8
];

% 指标类型向量（重要！）
% 1表示效益型（越大越好），-1表示成本型（越小越好）
% 价格和耗油量是成本型，续航是效益型
criteria_type = [-1, 1, -1];
% 2选择并调用预处理函数
normalized_data = minmax_normalize(data_matrix, criteria_type);


% --- 2. 熵权法函数 ---

function weights = entropy_method(data_matrix, criteria_type)
    % 获取矩阵的行数（方案数）和列数（指标数）
    [m, n] = size(data_matrix);

    % (1) 数据预处理：统一所有指标的类型（将成本型指标转为效益型）
    % 这一步非常关键，它确保所有指标的“好”方向是一致的
    processed_matrix = data_matrix;
    for j = 1:n
        if criteria_type(j) == -1 % 如果是成本型指标
            % 将数据进行逆向处理（比如取最大值减去原始值）
            processed_matrix(:, j) = max(data_matrix(:, j)) - data_matrix(:, j);
        end
    end
    
    % (2) 矩阵规范化
    % 将矩阵进行归一化处理，计算每一列的“贡献度”
    sum_col = sum(processed_matrix, 1);
    P = processed_matrix ./ repmat(sum_col, m, 1);
    
    % (3) 计算每个指标的信息熵
    % 如果 Pij 等于0，则 Pij*log(Pij) = 0
    % 为了避免log(0)报错，需要处理 Pij=0 的情况
    P(P == 0) = 1e-6; % 用一个非常小的正数代替
    E = - (1/log(m)) * sum(P .* log(P), 1);
    
    % (4) 计算每个指标的差异系数
    % 差异系数越大，说明该指标包含的信息越多
    D = 1 - E;
    
    % (5) 计算熵权
    % 将差异系数归一化，得到最终的权重
    weights = D ./ sum(D);
end

% --- 3. 调用函数 ---

final_weights = entropy_method(data_matrix, criteria_type);

% 显示结果
disp('通过熵权法计算出的权重:');
disp(final_weights);
