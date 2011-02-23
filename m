Content-Type: multipart/mixed; boundary="===============5493405328674673746=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 2/2] emulator: add CIND support
Date: Wed, 23 Feb 2011 18:02:14 +0100
Message-ID: <1298480534-12917-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1298480534-12917-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5493405328674673746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 53844a7..e6f503d 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -172,6 +172,85 @@ error:
        g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
 }
 =

+static void cind_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	GSList *l;
+	struct indicator *ind;
+	gsize size;
+	int len;
+	char *buf;
+	char *tmp;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		/*
+		 * "+CIND: " + terminating null + number of indicators *
+		 * (max of 3 digits in the value + separator)
+		 */
+		size =3D 7 + 1 + (g_slist_length(em->indicators) * 4);
+		buf =3D g_try_malloc0(size);
+		if (buf =3D=3D NULL)
+			goto fail;
+
+		len =3D sprintf(buf, "+CIND: ");
+		tmp =3D buf + len;
+
+		for (l =3D em->indicators; l; l =3D l->next) {
+			ind =3D l->data;
+			len =3D sprintf(tmp, "%s%d",
+					l =3D=3D em->indicators ? "" : ",",
+					ind->value);
+			tmp =3D tmp + len;
+		}
+
+		g_at_server_send_info(em->server, buf, TRUE);
+		g_free(buf);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		/*
+		 * '+CIND: ' + terminating null + number of indicators *
+		 * ( indicator name + '("",(000,000))' + separator)
+		 */
+		size =3D 8;
+
+		for (l =3D em->indicators; l; l =3D l->next) {
+			ind =3D l->data;
+			size +=3D strlen(ind->name) + 15;
+		}
+
+		buf =3D g_try_malloc0(size);
+		if (buf =3D=3D NULL)
+			goto fail;
+
+		len =3D sprintf(buf, "+CIND: ");
+		tmp =3D buf + len;
+
+		for (l =3D em->indicators; l; l =3D l->next) {
+			ind =3D l->data;
+			len =3D sprintf(tmp, "%s(\"%s\",(%d%c%d))",
+					l =3D=3D em->indicators ? "" : ",",
+					ind->name, ind->min,
+					(ind->max - ind->min) =3D=3D 1 ? ',' : '-',
+					ind->max);
+			tmp =3D tmp + len;
+		}
+
+		g_at_server_send_info(server, buf, TRUE);
+		g_free(buf);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	default:
+fail:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
 static void emulator_add_indicator(struct ofono_emulator *em, const char* =
name,
 					int min, int max, int dflt)
 {
@@ -243,6 +322,8 @@ void ofono_emulator_register(struct ofono_emulator *em,=
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


--===============5493405328674673746==--

