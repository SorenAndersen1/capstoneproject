from skimage import data, io, filters, feature, measure, morphology
from matplotlib import pyplot as plt, patches
import numpy as np
from PIL import Image

# Draw red boxes around discrete portions of the image
# Does not work well for our ATM images
def redboxes():
    img = np.asarray(Image.open('./ATM.jpg').convert("L"))
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
def cannyLines():
    img = np.asarray(Image.open('./ATM.jpg').convert("L"))
    edges = feature.canny(img, sigma=1)
    plt.imshow(edges)
    plt.show()

#Convert the image to be in two colors only
#Numbers are very clear in this image, maybe look into?
def BinaryColor():
    img = np.asarray(Image.open('./ATM.jpg').convert("L"))
    val = filters.threshold_yen(img)
    mask = img < val
    plt.imshow(mask)
    plt.show()

#Run the canny edge finding on the binary image
#Doesn't work well
def VeryCanny():
    img = np.asarray(Image.open('./ATM.jpg').convert("L"))
    val = filters.threshold_yen(img)
    mask = img < val
    edges = feature.canny(mask)
    plt.imshow(edges)
    plt.show()

BinaryColor()