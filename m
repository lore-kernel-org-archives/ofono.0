Content-Type: multipart/mixed; boundary="===============1113617832091432848=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 2/4 v2] plugins: Enabling nettime plugin in Makefile.am
Date: Fri, 10 Dec 2010 09:53:56 +0200
Message-ID: <1291967638-12371-3-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1291967638-12371-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1113617832091432848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index cdb3166..70162ec 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -296,6 +296,9 @@ builtin_modules +=3D example_nettime
 builtin_sources +=3D examples/nettime.c
 endif
 =

+builtin_modules +=3D nettime
+builtin_sources +=3D plugins/nettime.c
+
 builtin_modules +=3D smart_messaging
 builtin_sources +=3D plugins/smart-messaging.c
 =

@@ -358,7 +361,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt \
 			doc/message-api.txt doc/message-waiting-api.txt \
 			doc/phonebook-api.txt doc/radio-settings-api.txt \
 			doc/sim-api.txt doc/stk-api.txt \
-			doc/audio-settings-api.txt doc/text-telephony-api.txt
+			doc/audio-settings-api.txt doc/text-telephony-api.txt \
+			doc/network-time-api.txt
 =

 =

 test_scripts =3D test/backtrace \
@@ -423,7 +427,9 @@ test_scripts =3D test/backtrace \
 		test/test-push-notification \
 		test/test-smart-messaging \
 		test/send-vcard \
-		test/set-tty
+		test/set-tty \
+		test/test-nettime \
+		test/get-nettime
 =

 if TEST
 testdir =3D $(pkglibdir)/test
-- =

1.7.1


--===============1113617832091432848==--

