Content-Type: multipart/mixed; boundary="===============3246969481237176255=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: [PATCH v2 1/2] gemalto: add PIN retries support in driver
Date: Mon, 06 Nov 2017 14:57:08 +0100
Message-ID: <1509976629-9430-1-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3246969481237176255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In SimManager, the Retries property isn't used for gemalto modems.
The at command AT^SPIC is used to get the remaining retries left
for the current required password type.

This commit adds the implementation in the SIM driver of the retries
queries.
---
 drivers/atmodem/sim.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 7508281..f593a51 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -74,6 +74,7 @@ static const char *upincnt_prefix[] =3D { "+UPINCNT:", NU=
LL };
 static const char *cuad_prefix[] =3D { "+CUAD:", NULL };
 static const char *ccho_prefix[] =3D { "+CCHO:", NULL };
 static const char *crla_prefix[] =3D { "+CRLA:", NULL };
+static const char *spic_prefix[] =3D { "^SPIC:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 static void append_file_path(char *buf, const unsigned char *path,
@@ -1065,6 +1066,45 @@ error:
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 }
 =

+static void spic_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_sim *sim =3D cbd->user;
+	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
+	const char *final =3D g_at_result_final_response(result);
+	GAtResultIter iter;
+	struct ofono_error error;
+	int retries[OFONO_SIM_PASSWORD_INVALID];
+	size_t i;
+	int pin_type =3D ofono_sim_get_password_type(sim);
+
+	decode_at_error(&error, final);
+
+	if (!ok) {
+		cb(&error, NULL, cbd->data);
+		return;
+	}
+
+	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
+		retries[i] =3D -1;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^SPIC:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &retries[pin_type]))
+		goto error;
+
+	DBG("Retry : %d, type : %d", retries[pin_type], pin_type);
+	cb(&error, retries, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+}
+
 static void at_pin_retries_query(struct ofono_sim *sim,
 					ofono_sim_pin_retries_cb_t cb,
 					void *data)
@@ -1137,6 +1177,11 @@ static void at_pin_retries_query(struct ofono_sim *s=
im,
 					upincnt_cb, cbd, g_free) > 0)
 			return;
 		break;
+	case OFONO_VENDOR_CINTERION:
+		if (g_at_chat_send(sd->chat, "AT^SPIC", spic_prefix,
+					spic_cb, cbd, g_free) > 0)
+			return;
+		break;
 	default:
 		if (g_at_chat_send(sd->chat, "AT+CPINR", cpinr_prefixes,
 					at_cpinr_cb, cbd, g_free) > 0)
-- =

2.7.4


--===============3246969481237176255==--

