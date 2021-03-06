#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDir>
#include <QDebug>
#include <QIcon>
#include <QFile>
#include "qmlclipboardadapter.h"
//#include <QtWebView/QtWebView>

#include "unikqprocess.h"
#include "unik.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    app.setApplicationDisplayName("Zool");
    app.setApplicationName("Zool");
    app.setOrganizationDomain("zool.ar");
    app.setOrganizationName("Zool.ar");

    //QtWebView::initialize();


    Unik u;
    u.debugLog=true;

    //Variables Globales
    QString bundlePath="";
    bundlePath.append(qApp->applicationDirPath());
    QString bundleVersionPath="";
    bundleVersionPath.append(bundlePath);
    bundleVersionPath.append("/version");
    QString bundleVersionData="";
    bundleVersionData.append(u.getFile(bundleVersionPath.toUtf8()));
    bundleVersionData=bundleVersionData.replace("\n", "");
    bool forceUpdate=false;
    bool isDev=false;
    bool forceCopyFiles=false;
    bool copyFiles=true;
    QString numVersionInstall="0.0.0";
    QString argtitle="";
    QString fromPath=QDir::currentPath();
    QDir::setCurrent(u.getPath(4));
    QString numVersion="0.0.0";


    for (int i=0; i<argc; i++) {
        qDebug()<<"Arg: "<<argv[i];
        if(QString(argv[i])=="-dev"){
            isDev=true;
            qDebug()<<"Running as Developer...";
        }
        if(QString(argv[i])=="-update"){
            forceUpdate=true;
            qDebug()<<"Updating for -update";
        }
        if(QString(argv[i])=="-cp"){
            forceCopyFiles=true;
            qDebug()<<"Copyng for -cp";
            qApp->quit();
        }
        if(QString(argv[i]).contains("-title=")){
            QStringList nvi=QString(argv[i]).split("-title=");
            argtitle=nvi.at(1);
            qDebug()<<"Title seted from arg: "<<argtitle;
        }
        if(QString(argv[i]).contains("-numVersionInstall=")){
            QStringList nvi=QString(argv[i]).split("-numVersionInstall=");
            numVersionInstall=nvi.at(1);
            qDebug()<<"Number Version Install: "<<numVersionInstall;
        }
    }

    //-->VERSION
    bool update=false;
    bool cp=false;
    //Get version file
    QString fileVersionPath=u.getPath(4);
    QString currentPath=u.getPath(5);
    fileVersionPath.append(QDir::separator());
    fileVersionPath.append("version");
    qDebug()<<"Buscando archivo de versi??n :"<<fileVersionPath;
    if(!u.fileExist(fileVersionPath.toUtf8())){
        if(!isDev){
            update=false;
        }else{
            update=true;
        }
        qDebug()<<"El archivo de versi??n "<<fileVersionPath<<" no existe.";
        QByteArray avdPath="";
        avdPath.append(QDir::currentPath());
        avdPath.append("/version");
        qDebug()<<"Buscando archivo de versi??n de distribuici??n en "<<avdPath;
        if(!u.fileExist(avdPath)){
            qDebug()<<"El archivo de versi??n de distribuci??n no existe.";
        }else{
            qDebug()<<"El archivo de versi??n de distribuici??n si existe.";
            QFile::copy(avdPath, fileVersionPath.toUtf8());
        }
    }

    QDateTime rdt = QDateTime::currentDateTime();
    QByteArray urlVersionRemoteFile="";
    urlVersionRemoteFile.append("https://raw.githubusercontent.com/nextsigner/zool-release/main/version");
    urlVersionRemoteFile.append("?r=");
    urlVersionRemoteFile.append(QString::number(rdt.currentMSecsSinceEpoch()).toUtf8());
    QString version="";
    version.append(u.getHttpFile(urlVersionRemoteFile));
    version=version.replace("\n", "");
    QString currentVersion="";
    currentVersion.append(u.getFile(fileVersionPath.toUtf8()));
    currentVersion=currentVersion.replace("\n", "");
    qDebug()<<"Current Version: "<<currentVersion;
    qDebug()<<"Remote Version:"<<version;
    qDebug()<<"Bundle Version:"<<bundleVersionData;
    if((currentVersion!=version && currentVersion!="error") || currentVersion!=bundleVersionData){
        QStringList m0=version.split(".");
        QStringList m1=currentVersion.split(".");
        if(m0.length()==3 && m1.length()==3){
            int nv1A=m0.at(0).toInt();
            int nv1B=m0.at(1).toInt();
            int nv1C=m0.at(2).toInt();

            int nv2A=m1.at(0).toInt();
            int nv2B=m1.at(1).toInt();
            int nv2C=m1.at(2).toInt();

            QString sNumA="";
            sNumA.append(QString::number(nv1A));
            sNumA.append(".");
            sNumA.append(QString::number(nv1B));
            sNumA.append(QString::number(nv1C));
            qDebug()<<"sNumA:"<<sNumA;
            float numA=sNumA.toFloat();
            QString sNumB="";
            sNumB.append(QString::number(nv2A));
            sNumB.append(".");
            sNumB.append(QString::number(nv2B));
            sNumB.append(QString::number(nv2C));
            qDebug()<<"sNumB:"<<sNumB;
            float numB=sNumB.toFloat();
            qDebug()<<"numA:"<<numA;
            qDebug()<<"numB:"<<numB;


            if(numA>numB){
                qDebug()<<"Se ha detectado una versi??n remota superior.";
                numVersion=version;
                update=true;
            }else if(numB>=numA){
                qDebug()<<"Se ha detectado una versi??n local inferior al de la aplicaci??n.";
                numVersion=bundleVersionData;
                u.setFile(bundleVersionPath.toUtf8(), bundleVersionData.toUtf8());
                update=false;
                if(!isDev){
                    forceCopyFiles=true;
                    copyFiles=true;
                    QDir::setCurrent(u.getPath(4).toUtf8());
                }else{
                    QDir::setCurrent(qApp->applicationDirPath().toUtf8());
                }

            }else{
                qDebug()<<"Se ha detectado una versi??n remota inferior.";
                numVersion=currentVersion;
                update=false;
            }
        }else{
            //return 0;
        }
        //qDebug()<<"Hay una versi??n nueva de Zool para instalar "<<version;

    }else{
        if(currentVersion=="error"){
            copyFiles=false;
            update=true;
        }else{
            numVersion=currentVersion;
            if(!isDev){
                copyFiles=false;
                QDir::setCurrent(u.getPath(4));
            }
        }
    }

    //<--VERSION
    app.setApplicationVersion(numVersion);

    QmlClipboardAdapter clipboard;


