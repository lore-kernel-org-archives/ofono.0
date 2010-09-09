Content-Type: multipart/mixed; boundary="===============1861212889770709547=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 04/12] USSD atom driver changes to read current character
 setting
Date: Thu, 09 Sep 2010 05:31:48 -0700
Message-ID: <1284035516-21359-5-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1284035516-21359-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1861212889770709547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/ussd.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 1e1fc25..cb1515f 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -44,12 +44,27 @@
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
+	const char *str =3D NULL;
+
+	if (!ok)
+		return;
+
+	if (at_util_parse_cscs_query(result, &str))
+		at_util_charset_string_to_charset(str, &data->charset);
+}
+
 static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
 {
 	GAtResultIter iter;
@@ -247,6 +262,9 @@ static int at_ussd_probe(struct ofono_ussd *ussd, unsig=
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


--===============1861212889770709547==--

