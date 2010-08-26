Content-Type: multipart/mixed; boundary="===============8230373436320211835=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-reset-pin PATCH 2/4] atmodem/sim: reset PIN or PIN2
Date: Thu, 26 Aug 2010 15:49:15 +0300
Message-ID: <1282826957-8238-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1282826957-8238-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8230373436320211835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

The PIN or PIN2 reset requires that modem waits for corresponding PUK code.
If PIN is unlocked, modem does not wait for PUK code. Modem does not wait
for PUK2 by default. The modem is triggered into a state waiting for PUK
codes with AT+CPWD command.

Password reset may fail if some other command is executed between AT+CPWD,
AT+CPIN? and AT+CPIN.
---
 drivers/atmodem/sim.c |  130 ++++++++++++++++++++++++++++++++++++++-------=
----
 1 files changed, 102 insertions(+), 28 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 21bc933..2f68b5f 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -44,6 +44,7 @@
 struct sim_data {
 	GAtChat *chat;
 	unsigned int vendor;
+	enum ofono_sim_password_type cpin_type;
 	guint epev_id;
 	guint epev_source;
 };
@@ -459,6 +460,8 @@ static void at_cpin_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	int len =3D sizeof(at_sim_name) / sizeof(*at_sim_name);
 	const char *final =3D g_at_result_final_response(result);
 =

+	sd->cpin_type =3D OFONO_SIM_PASSWORD_NONE;
+
 	if (sd->vendor =3D=3D OFONO_VENDOR_WAVECOM && ok && strlen(final) > 7)
 		decode_at_error(&error, "OK");
 	else
@@ -498,6 +501,8 @@ static void at_cpin_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 =

 	DBG("crsm_pin_cb: %s", pin_required);
 =

+	sd->cpin_type =3D pin_type;
+
 	cb(&error, pin_type, cbd->data);
 }
 =

@@ -616,34 +621,6 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static void at_pin_send_puk(struct ofono_sim *sim, const char *puk,
-				const char *passwd,
-				ofono_sim_lock_unlock_cb_t cb, void *data)
-{
-	struct sim_data *sd =3D ofono_sim_get_data(sim);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
-	char buf[64];
-	int ret;
-
-	if (!cbd)
-		goto error;
-
-	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\",\"%s\"", puk, passwd);
-
-	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
-				at_lock_unlock_cb, cbd, g_free);
-
-	memset(buf, 0, sizeof(buf));
-
-	if (ret > 0)
-		return;
-
-error:
-	g_free(cbd);
-
-	CALLBACK_WITH_FAILURE(cb, data);
-}
-
 static const char *const at_clck_cpwd_fac[] =3D {
 	[OFONO_SIM_PASSWORD_SIM_PIN] =3D "SC",
 	[OFONO_SIM_PASSWORD_SIM_PIN2] =3D "P2",
@@ -724,6 +701,103 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

+struct at_pin_reset_data {
+	struct cb_data base;
+	enum ofono_sim_password_type type;
+	char puk[9];
+	char pin[9];
+};
+
+static void at_pin_query_result(const struct ofono_error *error,
+				enum ofono_sim_password_type pin_type,
+				void *data)
+{
+	struct at_pin_reset_data *cbd =3D data;
+	struct sim_data *sd =3D ofono_sim_get_data(cbd->base.user);
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->base.cb;
+	void *user_data =3D cbd->base.data;
+	char buf[64];
+	int ret;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		goto failed;
+
+	switch (pin_type) {
+	case OFONO_SIM_PASSWORD_SIM_PUK:
+		if (cbd->type !=3D OFONO_SIM_PASSWORD_SIM_PIN)
+			goto failed;
+		break;
+	case OFONO_SIM_PASSWORD_SIM_PUK2:
+		if (cbd->type !=3D OFONO_SIM_PASSWORD_SIM_PIN2)
+			goto failed;
+		break;
+	default:
+		goto failed;
+	}
+
+	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\",\"%s\"", cbd->puk, cbd->pin);
+
+	memset(cbd->pin, 0, sizeof(cbd->pin));
+	memset(cbd->puk, 0, sizeof(cbd->puk));
+
+	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
+				at_lock_unlock_cb, cbd, g_free);
+
+	memset(buf, 0, sizeof(buf));
+
+	if (ret > 0)
+		return;
+
+failed:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, user_data);
+}
+
+static void at_pin_send_puk(struct ofono_sim *sim,
+				enum ofono_sim_password_type type,
+				const char *puk, const char *pin,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct at_pin_reset_data *cbd =3D g_new0(struct at_pin_reset_data, 1);
+	char buf[64];
+
+	if (!cbd)
+		goto error;
+
+	cbd->base.cb =3D cb;
+	cbd->base.data =3D data;
+	cbd->base.user =3D sim;
+	cbd->type =3D type;
+	strcpy(cbd->puk, puk);
+	strcpy(cbd->pin, pin);
+
+	if (type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN && sd->cpin_type =3D=3D type) {
+		/* +CPIN: SIM PUK is not transient, we can take shortcut */
+		struct ofono_error error =3D { OFONO_ERROR_TYPE_NO_ERROR };
+
+		at_pin_query_result(&error, type, cbd);
+
+		return;
+	}
+
+	/* We need to trigger AT+CPIN? to return SIM PUK or SIM PUK2 */
+
+	snprintf(buf, sizeof(buf), "AT+CPWD=3D\"%s\",\"%s\",\"%s\"",
+			at_clck_cpwd_fac[type], pin, pin);
+
+	g_at_chat_send(sd->chat, buf, none_prefix, NULL, NULL, NULL);
+
+	memset(buf, 0, sizeof(buf));
+
+	at_pin_query(sim, at_pin_query_result, cbd);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
 static void at_lock_status_cb(gboolean ok, GAtResult *result,
 		gpointer user_data)
 {
-- =

1.7.0.4


--===============8230373436320211835==--