#ifdef Q_OS_LINUX
    if(argc==3 && argv[1]==QByteArray("-install")){
        //Esta operaci??n se realiza en la carpeta donde est?? el AppImage (antes de ir con CD a la carpeta del executable interno del AppImage)
        qDebug()<<"Installing zool...";
        QByteArray cf;
        cf.append(u.getPath(4).toUtf8());
        cf.append("/img");
        qInfo()<<"Zool icon Image Folder: "<<cf;
        QDir configFolder(cf);
        if(!configFolder.exists()){
            qInfo()<<"Making Unik Image Folder...";
            u.mkdir(cf);
        }
        QFile icon2(cf+"/icon.png");
        if(!icon2.exists()){
            QByteArray cf2;
            cf2.append(qApp->applicationDirPath().toUtf8());
            cf2.append("/icon.png");
            QFile icon(cf2);
            icon.copy(cf+"/icon.png");
            qInfo()<<"Copyng unik icon file: "<<cf2<<" to "<<cf+"/icon.png";
        }
        QByteArray iconData;
        iconData.append("[Desktop Entry]\n");
        iconData.append("Categories=Development;Qt;Settings;\n");
        iconData.append("Type=Application\n");
        iconData.append("Name=Zool");
        iconData.append(numVersion);
        iconData.append("\n");
        iconData.append("Exec=");
        //iconData.append(QDir::currentPath()+"/unik_v");
        //iconData.append(nv);
        //iconData.append("-x86_64.AppImage");
        iconData.append("zool");
        iconData.append("\n");
        iconData.append("Icon=");
        iconData.append(cf+"/icon.png\n");
        iconData.append("Comment=Zool by @nextsigner\n");
        iconData.append("Terminal=false\n");
        u.setFile("/usr/share/applications/zool.desktop", iconData);
        if(!u.fileExist("/usr/share/applications/zool.desktop")){
            qInfo()<<"Error when install Zool. Run Unik whit sudo permission for install this app into GNU/Linux";
        }else{
            qInfo()<<"Zool installed in category Development.";
        }
        if(u.fileExist("/usr/local/bin/zool")){
            u.deleteFile("/usr/local/bin/zool");
        }
        QByteArray cmdLN;
        cmdLN.append("sudo rm /usr/local/bin/zool && ");
        cmdLN.append("sudo ln ");
        //cmdLN.append(QDir::currentPath().toUtf8()+"/astrologica_v");
        cmdLN.append(fromPath.toUtf8()+"/Zool_v");
        cmdLN.append(numVersionInstall.toUtf8());
        cmdLN.append("-x86_64.AppImage");
        cmdLN.append(" /usr/local/bin/zool");
        cmdLN.append(" && zool -cp");
        u.ejecutarLineaDeComandoAparte(cmdLN);
        qInfo()<<"Zool Current Path: "<<QDir::currentPath();
        //u.restartApp()
        return 0;
    }
