Content-Type: multipart/mixed; boundary="===============4024785780789826430=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] TODO: mark 'GPS power control atom' task as done
Date: Fri, 11 Mar 2011 17:29:33 -0300
Message-ID: <1299875373-10758-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4024785780789826430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |   11 -----------
 doc/features.txt |    8 ++++++++
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/TODO b/TODO
index c432cba..9db9e0b 100644
--- a/TODO
+++ b/TODO
@@ -444,17 +444,6 @@ Miscellaneous
   Complexity: C8
   Owner: Jukka Saunam=C3=A4ki <jukka.saunamaki@nokia.com>
 =

-- Add support for GPS power control atom.  Many modem manufacturers provide
-  a GPS unit with their modem hardware.  This unit can be turned on or off
-  and frequently takes over one of the tty ports that the modem provides.
-
-  This feature is not discussed in 27.007, thus manufacturer specific comm=
ands
-  are required.
-
-  Priority: Low
-  Complexity: C4
-  Owner: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
-
 - Add Location Service API for providing basic E911 support.
   This will be based on the 27.007 defined AT commands using
   XML for transport of positioning request and responses.
diff --git a/doc/features.txt b/doc/features.txt
index ed4c058..ce36265 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -492,6 +492,14 @@ GPRS
   suspended while a circuit switched service such as voice call or SMS is
   active.
 =

+Location Reporting
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- GPS support. Many modem manufacturers provide a GPS unit with their modem
+  hardware.  Upon client request oFono can turn this unit on or off and pa=
ss a
+  file descriptor in which client may receive the desired location reporti=
ng
+  data.
+
 SIM
 =3D=3D=3D
 =

-- =

1.7.4.1


--===============4024785780789826430==--

