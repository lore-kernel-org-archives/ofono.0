Content-Type: multipart/mixed; boundary="===============0651701555637751614=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@nokia.com>
Subject: [PATCH 2/9] SMS history plugin.
Date: Wed, 29 Dec 2010 14:51:18 +0200
Message-ID: <1293627085-24428-3-git-send-email-oleg.zhurakivskyy@nokia.com>
In-Reply-To: <1293627085-24428-1-git-send-email-oleg.zhurakivskyy@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0651701555637751614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index dfdb7bd..d30d2e6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -310,6 +310,9 @@ builtin_sources +=3D plugins/smart-messaging.c
 builtin_modules +=3D push_notification
 builtin_sources +=3D plugins/push-notification.c
 =

+builtin_modules +=3D messaging_agent
+builtin_sources +=3D plugins/messaging-agent.c
+
 sbin_PROGRAMS =3D src/ofonod
 =

 src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sources) src/ofono.ver \
-- =

1.7.1


--===============0651701555637751614==--

