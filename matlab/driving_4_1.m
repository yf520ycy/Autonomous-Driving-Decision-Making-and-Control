% 构建驾驶场景命令
% s = drivingScenario; % 创建一个空的驾驶场景
% s = drivingScenario(Name,Value); % 使用名称和值设置采样时间和仿真时间
s = drivingScenario('SampleTime',0.1,'StopTime',10); %创建一个空的驾驶场景 每隔0.1s对场景进行采样 仿真时间10s
plot(s);  % 绘制驾驶场景