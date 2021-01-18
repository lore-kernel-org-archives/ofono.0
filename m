Content-Type: multipart/mixed; boundary="===============1665726743773354547=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 1/7] Add CMake build system
Date: Mon, 18 Jan 2021 17:46:15 +0100
Message-ID: <20210118164621.52831-2-jbb.prv@gmx.de>
In-Reply-To: <20210118164621.52831-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1665726743773354547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 CMakeLists.txt     | 20 ++++++++++++++++++++
 src/CMakeLists.txt | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 CMakeLists.txt
 create mode 100644 src/CMakeLists.txt

diff --git a/CMakeLists.txt b/CMakeLists.txt
new file mode 100644
index 0000000..9de202a
--- /dev/null
+++ b/CMakeLists.txt
@@ -0,0 +1,20 @@
+cmake_minimum_required(VERSION 2.8.12)
+project(phonesim)
+set(PHONESIM_VERSION 1.21)
+
+include(FeatureSummary)
+include(GNUInstallDirs)
+
+find_package(Qt5 "5.10.0" REQUIRED NO_MODULE COMPONENTS Core Widgets Qml N=
etwork DBus)
+
+set(CMAKE_AUTOMOC ON)
+set(CMAKE_AUTOUIC ON)
+
+################# Enable C++14 #################
+
+set(CMAKE_CXX_STANDARD 14)
+
+################# build and install #################
+add_subdirectory(src)
+
+feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_=
PACKAGES)
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
new file mode 100644
index 0000000..6d7ebf5
--- /dev/null
+++ b/src/CMakeLists.txt
@@ -0,0 +1,40 @@
+set(PHONESIM_SRCS
+    control.cpp
+    controlbase.ui
+    qatutils.cpp
+    qatresult.cpp
+    qwsppdu.cpp
+    qgsmcodec.cpp
+    callmanager.cpp
+    qsimterminalresponse.cpp
+    qsmsmessagelist.cpp
+    qsmsmessage.cpp
+    qsimcontrolevent.cpp
+    conformancesimapplication.cpp
+    server.cpp
+    aidapplication.cpp
+    gsmitem.cpp
+    simauth.cpp
+    phonesim.cpp
+    qsimcommand.cpp
+    qsimenvelope.cpp
+    qcbsmessage.cpp
+    hardwaremanipulator.cpp
+    simapplication.cpp
+    qatresultparser.cpp
+    attranslator.cpp
+    gsmspec.cpp
+    main.cpp
+    simfilesystem.cpp
+    aes.c
+    comp128.c
+)
+
+set(CMAKE_INCLUDE_CURRENT_DIR ON)
+
+add_executable(phonesim ${PHONESIM_SRCS})
+target_compile_definitions(phonesim PRIVATE -DVERSION=3D${PHONESIM_VERSION=
} -DQT_NO_FOREACH)
+target_link_libraries(phonesim Qt5::Core Qt5::Widgets Qt5::Qml Qt5::Networ=
k Qt5::DBus)
+
+install(TARGETS phonesim RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
+install(FILES default.xml DESTINATION ${CMAKE_INSTALL_DATADIR}/phonesim/)
--
2.29.2

--===============1665726743773354547==--

