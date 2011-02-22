Content-Type: multipart/mixed; boundary="===============6923305334238606831=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 3/3] emulator: add CIND support
Date: Tue, 22 Feb 2011 16:40:36 +0100
Message-ID: <1298389236-14953-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1298389236-14953-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6923305334238606831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 7a46d2a..ece38ab 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -51,6 +51,7 @@ struct indicator {
 	int value;
 	int min;
 	int max;
+	char separator;
 };
 =

 =

@@ -173,6 +174,58 @@ error:
        g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
 }
 =

+static void cind_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	GSList *l =3D em->indicators;
+	struct indicator *ind =3D l->data;
+	GString *gstr;
+	char *buf;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		gstr =3D g_string_new("+CIND: ");
+		g_string_append_printf(gstr, "%d", ind->value);
+
+		l =3D l->next;
+		while (l) {
+			ind =3D l->data;
+			g_string_append_printf(gstr, ",%d", ind->value);
+			l =3D l->next;
+		}
+		buf =3D g_string_free(gstr, FALSE);
+
+		g_at_server_send_info(em->server, buf, FALSE);
+		g_free(buf);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		gstr =3D g_string_new("+CIND: ");
+		g_string_append_printf(gstr, "(\"%s\",(%d%c%d))",
+			ind->name, ind->min, ind->separator, ind->max);
+
+		l =3D l->next;
+		while (l) {
+			ind =3D l->data;
+			g_string_append_printf(gstr, ",(\"%s\",(%d%c%d))",
+				ind->name, ind->min, ind->separator, ind->max);
+			l =3D l->next;
+		}
+		buf =3D g_string_free(gstr, FALSE);
+
+		g_at_server_send_info(server, buf, FALSE);
+		g_free(buf);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	default:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
 static void emulator_add_indicator(struct ofono_emulator *em, const char* =
name,
 					int min, int max, int dflt)
 {
@@ -188,6 +241,7 @@ static void emulator_add_indicator(struct ofono_emulato=
r *em, const char* name,
 	ind->min =3D min;
 	ind->max =3D max;
 	ind->value =3D dflt;
+	ind->separator =3D ((max - min) =3D=3D 1) ? ',' : '-';
 =

 	em->indicators =3D g_slist_append(em->indicators, ind);
 }
@@ -237,6 +291,8 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 		emulator_add_indicator(em, OFONO_EMULATOR_IND_SIGNAL, 0, 5, 0);
 		emulator_add_indicator(em, OFONO_EMULATOR_IND_ROAMING, 0, 1, 0);
 		emulator_add_indicator(em, OFONO_EMULATOR_IND_BATTERY, 0, 5, 5);
+
+		g_at_server_register(em->server, "+CIND", cind_cb, em, NULL);
 	}
 =

 	__ofono_atom_register(em->atom, emulator_unregister);
-- =

1.7.1


--===============6923305334238606831==--

