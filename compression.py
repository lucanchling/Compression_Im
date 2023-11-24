import pywt
import numpy as np
import cv2
import matplotlib.pyplot as plt

im = cv2.imread('08.png',0)

nb_level = 3# compute the 2D DWT

c = pywt.wavedec2(im, 'db2', mode='periodization', level=nb_level)
arr, slices = pywt.coeffs_to_array(c)

print()