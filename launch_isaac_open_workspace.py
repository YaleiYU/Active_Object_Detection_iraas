# Copyright (c) 2020-2023, NVIDIA CORPORATION. All rights reserved.
#
# NVIDIA CORPORATION and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto. Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA CORPORATION is strictly prohibited.
#

import os
os.system("./set_ld_path.sh")

import argparse
import sys
import carb
from omni.isaac.kit import SimulationApp

simulation_app = SimulationApp({"renderer": "RayTracedLighting", "headless": False})

import omni
from omni.isaac.core import World
from omni.isaac.core.objects import VisualCuboid
from omni.isaac.core.utils.extensions import enable_extension

from geometry_msgs.msg import Pose
from omni.isaac.core.utils import stage, nucleus
from omni.isaac.sensor import Camera

import numpy as np
import omni.graph.core as og
import omni.replicator.core as rep
import omni.syntheticdata._syntheticdata as sd
import omni.isaac.core.utils.numpy.rotations as rot_utils

# enable ROS2 bridge extension
enable_extension("omni.isaac.ros2_bridge")

simulation_app.update()

import time

# Note that this is not the system level rclpy, but one compiled for omniverse
import numpy as np
import rclpy
from rclpy.node import Node
from std_msgs.msg import Empty


BACKGROUND_STAGE_PATH = "/background"

# BACKGROUND_USD_PATH = "/Isaac/Environments/Simple_Warehouse/image_rendering.usd"
# BACKGROUND_USD_PATH = "/Isaac/Environments/Simple_Warehouse/warehouse_with_forklifts.usd"
# BACKGROUND_USD_PATH = "/Isaac/Environments/Simple_Warehouse/warehouse_legos.usd"
# BACKGROUND_USD_PATH = "/Isaac/Environments/Simple_Warehouse/warehouse_legos_s4_3_3.usd" # lego s2
BACKGROUND_USD_PATH = "/Isaac/Environments/Simple_Warehouse/warehouse_legos_s4_4.usd" # lego s1 
# BACKGROUND_USD_PATH = "/Isaac/Environments/Simple_Warehouse/warehouse_legos_s4_5.usd" # dog s1 

# BACKGROUND_USD_PATH = "/Isaac/Environments/Simple_Warehouse/warehouse_dog_s1_0.usd"


# add a camera to the world

camera = Camera(

    prim_path="/World/camera",

    name="cam_1",

    position=np.array([0.0, 3.0, 0.0]),

    frequency=20,

    resolution=(256, 256),
    # resolution=(640, 640),

    orientation=rot_utils.euler_angles_to_quats(np.array([0, 3, 0]), degrees=True),

    )

simulation_app.update()
camera.initialize()


def publish_camera_info(camera: Camera, freq):

    # The following code will link the camera's render product and publish the data to the specified topic name.

    render_product = camera._render_product_path

    step_size = int(60/freq)

    topic_name = camera.name+"_camera_info"

    queue_size = 1

    node_namespace = ""

    frame_id = camera.prim_path.split("/")[-1] # This matches what the TF tree is publishing.


    stereo_offset = [0.0, 0.0]


    writer = rep.writers.get("ROS2PublishCameraInfo")

    writer.initialize(

        frameId=frame_id,

        nodeNamespace=node_namespace,

        queueSize=queue_size,

        topicName=topic_name,

        stereoOffset=stereo_offset,

    )

    writer.attach([render_product])


    gate_path = omni.syntheticdata.SyntheticData._get_node_path(

        "PostProcessDispatch" + "IsaacSimulationGate", render_product

    )


    # Set step input of the Isaac Simulation Gate nodes upstream of ROS publishers to control their execution rate

    og.Controller.attribute(gate_path + ".inputs:step").set(step_size)

    return

def publish_pointcloud_from_depth(camera: Camera, freq):

    # The following code will link the camera's render product and publish the data to the specified topic name.

    render_product = camera._render_product_path

    step_size = int(60/freq)

    topic_name = camera.name+"_pointcloud" # Set topic name to the camera's name

    queue_size = 1

    node_namespace = ""

    frame_id = camera.prim_path.split("/")[-1] # This matches what the TF tree is publishing.


    # Note, this pointcloud publisher will simply convert the Depth image to a pointcloud using the Camera intrinsics.

    # This pointcloud generation method does not support semantic labelled objects.

    rv = omni.syntheticdata.SyntheticData.convert_sensor_type_to_rendervar(

        sd.SensorType.DistanceToImagePlane.name

    )


    writer = rep.writers.get(rv + "ROS2PublishPointCloud")

    writer.initialize(

        frameId=frame_id,

        nodeNamespace=node_namespace,

        queueSize=queue_size,

        topicName=topic_name

    )

    writer.attach([render_product])


    # Set step input of the Isaac Simulation Gate nodes upstream of ROS publishers to control their execution rate

    gate_path = omni.syntheticdata.SyntheticData._get_node_path(

        rv + "IsaacSimulationGate", render_product

    )

    og.Controller.attribute(gate_path + ".inputs:step").set(step_size)


    return

def publish_rgb(camera: Camera, freq):

    # The following code will link the camera's render product and publish the data to the specified topic name.

    render_product = camera._render_product_path

    step_size = int(60/freq)

    topic_name = camera.name+"_rgb"

    queue_size = 1

    node_namespace = ""

    frame_id = camera.prim_path.split("/")[-1] # This matches what the TF tree is publishing.


    rv = omni.syntheticdata.SyntheticData.convert_sensor_type_to_rendervar(sd.SensorType.Rgb.name)

    writer = rep.writers.get(rv + "ROS2PublishImage")

    writer.initialize(

        frameId=frame_id,

        nodeNamespace=node_namespace,

        queueSize=queue_size,

        topicName=topic_name

    )

    writer.attach([render_product])


    # Set step input of the Isaac Simulation Gate nodes upstream of ROS publishers to control their execution rate

    gate_path = omni.syntheticdata.SyntheticData._get_node_path(

        rv + "IsaacSimulationGate", render_product

    )

    og.Controller.attribute(gate_path + ".inputs:step").set(step_size)


    return

