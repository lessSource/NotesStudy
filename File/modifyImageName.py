# coding: utf-8

import os
import re
import time

# 前缀
PREFIXNAME = "BH_"
# 图片路径
IMAGEPATH = "/Users/Lj/Desktop/Test/道道/Behing/Supporting Flies/Assets.xcassets"
# 图片文件名称后缀
IMAGEFILEEND = ".imageset"
# 图片名称后缀
IMGAENAMEEND = ".png"

# 修改名称规则
def changeNameRule(oldName):
    # return PREFIXNAME + oldName
    return  oldName[3:]

# 获取所有图片名称
def getImageName(path):
    fileList = os.listdir(path)
    for file in fileList:
        currentPath = os.path.join('%s/%s' % (path, file))
        if os.path.isfile(currentPath):
            continue
        if currentPath.endswith(IMAGEFILEEND):
            imageNameList.append(file[:-len(IMAGEFILEEND)])
            currentPath = changeFilePathName(currentPath)
            changeImageName(currentPath)
        getImageName(currentPath)


# 修改文件名称
def changeFilePathName(oldPath):
    pathPuple =  os.path.split(oldPath)
    newName = changeNameRule(pathPuple[1])
    newPath = pathPuple[0] + "/" + newName
    os.rename(oldPath, newPath)
    print(oldPath)
    print(newPath)
    return newPath

# 修改图片名称
def changeImageName(path):
    fileList = os.listdir(path)
    imageList = []
    for floder in fileList:
        if floder.endswith(IMGAENAMEEND):
            imageList.append(floder)
    for item in imageList:
        changeFilePathName(path + "/" + item)
        replaceFileContent(path + "/Contents.json", [item])


# 替换文件内容
def replaceFileContent(path, contentList, isOCStr = bool(0)):
    fileOpen = open(path)
    w_str = ""
    for line in fileOpen:
        w_str += replaceLineContent(contentList, line, isOCStr)
    writeOpen = open(path, 'w')
    writeOpen.write(w_str)
    print(w_str)
    fileOpen.close()
    writeOpen.close()

def replaceLineContent(contentList, line, isOCStr = bool(0)):
    for item in contentList:
        oldName = item
        newName = changeNameRule(item)
        if isOCStr:
            oldName = "@\"" + oldName + "\""
            newName = "@\"" + newName + "\""
        if re.search(oldName, line):
            line = re.sub(oldName, newName, line)
    return line


#
# # 扫描.m文件
# def scanFiles(filePath):
#     fileNameList = os.listdir(filePath)
#     for fileName in fileNameList:
#         if fileName.startswith("."):
#             continue
#         currentPath = os.path.join('%s/%s' % (filePath, fileName))
#         if os.path.isfile(currentPath):
#             if currentPath.endswith(".m"):
#                 scanContent(currentPath)
#                 print(currentPath)
#             continue
#         scanFiles(currentPath)
#
# # 扫描.m内容
# def scanContent(fileName):
#     fileOpen = open(fileName)
#     w_str = ""
#     for line in fileOpen:
#         w_str += searchImageNameReplace(line)
#         print(searchImageNameReplace(line))
#     writeOpen = open(fileName, 'w')
#     writeOpen.write(w_str)
#     fileOpen.close()
#     writeOpen.close()
#
# # 搜所图标替换
# def searchImageNameReplace(line):
#     for item in imageNameArr:
#         name = "@\"" + item[:-9] + "\""
#         newName = "@\"" + prefixName + item[:-9] + "\""
#         if re.search(name, line):
#             line = re.sub(name, newName, line)
#     return line

if __name__ == "__main__":
    start = time.process_time()
    imageNameList = []
    getImageName(IMAGEPATH)



    end = time.process_time()
    print('Running time: %s Seconds' % (end - start))



    # prefixName = "BH_"

    # imagePath = "/Users/Lj/Desktop/Test/道道/Behing/Supporting Flies/Assets.xcassets"
    # imageNameArr =[]          # 图片名称
    # getImageArray(imagePath)
    #
    # controllersPath = "/Users/Lj/Desktop/Test/道道/Behing/Controllers"
    # commonsPath = "/Users/Lj/Desktop/Test/道道/Behing/Commons"
    # basePath = "/Users/Lj/Desktop/Test/道道/Behing/Base"
    # scanFiles(controllersPath)
    # scanFiles(commonsPath)
    # scanFiles(basePath)
    #
    # getImageolderArray(imagePath)
    #


