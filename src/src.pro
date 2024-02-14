TEMPLATE = lib
TARGET   = qvnceglfs

DEFINES += VNC_MAKEDLL

QT += gui gui-private network

CONFIG += hide_symbols
CONFIG += silent
CONFIG += no_private_qt_headers_warning

CONFIG += videoacceleration

CONFIG += strict_c++
CONFIG += c++11
CONFIG += warn_on
CONFIG += pedantic

CONFIG += debug

pedantic {
    linux-g++ | linux-g++-64 {

        QMAKE_CXXFLAGS *= -pedantic-errors
        QMAKE_CXXFLAGS *= -Wpedantic

        QMAKE_CXXFLAGS *= -Wsuggest-override
        QMAKE_CXXFLAGS *= -Wsuggest-final-types
        QMAKE_CXXFLAGS *= -Wsuggest-final-methods

        #QMAKE_CXXFLAGS *= -fanalyzer

           QMAKE_CXXFLAGS += \
                -isystem $$[QT_INSTALL_HEADERS]/QtCore \
                -isystem $$[QT_INSTALL_HEADERS]/QtCore/$$[QT_VERSION]/QtCore \
                -isystem $$[QT_INSTALL_HEADERS]/QtGui \
                -isystem $$[QT_INSTALL_HEADERS]/QtGui/$$[QT_VERSION]/QtGui \
                -isystem $$[QT_INSTALL_HEADERS]/QtNetwork \
    }
}

MOC_DIR=moc
OBJECTS_DIR=obj

TARGET = $$qtLibraryTarget(vncgl)
DESTDIR = lib

HEADERS += \
    RfbSocket.h \
    RfbPixelStreamer.h \
    RfbEncoder.h \
    RfbInputEventHandler.h \
    VncServer.h \
    VncClient.h \
    VncNamespace.h \

SOURCES += \
    RfbSocket.cpp \
    RfbPixelStreamer.cpp \
    RfbEncoder.cpp \
    RfbInputEventHandler.cpp \
    VncServer.cpp \
    VncClient.cpp \
    VncNamespace.cpp

videoacceleration {

    HEADERS += \
        va/VncJpeg.h \
        va/VncVaRenderer.h \
        va/VncVaEncoder.h

    SOURCES += \
        va/VncJpeg.cpp \
        va/VncVaRenderer.cpp \
        va/VncVaEncoder.cpp

    DEFINES += VNC_VA_ENCODER

    CONFIG += link_pkgconfig
    PKGCONFIG += libva-drm libva
}

CONFIG += link_pkgconfig
PKGCONFIG += openssl

INSTALL_ROOT=/usr/local/vnceglfs
# INSTALL_ROOT=$$[QT_INSTALL_PREFIX]

target.path = $${INSTALL_ROOT}/lib

header_files.files = VncNamespace.h
header_files.path = $${INSTALL_ROOT}/include

INSTALLS += target header_files
