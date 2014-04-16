Content-Type: multipart/mixed; boundary="===============7661713932098344047=="
MIME-Version: 1.0
From: jussi.pakkanen@canonical.com
Subject: [PATCH] Added support for PIN retry count.
Date: Wed, 16 Apr 2014 18:08:04 +0300
Message-ID: <1397660884-29140-1-git-send-email-jussi.pakkanen@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7661713932098344047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

Sorry, had a bit of a Git mixup in the previous patch. Here's the correct o=
ne,
now comes with the =3D? query interface as well as standards conforming out=
put.

---
 src/default.xml | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/src/default.xml b/src/default.xml
index 2868587..e0cafbb 100644
--- a/src/default.xml
+++ b/src/default.xml
@@ -232,6 +232,9 @@
     <!-- Value of the PIN that is required -->
     <set name=3D"PINVALUE" value=3D"2468"/>
 =

+    <!-- How many times can PIN unlocking be attempted -->
+    <set name=3D"PINRETRYCOUNT" value=3D"3"/>
+
     <!-- pin protection status -->
     <set name=3D"SC" value=3D"0"/>
 =

@@ -2280,6 +2283,19 @@
 </chat>
 =

 <chat>
+    <!-- Do we support CPINR? -->
+    <command>AT+CPINR=3D?</command>
+    <response>OK\n</response>
+</chat>
+
+<chat>
+    <!-- How many pin unlock attempts remain -->
+    <command>AT+CPINR</command>
+    <response>+CPINR: SIM PIN,${PINRETRYCOUNT},3\nOK\n</response>
+</chat>
+
+
+<chat>
     <!-- Check for which PIN is required -->
     <command>AT+CPIN?</command>
     <response delay=3D"2000">+CPIN: ${PINNAME}\n\nOK</response>
@@ -2290,6 +2306,7 @@
     <command>AT+CPIN=3D"${PINVALUE}"</command>
     <response>+CPIN: READY\n\nOK</response>
     <set name=3D"PINNAME" value=3D"READY"/>
+    <set name=3D"PINRETRYCOUNT" value=3D"3"/>
 </chat>
 =

 <chat>
@@ -2305,6 +2322,7 @@
     <response>+CPIN: READY\n\nOK</response>
     <set name=3D"PINVALUE" value=3D"${*}"/>
     <set name=3D"PINNAME" value=3D"READY"/>
+    <set name=3D"PINRETRYCOUNT" value=3D"3"/>
 </chat>
 =

 <chat>
@@ -2320,6 +2338,7 @@
     <command>AT+CPIN=3D"*","*"</command>
     <response>+CPIN: SIM PUK\n\nERROR</response>
     <set name=3D"PINNAME" value=3D"SIM PUK"/>
+    <set name=3D"PINRETRYCOUNT" value=3D"0"/>
 </chat>
 =

 <chat>
@@ -2327,6 +2346,7 @@
     <command>AT+CPIN=3D*</command>
     <response>+CPIN: SIM PIN\n\nERROR</response>
     <set name=3D"PINNAME" value=3D"SIM PIN"/>
+    <set name=3D"PINRETRYCOUNT" value=3D"2"/>
     <switch name=3D"pinretry1"/>
 </chat>
 =

@@ -2337,6 +2357,7 @@
         <command>AT+CPIN=3D"${PINVALUE}"</command>
         <response>+CPIN: READY\n\nOK</response>
         <set name=3D"PINNAME" value=3D"READY"/>
+        <set name=3D"PINRETRYCOUNT" value=3D"3"/>
         <switch name=3D"default"/>
     </chat>
 =

@@ -2346,6 +2367,7 @@
         <response>+CPIN: READY\n\nOK</response>
         <set name=3D"PINVALUE" value=3D"${*}"/>
         <set name=3D"PINNAME" value=3D"READY"/>
+        <set name=3D"PINRETRYCOUNT" value=3D"3"/>
         <switch name=3D"default"/>
     </chat>
 =

@@ -2354,6 +2376,7 @@
         <command>AT+CPIN=3D*</command>
         <response>+CPIN: SIM PIN\n\nERROR</response>
         <set name=3D"PINNAME" value=3D"SIM PIN"/>
+        <set name=3D"PINRETRYCOUNT" value=3D"1"/>
         <switch name=3D"pinretry2"/>
     </chat>
 =

@@ -2366,6 +2389,7 @@
         <command>AT+CPIN=3D"${PINVALUE}"</command>
         <response>+CPIN: READY\n\nOK</response>
         <set name=3D"PINNAME" value=3D"READY"/>
+        <set name=3D"PINRETRYCOUNT" value=3D"3"/>
         <switch name=3D"default"/>
     </chat>
 =

@@ -2375,6 +2399,7 @@
         <response>+CPIN: READY\n\nOK</response>
         <set name=3D"PINVALUE" value=3D"${*}"/>
         <set name=3D"PINNAME" value=3D"READY"/>
+        <set name=3D"PINRETRYCOUNT" value=3D"3"/>
         <switch name=3D"default"/>
     </chat>
 =

@@ -2383,6 +2408,7 @@
         <command>AT+CPIN=3D*</command>
         <response>+CPIN: SIM PUK\n\nERROR</response>
         <set name=3D"PINNAME" value=3D"SIM PUK"/>
+        <set name=3D"PINRETRYCOUNT" value=3D"0"/>
     </chat>
 =

 </state>
-- =

1.9.1


--===============7661713932098344047==--

