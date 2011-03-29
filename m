Content-Type: multipart/mixed; boundary="===============8562329584159320707=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH] atmodem: gnss aggregate xml
Date: Tue, 29 Mar 2011 13:25:41 +0300
Message-ID: <1301394341-22961-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8562329584159320707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
Hi,

this patch provides logic to re-construct XML-formatted string prefixed wit=
h +CPOSR as defined in 27.007.

Br,
Jarko

 drivers/atmodem/gnss.c |  134 ++++++++++++++++++++++++++++++++++++++++++--=
----
 1 files changed, 118 insertions(+), 16 deletions(-)

diff --git a/drivers/atmodem/gnss.c b/drivers/atmodem/gnss.c
index 4954bb8..5d5a883 100644
--- a/drivers/atmodem/gnss.c
+++ b/drivers/atmodem/gnss.c
@@ -47,6 +47,8 @@ struct gnss_data {
 	unsigned int vendor;
 };
 =

+char *xml_data;
+
 static const char *none_prefix[] =3D { NULL };
 static const char *cpos_prefix[] =3D { "+CPOS:", NULL };
 static const char *cposr_prefix[] =3D { "+CPOSR:", NULL };
@@ -136,41 +138,136 @@ error:
 }
 =

 static gboolean gnss_parse_report(GAtResult *result, const char *prefix,
-					const char **xml)
+					char **xml)
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
+		if (xml_data) {
+			g_free(xml_data);
+			xml_data =3D NULL;
+		}
+		goto error;
+	}
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, &xml_result)) {
+		if (xml_data) {
+			g_free(xml_data);
+			xml_data =3D NULL;
+		}
+		goto error;
+	}
+
+	if (xml_result =3D=3D NULL) {
+		if (xml_data) {
+			g_free(xml_data);
+			xml_data =3D NULL;
+		}
+		goto error;
+	}
 =

-	if (!g_at_result_iter_next_unquoted_string(&iter, xml))
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
+		if (xml_data) {
+			g_free(xml_data);
+			xml_data =3D NULL;
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
+		if (xml_data) {
+			old_len =3D strlen(xml_data);
+			buf =3D g_try_new(char, (old_len+len+1));
+			if (!buf) {
+				g_free(xml_data);
+				g_free(temp_xml);
+				xml_data =3D NULL;
+				goto error;
+			}
+
+			xml_len =3D sprintf(buf, "%s", xml_data);
+			xml_len +=3D sprintf(buf + xml_len, "%s", temp_xml);
+			buf[xml_len] =3D '\0';
+			g_free(xml_data);
+			g_free(temp_xml);
+			xml_data =3D NULL;
+			*xml =3D buf;
+			return TRUE;
+		} else {
+			*xml =3D temp_xml;
+			return TRUE;
+		}
+	} else {
+		if (xml_data) {
+			old_len =3D strlen(xml_data);
+			buf =3D g_try_new(char, (old_len+len+1));
+			if (!buf) {
+				g_free(xml_data);
+				g_free(temp_xml);
+				xml_data =3D NULL;
+				goto error;
+			}
+
+			xml_len =3D sprintf(buf, "%s", xml_data);
+			xml_len +=3D sprintf(buf + xml_len, "%s", temp_xml);
+			buf[xml_len] =3D '\0';
+			g_free(xml_data);
+			xml_data =3D buf;
+			g_free(temp_xml);
+			return FALSE;
+		} else {
+			xml_data =3D temp_xml;
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
 	struct ofono_gnss *gnss =3D user_data;
-	const char *xml;
+	char *xml;
 =

 	DBG("");
 =

 	xml =3D NULL;
 =

-	if (!gnss_parse_report(result, "+CPOSR:", &xml)) {
-		ofono_error("Unable to parse CPOSR notification");
-		return;
-	}
-
-	if (xml =3D=3D NULL) {
-		ofono_error("Unable to parse CPOSR notification");
-		return;
+	if (gnss_parse_report(result, "+CPOSR:", &xml)) {
+		ofono_gnss_notify_posr_request(gnss, xml);
+		g_free(xml);
 	}
-
-	DBG("%s", xml);
 }
 =

 static void at_gnss_reset_notify(GAtResult *result, gpointer user_data)
@@ -237,6 +334,8 @@ static int at_gnss_probe(struct ofono_gnss *gnss, unsig=
ned int vendor,
 =

 	DBG("");
 =

+	xml_data =3D NULL;
+
 	gd =3D g_try_new0(struct gnss_data, 1);
 	if (gd =3D=3D NULL)
 		return -ENOMEM;
@@ -258,6 +357,9 @@ static void at_gnss_remove(struct ofono_gnss *gnss)
 =

 	DBG("");
 =

+	if (xml_data)
+		g_free(xml_data);
+
 	ofono_gnss_set_data(gnss, NULL);
 =

 	g_at_chat_unref(gd->chat);
-- =

1.7.0.4


--===============8562329584159320707==--

