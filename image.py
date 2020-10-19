from skimage import data, io, filters, feature, measure, morphology #pip install scikit-image
from matplotlib import pyplot as plt, patches
import numpy as np
from PIL import Image
from skimage.morphology import skeletonize
from skimage import data
import matplotlib.pyplot as plt
from skimage.util import invert

MAX_PICTURE_WIDTH = 2500 #Global for Max picture size (pixels)

# Draw red boxes around discrete portions of the image
# Does not work well for our ATM images
def redboxes(imageObject):
    img = np.asarray(imageObject)
    edgestemp = feature.canny(img, sigma=0.5)
    edges = morphology.label(edgestemp)

    fig = plt.figure()
    ax = fig.add_subplot()
    ax.imshow(img, cmap=plt.cm.gray)
    for region in measure.regionprops(edges):
        minr, minc, maxr, maxc = region.bbox
        rect = patches.Rectangle((minc, minr),
            maxc - minc, maxr - minr, fill=False,
            edgecolor='red', linewidth=2)
        ax.add_patch(rect)
    plt.show()

# Use the canny edge finding algorithm on the image
def cannyLines(imageObject):
    img = np.asarray(imageObject)
    edges = feature.canny(img, sigma=1)
    plt.imshow(edges)
    plt.show()

#Convert the image to be in two colors only
#Numbers are very clear in this image, maybe look into?
def BinaryColor(imageObject):
    img = np.asarray(imageObject)
    val = filters.threshold_yen(img)
    mask = img < val
    plt.imshow(mask)
    plt.show()

#Run the canny edge finding on the binary image
#Doesn't work well
def VeryCanny(imageObject):
    img = np.asarray(imageObject)
    val = filters.threshold_yen(img)
    mask = img < val
    edges = feature.canny(mask)
    plt.imshow(edges)
    plt.show()

#Skeletonization, doesnt do invidual lines well but could be used to get overall shape.

def skeletonizer(imageObject):
    img = np.asarray(imageObject)
    binary = img > filters.threshold_otsu(img)
    np.unique(binary)
    image = invert(binary)

    skeleton = skeletonize(binary)
    plt.imshow(skeleton)
    plt.show()

#Resizes photo to specified max width, keeps scale.
#Takes in file name as string, creates new .jpg named "file_nameResized.jpg "
def resizeFunc(file_name):
    #function stolen from https://gist.github.com/tomvon/ae288482869b495201a0

    img = Image.open(file_name + ".jpg")
    wpercent = (MAX_PICTURE_WIDTH / float(img.size[0]))

    hsize = int((float(img.size[1]) * float(wpercent)))
    img = img.resize((MAX_PICTURE_WIDTH, hsize), Image.ANTIALIAS)
    img.save(file_name + "Resized.jpg")



file_name = 'topviewResized'

img = Image.open(file_name + ".jpg").convert("L")
if (MAX_PICTURE_WIDTH < float(img.size[0])):
    resizeFunc(file_name)
    cannyLines(Image.open(file_name + "Resized.jpg").convert("L"))
else:
    cannyLines(img)