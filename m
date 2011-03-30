Content-Type: multipart/mixed; boundary="===============5478673552838208973=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH] atmodem: gnss aggregate xml
Date: Wed, 30 Mar 2011 11:45:40 +0300
Message-ID: <1301474740-15233-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5478673552838208973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
Hi,

ok this is the very final patch from me for this. The parsing could be done=
 better I know but seems to work. Hopefully this will any way give some ide=
a for somebody else to finalise this.

br,
Jarko
 drivers/atmodem/gnss.c |  135 ++++++++++++++++++++++++++++++++++++++++++--=
----
 1 files changed, 119 insertions(+), 16 deletions(-)

diff --git a/drivers/atmodem/gnss.c b/drivers/atmodem/gnss.c
index e102815..719fb6d 100644
--- a/drivers/atmodem/gnss.c
+++ b/drivers/atmodem/gnss.c
@@ -45,6 +45,7 @@
 struct gnss_data {
 	GAtChat *chat;
 	unsigned int vendor;
+	char *xml_data;
 };
 =

 static const char *none_prefix[] =3D { NULL };
@@ -136,40 +137,138 @@ error:
 }
 =

 static gboolean gnss_parse_report(GAtResult *result, const char *prefix,
-					const char **xml)
+					char **xml, struct gnss_data *gd)
 {
 	GAtResultIter iter;
+	char *buf, *temp_xml;
+	int len, old_len, xml_len;
+	const char *xml_result;
+
+	buf =3D NULL;
+	temp_xml =3D NULL;
+	xml_result =3D NULL;
+	xml_len =3D 0;
+	old_len =3D 0;
+	len =3D 0;
 =

 	g_at_result_iter_init(&iter, result);
 =

-	if (!g_at_result_iter_next(&iter, prefix))
-		return FALSE;
+	if (!g_at_result_iter_next(&iter, prefix)) {
+		if (gd->xml_data) {
+			g_free(gd->xml_data);
+			gd->xml_data =3D NULL;
+		}
+		goto error;
+	}
 =

-	if (!g_at_result_iter_next_unquoted_string(&iter, xml))
+	if (!g_at_result_iter_next_unquoted_string(&iter, &xml_result)) {
+		if (gd->xml_data) {
+			g_free(gd->xml_data);
+			gd->xml_data =3D NULL;
+		}
+		goto error;
+	}
+
+	if (xml_result =3D=3D NULL) {
+		if (gd->xml_data) {
+			g_free(gd->xml_data);
+			gd->xml_data =3D NULL;
+		}
+		goto error;
+	}
+
+	len =3D strlen(xml_result);
+
+	if (len =3D=3D 0)
 		return FALSE;
 =

-	return TRUE;
+	while ((xml_result[len-1] =3D=3D '\n') || (xml_result[len-1] =3D=3D '\r')=
 ||
+			(xml_result[len-1] =3D=3D ' ')) {
+		len =3D len - 1;
+	}
+
+	temp_xml =3D g_try_new(char, len+1);
+	if (!temp_xml) {
+		if (gd->xml_data) {
+			g_free(gd->xml_data);
+			gd->xml_data =3D NULL;
+		}
+		goto error;
+	}
+
+	g_memmove(temp_xml, xml_result, len);
+	temp_xml[len] =3D '\0';
+
+	if (temp_xml[len-1] =3D=3D '>' && temp_xml[len-2] =3D=3D 's'
+			&& temp_xml[len-3] =3D=3D 'o'
+			&& temp_xml[len-4] =3D=3D 'p'
+			&& temp_xml[len-5] =3D=3D '/') {
+		if (gd->xml_data) {
+			old_len =3D strlen(gd->xml_data);
+			buf =3D g_try_new(char, (old_len+len+1));
+			if (!buf) {
+				g_free(gd->xml_data);
+				g_free(temp_xml);
+				gd->xml_data =3D NULL;
+				goto error;
+			}
+
+			xml_len =3D sprintf(buf, "%s", gd->xml_data);
+			xml_len +=3D sprintf(buf + xml_len, "%s", temp_xml);
+			buf[xml_len] =3D '\0';
+			g_free(gd->xml_data);
+			g_free(temp_xml);
+			gd->xml_data =3D NULL;
+			*xml =3D buf;
+			return TRUE;
+		} else {
+			*xml =3D temp_xml;
+			return TRUE;
+		}
+	} else {
+		if (gd->xml_data) {
+			old_len =3D strlen(gd->xml_data);
+			buf =3D g_try_new(char, (old_len+len+1));
+			if (!buf) {
+				g_free(gd->xml_data);
+				g_free(temp_xml);
+				gd->xml_data =3D NULL;
+				goto error;
+			}
+
+			xml_len =3D sprintf(buf, "%s", gd->xml_data);
+			xml_len +=3D sprintf(buf + xml_len, "%s", temp_xml);
+			buf[xml_len] =3D '\0';
+			g_free(gd->xml_data);
+			gd->xml_data =3D buf;
+			g_free(temp_xml);
+			return FALSE;
+		} else {
+			gd->xml_data =3D temp_xml;
+			return FALSE;
+		}
+	}
+
+error:
+	ofono_error("Unable to parse CPOSR notification");
+	return FALSE;
 }
 =

 static void gnss_report(GAtResult *result, gpointer user_data)
 {
-	const char *xml;
+	struct ofono_gnss *gnss =3D user_data;
+	struct gnss_data *gd =3D ofono_gnss_get_data(gnss);
+
+	char *xml;
 =

 	DBG("");
 =

 	xml =3D NULL;
 =

-	if (!gnss_parse_report(result, "+CPOSR:", &xml)) {
-		ofono_error("Unable to parse CPOSR notification");
-		return;
+	if (gnss_parse_report(result, "+CPOSR:", &xml, gd)) {
+		ofono_gnss_notify_posr_request(gnss, xml);
+		g_free(xml);
 	}
-
-	if (xml =3D=3D NULL) {
-		ofono_error("Unable to parse CPOSR notification");
-		return;
-	}
-
-	DBG("%s", xml);
 }
 =

 static void at_gnss_reset_notify(GAtResult *result, gpointer user_data)
@@ -242,6 +341,7 @@ static int at_gnss_probe(struct ofono_gnss *gnss, unsig=
ned int vendor,
 =

 	gd->chat =3D g_at_chat_clone(chat);
 	gd->vendor =3D vendor;
+	gd->xml_data =3D NULL;
 =

 	ofono_gnss_set_data(gnss, gd);
 =

@@ -257,6 +357,9 @@ static void at_gnss_remove(struct ofono_gnss *gnss)
 =

 	DBG("");
 =

+	if (gd->xml_data)
+		g_free(gd->xml_data);
+
 	ofono_gnss_set_data(gnss, NULL);
 =

 	g_at_chat_unref(gd->chat);
-- =

1.7.0.4


--===============5478673552838208973==--

