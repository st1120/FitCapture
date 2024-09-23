import os

import tarfile
from six.moves import urllib


import numpy as np
from PIL import Image
import cv2
from demo import main
import tensorflow as tf



class DeepLabModel(object):
	INPUT_TENSOR_NAME = 'ImageTensor:0'
	OUTPUT_TENSOR_NAME = 'SemanticPredictions:0'
	INPUT_SIZE = 513
	FROZEN_GRAPH_NAME = 'frozen_inference_graph'

	def __init__(self, tarball_path):
		#"""Creates and loads pretrained deeplab model."""
		self.graph = tf.Graph()
		graph_def = None
		# Extract frozen graph from tar archive.
		tar_file = tarfile.open(tarball_path)
		for tar_info in tar_file.getmembers():
			if self.FROZEN_GRAPH_NAME in os.path.basename(tar_info.name):
				file_handle = tar_file.extractfile(tar_info)
				graph_def = tf.GraphDef.FromString(file_handle.read())
				break

		tar_file.close()

		if graph_def is None:
			raise RuntimeError('Cannot find inference graph in tar archive.')

		with self.graph.as_default():
			tf.import_graph_def(graph_def, name='')

		self.sess = tf.Session(graph=self.graph)

	def run(self, image):
		width, height = image.size
		resize_ratio = 1.0 * self.INPUT_SIZE / max(width, height)
		target_size = (int(resize_ratio * width), int(resize_ratio * height))
		resized_image = image.convert('RGB').resize(target_size, Image.ANTIALIAS)
		batch_seg_map = self.sess.run(
			self.OUTPUT_TENSOR_NAME,
			feed_dict={self.INPUT_TENSOR_NAME: [np.asarray(resized_image)]})
		seg_map = batch_seg_map[0]
		return resized_image, seg_map

def create_pascal_label_colormap():
	colormap = np.zeros((256, 3), dtype=int)
	ind = np.arange(256, dtype=int)

	for shift in reversed(range(8)):
		for channel in range(3):
		  colormap[:, channel] |= ((ind >> channel) & 1) << shift
		ind >>= 3

	return colormap

def run(path, height):
	MODEL_NAME = 'xception_coco_voctrainval'  # @param ['mobilenetv2_coco_voctrainaug', 'mobilenetv2_coco_voctrainval', 'xception_coco_voctrainaug', 'xception_coco_voctrainval']

	_DOWNLOAD_URL_PREFIX = 'http://download.tensorflow.org/models/'
	_MODEL_URLS = {
		'mobilenetv2_coco_voctrainaug':
			'deeplabv3_mnv2_pascal_train_aug_2018_01_29.tar.gz',
		'mobilenetv2_coco_voctrainval':
			'deeplabv3_mnv2_pascal_trainval_2018_01_29.tar.gz',
		'xception_coco_voctrainaug':
			'deeplabv3_pascal_train_aug_2018_01_04.tar.gz',
		'xception_coco_voctrainval':
			'deeplabv3_pascal_trainval_2018_01_04.tar.gz',
	}
	_TARBALL_NAME = _MODEL_URLS[MODEL_NAME]

	model_dir = 'deeplab_model'
	if not os.path.exists(model_dir):
		tf.gfile.MakeDirs(model_dir)

	download_path = os.path.join(model_dir, _TARBALL_NAME)
	if not os.path.exists(download_path):
		print('downloading model to %s, this might take a while...' % download_path)
		urllib.request.urlretrieve(_DOWNLOAD_URL_PREFIX + _MODEL_URLS[MODEL_NAME], 
					download_path)
		print('download completed! loading DeepLab model...')
	
	MODEL = DeepLabModel(download_path)
	print('model loaded successfully!')

	image = Image.open(path)

	res_im,seg=MODEL.run(image)

	seg=cv2.resize(seg.astype(np.uint8),image.size)
	mask_sel=(seg==15).astype(np.float32)
	mask = 255*mask_sel.astype(np.uint8)

	img = 	np.array(image)
	img = cv2.cvtColor(img, cv2.COLOR_RGB2BGR)   

	res = cv2.bitwise_and(img,img,mask = mask)
	bg_removed = res + (255 - cv2.cvtColor(mask, cv2.COLOR_GRAY2BGR)) 
	return main(bg_removed,height,None)