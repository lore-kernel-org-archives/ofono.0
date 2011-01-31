Content-Type: multipart/mixed; boundary="===============3029505824833244778=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH] atmodem: implement standard PIN retries
Date: Mon, 31 Jan 2011 14:48:20 +0200
Message-ID: <1296478100-24306-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3029505824833244778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim.c |   48 +++++++++++++++++++++++++++++++++++++++++++++=
+++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 0938998..dfd40f8 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -57,6 +57,7 @@ static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
 static const char *clck_prefix[] =3D { "+CLCK:", NULL };
 static const char *huawei_cpin_prefix[] =3D { "^CPIN:", NULL };
 static const char *xpincnt_prefix[] =3D { "+XPINCNT:", NULL };
+static const char *cpinr_prefixes[] =3D { "+CPINR:", "+CPINRE:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -554,6 +555,50 @@ error:
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 }
 =

+static void at_cpinr_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
+	GAtResultIter iter;
+	struct ofono_error error;
+	int retries[OFONO_SIM_PASSWORD_INVALID];
+	size_t len =3D sizeof(at_sim_name) / sizeof(*at_sim_name);
+	size_t i;
+
+	decode_at_error(&error, g_at_result_final_response(result));
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
+	/* Ignore +CPINRE results... */
+	while (g_at_result_iter_next(&iter, "+CPINR:")) {
+		const char *name;
+		int val;
+
+		if (!g_at_result_iter_next_unquoted_string(&iter, &name))
+			continue;
+
+		if (!g_at_result_iter_next_number(&iter, &val))
+			continue;
+
+		for (i =3D 1; i < len; i++) {
+			if (!strcmp(name, at_sim_name[i].name)) {
+				retries[i] =3D val;
+				break;
+			}
+		}
+	}
+
+	cb(&error, retries, cbd->data);
+}
+
 static void at_pin_retries_query(struct ofono_sim *sim,
 					ofono_sim_pin_retries_cb_t cb,
 					void *data)
@@ -577,6 +622,9 @@ static void at_pin_retries_query(struct ofono_sim *sim,
 =

 		break;
 	default:
+		if (g_at_chat_send(sd->chat, "AT+CPINR", cpinr_prefixes,
+					at_cpinr_cb, cbd, g_free) > 0)
+			return;
 		break;
 	}
 =

-- =

1.7.1


--===============3029505824833244778==--