def publish_depth(camera: Camera, freq):

    # The following code will link the camera's render product and publish the data to the specified topic name.

    render_product = camera._render_product_path

    step_size = int(60/freq)

    topic_name = camera.name+"_depth"

    queue_size = 1

    node_namespace = ""

    frame_id = camera.prim_path.split("/")[-1] # This matches what the TF tree is publishing.


    rv = omni.syntheticdata.SyntheticData.convert_sensor_type_to_rendervar(

                            sd.SensorType.DistanceToImagePlane.name

                        )

    writer = rep.writers.get(rv + "ROS2PublishImage")

    writer.initialize(

        frameId=frame_id,

        nodeNamespace=node_namespace,

        queueSize=queue_size,

        topicName=topic_name

    )

    writer.attach([render_product])


    # Set step input of the Isaac Simulation Gate nodes upstream of ROS publishers to control their execution rate

    gate_path = omni.syntheticdata.SyntheticData._get_node_path(

        rv + "IsaacSimulationGate", render_product

    )

    og.Controller.attribute(gate_path + ".inputs:step").set(step_size)


    return

class Subscriber(Node):
    def __init__(self):
        super().__init__("tutorial_subscriber")

        # setting up the world with a cube
        self.timeline = omni.timeline.get_timeline_interface()
        self.ros_world = World(stage_units_in_meters=1.0)
        # self.ros_world.scene.add_default_ground_plane()
        
        self.ros_world.scene.add(camera)
        # self.cam_position = np.array([0, -3, 1])
        self.cam_position = np.array([0.750000, -2.308263, 1.763356])
        self.cam_orientation = np.array([0.5253, 0.8509, 0.0, 0.0])
        # self.cam_position = np.array([2.8532, 0, 0.9271])
        # self.cam_orientation = np.array([0.5721, 0.4156, 0.4156, 0.5721])

        simulation_app.update()
        camera.initialize()

        # setup the ROS2 subscriber here

        self.cam_sub = self.create_subscription(Pose, "Set_cam_pose", self.Move_cam_callback, 1)
        self.ros_world.reset()

        self.publisher_ = self.create_publisher(Pose, 'Get_cam_pose', 1)
        timer_period = 0.016666667  # seconds
        self.timer = self.create_timer(timer_period, self.timer_callback)

    def Move_cam_callback(self, data):
        if  self.ros_world.is_playing():
            self.cam_position = np.array([data.position.x, data.position.y, data.position.z])
            self.cam_orientation=np.array([data.orientation.w, data.orientation.x, data.orientation.y, data.orientation.z])

    def timer_callback(self):
        self.get_cam_position = np.array([])
        self.get_cam_orientation = np.array([])
        self.get_cam_position, self.get_cam_orientation = self.ros_world.scene.get_object("cam_1").get_world_pose()
        cam_pose = Pose()

        cam_pose.position.x = self.get_cam_position.data[0]
        cam_pose.position.y = self.get_cam_position.data[1]
        cam_pose.position.z = self.get_cam_position.data[2]

        cam_pose.orientation.w = self.get_cam_orientation.data[0]
        cam_pose.orientation.x = self.get_cam_orientation.data[1]
        cam_pose.orientation.y = self.get_cam_orientation.data[2]
        cam_pose.orientation.z = self.get_cam_orientation.data[3]
        self.publisher_.publish(cam_pose)


    def run_simulation(self):
        self.timeline.play()
        while simulation_app.is_running():
            self.ros_world.step(render=True)
            rclpy.spin_once(self, timeout_sec=0.0)
            if self.ros_world.is_playing():
                if self.ros_world.current_time_step_index == 0:
                    self.ros_world.reset()

                # self.cam_orientation = np.array([0.707,0,0.707,0])
                # self.ros_world.scene.get_object("cam_1").set_world_pose(self.cam_position, self.cam_orientation)
                # self.ros_world.scene.get_object("cam_1").GetAttribute('xformOp:translate').Set(self.cam_position)
                # self.ros_world.scene.get_object("cam_1").GetAttribute('xformOp:orient').Set(self.cam_orientation)
                self.ros_world.scene.get_object("cam_1").set_world_pose(self.cam_position, self.cam_orientation, camera_axes="usd")

        # Cleanup
        self.timeline.stop()
        self.destroy_node()
        simulation_app.close()


if __name__ == "__main__":
    rclpy.init()
    # Locate Isaac Sim assets folder to load environment and robot stages
    
    # assets_root_path = nucleus.get_assets_root_path()
    assets_root_path = "/home/superman-usr/Documents/IRaaS/Active_object_detection/Isaac_sim_ws/isaac_sim-assets-1-2023.1.1/Assets/Isaac/2023.1.1"
    if assets_root_path is None:

        carb.log_error("Could not find Isaac Sim assets folder")

        simulation_app.close()

        sys.exit()

    stage.add_reference_to_stage(assets_root_path + BACKGROUND_USD_PATH, BACKGROUND_STAGE_PATH)
    # world.scene.add(XFormPrim(BACKGROUND_STAGE_PATH, L))
   
    publish_camera_info(camera, 30)

    publish_rgb(camera, 30)

    publish_depth(camera, 30)

    publish_pointcloud_from_depth(camera, 30)
    subscriber = Subscriber()
    subscriber.run_simulation()
