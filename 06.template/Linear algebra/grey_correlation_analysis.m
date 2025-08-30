%% 1. 数据输入
% 将你的数据保存在一个矩阵中。每一列代表一个指标，每一行代表一个样本或时间点。
% 例如，这里我们有4个指标（列），10个样本（行）。
% 请将以下数据替换成你自己的数据。
% 注意：第一列通常是参考数列（母序列）。
Data = [
    10, 25, 5, 50;
    12, 28, 6, 55;
    15, 30, 7, 60;
    14, 32, 6, 58;
    16, 35, 8, 65;
    18, 38, 9, 70;
    20, 40, 10, 75;
    22, 42, 11, 80;
    25, 45, 12, 85;
    24, 43, 11, 82
];

% 设定参考序列和比较序列
% 第1列是参考序列（母序列），它代表我们想要分析的目标。
RefData = Data(:, 1);
% 剩下的列是比较序列（子序列），它们是影响参考序列的因素。
ComData = Data(:, 2:end);

% 设定分辨系数 rho，通常取0.5
rho = 0.5;

%% 2. 数据预处理（均值化）
% 这一步是为了消除不同指标的量纲影响。
% 使用“均值化”方法。
[m, n] = size(Data);
MeanData = mean(Data);
NormalizedData = Data ./ repmat(MeanData, m, 1);

% 提取预处理后的参考序列和比较序列
NormalizedRefData = NormalizedData(:, 1);
NormalizedComData = NormalizedData(:, 2:end);

%% 3. 计算关联系数
% 求差序列
DiffMatrix = abs(NormalizedComData - repmat(NormalizedRefData, 1, n-1));

% 找到最大差值和最小差值
min_diff = min(min(DiffMatrix));
max_diff = max(max(DiffMatrix));

% 计算关联系数矩阵
xi = (min_diff + rho * max_diff) ./ (DiffMatrix + rho * max_diff);

%% 4. 计算关联度
% 将关联系数矩阵的每一列求平均，得到关联度
GreyRelationalDegree = mean(xi);

%% 5. 计算权重并归一化
% 计算每个比较序列的权重
% 关联度越高，权重越大。
TotalDegree = sum(GreyRelationalDegree);
Weights = GreyRelationalDegree / TotalDegree;

%% 6. 计算综合得分
% 综合得分 = 各比较序列的归一化数据 * 对应权重
% 这里我们使用预处理后的数据，即NormalizedComData
CompositeScore = sum(NormalizedComData .* repmat(Weights, m, 1), 2);

%% 7. 结果显示与分析
% 显示最终的关联度（关联度即为未归一化的权重）
fprintf('各比较序列与参考序列的关联度（未归一化权重）为：\n');
for i = 1:length(GreyRelationalDegree)
    fprintf('第 %d 个序列的关联度: %.4f\n', i, GreyRelationalDegree(i));
end

% 显示归一化后的权重
fprintf('\n归一化后的指标权重为：\n');
for i = 1:length(Weights)
    fprintf('第 %d 个序列的权重: %.4f\n', i, Weights(i));
end

% 显示各样本的最终综合得分
fprintf('\n各样本的最终归一化综合得分为：\n');
for i = 1:length(CompositeScore)
    fprintf('第 %d 个样本的得分: %.4f\n', i, CompositeScore(i));
end

% 对得分进行排序
[SortedScores, SortedIndices] = sort(CompositeScore, 'descend');

fprintf('\n根据综合得分从高到低排序如下：\n');
for i = 1:length(SortedIndices)
    fprintf('第 %d 个样本 (得分: %.4f)\n', SortedIndices(i), SortedScores(i));
end