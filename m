Content-Type: multipart/mixed; boundary="===============1941923744404710295=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH v2] ublox: network-registration: Handle UREG unsolicited
 during poll
Date: Fri, 14 Feb 2020 10:06:01 +0100
Message-ID: <20200214090601.21727-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1941923744404710295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

In the case a unsolicited indication for UREG was received
while the status was polled. The poll response failed to parse.
This since the unsolicited indication only carries one
parameter, while the poll response is expected to carry two.

Update the code to loop until the response is found.

The log below shows a case where this happened.

10:07:55 ofonod[520]: Aux: > AT+UREG?\r
10:07:55 ofonod[520]: Aux: < \r\n+CGREG: 4\r\n\r\n+UREG: 0\r\n\r\n+CIEV: 9,=
1\r\n
10:07:55 ofonod[520]: src/gprs.c:ofono_gprs_status_notify() /ublox_0 status=
 unknown (4)
10:07:55 ofonod[520]: src/gprs.c:ofono_gprs_detached_notify() /ublox_0
10:07:55 ofonod[520]: Aux: < \r\n+UREG: 1,0\r\n
10:07:55 ofonod[520]: Aux: < \r\nOK\r\n
---
 drivers/ubloxmodem/network-registration.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/ubloxmodem/network-registration.c b/drivers/ubloxmodem=
/network-registration.c
index 6a524f47..662453b4 100644
--- a/drivers/ubloxmodem/network-registration.c
+++ b/drivers/ubloxmodem/network-registration.c
@@ -279,7 +279,7 @@ static void ublox_ureg_cb(gboolean ok, GAtResult *resul=
t,
 	struct netreg_data *nd =3D ofono_netreg_get_data(tq->netreg);
 	GAtResultIter iter;
 	gint enabled, state;
-	int tech =3D tq->tech;
+	int tech =3D -1;
 =

 	nd->updating_status =3D false;
 =

@@ -288,21 +288,22 @@ static void ublox_ureg_cb(gboolean ok, GAtResult *res=
ult,
 =

 	g_at_result_iter_init(&iter, result);
 =

-	if (!g_at_result_iter_next(&iter, "+UREG:"))
-		return;
+	while (g_at_result_iter_next(&iter, "+UREG:")) {
+		if (!g_at_result_iter_next_number(&iter, &enabled))
+			return;
 =

-	if (!g_at_result_iter_next_number(&iter, &enabled))
-		return;
+		/* Sometimes we get an unsolicited UREG here, skip it */
+		if (!g_at_result_iter_next_number(&iter, &state))
+			continue;
 =

-	if (!g_at_result_iter_next_number(&iter, &state))
-		return;
+		tech =3D ublox_ureg_state_to_tech(state);
+		break;
+	}
 =

-	tech =3D ublox_ureg_state_to_tech(state);
+error:
 	if (tech < 0)
 		/* No valid UREG status, we have to trust CREG... */
 		tech =3D tq->tech;
-
-error:
 	ofono_netreg_status_notify(tq->netreg,
 			tq->status, tq->lac, tq->ci, tech);
 }
-- =

2.20.1

--===============1941923744404710295==--

