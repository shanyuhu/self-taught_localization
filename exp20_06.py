from util import *
import numpy as np
import os
import os.path
import skimage.io
from vlg.util.parfun import *

from heatmap import *
from network import *
from configuration import *
from imgsegmentation import *
from heatextractor import *
from htmlreport import *
import exp20

if __name__ == "__main__":
    # load configurations and parameters  
    conf = Configuration()
    params = exp20.Params()
    # experiment name
    params.exp_name = 'exp20_06'
    # input: PASCAL-2007-test
    params.exp_name_input = 'exp19_01'
    # Segmentation params
    params.ss_version = 'fast'
    params.min_sz_segm = 10 # smaller that usual SelSearch (we resize the img!)
    params.obfuscate_bbox = True 
    # Num elements in batch (for decaf/caffe eval)
    params.batch_sz = 1
    # default Configuration, image and label files
    params.conf = conf
    # select network: 'CAFFE' or 'DECAF'
    params.classifier = 'CAFFE'
    params.center_only = True
    # select top C classes used to generate the heatmaps
    params.topC = 5
    # method for calculating the confidence
    params.heatextractor_confidence_tech = 'full_obf_positive'
    params.segm_type_load = 'warped' # warp to net size 
    # normalize the confidence by area?
    params.heatextractor_area_normalization = True
    # input/output directory
    params.output_dir = conf.experiments_output_directory \
                        + '/' + params.exp_name
    params.input_dir = conf.experiments_output_directory \
                        + '/' + params.exp_name_input 
    # parallelize the script on Anthill?
    params.run_on_anthill = True
    # Set jobname in case the process stop or crush
    params.job_name = None # set to None if you do not want to resume things
    params.task = [] # specify tasks to debug
    logging.info('Started')
    # RUN THE EXPERIMENT
    exp20.run_exp(params)
