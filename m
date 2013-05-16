Content-Type: multipart/mixed; boundary="===============2063438686659964351=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [RFC 15/22] emulator: Add AT+BCC support
Date: Thu, 16 May 2013 14:16:35 -0300
Message-ID: <1368724602-27781-16-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1368724602-27781-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2063438686659964351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This commit verifies the conditions where the AT+BCC command will fail.

The codec connection setup is missing.
---
 src/emulator.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/emulator.c b/src/emulator.c
index 24c5e48..f358a0e 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -871,6 +871,30 @@ fail:
 	}
 }
 =

+static void bcc_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+
+	switch(type) {
+	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
+		if (!em->slc)
+			goto fail;
+
+		if (!(em->l_features & HFP_AG_FEATURE_CODEC_NEGOTIATION) &&
+			!(em->r_features & HFP_HF_FEATURE_CODEC_NEGOTIATION))
+			goto fail;
+
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
 					int min, int max, int dflt,
 					gboolean mandatory)
@@ -979,6 +1003,7 @@ void ofono_emulator_register(struct ofono_emulator *em=
, int fd)
 		g_at_server_register(em->server, "+CCWA", ccwa_cb, em, NULL);
 		g_at_server_register(em->server, "+CMEE", cmee_cb, em, NULL);
 		g_at_server_register(em->server, "+BIA", bia_cb, em, NULL);
+		g_at_server_register(em->server, "+BCC", bcc_cb, em, NULL);
 	}
 =

 	__ofono_atom_register(em->atom, emulator_unregister);
-- =

1.7.9.5


--===============2063438686659964351==--

