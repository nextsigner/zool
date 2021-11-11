message(windows.pri is loaded)

#Windows Deploy
#E:/Qt/5.15.2/mingw81_64/bin/windeployqt.exe E:/zool/build_win/zool.exe -qmldir E:/zool

TARGET=zool

#FILE_VERSION_NAME=version
#QT += webengine
DD1=$$replace(PWD, /zool,/zool/build_win)
DESTDIR= $$DD1

#RC_FILE = unik.rc
#Building Quazip from Windows 8.1
INCLUDEPATH += $$PWD/quazip
DEFINES+=QUAZIP_STATIC
HEADERS += $$PWD\quazip\*.h
SOURCES += $$PWD\quazip\*.cpp
SOURCES += $$PWD\quazip\*.c
