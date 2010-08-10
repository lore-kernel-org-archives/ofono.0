Content-Type: multipart/mixed; boundary="===============5546895564027486519=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 08/10] sms: Unregister AT notifiers when removing
Date: Tue, 10 Aug 2010 22:43:47 +0800
Message-ID: <1281451429-17257-9-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281451429-17257-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5546895564027486519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Unregister AT notifiers when removing sms driver.
---
 drivers/atmodem/sms.c |   31 +++++++++++++++++++++----------
 1 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index ba98c12..335f456 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -78,6 +78,11 @@ struct sms_data {
 	guint timeout_source;
 	GAtChat *chat;
 	unsigned int vendor;
+	guint cmti_id;
+	guint cmt_id;
+	guint cds_id;
+	guint cdsi_id;
+	guint cmgr_id;
 };
 =

 struct cpms_request {
@@ -599,18 +604,18 @@ static void at_cmgl_done(struct ofono_sms *sms)
 		return;
 	}
 =

-	g_at_chat_register(data->chat, "+CMTI:", at_cmti_notify, FALSE,
-				sms, NULL);
-	g_at_chat_register(data->chat, "+CMT:", at_cmt_notify, TRUE,
-				sms, NULL);
-	g_at_chat_register(data->chat, "+CDS:", at_cds_notify, TRUE,
-				sms, NULL);
-	g_at_chat_register(data->chat, "+CDSI:", at_cdsi_notify, FALSE,
-				sms, NULL);
+	data->cmti_id =3D g_at_chat_register(data->chat, "+CMTI:", at_cmti_notify,
+						FALSE, sms, NULL);
+	data->cmt_id =3D g_at_chat_register(data->chat, "+CMT:", at_cmt_notify,
+						TRUE, sms, NULL);
+	data->cds_id =3D g_at_chat_register(data->chat, "+CDS:", at_cds_notify,
+						TRUE, sms, NULL);
+	data->cdsi_id =3D g_at_chat_register(data->chat, "+CDSI:", at_cdsi_notify,
+						FALSE, sms, NULL);
 =

 	/* We treat CMGR just like a notification */
-	g_at_chat_register(data->chat, "+CMGR:", at_cmgr_notify, TRUE,
-				sms, NULL);
+	data->cmgr_id =3D g_at_chat_register(data->chat, "+CMGR:", at_cmgr_notify,
+						TRUE, sms, NULL);
 }
 =

 static void at_cmgl_notify(GAtResult *result, gpointer user_data)
@@ -1233,6 +1238,12 @@ static void at_sms_remove(struct ofono_sms *sms)
 	if (data->timeout_source > 0)
 		g_source_remove(data->timeout_source);
 =

+	g_at_chat_unregister(data->chat, data->cmti_id);
+	g_at_chat_unregister(data->chat, data->cmt_id);
+	g_at_chat_unregister(data->chat, data->cds_id);
+	g_at_chat_unregister(data->chat, data->cdsi_id);
+	g_at_chat_unregister(data->chat, data->cmgr_id);
+
 	g_free(data);
 }
 =

-- =

1.7.0.4


--===============5546895564027486519==--

