Content-Type: multipart/mixed; boundary="===============9015727380033166288=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 02/10] gprs: Unregister AT notifiers when removing
Date: Tue, 10 Aug 2010 22:43:41 +0800
Message-ID: <1281451429-17257-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281451429-17257-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9015727380033166288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Unregister AT notifiers when removing gprs driver.
---
 drivers/atmodem/gprs.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index bf82d06..dcf9759 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -48,6 +48,8 @@ static const char *none_prefix[] =3D { NULL };
 struct gprs_data {
 	GAtChat *chat;
 	unsigned int vendor;
+	guint cgev_id;
+	guint cgreg_id;
 };
 =

 static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -181,9 +183,10 @@ static void gprs_initialized(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	struct ofono_gprs *gprs =3D user_data;
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 =

-	g_at_chat_register(gd->chat, "+CGEV:", cgev_notify, FALSE, gprs, NULL);
-	g_at_chat_register(gd->chat, "+CGREG:", cgreg_notify,
-				FALSE, gprs, NULL);
+	gd->cgev_id =3D g_at_chat_register(gd->chat, "+CGEV:", cgev_notify,
+						FALSE, gprs, NULL);
+	gd->cgreg_id =3D g_at_chat_register(gd->chat, "+CGREG:", cgreg_notify,
+						FALSE, gprs, NULL);
 =

 	ofono_gprs_register(gprs);
 }
@@ -321,6 +324,9 @@ static void at_gprs_remove(struct ofono_gprs *gprs)
 {
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 =

+	g_at_chat_unregister(gd->chat, gd->cgev_id);
+	g_at_chat_unregister(gd->chat, gd->cgreg_id);
+
 	ofono_gprs_set_data(gprs, NULL);
 	g_free(gd);
 }
-- =

1.7.0.4


--===============9015727380033166288==--

