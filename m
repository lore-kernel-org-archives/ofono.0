Content-Type: multipart/mixed; boundary="===============0517441842961911409=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] ublox: network-registration: Check ureg for tech also for L2
 modems
Date: Tue, 24 Sep 2019 18:11:12 +0200
Message-ID: <20190924161112.32561-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0517441842961911409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

It seems like the CREG reporting from the L2 modems are quite
buggy. An example for a L210 where CREG reports UTRAN while
COPS and UREG reports LTE. A manual poll also indicates LTE.

I also found that the technology mapping was incorrect,
probably confused with enum packet_bearer.

A commented log showing where CREG is not trustable:

UREG indicates LTE
21:59:29 : < \r\n+UREG: 7\r\n
21:59:29 : < \r\n+CIEV: 9,2\r\n
21:59:29 : < \r\n+CGEV: NW MODIFY 1,0,0\r\n
21:59:31 : < \r\n+CIEV: 2,2\r\n
21:59:39 : < \r\n+CIEV: 2,3\r\n
21:59:44 : < \r\n+CIEV: 2,2\r\n
22:01:38 : < \r\n+CIEV: 2,3\r\n
22:01:43 : < \r\n+CIEV: 2,2\r\n

A CREG indicating UTRAN with HSDPA and HSUPA
22:29:39 : < \r\n+CREG: 5,"0000","00000000",6\r\n
22:29:39 : > AT\r
22:29:39 : < \r\nOK\r\n
22:29:39 : > AT+COPS=3D3,2\r
22:29:39 : < \r\n+CIEV: 9,2\r\n
22:29:39 : < \r\nOK\r\n
22:29:39 : > AT+COPS?\r

An immediate cops indicating LTE
22:29:39 : < \r\n+COPS: 0,2,"24007",7\r\n
22:29:39 : < \r\nOK\r\n
22:29:39 : > AT+CSQ\r
22:29:39 : < \r\n+CIEV: 2,4\r\n
22:29:39 : < \r\n+CSQ: 26,4\r\n
22:29:39 : < \r\nOK\r\n
22:29:39 : > AT+CGATT=3D1\r
22:29:39 : < \r\nOK\r\n
22:29:39 : > AT+COPS=3D3,0\r
22:29:39 : < \r\nOK\r\n
22:29:39 : > AT+COPS?\r

Another cops also indicates LTE
22:29:39 : < \r\n+COPS: 0,0,"Tele2",7\r\n <- 7: LTE
22:29:39 : < \r\nOK\r\n
22:29:39 : > AT+CGREG?\r

CGREG indicates unknown -> normal on LTE
22:29:39 : < \r\n+CGREG: 2,4\r\n
22:29:39 : < \r\nOK\r\n
22:29:44 : < \r\n+CIEV: 9,2\r\n
22:29:46 : < \r\n+CIEV: 2,2\r\n
22:56:23 : < \r\n+CIEV: 2,3\r\n
22:56:28 : < \r\n+CIEV: 2,2\r\n
22:59:40 : < \r\n+CIEV: 2,4\r\n

Manual poll shows we are running LTE
at+creg?
+CREG: 2,5,"2AFC","01DB0206",7

OK
---
 drivers/ubloxmodem/network-registration.c | 34 +++++++++++++++++++----
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/ubloxmodem/network-registration.c b/drivers/ubloxmodem=
/network-registration.c
index 64ef8076..69af4644 100644
--- a/drivers/ubloxmodem/network-registration.c
+++ b/drivers/ubloxmodem/network-registration.c
@@ -58,6 +58,7 @@ struct tech_query {
 	int status;
 	int lac;
 	int ci;
+	int tech;
 	struct ofono_netreg *netreg;
 };
 =

@@ -235,20 +236,40 @@ static void ublox_query_tech_cb(gboolean ok, GAtResul=
t *result,
 		return;
 =

 	switch (state) {
+	case 0:
+		/* Not registered for PS, then we have to trust CREG... */
+		tech =3D tq->tech;
+		break;
+	case 1:
+		tech =3D ACCESS_TECHNOLOGY_GSM;
+		break;
+	case 2:
+		tech =3D ACCESS_TECHNOLOGY_GSM_EGPRS;
+		break;
+	case 3:
+		tech =3D ACCESS_TECHNOLOGY_UTRAN;
+		break;
 	case 4:
-		tech =3D 5;
+		tech =3D ACCESS_TECHNOLOGY_UTRAN_HSDPA;
 		break;
 	case 5:
-		tech =3D 4;
+		tech =3D ACCESS_TECHNOLOGY_UTRAN_HSUPA;
+		break;
+	case 6:
+		tech =3D ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA;
+		break;
+	case 7:
+		tech =3D ACCESS_TECHNOLOGY_EUTRAN;
 		break;
 	case 8:
-		tech =3D 1;
+		tech =3D ACCESS_TECHNOLOGY_GSM;
 		break;
 	case 9:
-		tech =3D 2;
+		tech =3D ACCESS_TECHNOLOGY_GSM_EGPRS;
 		break;
 	default:
-		tech =3D state;
+		/* Not registered for PS or something unknown, trust CREG... */
+		tech =3D tq->tech;
 	}
 =

 error:
@@ -270,12 +291,13 @@ static void creg_notify(GAtResult *result, gpointer u=
ser_data)
 	if (status !=3D 1 && status !=3D 5)
 		goto notify;
 =

-	if (ublox_is_toby_l4(nd->model)) {
+	if (ublox_is_toby_l4(nd->model) || ublox_is_toby_l2(nd->model)) {
 		tq =3D g_new0(struct tech_query, 1);
 =

 		tq->status =3D status;
 		tq->lac =3D lac;
 		tq->ci =3D ci;
+		tq->tech =3D tech;
 		tq->netreg =3D netreg;
 =

 		if (g_at_chat_send(nd->at_data.chat, "AT+UREG?", ureg_prefix,
-- =

2.20.1


--===============0517441842961911409==--

