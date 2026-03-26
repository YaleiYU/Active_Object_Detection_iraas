# Active_Object_Detection_iraas


## Overview
This repository is the implementation of the paper "A Goal-Oriented Approach for Active Object Detection with Exploration-Exploitation Balance" with the link https://arxiv.org/abs/2509.11467.
This work proposes a novel approach for active object detection that balances exploration and exploitation to efficiently detect target objects in complex environments. The method is evaluated through simulations and real-world experiments, demonstrating its effectiveness in improving detection performance while navigating through the environment. The repository includes the code for the proposed method, as well as instructions for running the simulations and experiments. 



## Features
- Proposed a novel approach for active object detection that balances exploration and exploitation. 
- Developed a measurement model that incorporates both the detection performance and the exploration potential of the robot's actions, allowing for a more informed decision-making process in active object detection tasks.
- Evaluated the method through simulations and real-world experiments, demonstrating its effectiveness in improving detection performance while navigating through the environment.
- Demostration of the pipeline is given in the following figure
<!-- ![Pipeline](Results/aod_fig1.png) -->


## Requirements
- MATLAB R2024b

  
## Qick Start
- There are five steps to run the experiments, for details please see the repository：https://github.com/YaleiYU/UR5e-YOLO-Vision-Integration 

### 1️⃣ Launch RealSense Camera

```bash
ros2 launch realsense2_camera rs_pointcloud_launch.py
```

---

### 2️⃣ Launch UR5e Driver

```bash
ros2 launch ur_robot_driver ur_control.launch.py ur_type:=ur5e robot_ip:=158.125.190.88
```

---

### 3️⃣ Launch YOLO Detection Node

```bash
ros2 launch yolov5_ros2 yolov5_ros2
```


### 4️⃣ Launch Confidence Bridge Node

```bash
ros2 run confid_subpub confid_subpub
```

### 5️⃣ Launch MATLAB Control Node

```bash
matlab -softwareopengl
```

Run in MATLAB:

```matlab
ur5e_ros2_lookAt_control.m
```

---

## Experiments setting 
 
 - The structure is given in the following figure

![Structure](Results/ros2_system_diagram.png)

## Results  
- Active object detection for lego bricks searching in MATLAB simulations using the proposed DCEE method. The robot successfully detects the target objects while navigating through the environment, demonstrating the effectiveness of the proposed approach in simulation scenarios.
![Sim](Results/dcee_aod_matlab_simu.gif)

- Active object detection for lego bricks in real-world scenarios using the proposed DCEE method. The robot successfully detects the target objects while navigating through the environment, demonstrating the effectiveness of the proposed approach in real-world applications. 
![Demo](Results/dcee_aod_expt.gif)

- The videos of simulations and experiments have been uploaded to YouTube and can be accessed through the following links:
  - [Active Object Detection Results](https://www.youtube.com/watch?v=FdFXst8uWxc)
  <!-- - [Active Object Detection Experiment](https://www.youtube.com/watch?v=experiment_video_link) -->


<!-- ![lookahead](Figures/Numerical%20Sim/grad_lksdcee.png) -->



## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


## Acknowledgments
- Thanks to the contributors and maintainers of the open-source libraries and tools used in this project.
- Special thanks to the research community for their valuable insights and feedback.
- This work was supported by by the UK Engineering and Physical Sciences Research Council (EPSRC) Established Career Fellowship “Goal-Oriented Control Systems: Disturbance, Uncertainty and Constraints” under the grant number EP/T005734/1, and EPSRC research grant “Industrial Robots-as-a-Service (IRaaS) - Resilient and responsive manufacturing systems enabled by rapidly deployable mobile robots" under the grant number EP/V050966/2.


## Contact
y.yu2@lboro.ac.uk




