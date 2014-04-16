Content-Type: multipart/mixed; boundary="===============1703141774774217510=="
MIME-Version: 1.0
From: jussi.pakkanen@canonical.com
Subject: [PATCH] Added support for PIN retry count.
Date: Wed, 16 Apr 2014 17:26:50 +0300
Message-ID: <1397658410-28951-1-git-send-email-jussi.pakkanen@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1703141774774217510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

Here's a patch for ofono-phonesim. It adds the command AT+CPINR that returns
the amount of PIN unlock attempts remaining. It also tracks the value prope=
rly
according to state changes. The output format is (roughly) as specified in =
ETSI
TS 127 007 v11.8.0.

PS I'm hoping this is the correct place to send this patch, ofono-phonesim's
README and HACKING files don't seem to contain patch submission guidelines.

---
 src/default.xml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/src/default.xml b/src/default.xml
index 2868587..e195cfa 100644
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

@@ -2280,6 +2283,13 @@
 </chat>
 =

 <chat>
+    <!-- How many pin unlock attempts remain -->
+    <command>AT+CPINR</command>
+    <response>+CPINR: SIM PIN,${PINRETRYCOUNT},3\n</response>
+</chat>
+
+
+<chat>
     <!-- Check for which PIN is required -->
     <command>AT+CPIN?</command>
     <response delay=3D"2000">+CPIN: ${PINNAME}\n\nOK</response>
@@ -2290,6 +2300,7 @@
     <command>AT+CPIN=3D"${PINVALUE}"</command>
     <response>+CPIN: READY\n\nOK</response>
     <set name=3D"PINNAME" value=3D"READY"/>
+    <set name=3D"PINRETRYCOUNT" value=3D"3"/>
 </chat>
 =

 <chat>
@@ -2305,6 +2316,7 @@
     <response>+CPIN: READY\n\nOK</response>
     <set name=3D"PINVALUE" value=3D"${*}"/>
     <set name=3D"PINNAME" value=3D"READY"/>
+    <set name=3D"PINRETRYCOUNT" value=3D"3"/>
 </chat>
 =

 <chat>
@@ -2320,6 +2332,7 @@
     <command>AT+CPIN=3D"*","*"</command>
     <response>+CPIN: SIM PUK\n\nERROR</response>
     <set name=3D"PINNAME" value=3D"SIM PUK"/>
+    <set name=3D"PINRETRYCOUNT" value=3D"0"/>
 </chat>
 =

 <chat>
@@ -2327,6 +2340,7 @@
     <command>AT+CPIN=3D*</command>
     <response>+CPIN: SIM PIN\n\nERROR</response>
     <set name=3D"PINNAME" value=3D"SIM PIN"/>
+    <set name=3D"PINRETRYCOUNT" value=3D"2"/>
     <switch name=3D"pinretry1"/>
 </chat>
 =

@@ -2337,6 +2351,7 @@
         <command>AT+CPIN=3D"${PINVALUE}"</command>
         <response>+CPIN: READY\n\nOK</response>
         <set name=3D"PINNAME" value=3D"READY"/>
+        <set name=3D"PINRETRYCOUNT" value=3D"3"/>
         <switch name=3D"default"/>
     </chat>
 =

@@ -2346,6 +2361,7 @@
         <response>+CPIN: READY\n\nOK</response>
         <set name=3D"PINVALUE" value=3D"${*}"/>
         <set name=3D"PINNAME" value=3D"READY"/>
+        <set name=3D"PINRETRYCOUNT" value=3D"3"/>
         <switch name=3D"default"/>
     </chat>
 =

@@ -2354,6 +2370,7 @@
         <command>AT+CPIN=3D*</command>
         <response>+CPIN: SIM PIN\n\nERROR</response>
         <set name=3D"PINNAME" value=3D"SIM PIN"/>
+        <set name=3D"PINRETRYCOUNT" value=3D"1"/>
         <switch name=3D"pinretry2"/>
     </chat>
 =

@@ -2366,6 +2383,7 @@
         <command>AT+CPIN=3D"${PINVALUE}"</command>
         <response>+CPIN: READY\n\nOK</response>
         <set name=3D"PINNAME" value=3D"READY"/>
+        <set name=3D"PINRETRYCOUNT" value=3D"3"/>
         <switch name=3D"default"/>
     </chat>
 =

@@ -2375,6 +2393,7 @@
         <response>+CPIN: READY\n\nOK</response>
         <set name=3D"PINVALUE" value=3D"${*}"/>
         <set name=3D"PINNAME" value=3D"READY"/>
+        <set name=3D"PINRETRYCOUNT" value=3D"3"/>
         <switch name=3D"default"/>
     </chat>
 =

@@ -2383,6 +2402,7 @@
         <command>AT+CPIN=3D*</command>
         <response>+CPIN: SIM PUK\n\nERROR</response>
         <set name=3D"PINNAME" value=3D"SIM PUK"/>
+        <set name=3D"PINRETRYCOUNT" value=3D"0"/>
     </chat>
 =

 </state>
-- =

1.9.1


--===============1703141774774217510==--

