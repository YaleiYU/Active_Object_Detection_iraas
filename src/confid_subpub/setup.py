from setuptools import find_packages, setup

package_name = 'confid_subpub'

setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='YALEIYU',
    maintainer_email='y.yu2@lboro.ac.uk',
    description='subscribe confidence score in customized topic and publish to another topic',
    license='TODO: License declaration',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'confid_subpub = confid_subpub.confid_sub_pub:main',
        ],
    },
)
