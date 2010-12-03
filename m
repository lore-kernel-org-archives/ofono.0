Content-Type: multipart/mixed; boundary="===============8959998381604442915=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 2/3] plugins: Enabling nettime plugin in Makefile.am
Date: Fri, 03 Dec 2010 11:47:27 +0200
Message-ID: <1291369648-25059-2-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1291369648-25059-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8959998381604442915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index a4c47e8..94dbaa1 100644
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

-- =

1.7.1


--===============8959998381604442915==--

