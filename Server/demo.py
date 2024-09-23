from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
import extract_measurements
from absl import flags
import numpy as np

import tensorflow as tf

from src.util import image as img_util
from src.util import openpose as op_util
from src.RunModel import RunModel

flags.DEFINE_string('img_path', 'data/k3.png', 'Image to run')
flags.DEFINE_string(
    'json_path', None,
    'If specified, uses the openpose output to crop the image.')


def preprocess_image(img_path, json_path=None):
    img = img_path
    print("$$$$$$$",img.shape)
    if img.shape[2] == 4:
        img = img[:, :, :3]

    if json_path is None:
        if np.max(img.shape[:2]) != 224:
#            print('Resizing so the max image size is %d..' % config.img_size)
            scale = (float(224) / np.max(img.shape[:2]))
        else:
            scale = 1.
        center = np.round(np.array(img.shape[:2]) / 2).astype(int)
        # image center in (x,y)
        center = center[::-1]
    else:
        scale, center = op_util.get_bbox(json_path)

    crop, proc_param = img_util.scale_and_crop(img, scale, center,
                                               224)

    crop = 2 * ((crop / 255.) - 0.5)

    return crop, proc_param, img


def main(img_path, height, json_path=None):
    sess = tf.Session()
    model = RunModel(sess=sess)

    input_img, proc_param, img = preprocess_image(img_path, json_path)
    input_img = np.expand_dims(input_img, 0)

    joints, verts, cams, joints3d, theta = model.predict(
        input_img, get_theta=True)
    
    res = extract_measurements.extract_measurements(height,verts[0])
    return res