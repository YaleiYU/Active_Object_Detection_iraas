import rclpy
from rclpy.node import Node
from bboxes_msgs.msg import BoundingBoxes
from std_msgs.msg import Float32

class MinimalSubscriber(Node):

    def __init__(self):
        super().__init__('minimal_subscriber')
        self.subscription = self.create_subscription(
            BoundingBoxes,
            'yolov5/bounding_boxes',
            self.listener_callback,
            10)
        self.subscription  # prevent unused variable warning
        self.publisher_ = self.create_publisher(Float32, 'confidence_score', 10)

    def listener_callback(self, msg):
        if len(msg.bounding_boxes) != 0:
            self.get_logger().info('det 1 confidence: "%f"' % msg.bounding_boxes[0].confidence)
            conf_msg = Float32()
            conf_msg.data = msg.bounding_boxes[0].confidence
            self.publisher_.publish(conf_msg)
        else:
            self.get_logger().info('no detection.')
            conf_msg = Float32()
            conf_msg.data = 0.0
            self.publisher_.publish(conf_msg) 

def main(args=None):
    rclpy.init(args=args)
    # node = image_publisher()
    node = MinimalSubscriber()
    
    rclpy.spin(node)
    rclpy.shutdown()

if __name__ == "__main__":
    main()