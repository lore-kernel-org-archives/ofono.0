Content-Type: multipart/mixed; boundary="===============6712323607281598696=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 2/2] qmi: report SIM not inserted when unable to get PIN type
Date: Fri, 13 Apr 2018 15:58:36 +0200
Message-ID: <1523627916-6684-2-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <1523627916-6684-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6712323607281598696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/sim.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 6633c13..9aa943b 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -612,9 +612,10 @@ static void query_passwd_state_cb(struct qmi_result *r=
esult,
 	case GET_CARD_STATUS_RESULT_OK:
 		DBG("passwd state %d", sim_stat.passwd_state);
 		data->retry_count =3D 0;
-		if (sim_stat.passwd_state =3D=3D OFONO_SIM_PASSWORD_INVALID)
+		if (sim_stat.passwd_state =3D=3D OFONO_SIM_PASSWORD_INVALID) {
 			CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-		else
+			ofono_sim_inserted_notify(sim, FALSE);
+		} else
 			CALLBACK_WITH_SUCCESS(cb, sim_stat.passwd_state,
 								cbd->data);
 		break;
@@ -626,6 +627,7 @@ static void query_passwd_state_cb(struct qmi_result *re=
sult,
 							sim_stat.card_state);
 			data->retry_count =3D 0;
 			CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+			ofono_sim_inserted_notify(sim, FALSE);
 		} else {
 			DBG("Retry command");
 			retry_cbd =3D cb_data_new(cb, cbd->data);
@@ -639,6 +641,7 @@ static void query_passwd_state_cb(struct qmi_result *re=
sult,
 		DBG("Command failed");
 		data->retry_count =3D 0;
 		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		ofono_sim_inserted_notify(sim, FALSE);
 		break;
 	}
 }
-- =

2.7.4


--===============6712323607281598696==--

