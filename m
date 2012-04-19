Content-Type: multipart/mixed; boundary="===============6453677650956036182=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 5/7] plugins: Add history-agent
Date: Thu, 19 Apr 2012 11:20:54 +0300
Message-ID: <1334823656-3366-6-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1334823656-3366-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6453677650956036182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index b80f501..0a529ce 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -432,6 +432,9 @@ builtin_sources +=3D plugins/smart-messaging.c
 builtin_modules +=3D push_notification
 builtin_sources +=3D plugins/push-notification.c
 =

+builtin_modules +=3D history_agent
+builtin_sources +=3D plugins/history-agent.c
+
 sbin_PROGRAMS =3D src/ofonod
 =

 src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sources) src/ofono.ver \
-- =

1.7.5.4


--===============6453677650956036182==--

