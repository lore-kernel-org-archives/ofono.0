Content-Type: multipart/mixed; boundary="===============8519629853586740917=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 04/10] cbs: Unregister AT notifiers when removing
Date: Tue, 10 Aug 2010 22:43:43 +0800
Message-ID: <1281451429-17257-5-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281451429-17257-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8519629853586740917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Unregister AT notifications when removing cbs driver.
---
 drivers/atmodem/cbs.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/cbs.c b/drivers/atmodem/cbs.c
index a1c4037..ef312e9 100644
--- a/drivers/atmodem/cbs.c
+++ b/drivers/atmodem/cbs.c
@@ -47,6 +47,7 @@ struct cbs_data {
 	GAtChat *chat;
 	gboolean cscb_mode_1;
 	unsigned int vendor;
+	guint cbm_id;
 };
 =

 static void at_cbm_notify(GAtResult *result, gpointer user_data)
@@ -182,7 +183,8 @@ static void at_cbs_register(gboolean ok, GAtResult *res=
ult, gpointer user)
 	 * The default SMS driver will setup the CNMI for +CBM delivery
 	 * appropriately for us
 	 */
-	g_at_chat_register(data->chat, "+CBM:", at_cbm_notify, TRUE, cbs, NULL);
+	data->cbm_id =3D g_at_chat_register(data->chat, "+CBM:",
+						at_cbm_notify, TRUE, cbs, NULL);
 =

 	ofono_cbs_register(cbs);
 }
@@ -252,6 +254,8 @@ static void at_cbs_remove(struct ofono_cbs *cbs)
 {
 	struct cbs_data *data =3D ofono_cbs_get_data(cbs);
 =

+	g_at_chat_unregister(data->chat, data->cbm_id);
+
 	ofono_cbs_set_data(cbs, NULL);
 =

 	g_free(data);
-- =

1.7.0.4


--===============8519629853586740917==--

