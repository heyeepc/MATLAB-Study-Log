%% --- 数学建模通用PCA模板（修正版）---

%% 1. 数据准备
% 假设你的原始数据存储在矩阵 X 中。每一行是一个样本，每一列是一个特征。
% 这里的例子使用一个随机生成的数据矩阵
% 假设有 100 个样本，每个样本有 10 个特征
X = rand(100, 10); 
% 注意: 在实际应用中，你需要将你的数据加载到 X 中，例如：
% load('your_data.mat');
% X = your_data;

%% 2. 数据中心化
% 计算每个特征的均值
data_mean = mean(X);
% 将每个样本减去均值，实现中心化
X_centered = X - repmat(data_mean, size(X, 1), 1);

%% 3. 计算协方差矩阵
% C = (X_centered' * X_centered) / (n-1);
% 这里的 'cov' 函数可以一步完成中心化和协方差矩阵的计算，更方便
C = cov(X);

%% 4. 计算特征值和特征向量
% 'eig' 函数用于计算协方差矩阵的特征值和特征向量
% V 是特征向量矩阵，D 是特征值对角矩阵
[V, D] = eig(C);

% 获取特征值
eigenvalues = diag(D);

%% 5. 排序和选择主成分
% 对特征值进行降序排序
[~, sorted_indices] = sort(eigenvalues, 'descend');
sorted_eigenvalues = eigenvalues(sorted_indices);
sorted_eigenvectors = V(:, sorted_indices);

% 计算每个主成分的贡献率（方差解释比例）
explained_variance_ratio = sorted_eigenvalues / sum(sorted_eigenvalues);

% 绘制方差贡献率曲线，以便确定保留多少个主成分
figure;
plot(1:length(explained_variance_ratio), cumsum(explained_variance_ratio), 'o-');
title('主成分累积贡献率');
xlabel('主成分个数');
ylabel('累积贡献率');
grid on;

% 打印每个主成分的贡献率
fprintf('每个主成分的贡献率 (方差解释比例):\n');
for i = 1:length(explained_variance_ratio)
    fprintf('  第 %d 主成分: %.2f%%\n', i, explained_variance_ratio(i)*100);
end

% 通常选择累积贡献率达到 85% 或 90% 的主成分个数
% 假设我们选择前 3 个主成分
num_components = 3; 

% 选取前 num_components 个主成分的特征向量作为投影矩阵 W
W = sorted_eigenvectors(:, 1:num_components);

%% 6. 投影到新空间
% 得到降维后的数据
X_reduced = X_centered * W;

%% 7. 结果展示
fprintf('\n--- 结果汇总 ---\n');
fprintf('原始数据维度: %d x %d\n', size(X, 1), size(X, 2));
fprintf('降维后的数据维度: %d x %d\n', size(X_reduced, 1), size(X_reduced, 2));
fprintf('前 %d 个主成分的累积贡献率: %.2f%%\n', num_components, sum(explained_variance_ratio(1:num_components))*100);

% 如果降维到 2 维或 3 维，可以进行可视化
if num_components == 2
    figure;
    scatter(X_reduced(:, 1), X_reduced(:, 2));
    title('降维后的数据可视化');
    xlabel('主成分 1');
    ylabel('主成分 2');
end