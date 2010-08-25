Content-Type: multipart/mixed; boundary="===============7120482521365265595=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/2] atmodem: call sim_ready_notify when epev is received
Date: Wed, 25 Aug 2010 04:23:12 -0700
Message-ID: <1282735392-5283-3-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1282735392-5283-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7120482521365265595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 21bc933..44ecc1a 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -537,13 +537,16 @@ static gboolean at_epev_unregister(gpointer user_data)
 static void at_epev_notify(GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
-	struct sim_data *sd =3D cbd->user;
+	struct ofono_sim *sim =3D cbd->user;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
 	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_NO_ERROR };
 =

 	if (sd->epev_source)
 		return;
 =

+	ofono_sim_ready_notify(sim);
+
 	cb(&error, cbd->data);
 =

 	sd->epev_source =3D g_timeout_add(0, at_epev_unregister, sd);
@@ -553,7 +556,8 @@ static void at_pin_send_cb(gboolean ok, GAtResult *resu=
lt,
 				gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
-	struct sim_data *sd =3D cbd->user;
+	struct ofono_sim *sim =3D cbd->user;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
 =

@@ -590,15 +594,15 @@ static void at_lock_unlock_cb(gboolean ok, GAtResult =
*result,
 static void at_pin_send(struct ofono_sim *sim, const char *passwd,
 			ofono_sim_lock_unlock_cb_t cb, void *data)
 {
-	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	char buf[64];
 	int ret;
 =

 	if (!cbd)
 		goto error;
 =

-	cbd->user =3D sd;
+	cbd->user =3D sim;
 =

 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\"", passwd);
 =

-- =

1.7.2.1


--===============7120482521365265595==--

