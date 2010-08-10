Content-Type: multipart/mixed; boundary="===============4815178815209204568=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 10/10] voicecall: Unregister AT notifiers when removing
Date: Tue, 10 Aug 2010 22:43:49 +0800
Message-ID: <1281451429-17257-11-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281451429-17257-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4815178815209204568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Unregister AT notifiers when removing voicecall driver.
---
 drivers/atmodem/voicecall.c |   40 +++++++++++++++++++++++++++++++---------
 1 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index fce9144..16b3069 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -56,6 +56,13 @@ struct voicecall_data {
 	unsigned int local_release;
 	unsigned int clcc_source;
 	GAtChat *chat;
+	guint ring_id;
+	guint cring_id;
+	guint clip_id;
+	guint ccwa_id;
+	guint no_carrier_id;
+	guint no_answer_id;
+	guint busy_id;
 };
 =

 struct release_id_req {
@@ -814,19 +821,26 @@ static void at_voicecall_initialized(gboolean ok, GAt=
Result *result,
 =

 	DBG("voicecall_init: registering to notifications");
 =

-	g_at_chat_register(vd->chat, "RING", ring_notify, FALSE, vc, NULL);
-	g_at_chat_register(vd->chat, "+CRING:", cring_notify, FALSE, vc, NULL);
-	g_at_chat_register(vd->chat, "+CLIP:", clip_notify, FALSE, vc, NULL);
-	g_at_chat_register(vd->chat, "+CCWA:", ccwa_notify, FALSE, vc, NULL);
+	vd->ring_id =3D g_at_chat_register(vd->chat, "RING", ring_notify,
+						FALSE, vc, NULL);
+	vd->cring_id =3D g_at_chat_register(vd->chat, "+CRING:", cring_notify,
+						FALSE, vc, NULL);
+	vd->clip_id =3D g_at_chat_register(vd->chat, "+CLIP:", clip_notify,
+						FALSE, vc, NULL);
+	vd->ccwa_id =3D g_at_chat_register(vd->chat, "+CCWA:", ccwa_notify,
+						FALSE, vc, NULL);
 =

 	/* Modems with 'better' call progress indicators should
 	 * probably not even bother registering to these
 	 */
-	g_at_chat_register(vd->chat, "NO CARRIER",
-				no_carrier_notify, FALSE, vc, NULL);
-	g_at_chat_register(vd->chat, "NO ANSWER",
-				no_answer_notify, FALSE, vc, NULL);
-	g_at_chat_register(vd->chat, "BUSY", busy_notify, FALSE, vc, NULL);
+	vd->no_carrier_id =3D g_at_chat_register(vd->chat, "NO CARRIER",
+						no_carrier_notify,
+						FALSE, vc, NULL);
+	vd->no_answer_id =3D g_at_chat_register(vd->chat, "NO ANSWER",
+						no_answer_notify,
+						FALSE, vc, NULL);
+	vd->busy_id =3D g_at_chat_register(vd->chat, "BUSY", busy_notify,
+						FALSE, vc, NULL);
 =

 	ofono_voicecall_register(vc);
 =

@@ -863,6 +877,14 @@ static void at_voicecall_remove(struct ofono_voicecall=
 *vc)
 	g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
 	g_slist_free(vd->calls);
 =

+	g_at_chat_unregister(vd->chat, vd->ring_id);
+	g_at_chat_unregister(vd->chat, vd->cring_id);
+	g_at_chat_unregister(vd->chat, vd->clip_id);
+	g_at_chat_unregister(vd->chat, vd->ccwa_id);
+	g_at_chat_unregister(vd->chat, vd->no_carrier_id);
+	g_at_chat_unregister(vd->chat, vd->no_answer_id);
+	g_at_chat_unregister(vd->chat, vd->busy_id);
+
 	ofono_voicecall_set_data(vc, NULL);
 =

 	g_free(vd);
-- =

1.7.0.4


--===============4815178815209204568==--

