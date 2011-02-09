Content-Type: multipart/mixed; boundary="===============3364256840085465433=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 2/3] nettime: Makefile.am modification
Date: Wed, 09 Feb 2011 21:12:50 +0200
Message-ID: <1297278771-14468-3-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1297278771-14468-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3364256840085465433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index e402de4..b043f9e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -338,6 +338,9 @@ builtin_modules +=3D example_provision
 builtin_sources +=3D examples/provision.c
 endif
 =

+builtin_modules +=3D meego_nettime
+builtin_sources +=3D plugins/meego-nettime.c
+
 builtin_modules +=3D smart_messaging
 builtin_sources +=3D plugins/smart-messaging.c
 =

@@ -480,7 +483,8 @@ test_scripts =3D test/backtrace \
 		test/cdma-hangup \
 		test/disable-call-forwarding \
 		test/list-messages \
-		test/test-sms
+		test/test-sms \
+		test/test-nettime
 =

 if TEST
 testdir =3D $(pkglibdir)/test
-- =

1.7.1


--===============3364256840085465433==--

