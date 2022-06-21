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

//#define VERSION "0.75"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    //QtWebView::initialize();

    Unik u;
    QString numVersion="0.0.0";

    //-->VERSION
    bool update=false;
    //Get version file
    QString fileVersionPath=u.getPath(4);
    QString currentPath=u.getPath(5);
    fileVersionPath.append(QDir::separator());
    fileVersionPath.append("version");
    qDebug()<<"Buscando archivo de versión :"<<fileVersionPath;
    if(!u.fileExist(fileVersionPath.toUtf8())){
        if(currentPath.contains(".mount")){
            update=false;
        }else{
            update=true;
        }
    }else{
        QString version="";
        version.append(u.getHttpFile("https://raw.githubusercontent.com/nextsigner/zool-release/main/version"));
        version=version.replace("\n", "");
        QString currentVersion="";
        currentVersion.append(u.getFile(fileVersionPath.toUtf8()));
        currentVersion=currentVersion.replace("\n", "");
        qDebug()<<"Current Version: "<<currentVersion;
        qDebug()<<"Remote Version:"<<version;
    }
    //<--VERSION
    app.setApplicationDisplayName("Zool");
    app.setApplicationName("Zool");
    app.setOrganizationDomain("zool.ar");
    app.setOrganizationName("Zool.ar");
    app.setApplicationVersion(numVersion);

    QmlClipboardAdapter clipboard;


#ifdef Q_OS_LINUX
    if(argc==2 && argv[1]==QByteArray("-install")){
        //Esta operación se realiza en la carpeta donde está el AppImage (antes de ir con CD a la carpeta del executable interno del AppImage)
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
        cmdLN.append("sudo ln ");
        //cmdLN.append(QDir::currentPath().toUtf8()+"/astrologica_v");
        cmdLN.append(QDir::currentPath().toUtf8()+"/Zool_v");
        cmdLN.append(numVersion);
        cmdLN.append("-x86_64.AppImage");
        cmdLN.append(" /usr/local/bin/zool");
        u.ejecutarLineaDeComandoAparte(cmdLN);
        qInfo()<<"Zool Current Path: "<<QDir::currentPath();
        return 0;
    }
#endif
    QByteArray mainFolder;
    mainFolder.append(qApp->applicationDirPath().toUtf8());
    qDebug()<<"Argv 1: "<<argv[1];
    if(QString(argv[1]).contains("-folder=")){
        QStringList sl1=QString(argv[1]).split("-folder=");
        QDir::setCurrent(sl1.at(1));
        qDebug()<<"Set current folder from -folder: "<<sl1.at(1);
        mainFolder="";
        mainFolder.append(sl1.at(1).toUtf8());
    }else{
        QDir::setCurrent(qApp->applicationDirPath());
    }
    QDir::setCurrent("/media/ns/ZONA-A1/zool");
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


    if(currentPath.contains(".mount") && !update){
        //if(true){
        qDebug()<<"Running without update...";
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
            if(!folder.contains("resources") && !folder.contains("qml") && !folder.contains("py")  && !folder.contains("plugins")  && !folder.contains("qml")  && !folder.contains("lib")  && !folder.contains("libexec")  && !folder.contains("translations")){
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
        QDir::setCurrent(u.getPath(4));
    }

    if(currentPath.contains(".mount") && update){
        qDebug()<<"Running updating...";
        bool download=u.downloadGit("https://github.com/nextsigner/zool-release.git", u.getPath(4).toUtf8());
        if(download){
            qDebug()<<"Zool updated!";
        }else{
            qDebug()<<"Zool not updated.";
        }
    }

    QByteArray documentsPath;
    documentsPath.append(u.getPath(3).toUtf8());
    documentsPath.append("/Zool");
    engine.rootContext()->setContextProperty("documentsPath", documentsPath);
    engine.rootContext()->setContextProperty("unik", &u);
    engine.rootContext()->setContextProperty("version", numVersion);
    engine.rootContext()->setContextProperty("clipboard", &clipboard);
    engine.rootContext()->setContextProperty("engine", &engine);
    QByteArray importPath="";
    importPath.append(u.getPath(4));
    importPath.append("/modules");
    engine.addImportPath(importPath);
    qDebug()<<"engine.addImportPath:"<<importPath;
    engine.load(url);

    return app.exec();
}
