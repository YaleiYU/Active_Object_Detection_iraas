function ROS2ConfCallback(message)    
% function conf = ROS2ConfCallback(message)    
    % Declare global variables to store position and orientation
    global conf

    
    % Extract position and orientation from the ROS message and assign the
    % conf to the global variables.
%     pos = [message.linear.x message.linear.y message.linear.z];
%     orient = [message.angular.x message.angular.y message.angular.z];

    conf = message.data;
    % disp(conf);

    % global conf_plt
    % set(conf_plt, 'XData', [conf_plt.XData,conf_plt.XData(end)+1],'YData',[conf_plt.YData, conf])
    % drawnow
end
