Content-Type: multipart/mixed; boundary="===============5815323046102847444=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: [PATCH 6/6] gemalto: fix sim reinsertion issue
Date: Mon, 12 Mar 2018 13:57:13 +0100
Message-ID: <1520859433-14112-7-git-send-email-gabriel.lucas@smile.fr>
In-Reply-To: <1520859433-14112-1-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5815323046102847444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the SIM card is reinserted in the holder,
the IRC +CIEV: simstatus,1 is emitted. The problem
is that the SIM isn't ready when it is received.
Hence, Ofono fails on CPIN? command and the modem
cannot be used. This patch make ofono retry the
CPIN? command until it succeeds.
---
 plugins/gemalto.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index c7fb783..caa5912 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -497,6 +497,33 @@ static void gemalto_set_online(struct ofono_modem *mod=
em, ofono_bool_t online,
 	g_free(cbd);
 }
 =

+static void sim_pin_query_cb(const struct ofono_error *error,
+				enum ofono_sim_password_type pin_type,
+				void *data);
+
+static void gemalto_wait_after_plug(struct ofono_sim *sim) {
+	ofono_sim_get_driver(sim)->query_passwd_state(sim, sim_pin_query_cb, sim);
+}
+
+static gboolean cpin_timeout(gpointer sim) {
+	gemalto_wait_after_plug(sim);
+
+	return FALSE;
+}
+
+static void sim_pin_query_cb(const struct ofono_error *error,
+				enum ofono_sim_password_type pin_type,
+				void *data) {
+	struct ofono_sim *sim =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		g_timeout_add(50, cpin_timeout, sim);
+	}
+	else {
+		ofono_sim_inserted_notify(sim, TRUE);
+	}
+}
+
 static void gemalto_ciev_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_sim *sim =3D user_data;
@@ -523,7 +550,7 @@ static void gemalto_ciev_notify(GAtResult *result, gpoi=
nter user_data)
 	if (status =3D=3D 0) {
 		ofono_sim_inserted_notify(sim, FALSE);
 	} else if(status =3D=3D 1) {
-		ofono_sim_inserted_notify(sim, TRUE);
+		gemalto_wait_after_plug(sim);
 	}
 }
 =

-- =

1.9.1


--===============5815323046102847444==--

