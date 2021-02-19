Content-Type: multipart/mixed; boundary="===============5670633093738857114=="
MIME-Version: 1.0
From: ofono@market.talbothome.com
Subject: [PATCH 07/09] MMSD: Update the README
Date: Fri, 19 Feb 2021 01:04:37 +0000
Message-ID: <20210219010437.2937.14692@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5670633093738857114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch updates the README to allow users to see how to compile and run =
MMSD,
and how to configure the settings.
---
 README | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/README b/README
index e33be69..cecc99f 100644
--- a/README
+++ b/README
@@ -2,20 +2,76 @@ Multimedia Messaging Service
 ****************************
 =

 Copyright (C) 2010-2011  Intel Corporation. All rights reserved.
+Updated 2021 by: Mohammad Sadiq, kent, kop316, =

+                 fuzzy7k, craftyguy, anteater
+Parts adapted from: https://source.puri.sm/Librem5/purple-mm-sms
+                    Copyright (C) 2018 Purism SPC
+                    =

+About
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+mmsd is a lower level daemon that transmits and recieves MMSes. It works w=
ith
+both the ofono stack and the Modem Manager stack.
 =

+Please note that mmsd alone will not get MMS working! It is designed to wo=
rk =

+with a higher level chat application to facilitate fetching and =

+sending MMS. It interfaces with other applications via the dbus.
 =

-Compilation and installation
+Compiling mmsd
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
-
 In order to compile proxy daemon you need following software packages:
 	- GCC compiler
 	- D-Bus library
 	- GLib library
 =

+Installing mmsd
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
 To configure run:
-	./configure --prefix=3D/usr
+    ./bootstrap-configure --prefix=3D/usr/
 =

 Configure automatically searches for all required components and packages.
 =

-To compile and install run:
-	make && make install
+To compile, run:
+    make
+	=

+And to Install:
+    make install
+
+mmsd will be installed in /${prefix}/libexec (if you are following this gu=
ide,
+it is /usr/libexec )
+
+To uninstall, simply remove the "mmsd" binary from /${prefix}/libexec or r=
un:
+    sudo make uninstall
+
+Note that you must manually configure your favorite service manager to run =

+the daemon, as this installer does not configure it to autorun.
+
+Testing out mmsd
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+To configure, run:
+    ./bootstrap-configure --enable-debug --enable-maintainer-mode
+
+Make it:
+    make =

+
+Run daemon in foreground with debugging:
+    ./src/mmsd -n -d 'src/*'
+
+General Configuration
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+On first run, mmsd will write a settings file at
+"$HOME/.mms/$PLUGIN/mms"
+
+IMPORTANT NOTE: If you change settings in this file, mmsd MUST BE RESTARTE=
D =

+                for the changes to take effect!
+
+This settings file use sane defaults, but you can change them:
+
+UseDeliveryReports
+        Whether you want delivery reports for MMSes you send
+
+TotalMaxAttachmentSize
+        The maximum size all of your attachments can be before mmsd reject=
s it.
+        NOTE: This value is carrier specific! Changing this value to a hig=
her
+              number may cause your carrier to silently reject MMSes you s=
end.
+              CHANGE AT YOUR OWN RISK!
\ No newline at end of file
-- =

2.30.0
--===============5670633093738857114==--

