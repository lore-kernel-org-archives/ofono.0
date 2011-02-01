Content-Type: multipart/mixed; boundary="===============2486420350165737927=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 2/4] nettime: Makefile.am modification
Date: Tue, 01 Feb 2011 16:49:29 +0200
Message-ID: <1296571771-26513-3-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1296571771-26513-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2486420350165737927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index a38fcb9..2d54025 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -337,6 +337,9 @@ builtin_modules +=3D example_provision
 builtin_sources +=3D examples/provision.c
 endif
 =

+builtin_modules +=3D nettime
+builtin_sources +=3D plugins/nettime.c
+
 builtin_modules +=3D smart_messaging
 builtin_sources +=3D plugins/smart-messaging.c
 =

@@ -404,7 +407,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/=
release-faq.txt \
 			doc/phonebook-api.txt doc/radio-settings-api.txt \
 			doc/sim-api.txt doc/stk-api.txt \
 			doc/audio-settings-api.txt doc/text-telephony-api.txt \
-			doc/calypso-modem.txt doc/message-api.txt
+			doc/calypso-modem.txt doc/message-api.txt \
+			doc/network-time-api.txt
 =

 =

 test_scripts =3D test/backtrace \
@@ -478,7 +482,8 @@ test_scripts =3D test/backtrace \
 		test/cdma-dial-number \
 		test/cdma-hangup \
 		test/disable-call-forwarding \
-		test/list-messages
+		test/list-messages \
+		test/test-nettime
 =

 if TEST
 testdir =3D $(pkglibdir)/test
-- =

1.7.1


--===============2486420350165737927==--

