Content-Type: multipart/mixed; boundary="===============6957169052199467590=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] mbmmodem: Fix ip netmask should be 255.255.255.255
Date: Wed, 23 Jun 2010 09:06:31 +0800
Message-ID: <1277255191-1335-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6957169052199467590==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change static IP netmask to 255.255.255.255.
---
 drivers/mbmmodem/gprs-context.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mbmmodem/gprs-context.c b/drivers/mbmmodem/gprs-contex=
t.c
index cca5087..2d0e4e2 100644
--- a/drivers/mbmmodem/gprs-context.c
+++ b/drivers/mbmmodem/gprs-context.c
@@ -48,7 +48,7 @@
 =

 #define MAX_DNS 5
 =

-#define STATIC_IP_NETMASK "255.255.255.248"
+#define STATIC_IP_NETMASK "255.255.255.255"
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *e2ipcfg_prefix[] =3D { "*E2IPCFG:", NULL };
-- =

1.6.3.3


--===============6957169052199467590==--

