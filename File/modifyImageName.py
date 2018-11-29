# coding: utf-8

import os
import re
import time

# 获取所有图片名称
def getImageArray(filePath):
    fileList = os.listdir(filePath)
    for file in fileList:
        if file.startswith("."):
            continue
        currentPath = os.path.join('%s/%s' % (filePath, file))
        if os.path.isfile(currentPath):
            continue
        if currentPath.endswith(".imageset"):
            imageNameArr.append(file)
            findImageFile(currentPath)
            print(currentPath)
        getImageArray(currentPath)


# 修改image文件名和图片名
def findImageFile(imageFolderPath):
    folderArray = os.listdir(imageFolderPath)
    image = []
    for floder in folderArray:
        if floder.endswith(".png"):
            image.append(floder)

    for item in image:
        newName = modifyFileName(imageFolderPath, item)
        findModifyJson(imageFolderPath, item, newName)

# 修改图片名称
def modifyFileName(filePath, imageName):
    os.rename(filePath + "/" + imageName, filePath + "/" + prefixName + imageName)
    return prefixName + imageName


# 修改图片路径名称
def getImageolderArray(filePath):
    fileList = os.listdir(filePath)
    for file in fileList:
        if file.startswith("."):
            continue
        currentPath = os.path.join('%s/%s' % (filePath, file))
        if os.path.isfile(currentPath):
            continue
        if currentPath.endswith(".imageset"):
            pathList = currentPath.split("/")
            newName = prefixName + pathList[-1]
            pathList[-1] = newName
            newPath = '/'.join(pathList)
            os.rename(currentPath, newPath)
            currentPath = newPath
            print(currentPath)
        getImageolderArray(currentPath)


# 修改json文件
def findModifyJson(filePath, oleName, newName):
    jsonPath = filePath + "/Contents.json"
    fileOpen = open(jsonPath)
    w_str = ""
    for line in fileOpen:
        if re.search(oleName, line):
            line = re.sub(oleName, newName, line)
            print(line)
        w_str += line
    writeOpen = open(jsonPath, 'w')
    writeOpen.write(w_str)
    fileOpen.close()
    writeOpen.close()

# 扫描.m文件
def scanFiles(filePath):
    fileNameList = os.listdir(filePath)
    for fileName in fileNameList:
        if fileName.startswith("."):
            continue
        currentPath = os.path.join('%s/%s' % (filePath, fileName))
        if os.path.isfile(currentPath):
            if currentPath.endswith(".m"):
                scanContent(currentPath)
                print(currentPath)
            continue
        scanFiles(currentPath)

# 扫描.m内容
def scanContent(fileName):
    fileOpen = open(fileName)
    w_str = ""
    for line in fileOpen:
        w_str += searchImageNameReplace(line)
        print(searchImageNameReplace(line))
    writeOpen = open(fileName, 'w')
    writeOpen.write(w_str)
    fileOpen.close()
    writeOpen.close()


# 搜所图标替换
def searchImageNameReplace(line):
    for item in imageNameArr:
        name = "@\"" + item[:-9] + "\""
        newName = "@\"" + prefixName + item[:-9] + "\""
        if re.search(name, line):
            line = re.sub(name, newName, line)
    return line

if __name__ == "__main__":
    prefixName = "RC_"

    start = time.process_time()
    imagePath = "/Users/less/Desktop/备份/BlackFish/Reaches/Assets.xcassets"
    imageNameArr =[]          # 图片名称
    getImageArray(imagePath)

    modulesPath = "/Users/less/Desktop/备份/BlackFish/Reaches/Modules"
    basePath = "/Users/less/Desktop/备份/BlackFish/Reaches/Common/Base"
    scanFiles(modulesPath)
    scanFiles(basePath)

    getImageolderArray(imagePath)

    end = time.process_time()
    print('Running time: %s Seconds' % (end - start))


