Content-Type: multipart/mixed; boundary="===============7789134455503730406=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH] dun: Add ATX command in emulator (X0 only)
Date: Thu, 24 Mar 2011 16:29:51 +0100
Message-ID: <1300980591-9395-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7789134455503730406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 56 insertions(+), 1 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index c84f0a9..101d6b8 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -177,6 +177,59 @@ error:
 	g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
 }
 =

+static gboolean get_result_value(GAtServer *server, GAtResult *result,
+						int min, int max, int *value)
+{
+	GAtResultIter iter;
+	int val;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, ""))
+		return FALSE;
+
+	if (!g_at_result_iter_next_number(&iter, &val))
+		return FALSE;
+
+	if (val < min || val > max)
+		return FALSE;
+
+	if (value !=3D NULL)
+		*value =3D val;
+
+	return TRUE;
+}
+
+static void at_x_cb(GAtServer *server, GAtServerRequestType type,
+				GAtResult *result, gpointer user_data)
+{
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		if (!get_result_value(server, result, 0, 0, NULL)) {
+			g_at_server_send_final(server,
+						G_AT_SERVER_RESULT_ERROR);
+			return;
+		}
+		/* the value is not stored, as there's only one choice */
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		g_at_server_send_info(server, "000", TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		g_at_server_send_info(server, "X: (0-0)", TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	default:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
 static void brsf_cb(GAtServer *server, GAtServerRequestType type,
 			GAtResult *result, gpointer user_data)
 {
@@ -466,8 +519,10 @@ void ofono_emulator_register(struct ofono_emulator *em=
, int fd)
 =

 	__ofono_atom_register(em->atom, emulator_unregister);
 =

-	if (em->type =3D=3D OFONO_EMULATOR_TYPE_DUN)
+	if (em->type =3D=3D OFONO_EMULATOR_TYPE_DUN) {
 		g_at_server_register(em->server, "D", dial_cb, em, NULL);
+		g_at_server_register(em->server, "X", at_x_cb, em, NULL);
+	}
 	else if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP)
 		g_at_server_set_echo(em->server, FALSE);
 }
-- =

1.7.1


--===============7789134455503730406==--

