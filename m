Content-Type: multipart/mixed; boundary="===============5738470515718605360=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/1] ifxmodem: change AT command for enabling SATK
Date: Thu, 13 Jan 2011 15:27:27 +0200
Message-ID: <1294925247-5144-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294925247-5144-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5738470515718605360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/stk.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/ifxmodem/stk.c b/drivers/ifxmodem/stk.c
index 1a1805c..5951149 100644
--- a/drivers/ifxmodem/stk.c
+++ b/drivers/ifxmodem/stk.c
@@ -46,7 +46,7 @@ struct stk_data {
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *sate_prefix[] =3D { "+SATE:", NULL };
-static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
+static const char *xsatk_prefix[] =3D { "+XSATK:", NULL };
 =

 static void sate_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
@@ -244,7 +244,7 @@ static void satf_notify(GAtResult *result, gpointer use=
r_data)
 		ofono_stk_proactive_session_end_notify(stk);
 }
 =

-static void cfun_support_cb(gboolean ok, GAtResult *result,
+static void xsatk_support_cb(gboolean ok, GAtResult *result,
 						gpointer user_data)
 {
 	struct ofono_stk *stk =3D user_data;
@@ -259,8 +259,7 @@ static void cfun_support_cb(gboolean ok, GAtResult *res=
ult,
 	g_at_chat_register(sd->chat, "+SATN:", satn_notify, FALSE, stk, NULL);
 	g_at_chat_register(sd->chat, "+SATF:", satf_notify, FALSE, stk, NULL);
 =

-	g_at_chat_send(sd->chat, "AT+CFUN=3D6", none_prefix,
-						NULL, NULL, NULL);
+	g_at_chat_send(sd->chat, "AT+XSATK=3D1,1", none_prefix, NULL, NULL, NULL);
 =

 	ofono_stk_register(stk);
 }
@@ -280,8 +279,8 @@ static int ifx_stk_probe(struct ofono_stk *stk, unsigne=
d int vendor, void *data)
 =

 	ofono_stk_set_data(stk, sd);
 =

-	g_at_chat_send(sd->chat, "AT+CFUN=3D?", cfun_prefix,
-					cfun_support_cb, stk, NULL);
+	g_at_chat_send(sd->chat, "AT+XSATK=3D?", xsatk_prefix, xsatk_support_cb,
+			stk, NULL);
 =

 	return 0;
 }
-- =

1.7.0.4


--===============5738470515718605360==--

