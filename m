Content-Type: multipart/mixed; boundary="===============5469093198879411915=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/2] TODO: Mark CTM task as done
Date: Sat, 27 Nov 2010 17:22:55 -0200
Message-ID: <1290885775-23243-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <4CF14741.8060906@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5469093198879411915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |   11 -----------
 doc/features.txt |    7 +++++++
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/TODO b/TODO
index c484871..4443ac1 100644
--- a/TODO
+++ b/TODO
@@ -479,17 +479,6 @@ Miscellaneous
   Complexity: C2
   Owner: Gustavo F Padovan <padovan@profusion.mobi>
 =

-- TTY (hearing impaired) support.  Add a new oFono atom type that will ena=
ble
-  the user to enable or disable the TTY support on the modem.  Support for
-  automatic detection of TTY (signaled by the driver) is also desired.
-
-  This feature is not discussed in 27.007, thus manufacturer specific comm=
ands
-  are required.
-
-  Priority: High
-  Complexity: C1
-  Owner: Lucas De Marchi <lucas.demarchi@profusion.mobi>
-
 - Add support for GPS power control atom.  Many modem manufacturers provide
   a GPS unit with their modem hardware.  This unit can be turned on or off
   and frequently takes over one of the tty ports that the modem provides.
diff --git a/doc/features.txt b/doc/features.txt
index 06f5203..ef20cf2 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -216,3 +216,10 @@ Radio settings
   cellular modem to conserve power when the end user is not actively
   using the device but some networking applications are online using
   packet data.
+
+Text Telephony
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- TTY (hearing impaired) support, also known as Cellular Text Modem (CTM).
+  In case it's supported by the modem, oFono allows the user to enabled
+  or disable it through the TextTelephony interface.
-- =

1.7.3.2


--===============5469093198879411915==--

