Content-Type: multipart/mixed; boundary="===============2113376226051218364=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH] qmimodem: report failure in case of invalid pin type
Date: Tue, 29 Aug 2017 14:29:01 +0200
Message-ID: <1504009741-3040-2-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <1504009741-3040-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2113376226051218364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will avoid a crash seen in sim_pin_query_cb (src/sim.c) if pin type
is OFONO_SIM_PASSWORD_INVALID.
---
 drivers/qmimodem/sim-legacy.c | 5 ++++-
 drivers/qmimodem/sim.c        | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/sim-legacy.c b/drivers/qmimodem/sim-legacy.c
index 318b1ae..d16b2eb 100644
--- a/drivers/qmimodem/sim-legacy.c
+++ b/drivers/qmimodem/sim-legacy.c
@@ -211,7 +211,10 @@ static void get_pin_status_cb(struct qmi_result *resul=
t, void *user_data)
 	data->retries[OFONO_SIM_PASSWORD_SIM_PUK2] =3D pin->unblock_retries;
 =

 done:
-	CALLBACK_WITH_SUCCESS(cb, pin_type, cbd->data);
+	if (pin_type =3D=3D OFONO_SIM_PASSWORD_INVALID)
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+	else
+		CALLBACK_WITH_SUCCESS(cb, pin_type, cbd->data);
 }
 =

 static void qmi_query_passwd_state(struct ofono_sim *sim,
diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 8d40028..7425d5e 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -483,7 +483,11 @@ static void query_passwd_state_cb(struct qmi_result *r=
esult,
 	case GET_CARD_STATUS_RESULT_OK:
 		DBG("passwd state %d", sim_stat.passwd_state);
 		data->retry_count =3D 0;
-		CALLBACK_WITH_SUCCESS(cb, sim_stat.passwd_state, cbd->data);
+		if (sim_stat.passwd_state =3D=3D OFONO_SIM_PASSWORD_INVALID)
+			CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		else
+			CALLBACK_WITH_SUCCESS(cb, sim_stat.passwd_state,
+								cbd->data);
 		break;
 	case GET_CARD_STATUS_RESULT_TEMP_ERROR:
 		data->retry_count++;
-- =

2.7.4


--===============2113376226051218364==--

