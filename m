Content-Type: multipart/mixed; boundary="===============2454747170447995873=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-fdn PATCH 2/4] atmodem/sim: implement enable_fdn
Date: Thu, 26 Aug 2010 15:52:39 +0300
Message-ID: <1282827161-8351-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1282827161-8351-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2454747170447995873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/atmodem/sim.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 2f68b5f..1a6b1f4 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -856,6 +856,35 @@ error:
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

+static void at_enable_fdn(struct ofono_sim *sim,
+				int enable, const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[64];
+	int ret;
+
+	if (!cbd)
+		goto error;
+
+	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",%i,\"%s\"",
+			"FD", enable ? 1 : 0, passwd);
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
 static gboolean at_sim_register(gpointer user)
 {
 	struct ofono_sim *sim =3D user;
@@ -923,6 +952,7 @@ static struct ofono_sim_driver driver =3D {
 	.lock			=3D at_pin_enable,
 	.change_passwd		=3D at_change_passwd,
 	.query_locked		=3D at_pin_query_enabled,
+	.enable_fdn             =3D at_enable_fdn,
 };
 =

 void at_sim_init()
-- =

1.7.0.4


--===============2454747170447995873==--

