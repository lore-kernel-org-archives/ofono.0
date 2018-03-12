Content-Type: multipart/mixed; boundary="===============7142030436465419677=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: [PATCH 3/6] gemalto: acquire the network technology
Date: Mon, 12 Mar 2018 13:57:10 +0100
Message-ID: <1520859433-14112-4-git-send-email-gabriel.lucas@smile.fr>
In-Reply-To: <1520859433-14112-1-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7142030436465419677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mariem Cherif <mariem.cherif@ardia.com.tn>

---
 drivers/atmodem/network-registration.c | 45 ++++++++++++++++++++++++++++++=
++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index a5e2af3..aec9c2d 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -48,6 +48,7 @@ static const char *cops_prefix[] =3D { "+COPS:", NULL };
 static const char *csq_prefix[] =3D { "+CSQ:", NULL };
 static const char *cind_prefix[] =3D { "+CIND:", NULL };
 static const char *cmer_prefix[] =3D { "+CMER:", NULL };
+static const char *smoni_prefix[] =3D { "^SMONI:", "", NULL };
 static const char *zpas_prefix[] =3D { "+ZPAS:", NULL };
 static const char *option_tech_prefix[] =3D { "_OCTI:", "_OUWCTI:", NULL };
 =

@@ -178,6 +179,32 @@ static int option_parse_tech(GAtResult *result)
 	return tech;
 }
 =

+static int cinterion_parse_tech(GAtResult *result)
+{
+	int tech =3D -1;
+	GAtResultIter iter;
+	GSList *l;
+	g_at_result_iter_init(&iter, result);
+	l =3D result->lines;
+	if (strstr(l->data, "^SMONI: ") !=3D NULL) {
+		gchar **body =3D g_strsplit(l->data, "^SMONI: ", 2);
+		if (*body !=3D NULL) {
+			gchar **data =3D g_strsplit(body[1], ",", 20);
+			if (*data !=3D NULL) {
+				if (g_strcmp0(data[0], "2G") =3D=3D 0) {
+					tech =3D ACCESS_TECHNOLOGY_GSM;
+				} else if (g_strcmp0 (data[0], "3G") =3D=3D 0) {
+					tech =3D ACCESS_TECHNOLOGY_UTRAN;
+				} else if (g_strcmp0 (data[0], "4G") =3D=3D 0) {
+					tech =3D ACCESS_TECHNOLOGY_EUTRAN;
+				}
+			}
+			g_strfreev(body);
+		}
+	}
+	return tech;
+}
+
 static void at_creg_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -205,6 +232,18 @@ static void at_creg_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	cb(&error, status, lac, ci, tech, cbd->data);
 }
 =

+static void cinterion_query_tech_cb(gboolean ok, GAtResult *result,
+                                              gpointer user_data)
+{
+	struct tech_query *tq =3D user_data;
+	int tech;
+
+	tech =3D cinterion_parse_tech(result);
+
+	ofono_netreg_status_notify(tq->netreg,
+			tq->status, tq->lac, tq->ci, tech);
+}
+
 static void zte_tech_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -1518,6 +1557,12 @@ static void creg_notify(GAtResult *result, gpointer =
user_data)
 					option_query_tech_cb, tq, g_free) > 0)
 			return;
 		break;
+    case OFONO_VENDOR_CINTERION:
+              if (g_at_chat_send(nd->chat, "AT^SMONI",
+                                      smoni_prefix,
+                                      cinterion_query_tech_cb, tq, g_free)=
 > 0)
+                      return;
+              break;
 	}
 =

 	g_free(tq);
-- =

1.9.1


--===============7142030436465419677==--

