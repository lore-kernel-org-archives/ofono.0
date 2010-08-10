Content-Type: multipart/mixed; boundary="===============7042600801159650596=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 05/10] ussd: Unregister AT notifiers when removing
Date: Tue, 10 Aug 2010 22:43:44 +0800
Message-ID: <1281451429-17257-6-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281451429-17257-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7042600801159650596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add struct ussd_data to hold gatchat and cusd_id. So that we could
unregister AT notifications in driver removing phase.
---
 drivers/atmodem/ussd.c |   33 ++++++++++++++++++++++++++-------
 1 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 555ce13..0def9b1 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -47,6 +47,11 @@ struct cusd_req {
 	struct ofono_ussd *ussd;
 };
 =

+struct ussd_data {
+	GAtChat *chat;
+	guint cusd_id;
+};
+
 static const char *cusd_prefix[] =3D { "+CUSD:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

@@ -119,7 +124,7 @@ static void cusd_request_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 static void at_ussd_request(struct ofono_ussd *ussd, const char *str,
 				ofono_ussd_cb_t cb, void *data)
 {
-	GAtChat *chat =3D ofono_ussd_get_data(ussd);
+	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
 	struct cusd_req *cbd =3D g_try_new0(struct cusd_req, 1);
 	unsigned char *converted =3D NULL;
 	int dcs;
@@ -152,7 +157,7 @@ static void at_ussd_request(struct ofono_ussd *ussd, co=
nst char *str,
 	g_free(converted);
 	converted =3D NULL;
 =

-	if (g_at_chat_send(chat, buf, cusd_prefix,
+	if (g_at_chat_send(ud->chat, buf, cusd_prefix,
 				cusd_request_cb, cbd, g_free) > 0)
 		return;
 =

@@ -180,13 +185,13 @@ static void cusd_cancel_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 static void at_ussd_cancel(struct ofono_ussd *ussd,
 				ofono_ussd_cb_t cb, void *data)
 {
-	GAtChat *chat =3D ofono_ussd_get_data(ussd);
+	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

 	if (!cbd)
 		goto error;
 =

-	if (g_at_chat_send(chat, "AT+CUSD=3D2", none_prefix,
+	if (g_at_chat_send(ud->chat, "AT+CUSD=3D2", none_prefix,
 				cusd_cancel_cb, cbd, g_free) > 0)
 		return;
 =

@@ -207,14 +212,16 @@ static void cusd_notify(GAtResult *result, gpointer u=
ser_data)
 static void at_ussd_register(gboolean ok, GAtResult *result, gpointer user)
 {
 	struct ofono_ussd *ussd =3D user;
-	GAtChat *chat =3D ofono_ussd_get_data(ussd);
+	struct ussd_data *data =3D ofono_ussd_get_data(ussd);
 =

 	if (!ok) {
 		ofono_error("Could not enable CUSD notifications");
 		return;
 	}
 =

-	g_at_chat_register(chat, "+CUSD:", cusd_notify, FALSE, ussd, NULL);
+	data->cusd_id =3D g_at_chat_register(data->chat, "+CUSD:",
+						cusd_notify, FALSE,
+						ussd, NULL);
 =

 	ofono_ussd_register(ussd);
 }
@@ -223,8 +230,13 @@ static int at_ussd_probe(struct ofono_ussd *ussd, unsi=
gned int vendor,
 				void *data)
 {
 	GAtChat *chat =3D data;
+	struct ussd_data *ud;
+
+	ud =3D g_new0(struct ussd_data, 1);
+
+	ud->chat =3D chat;
 =

-	ofono_ussd_set_data(ussd, chat);
+	ofono_ussd_set_data(ussd, ud);
 =

 	g_at_chat_send(chat, "AT+CUSD=3D1", NULL, at_ussd_register, ussd, NULL);
 =

@@ -233,6 +245,13 @@ static int at_ussd_probe(struct ofono_ussd *ussd, unsi=
gned int vendor,
 =

 static void at_ussd_remove(struct ofono_ussd *ussd)
 {
+	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
+
+	g_at_chat_unregister(ud->chat, ud->cusd_id);
+
+	ofono_ussd_set_data(ussd, NULL);
+
+	g_free(ud);
 }
 =

 static struct ofono_ussd_driver driver =3D {
-- =

1.7.0.4


--===============7042600801159650596==--

