Content-Type: multipart/mixed; boundary="===============7568938260033809001=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 3/5 v3] nettime: DBUS and compilation configuration
Date: Thu, 13 Jan 2011 11:49:33 +0200
Message-ID: <1294912175-12026-4-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1294912175-12026-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7568938260033809001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am    |    9 +++++++--
 src/ofono.conf |    2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index a68fc36..4e30cc9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -321,6 +321,9 @@ builtin_modules +=3D example_nettime
 builtin_sources +=3D examples/nettime.c
 endif
 =

+builtin_modules +=3D nettime
+builtin_sources +=3D plugins/nettime.c
+
 builtin_modules +=3D smart_messaging
 builtin_sources +=3D plugins/smart-messaging.c
 =

@@ -386,7 +389,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/=
release-faq.txt \
 			doc/phonebook-api.txt doc/radio-settings-api.txt \
 			doc/sim-api.txt doc/stk-api.txt \
 			doc/audio-settings-api.txt doc/text-telephony-api.txt \
-			doc/calypso-modem.txt
+			doc/calypso-modem.txt \
+			doc/network-time-api.txt
 =

 =

 test_scripts =3D test/backtrace \
@@ -455,7 +459,8 @@ test_scripts =3D test/backtrace \
 		test/set-gsm-band \
 		test/set-umts-band \
 		test/lockdown-modem \
-		test/set-call-forwarding
+		test/set-call-forwarding \
+		test/test-nettime
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/src/ofono.conf b/src/ofono.conf
index 0dfa038..c7b2e79 100644
--- a/src/ofono.conf
+++ b/src/ofono.conf
@@ -9,10 +9,12 @@
 =

   <policy user=3D"root">
     <allow own=3D"org.ofono"/>
+    <allow own=3D"com.meego"/>
     <allow send_destination=3D"org.ofono"/>
     <allow send_interface=3D"org.ofono.SimToolkitAgent"/>
     <allow send_interface=3D"org.ofono.PushNotificationAgent"/>
     <allow send_interface=3D"org.ofono.SmartMessagingAgent"/>
+    <allow send_interface=3D"org.ofono.NetworkTime"/>
   </policy>
 =

   <policy at_console=3D"true">
-- =

1.7.1


--===============7568938260033809001==--

