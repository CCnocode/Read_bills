import sys, fitz
import os


def pyMuPDF_fitz(pdfpath, imagePath):
    # open the pdf file
    pdfDoc = fitz.open(pdfpath)

    for index in range(pdfDoc.page_count):
        page = pdfDoc[index]
        rotate = int(0)
        # resize the image to generate high dpi figure
        # choose the para as 1.3 to improve 2.6dpi
        zoom_x = 1.33333333
        zoom_y = 1.33333333
        mat = fitz.Matrix(zoom_x, zoom_y).prerotate(rotate)
        pix = page.get_pixmap(matrix=mat, alpha=False)

        if not os.path.exists(imagePath):
            os.makedirs(imagePath)

        pix.save(imagePath + '/' + 'image_%s.jpg' % index)  # write the image


if __name__ == '__main__':
    pdfpath = '../bills/2.pdf'
    imagepath = '../image_test'

    pyMuPDF_fitz(pdfpath,imagepath)