#endif
    QByteArray mainFolder;
    //mainFolder.append(qApp->applicationDirPath().toUtf8());
    mainFolder.append(QDir::currentPath().toUtf8());
    qDebug()<<"Argv 1: "<<argv[1];
    //QDir::setCurrent(qApp->applicationDirPath());
    for (int i=0; i<argc; i++) {
        qDebug()<<"Arg: "<<argv[i];
        if(QString(argv[i]).contains("-folder=")){
            QStringList nfolder=QString(argv[i]).split("-folder=");
            //numVersionInstall=nvi.at(1);
            //QStringList sl1=QString(argv[1]).split("-folder=");
            QDir::setCurrent(nfolder.at(1));
            qDebug()<<"Set current folder from -folder: "<<nfolder.at(1);
            mainFolder="";
            mainFolder.append(nfolder.at(1).toUtf8());
            qDebug()<<"-folder changing current folder: "<<QDir::currentPath();
        }
    }

    if(isDev){
        QDir::setCurrent(qApp->applicationDirPath());
        QDir::setCurrent("../");
        qDebug()<<"IsDEV Set current folder to: "<<QDir::currentPath();
        mainFolder="";
        mainFolder.append(QDir::currentPath().toUtf8());
    }

    //QDir::setCurrent("/media/ns/ZONA-A1/zool");
    mainFolder=mainFolder.replace("\\", "/");
    qDebug()<<"Current folder: "<<QDir::currentPath();
    qDebug()<<"Current mainFolder: "<<mainFolder;
    QString iconPath=mainFolder;
    iconPath.append("/resources/imgs/logo.png");
    app.setWindowIcon(QIcon(iconPath));
    qDebug()<<"icon path: "<<iconPath;



    QByteArray mainPath;
#ifdef Q_OS_WIN
    mainPath.append("file:///");
