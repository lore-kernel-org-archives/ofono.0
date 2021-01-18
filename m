Content-Type: multipart/mixed; boundary="===============4035325481830787795=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 4/7] Update README
Date: Mon, 18 Jan 2021 17:46:18 +0100
Message-ID: <20210118164621.52831-5-jbb.prv@gmx.de>
In-Reply-To: <20210118164621.52831-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4035325481830787795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 README    | 20 --------------------
 README.md | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 20 deletions(-)
 delete mode 100644 README
 create mode 100644 README.md

diff --git a/README b/README
deleted file mode 100644
index 07dd800..0000000
--- a/README
+++ /dev/null
@@ -1,20 +0,0 @@
-Phone Simulator for modem testing
-*********************************
-
-Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
-
-
-Compilation and installation
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
-
-In order to compile phone simulator you need following software packages:
-	- GCC compiler
-	- Qt libraries
-
-To configure run:
-	./configure --prefix=3D/usr
-
-Configure automatically searches for all required components and packages.
-
-To compile and install run:
-	make && make install
diff --git a/README.md b/README.md
new file mode 100644
index 0000000..e5cb9f8
--- /dev/null
+++ b/README.md
@@ -0,0 +1,24 @@
+# Phone Simulator for modem testing
+
+Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+
+
+Compilation and installation
+----------------------------
+
+In order to compile phone simulator you need following software packages:
+ - GCC compiler
+ - Qt libraries
+
+To configure run:
+
+```
+mkdir build && cd build
+cmake -GNinja ..
+```
+
+CMake automatically detects the location of the dependencies.
+To compile and install run:
+```
+ninja && ninja install
+```
--
2.29.2

--===============4035325481830787795==--

