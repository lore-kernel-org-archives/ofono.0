Content-Type: multipart/mixed; boundary="===============7872930441189364646=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] ifxmodem: fix xtms read and test cmd prefix
Date: Fri, 04 Feb 2011 15:42:28 +0200
Message-ID: <1296826948-12839-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7872930441189364646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

with the latest modem firmware, xctms prefix
is returned as per the 3GPP format.
---
 drivers/ifxmodem/ctm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ifxmodem/ctm.c b/drivers/ifxmodem/ctm.c
index 7b23a9b..5080b16 100644
--- a/drivers/ifxmodem/ctm.c
+++ b/drivers/ifxmodem/ctm.c
@@ -41,7 +41,7 @@
 #include "ifxmodem.h"
 =

 static const char *none_prefix[] =3D { NULL };
-static const char *xctms_prefix[] =3D { "XCTMS:", NULL };
+static const char *xctms_prefix[] =3D { "+XCTMS:", NULL };
 =

 struct ctm_data {
 	GAtChat *chat;
@@ -65,7 +65,7 @@ static void xctms_query_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 =

 	g_at_result_iter_init(&iter, result);
 =

-	if (g_at_result_iter_next(&iter, "XCTMS:") =3D=3D FALSE)
+	if (g_at_result_iter_next(&iter, "+XCTMS:") =3D=3D FALSE)
 		goto error;
 =

 	if (g_at_result_iter_next_number(&iter, &value) =3D=3D FALSE)
-- =

1.7.0.4


--===============7872930441189364646==--

