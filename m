Content-Type: multipart/mixed; boundary="===============3345053440603803232=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] sim: removal of extra ril_pin_send in ril_pin_change_state
Date: Sat, 06 Aug 2016 09:55:30 +0530
Message-ID: <1470457530-10991-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3345053440603803232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/sim.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/rilmodem/sim.c b/drivers/rilmodem/sim.c
index e411215..0eec10a 100644
--- a/drivers/rilmodem/sim.c
+++ b/drivers/rilmodem/sim.c
@@ -1176,23 +1176,6 @@ static void ril_pin_send(struct ofono_sim *sim, cons=
t char *passwd,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static void enter_pin_done(const struct ofono_error *error, void *data)
-{
-	struct change_state_cbd *csd =3D data;
-	struct sim_data *sd =3D ofono_sim_get_data(csd->sim);
-
-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		ofono_error("%s: wrong password", __func__);
-		sd->unlock_pending =3D FALSE;
-		CALLBACK_WITH_FAILURE(csd->cb, csd->data);
-	} else {
-		ril_pin_change_state(csd->sim, csd->passwd_type, csd->enable,
-					csd->passwd, csd->cb, csd->data);
-	}
-
-	g_free(csd);
-}
-
 static const char *const clck_cpwd_fac[] =3D {
 	[OFONO_SIM_PASSWORD_SIM_PIN] =3D "SC",
 	[OFONO_SIM_PASSWORD_SIM_PIN2] =3D "P2",
@@ -1215,28 +1198,6 @@ static void ril_pin_change_state(struct ofono_sim *s=
im,
 	struct cb_data *cbd;
 	struct parcel rilp;
 =

-	/*
-	 * If we want to unlock a password that has not been entered yet,
-	 * we enter it before trying to unlock. We need sd->unlock_pending as
-	 * the password still has not yet been refreshed when this function is
-	 * called from enter_pin_done().
-	 */
-	if (ofono_sim_get_password_type(sim) =3D=3D passwd_type
-			&& enable =3D=3D FALSE && sd->unlock_pending =3D=3D FALSE) {
-		struct change_state_cbd *csd =3D g_malloc0(sizeof(*csd));
-		csd->sim =3D sim;
-		csd->passwd_type =3D passwd_type;
-		csd->enable =3D enable;
-		csd->passwd =3D passwd;
-		csd->cb =3D cb;
-		csd->data =3D data;
-		sd->unlock_pending =3D TRUE;
-
-		ril_pin_send(sim, passwd, enter_pin_done, csd);
-
-		return;
-	}
-
 	sd->unlock_pending =3D FALSE;
 =

 	if (passwd_type >=3D ARRAY_SIZE(clck_cpwd_fac) ||
-- =

1.9.1


--===============3345053440603803232==--

