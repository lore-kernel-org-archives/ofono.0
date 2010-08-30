Content-Type: multipart/mixed; boundary="===============1557899407278228018=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-reset-pin-v2 2/3] atmodem/sim: add pin type to PIN reset method
Date: Mon, 30 Aug 2010 20:53:43 +0300
Message-ID: <1283190824-9876-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1283190824-9876-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1557899407278228018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

The PIN reset requires that modem waits for corresponding PUK code.
---
 drivers/atmodem/sim.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 21bc933..a80891c 100644
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

@@ -616,8 +621,9 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static void at_pin_send_puk(struct ofono_sim *sim, const char *puk,
-				const char *passwd,
+static void at_pin_send_puk(struct ofono_sim *sim,
+				enum ofono_sim_password_type type,
+				const char *puk, const char *passwd,
 				ofono_sim_lock_unlock_cb_t cb, void *data)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
@@ -628,6 +634,10 @@ static void at_pin_send_puk(struct ofono_sim *sim, con=
st char *puk,
 	if (!cbd)
 		goto error;
 =

+	if (type !=3D OFONO_SIM_PASSWORD_SIM_PIN ||
+			sd->cpin_type !=3D OFONO_SIM_PASSWORD_SIM_PUK)
+		goto error;
+
 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\",\"%s\"", puk, passwd);
 =

 	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
-- =

1.7.0.4


--===============1557899407278228018==--

