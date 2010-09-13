Content-Type: multipart/mixed; boundary="===============2848902527631867125=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 4/8] USSD atom driver changes to read current character setting
Date: Mon, 13 Sep 2010 16:00:13 -0700
Message-ID: <1284418817-28575-5-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1284418817-28575-4-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2848902527631867125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/ussd.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 1e1fc25..30145ad 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -44,12 +44,25 @@
 =

 static const char *cusd_prefix[] =3D { "+CUSD:", NULL };
 static const char *none_prefix[] =3D { NULL };
+static const char *cscs_prefix[] =3D { "+CSCS:", NULL };
 =

 struct ussd_data {
 	GAtChat *chat;
 	unsigned int vendor;
+	enum at_util_charset charset;
 };
 =

+static void read_charset_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ussd_data *data =3D user_data;
+
+	if (!ok)
+		return;
+
+	at_util_parse_cscs_query(result, &data->charset);
+}
+
 static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
 {
 	GAtResultIter iter;
@@ -247,6 +260,9 @@ static int at_ussd_probe(struct ofono_ussd *ussd, unsig=
ned int vendor,
 =

 	ofono_ussd_set_data(ussd, data);
 =

+	g_at_chat_send(chat, "AT+CSCS?", cscs_prefix, read_charset_cb, data,
+			NULL);
+
 	g_at_chat_send(chat, "AT+CUSD=3D1", NULL, at_ussd_register, ussd, NULL);
 =

 	return 0;
-- =

1.7.0.4


--===============2848902527631867125==--

