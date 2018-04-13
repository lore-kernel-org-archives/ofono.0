Content-Type: multipart/mixed; boundary="===============2134431797529890500=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/2] qmi: report failure or retry in case of invalid pin type
Date: Fri, 13 Apr 2018 15:58:35 +0200
Message-ID: <1523627916-6684-1-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <b661d335-c59e-73a4-f6d5-640f8f9c2a5e@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2134431797529890500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

QMI_UIM_GET_CARD_STATUS is retried in more error cases
when trying to get password type.
In case of failure, driver report an error instead of
OFONO_SIM_PASSWORD_INVALID. This avoids a crash.
---
 drivers/qmimodem/sim.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 1d9befc..6633c13 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -493,8 +493,15 @@ static bool get_card_status(const struct qmi_uim_slot_=
info *slot,
 	case 0x03:	/* PUK1 or PUK for UPIN is required */
 		sim_stat->passwd_state =3D OFONO_SIM_PASSWORD_SIM_PUK;
 		break;
+	case 0x00:	/* Unknown */
+	case 0x01:	/* Detected */
 	case 0x04:	/* Personalization state must be checked. */
-		/* This is temporary, we could retry and get another result */
+	case 0x05:	/* PIN1 blocked */
+	case 0x06:	/* Illegal */
+		/*
+		 * This could be temporary, we should retry and
+		 * expect another result
+		 */
 		sim_stat->passwd_state =3D OFONO_SIM_PASSWORD_INVALID;
 		need_retry =3D true;
 		break;
@@ -605,12 +612,18 @@ static void query_passwd_state_cb(struct qmi_result *=
result,
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
 		if (data->retry_count > MAX_RETRY_COUNT) {
-			DBG("Failed after %d attempts", data->retry_count);
+			DBG("Failed after %d attempts. Card state:%d",
+							data->retry_count,
+							sim_stat.card_state);
 			data->retry_count =3D 0;
 			CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 		} else {
-- =

2.7.4


--===============2134431797529890500==--

