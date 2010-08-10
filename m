Content-Type: multipart/mixed; boundary="===============8620485630661568513=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 06/10] ssn: Unregister AT notifiers when removing
Date: Tue, 10 Aug 2010 22:43:45 +0800
Message-ID: <1281451429-17257-7-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281451429-17257-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8620485630661568513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Unregister AT notifications when removing ssn driver.
---
 drivers/atmodem/ssn.c |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/ssn.c b/drivers/atmodem/ssn.c
index f219cde..ce8f1e0 100644
--- a/drivers/atmodem/ssn.c
+++ b/drivers/atmodem/ssn.c
@@ -39,6 +39,12 @@
 =

 static const char *none_prefix[] =3D { NULL };
 =

+struct ssn_data {
+	GAtChat *chat;
+	guint cssi_id;
+	guint cssu_id;
+};
+
 static void cssi_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_ssn *ssn =3D user_data;
@@ -100,10 +106,12 @@ static void at_ssn_initialized(gboolean ok, GAtResult=
 *result,
 				gpointer user_data)
 {
 	struct ofono_ssn *ssn =3D user_data;
-	GAtChat *chat =3D ofono_ssn_get_data(ssn);
+	struct ssn_data *sd =3D ofono_ssn_get_data(ssn);
 =

-	g_at_chat_register(chat, "+CSSI:", cssi_notify, FALSE, ssn, NULL);
-	g_at_chat_register(chat, "+CSSU:", cssu_notify, FALSE, ssn, NULL);
+	sd->cssi_id =3D g_at_chat_register(sd->chat, "+CSSI:", cssi_notify,
+						FALSE, ssn, NULL);
+	sd->cssu_id =3D g_at_chat_register(sd->chat, "+CSSU:", cssu_notify,
+						FALSE, ssn, NULL);
 =

 	ofono_ssn_register(ssn);
 }
@@ -112,8 +120,14 @@ static int at_ssn_probe(struct ofono_ssn *ssn, unsigne=
d int vendor,
 				void *data)
 {
 	GAtChat *chat =3D data;
+	struct ssn_data *sd;
+
+	sd =3D g_new0(struct ssn_data, 1);
+
+	sd->chat =3D chat;
+
+	ofono_ssn_set_data(ssn, sd);
 =

-	ofono_ssn_set_data(ssn, chat);
 	g_at_chat_send(chat, "AT+CSSN=3D1,1", none_prefix,
 			at_ssn_initialized, ssn, NULL);
 =

@@ -122,6 +136,14 @@ static int at_ssn_probe(struct ofono_ssn *ssn, unsigne=
d int vendor,
 =

 static void at_ssn_remove(struct ofono_ssn *ssn)
 {
+	struct ssn_data *sd =3D ofono_ssn_get_data(ssn);
+
+	g_at_chat_unregister(sd->chat, sd->cssi_id);
+	g_at_chat_unregister(sd->chat, sd->cssu_id);
+
+	ofono_ssn_set_data(ssn, NULL);
+
+	g_free(sd);
 }
 =

 static struct ofono_ssn_driver driver =3D {
-- =

1.7.0.4


--===============8620485630661568513==--

