# coding: utf-8

import os
import re


# 遍历指定目录，显示目录下所有的文件名
def eachFile(filePath):
    pathList = os.listdir(filePath)
    print(pathList)
    for fileName in pathList:
        allPath = os.path.join('%s/%s'% (filePath, fileName))
        if fileName.endswith(".json"):
            print(2)
        else:
            if fileName.startswith("."):
                print("3")
            else:
                allPath = modifyFileName(allPath)
        if os.path.isfile(allPath):
            if fileName.endswith(".png"):
                print(fileName)
            if fileName.endswith(".json"):
                print(2)
                # modifyFileName(filePath)
                # findJson(pathList, allPath)
            continue
        eachFile(allPath)

# 修改文件名称
def modifyFileName(imageFileName):
    imageArr = imageFileName.split("/")
    imageArr[len(imageArr) - 1] = "ddddd_" + imageArr[len(imageArr) - 1]
    # print(imageArr[len(imageArr)-1])
    str = '/'.join(imageArr)
    os.rename(imageFileName, str)
    print(imageArr[len(imageArr)-1])
    return str


# 查找json文件 修改文件内容
def findJson(fileImageArr, imageJson):
    print(fileImageArr, imageJson)
    fopen = open(imageJson)
    w_str = ""
    for line in fopen:
        if re.search("settingUnselect", line):
            line = re.sub("settingUnselect", "settingUnselect@2x",line)
            w_str += line
        else:
            w_str += line
    print(w_str)
    wopen = open(imageJson, 'w')
    wopen.write(w_str)
    fopen.close()
    wopen.close()


if __name__ == "__main__":
    fileNames = "/Users/Lj/Desktop/py/testFile/Behing/Supporting Flies/Assets.xcassets"
    fileArr = []
    eachFile(fileNames)
