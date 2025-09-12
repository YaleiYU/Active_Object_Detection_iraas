function ROS2RNBVCallback(message)       
    % Declare global variables to store position and orientation
    global Req_NBV

    
      Req_NBV = message.data;

end
