# Active_Object_Detection_IRaaS

## Overview
This repository implements the paper:

**"A Goal-Oriented Approach for Active Object Detection with Exploration-Exploitation Balance"**  
🔗 https://arxiv.org/abs/2509.11467  

The project introduces a novel framework for **active object detection**, enabling robots to intelligently balance:
- **Exploration** (searching new areas)
- **Exploitation** (focusing on likely target regions)

This balance improves detection efficiency in complex environments. The approach is validated through both **simulation** and **real-world experiments** using a UR5e robotic system.

---

## Key Features
- Goal-oriented active object detection strategy  
- Balanced exploration–exploitation decision-making  
- Measurement model integrating:
  - Detection confidence
  - Exploration potential  
- Integration with real robotic hardware (UR5e + RealSense + YOLO)  
- Verified in both simulation and real-world scenarios  

---

## System Pipeline
The full pipeline integrates perception, decision-making, and control:

- RealSense camera → Images
- YOLO → Object detection
- Confidence bridge → Data fusion
- MATLAB → Decision-making (DCEE algorithm)
- UR5e → Motion execution

---

## Quick Start

Follow these steps to run the real-world experiment:

### 1️⃣ Launch RealSense Camera
```bash
ros2 launch realsense2_camera rs_pointcloud_launch.py
```

### 2️⃣ Launch UR5e Driver
```bash
ros2 launch ur_robot_driver ur_control.launch.py ur_type:=ur5e robot_ip:=158.125.190.88
```

### 3️⃣ Launch YOLO Detection Node
```bash
ros2 launch yolov5_ros2 yolov5_ros2
```

### 4️⃣ Launch Confidence Bridge Node
```bash
ros2 run confid_subpub confid_subpub
```

### 5️⃣ Run MATLAB Control Node
```matlab
DCEE_lego_s1_ros2_urscript_multi_run.m
```

📎 Full setup instructions:  
https://github.com/YaleiYU/UR5e-YOLO-Vision-Integration  

---

## Isaac Sim Virtual Simulation

Follow these steps to run the virtual simulation in Isaac Sim.

The Isaac Sim assets (USD scenes and LEGO brick models) are provided in the `DCEE_AOD_Assets` folder.

> **Note:** `pre_isaac_sim_setup` and `iraas_python` are shell aliases on the lab machine. Define equivalents on your own system, e.g. in `~/.bashrc`:
> ```bash
> # Point LD_LIBRARY_PATH at Isaac Sim's bundled ROS2 libraries so omni.isaac.ros2_bridge can load
> alias pre_isaac_sim_setup='export ROS_DISTRO=humble RMW_IMPLEMENTATION=rmw_fastrtps_cpp LD_LIBRARY_PATH=$LD_LIBRARY_PATH:<ISAAC_SIM_ROOT>/exts/omni.isaac.ros2_bridge/humble/lib'
> # Isaac Sim's bundled Python interpreter
> alias iraas_python='<ISAAC_SIM_ROOT>/python.sh'
> ```
> where `<ISAAC_SIM_ROOT>` is your Isaac Sim installation directory (e.g. `~/.local/share/ov/pkg/isaac-sim-<version>`).

### 1️⃣ Launch Isaac Sim with ROS2 for Images
```bash
pre_isaac_sim_setup   # sets LD_LIBRARY_PATH to enable omni.isaac.ros2_bridge
iraas_python ~/Documents/IRaaS/Active_object_detection/Isaac_sim_ws/launch_isaac_open_workspace.py   # runs the Isaac Sim launch file (can also be debugged in VS Code)
```

### 2️⃣ Launch YOLO Detector
```bash
ros2 launch yolov5_ros yolov5s_launch.py
```

### 3️⃣ Launch Confidence Score Publisher and Subscriber
```bash
iraas_python ~/Documents/IRaaS/Active_object_detection/Isaac_sim_ws/yolov5_sub_pub.py
```

### 4️⃣ Run DCEE Algorithm in MATLAB
```matlab
DCEE_lego_s1_ros2_multi_run.m
```

---

## Experiments

### Simulation
- LEGO brick detection in Isaac Sim environment  
- Demonstrates efficient exploration and detection  

### Real-World Experiment
- UR5e robot performs active search  
- Successfully detects targets in physical environment  

🎥 Demo Video:  
https://www.youtube.com/watch?v=FdFXst8uWxc  

![Sim](Results/dcee_aod_matlab_simu.gif)
![Demo](Results/dcee_aod_expt.gif)

---

## Requirements
- MATLAB R2024b  
- ROS2  
- Intel RealSense Camera  
- UR5e Robot  
- YOLOv5 ROS2 package  


---

## License
This project is licensed under the MIT License.  
See the `LICENSE` file for details.

---

## Acknowledgments
This work was supported by:

- UK EPSRC Established Career Fellowship  
  *“Goal-Oriented Control Systems: Disturbance, Uncertainty and Constraints”* (EP/T005734/1)

- EPSRC Project  
  *“Industrial Robots-as-a-Service (IRaaS)”* (EP/V050966/2)

Special thanks to the open-source community and contributors.

---

## Citation
If you use this work, please cite:

```bibtex
@misc{yu2025goal,
     author        = {Yu, Yalei and Coombes, Matthew and Chen, Wen-Hua and Sun, Cong and Flanagan, Myles and Jiang, Jingjing and Pashupathy, Pramod and Sotoodeh-Bahraini, Masoud and Kinnell, Peter and Lohse, Niels},
     title         = {{A Goal-Oriented Approach for Active Object Detection with Exploration-Exploitation Balance}},
     journal       = {arXiv preprint arXiv:2509.11467},
     year          = {2025},
     url           = {http://arxiv.org/abs/2509.11467}
}
```
