'''
Minimal test, starting stella_vslam.
It tests import and some basic bindings.
You can see stella_vslam console messages while warming up and shutting down.
You need config.yaml and orb_vocab.dbow2.  Feel free to change their paths.
'''

import stella_vslam

print("This is an operation test.  It should open stella_vslam binding module, init and shutdown stella_vslam whitout errors, and nothing else.  You should see many console messages as proof of work.")
print("stella_vslam module content:", dir(stella_vslam))
config = stella_vslam.config(config_file_path="./config.yaml")
SLAM = stella_vslam.system(cfg=config, vocab_file_path="./orb_vocab.dbow2")
SLAM.startup()
SLAM.shutdown()