Content-Type: multipart/mixed; boundary="===============1496005371987717057=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] ublox: network-registration: Handle UREG unsolicited during
 poll
Date: Sun, 09 Feb 2020 22:59:28 +0100
Message-ID: <20200209215928.25656-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1496005371987717057==
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
 drivers/ubloxmodem/network-registration.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/ubloxmodem/network-registration.c b/drivers/ubloxmodem=
/network-registration.c
index 6a524f47..2c6358e3 100644
--- a/drivers/ubloxmodem/network-registration.c
+++ b/drivers/ubloxmodem/network-registration.c
@@ -288,15 +288,21 @@ static void ublox_ureg_cb(gboolean ok, GAtResult *res=
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
+		goto parsed_state;
+	}
+
+	/* In case we get here, the response was not parsed */
+	goto error;
 =

+parsed_state:
 	tech =3D ublox_ureg_state_to_tech(state);
 	if (tech < 0)
 		/* No valid UREG status, we have to trust CREG... */
-- =

2.20.1

--===============1496005371987717057==--