#endif
    mainPath.append(mainFolder);
    mainPath.append("/main.qml");
    qDebug()<<"mainPath: "<<mainPath;
    QQmlApplicationEngine engine;
    //const QUrl url(QStringLiteral(mainPath));
    const QUrl url(mainPath);

    //const QUrl url(QStringLiteral("qr.cfgc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    qmlRegisterType<UnikQProcess>("unik.UnikQProcess", 1, 0, "UnikQProcess");



    //return 0;


    QString execPath=u.getPath(5);
    qDebug()<<"Exec path: "<<execPath;
    //Copiar archivos
    if((!isDev && !update && copyFiles) || forceCopyFiles){
        //if(true){
        qDebug()<<"Running as user without update...";
        qDebug()<<"Copyng files...";
        QString src=".";
        QString dst=u.getPath(4);
        QDir dir(QDir::currentPath());
        if (! dir.exists()){
            return -3;
        }
        foreach (QString d, dir.entryList(QDir::Dirs | QDir::NoDotAndDotDot)) {
            QString dst_path = dst + QDir::separator() + d;
            dir.mkpath(dst_path);
            QString folder="";
            folder.append(src);
            folder.append(QDir::separator());
            folder.append(d);
            if(!folder.contains("resources") && !folder.contains("qml") && !folder.contains("plugins")  && !folder.contains("qml")  && !folder.contains("lib")  && !folder.contains("libexec")  && !folder.contains("translations")){
                qDebug()<<"Folder: "<<folder;
                QFile::copy(src+ QDir::separator() + d, dst_path);
            }else{
                qDebug()<<"Folder ominted: "<<folder;
            }
        }

        foreach (QString f, dir.entryList(QDir::Files)) {
            QString file="";
            file.append(src);
            file.append(QDir::separator());
            file.append(f);
            if(!file.contains(".pro") && !file.contains(".pro.") && !file.contains(".sh") && !file.contains(".cfg") && !file.contains("id_rsa_github")){
                qDebug()<<"File: "<<file;
                QFile::copy(src + QDir::separator() + f, dst + QDir::separator() + f);
            }else{
                qDebug()<<"File omited: "<<file;
            }

        }
        src.append("/resources");
        dst.append("/resources");
        QString pathRes="";
        pathRes.append(QDir::currentPath());
        pathRes.append(QDir::separator());
        pathRes.append("resources");
        QDir dirRes(pathRes);
        foreach (QString f, dirRes.entryList(QDir::Files)) {
            QString file="";
            file.append(src);
            file.append(QDir::separator());
            file.append(f);
            if(!file.contains(".xcf") && !file.contains(".sh") && !file.contains(".dat")  && !file.contains(".pak")  && !file.contains(".txt")){
                qDebug()<<"File: "<<file;
                QFile::copy(src + QDir::separator() + f, dst + QDir::separator() + f);
            }else{
                qDebug()<<"File omited: "<<file;
            }

        }
        foreach (QString d, dirRes.entryList(QDir::Dirs | QDir::NoDotAndDotDot)) {
            QString dst_path = dst + QDir::separator() + d;
            dirRes.mkpath(dst_path);
            QString folder="";
            folder.append(src);
            folder.append(QDir::separator());
            folder.append(d);
            if(!folder.contains("__pycache__")){
                qDebug()<<"Folder: "<<folder;
                QFile::copy(src+ QDir::separator() + d, dst_path);
            }else{
                qDebug()<<"Folder ominted: "<<folder;
            }
        }

        //-->cp folder py
        src=".";
        dst=u.getPath(4);
        src.append("/py");
        dst.append("/py");
        QString pathPy="";
        pathPy.append(QDir::currentPath());
        pathPy.append(QDir::separator());
        pathPy.append("py");
        QDir dirPy(pathPy);
        foreach (QString f, dirPy.entryList(QDir::Files)) {
            QString file="";
            file.append(src);
            file.append(QDir::separator());
            file.append(f);
            QFile::copy(src + QDir::separator() + f, dst + QDir::separator()+ f);
            qDebug()<<"File: "<<file;
        }
        //<--cp folder py

        //-->cp folder swe
        src=".";
        dst=u.getPath(4);
        src.append("/swe");
        dst.append("/swe");
        QString pathSWE="";
        pathSWE.append(QDir::currentPath());
        pathSWE.append(QDir::separator());
        pathSWE.append("swe");
        QDir dirSWE(pathSWE);
        foreach (QString f, dirSWE.entryList(QDir::Files)) {
            QString file="";
            file.append(src);
            file.append(QDir::separator());
            file.append(f);
            QFile::copy(src + QDir::separator() + f, dst + QDir::separator()+ f);
            qDebug()<<"File: "<<file;
        }
        //<--cp folder swe


        if(!isDev || forceCopyFiles){
            QDir::setCurrent(u.getPath(4));
        }
        qDebug()<<"Files moved, currentPath: "<<QDir::currentPath();
    }else{
        if(!copyFiles){
            qDebug()<<"Running without copyng files...";
            qDebug()<<"CurrentPath: "<<QDir::currentPath();
        }
    }

    if((!isDev && update) || forceUpdate){
        qDebug()<<"Running updating...";
        bool download=u.downloadGit("https://github.com/nextsigner/zool-release.git", u.getPath(4).toUtf8());
        if(download){
            qDebug()<<"Zool updated!";
            u.setFile(fileVersionPath.toUtf8(), numVersion.toUtf8());
        }else{
            qDebug()<<"Zool not updated.";
        }
    }



    QByteArray documentsPath;
    documentsPath.append(u.getPath(3).toUtf8());
    documentsPath.append("/Zool");
    engine.rootContext()->setContextProperty("documentsPath", documentsPath);
    engine.rootContext()->setContextProperty("isDev", isDev);
    engine.rootContext()->setContextProperty("unik", &u);
    engine.rootContext()->setContextProperty("version", numVersion);
    engine.rootContext()->setContextProperty("clipboard", &clipboard);
    engine.rootContext()->setContextProperty("engine", &engine);
    engine.rootContext()->setContextProperty("argtitle", argtitle);

    QByteArray importPath="";
    importPath.append(u.getPath(4));
    importPath.append("/modules");
    engine.addImportPath(importPath);
    engine.addImportPath("./modules");
    qDebug()<<"engine.addImportPath:"<<importPath;
    qDebug()<<"engine.addImportPath:"<<u.getPath(4);

#ifndef Q_OS_LINUX
    //-->Check Python
    bool isPythonInAppData=false;
    QByteArray pathPython0;
    pathPython0.append(u.getPath(1));
    pathPython0.append("/Python/python.exe");

    QByteArray pathPython;
    pathPython.append(u.getPath(4));
    pathPython.append("/Python/python.exe");

    QByteArray ppi;
    ppi.append(u.getPath(5));
    //ppi.append("/XCheckPythonInstall.qml");
    ppi.append("/XPythonInstall.qml");


    if(!u.fileExist(pathPython0) && !u.fileExist(pathPython)){
        qDebug()<<"Loading "<<ppi;
        qDebug()<<"ppi: "<<u.getPath(1);
        engine.load(ppi);
    }else{
        if(u.fileExist(pathPython0)){
            qDebug()<<"Running Zool with "<<pathPython;
            engine.rootContext()->setContextProperty("pythonLocationSeted", pathPython0);
        }else{
            qDebug()<<"Running Zool with "<<pathPython;
            //qDebug()<<pathPython<<" not found...";
            engine.rootContext()->setContextProperty("pythonLocationSeted", pathPython);
        }
        qDebug()<<"Loading "<<url;
        engine.load(url);
    }
    //<--Check Python
#else
    engine.load(url);
#endif

    return app.exec();
}
