Content-Type: multipart/mixed; boundary="===============0385649569191274282=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-reset-pin-v2 3/3] atmodem/sim: add mbm quirk for PIN/PIN2 reset
Date: Mon, 30 Aug 2010 20:53:44 +0300
Message-ID: <1283190824-9876-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1283190824-9876-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0385649569191274282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Trigger prompt for the correct PUK on mbm.
---
 drivers/atmodem/sim.c |  169 +++++++++++++++++++++++++++++++++++++++------=
----
 1 files changed, 136 insertions(+), 33 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index a80891c..1ef4342 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -621,39 +621,6 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static void at_pin_send_puk(struct ofono_sim *sim,
-				enum ofono_sim_password_type type,
-				const char *puk, const char *passwd,
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
-	if (type !=3D OFONO_SIM_PASSWORD_SIM_PIN ||
-			sd->cpin_type !=3D OFONO_SIM_PASSWORD_SIM_PUK)
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
@@ -699,6 +666,142 @@ error:
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
+static void at_trigger_puk(struct ofono_sim *sim,
+				enum ofono_sim_password_type type,
+				const char *puk, const char *pin,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct at_pin_reset_data *cbd;
+	char buf[64];
+
+	if (type !=3D OFONO_SIM_PASSWORD_SIM_PIN &&
+			type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN2)
+		goto error;
+
+	cbd =3D g_new0(struct at_pin_reset_data, 1);
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
+static void at_pin_send_puk(struct ofono_sim *sim,
+				enum ofono_sim_password_type type,
+				const char *puk, const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D NULL;
+	char buf[64];
+	int ret;
+
+	if (type !=3D OFONO_SIM_PASSWORD_SIM_PIN ||
+			sd->cpin_type !=3D OFONO_SIM_PASSWORD_SIM_PUK) {
+		switch (sd->vendor) {
+		case OFONO_VENDOR_MBM:
+			at_trigger_puk(sim, type, puk, passwd, cb, data);
+			return;
+		default:
+			break;
+		}
+
+		goto error;
+	}
+
+	cbd =3D cb_data_new(cb, data);
+	if (!cbd)
+		goto error;
+
+	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\",\"%s\"", puk, passwd);
+
+	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
+				at_lock_unlock_cb, cbd, g_free);
+
+	memset(buf, 0, sizeof(buf));
+
+	if (ret > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
 static void at_change_passwd(struct ofono_sim *sim,
 			enum ofono_sim_password_type passwd_type,
 			const char *old, const char *new,
-- =

1.7.0.4


--===============0385649569191274282==--

