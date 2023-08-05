% 构建道路
% road(s,roadCenters); % 在驾驶场景中添加道路
% road(s,roadCenters,roadWidth); % 在驾驶场景中添加指定宽度的道路
% road(s,roadCenters,roadWidth,bankingAngle); % 在驾驶场景中添加指定宽度和倾斜角度的道路
% road(s,roadCenters,'Lanes',lspec); % 在驾驶场景中添加指定车道的道路
% road(s,roadCenters,bankingAngle,'Lanes',lspec); % 在驾驶场景中添加指定倾斜角度和车道的道路

% 1.构造直道
% s = drivingScenario;
% roadCenters = [0,0;100,0]; % 设置道路中心位置
% roadWidth = 16; % 设置道路宽度
% road(s,roadCenters,roadWidth); % 在驾驶场景中添加道路
% plot(s);

% 2.构建十字交叉路
% s = drivingScenario;
% roadCenters = [0,0;100,0]; % 设置道路中心位置
% roadWidth = 16; % 设置道路宽度
% road(s,roadCenters,roadWidth); % 在驾驶场景中添加道路
% roadCenters = [50,-50;50,50];
% road(s,roadCenters,roadWidth); % 在驾驶场景中添加道路
% plot(s);

% 3.构建丁字路
% s = drivingScenario;
% roadCenters = [0,0;92,0]; % 设置道路中心位置
% roadWidth = 16; % 设置道路宽度
% road(s,roadCenters,roadWidth); % 在驾驶场景中添加道路
% roadCenters = [92,-50;92,50];
% road(s,roadCenters,roadWidth); % 在驾驶场景中添加道路
% plot(s);

% 4.构建弯道
% 弯道可以用三个或者更多的点来描述 使用的点越多 可以构建的弯道越复杂
% s = drivingScenario;
% roadCenters = [0,0;50,25;100,60]; % 设置道路中心位置
% roadWidth = 16; % 设置道路宽度
% road(s,roadCenters,roadWidth); % 在驾驶场景中添加道路
% plot(s)

% 5.构建环道
% 环道 要采用分段旋转曲线 需要重复第一个点和最后一个点
% 5.1 构建四个出口的环道
% s = drivingScenario;
% roadCenters = [-15,-15;15,-15;15,15;-15,15;-15,-15]; % 设置道路中心位置
% road(s,roadCenters); % 在驾驶场景中添加道路
% road(s,[-35,0;-20,0]); % 设置环路出口
% road(s,[20,0;35,0]); % 设置环路出口
% road(s,[0,20;0,35]); % 设置环路出口
% road(s,[0,-35;0,-20]); % 设置环路出口
% plot(s)

% 5.2 构建八字形道路
% s = drivingScenario;
% roadCenters = [0,0,1;20,-20,1;20,20,1;-20,-20,1;-20,20,1;0,0,1]; % 设置道路中心位置
% roadWidth = 3;
% bankAngle = [0,15,15,-15,-15,0]; % 设置道路的倾斜角度
% road(s,roadCenters,roadWidth,bankAngle); % 在驾驶场景中添加道路
% plot(s)

% 6.构建道路的车道
% lnspec = lanespec(numlanes) % 设置车道数
% lnspec = lanespec(numlanes,Name,Value) % 使用一个或多个名称设置车道
% 车道数numlanes用[NL,NR]表示 NL表示左车道的数量 NR表示右车道的数量
% 车道宽度Width 如果是标量所有车道一样宽度 如果是矢量 从左到右依次指向车道 [3.5,3.7,3.7,3.5]
% 车道线 laneMarking 其中'Unmarked' 表示没有车道线 'Solid'表示车道线为实线 'Dashed'表示车道线为虚线
% 'DoubleSolid'表示车道线为两条实线 'DoubleDashed'表示车道线为两条虚线 'SolidDashed'表示左边实右边虚 'DashedSolid'表示左边虚右边实
% 默认情况下 对于单向道路 最右侧和中心车道线为白色 最左侧车道线为黄色 对于双向道路 分隔车道线的颜色为黄色

% 6.1 构建双向6车道直路
% s = drivingScenario;
% roadCenters = [0,0;100,0];
% road(s,roadCenters,'Lanes',lanespec([3 3]));
% plot(s,'roadCenters','on');

% 6.2 构建双向4车道直路 中间分割线左实右虚 颜色黄色
s = drivingScenario;
roadCenters = [0,0;100,0];
lm = [laneMarking('Solid'),laneMarking('Dashed'),laneMarking('SolidDashed','color','y'),...
    laneMarking('Dashed'),laneMarking('Solid')];% 设置标线 双向4车道需要5个参数 不够会报错
ls = lanespec([2,2],'Marking',lm); % 设置车道
road(s,roadCenters,'Lanes',ls);
plot(s,'roadCenters','on');
