function ROS2PosiCallback(message)    
% function conf = ROS2ConfCallback(message)    
    % Declare global variables to store position and orientation
    global Set_cam_pose

    
    % Extract position and orientation from the ROS message and assign the
    % conf to the global variables.
%     pos = [message.linear.x message.linear.y message.linear.z];
%     orient = [message.angular.x message.angular.y message.angular.z];

    % posi = [message.x message.y message.z];

    % posi.x = message.linear.x;
    % posi.y = message.linear.y;
    % posi.z = message.linear.z; 

    Set_cam_pose = message; 


    disp(Set_cam_pose);
end