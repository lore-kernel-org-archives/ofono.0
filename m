Content-Type: multipart/mixed; boundary="===============4208473940397451525=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH] qmimodem: fix roaming status report
Date: Mon, 18 Dec 2017 10:33:40 +0100
Message-ID: <1513589620-9157-1-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <dfb296c5-1f15-b7d9-790b-9150b0864c0c@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4208473940397451525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Problem seen with a MC7304 modem and a roaming SIM card.
Status in org.ofono.NetworkRegistration properties ends up in "registered"
instead of roaming. Both AT command and qmicli indicates we are roaming.

What's happening is the following:

1) first QMI_NAS_SS_INFO_IND indicating we are registered contains a
QMI_NAS_RESULT_ROAMING_STATUS parameter.
Parameter inside says we are roaming and qmimidem driver correctly reports
status NETWORK_REGISTRATION_STATUS_ROAMING.
2) other QMI_NAS_SS_INFO_IND arrive, saying we are registered without
QMI_NAS_RESULT_ROAMING_STATUS parameter.
Driver reports NETWORK_REGISTRATION_STATUS_REGISTERED.

Extract of traces with QMI binary debug interpreted (as far as I can...):
a) first "searching" indication
ofonod[855]: QMI: < 01 3b 00 80 03 01 04 00 00 24 00 2f 00
29 05 00 d0 00 14 00 00 MCC:208 MNC:20
22 05 00 01 02 00 01 00 Detailed Service Status:
                        QMI_NAS_SERVICE_STATUS_LIMITED,
                        QMI_NAS_NETWORK_SERVICE_DOMAIN_PS, ...
15 03 00 01 08 01 LTE, no roaming
12 05 00 d0 00 14 00 00 Current PLMN: MCC:208 MNC:20, no desc
11 01 00 00
10 01 00 01 No roaming
01 06 00 02 02 02 02 01 08 NAS_REGISTRATION_STATE_NOT_REGISTERED_SEARCHING,
                           CS detached, PS detached, NETWORK_TYPE_3GPP,
                           QMI_NAS_RADIO_INTERFACE_LTE
ofonod[855]: QMI: NAS_ind msg=3D36 len=3D47 [client=3D1,type=3D4,tid=3D0,le=
n=3D59]
ofonod[855]: QMI: {type=3D41,len=3D5} {type=3D34,len=3D5} {type=3D21,len=3D=
3}
             {type=3D18,len=3D5}
ofonod[855]: QMI: {type=3D17,len=3D1} {type=3D16,len=3D1} {type=3D1,len=3D6}
ofonod[855]: ofono_netreg_status_notify modem /sierra_0 status 2 lac -1
             cellid -1 tech 7

b) second "searching" indication
ofonod[855]: QMI: < 01 21 00 80 03 01 04 00 00 24 00 15 00
22 05 00 03 03 00 01 00 Detailed Service Status:
                        QMI_NAS_SERVICE_STATUS_LIMITED_REGIONAL, CS_PS, ...
11 01 00 00
01 06 00 02 02 02 02 01 08 NAS_REGISTRATION_STATE_NOT_REGISTERED_SEARCHING,
                           CS detached, PS detached, NETWORK_TYPE_3GPP,
                           QMI_NAS_RADIO_INTERFACE_LTE

ofonod[855]: QMI: NAS_ind msg=3D36 len=3D21 [client=3D1,type=3D4,tid=3D0,le=
n=3D33]
ofonod[855]: QMI: {type=3D34,len=3D5} {type=3D17,len=3D1} {type=3D1,len=3D6}

c) First indication while "registered"
ofonod[855]: QMI: < 01 5e 00 80 03 01 04 00 00 24 00 52 00
2a 01 00 00
29 05 00 d0 00 14 00 00 MCC:208 MNC:20
28 02 00 15 01 UMTS Primary Scrambling Code
26 08 00 03 00 00 00 03 00 00 00 CS: all calls allowed,
                                 PS: all calls allowed
22 05 00 02 03 00 01 00 Detailed Service Status:
                        QMI_NAS_SERVICE_STATUS_AVAILABLE, CS_PS, ...
1e 04 00 f7 00 95 04 CID 3GPP
1d 02 00 fb 50 LAC 3GPP
15 03 00 01 05 00 UMTS: roaming
12 05 00 d0 00 14 00 00 Current PLMN: MCC:208 MNC:20, no desc
11 04 00 03 03 04 05
10 01 00 00 ROAMING ON
01 06 00 01 01 01 02 01 05 NAS_REGISTRATION_STATE_REGISTERED, CS attached,
                           PS attached, NETWORK_TYPE_3GPP,
                           QMI_NAS_RADIO_INTERFACE_UMTS
ofonod[855]: QMI: NAS_ind msg=3D36 len=3D82 [client=3D1,type=3D4,tid=3D0,le=
n=3D94]
ofonod[855]: QMI: {type=3D42,len=3D1} {type=3D41,len=3D5} {type=3D40,len=3D=
2}
             {type=3D38,len=3D8}
ofonod[855]: QMI: {type=3D34,len=3D5} {type=3D30,len=3D4} {type=3D29,len=3D=
2}
             {type=3D21,len=3D3}
ofonod[855]: QMI: {type=3D18,len=3D5} {type=3D17,len=3D4} {type=3D16,len=3D=
1}
             {type=3D1,len=3D6}
ofonod[855]: ofono_gprs_status_notify modem /sierra_0 status 1

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> ROAMING status repo=
rted <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
ofonod[855]: ofono_netreg_status_notify modem /sierra_0 status 5 lac 20731
             cellid 76873975 tech 2

d) second indication while "registered"
ofonod[855]: QMI: < 01 31 00 80 03 01 04 00 00 24 00 25 00
29 05 00 d0 00 14 00 00 MCC:208 MNC:20
28 02 00 15 01 UMTS Primary Scrambling Code
12 05 00 d0 00 14 00 00 Current PLMN: MCC:208 MNC:20, no desc
11 04 00 03 03 04 05
01 06 00 01 01 01 02 01 05 NAS_REGISTRATION_STATE_REGISTERED, CS attached,
                           PS attached, NETWORK_TYPE_3GPP,
                           QMI_NAS_RADIO_INTERFACE_UMTS
ofonod[855]: QMI: NAS_ind msg=3D36 len=3D37 [client=3D1,type=3D4,tid=3D0,le=
n=3D49]
ofonod[855]: QMI: {type=3D41,len=3D5} {type=3D40,len=3D2} {type=3D18,len=3D=
5}
                  {type=3D17,len=3D4}
ofonod[855]: QMI: {type=3D1,len=3D6}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> ROAMING information=
 lost <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
ofonod[855]: ofono_netreg_status_notify modem /sierra_0 status 1 lac -1
             cellid -1 tech 2

I can't tell if not having the ROAMING_STATUS parameter in all indication
is something happening only on MC7304 or if it happens on all "QMI" modems.
---
 drivers/qmimodem/network-registration.c | 50 ++++++++++++++++++++++++++++-=
----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/net=
work-registration.c
index 6c1f50b..85de4e1 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -42,6 +42,13 @@ struct netreg_data {
 	struct qmi_service *nas;
 	struct ofono_network_operator operator;
 	uint8_t current_rat;
+	bool is_roaming;
+};
+
+enum roaming_status {
+	ROAMING_STATUS_OFF,
+	ROAMING_STATUS_ON,
+	ROAMING_STATUS_NO_CHANGE,
 };
 =

 static bool extract_ss_info_time(
@@ -78,11 +85,12 @@ static bool extract_ss_info_time(
 =

 static bool extract_ss_info(struct qmi_result *result, int *status,
 				int *lac, int *cellid, int *tech,
+				enum roaming_status *roaming,
 				struct ofono_network_operator *operator)
 {
 	const struct qmi_nas_serving_system *ss;
 	const struct qmi_nas_current_plmn *plmn;
-	uint8_t i, roaming;
+	uint8_t i, is_not_roaming;
 	uint16_t value16, len, opname_len;
 	uint32_t value32;
 =

@@ -105,10 +113,13 @@ static bool extract_ss_info(struct qmi_result *result=
, int *status,
 	}
 =

 	if (qmi_result_get_uint8(result, QMI_NAS_RESULT_ROAMING_STATUS,
-								&roaming)) {
-		if (ss->status =3D=3D 1 && roaming =3D=3D 0)
-			*status =3D NETWORK_REGISTRATION_STATUS_ROAMING;
-	}
+							&is_not_roaming)) {
+		if (is_not_roaming =3D=3D 0)
+			*roaming =3D ROAMING_STATUS_ON;
+		else
+			*roaming =3D ROAMING_STATUS_OFF;
+	} else
+		*roaming =3D ROAMING_STATUS_NO_CHANGE;
 =

 	if (!operator)
 		return true;
@@ -160,16 +171,28 @@ static void ss_info_notify(struct qmi_result *result,=
 void *user_data)
 	struct ofono_network_time net_time;
 	struct netreg_data *data =3D ofono_netreg_get_data(netreg);
 	int status, lac, cellid, tech;
+	enum roaming_status roaming;
 =

 	DBG("");
 =

 	if (extract_ss_info_time(result, &net_time))
 		ofono_netreg_time_notify(netreg, &net_time);
 =

-	if (!extract_ss_info(result, &status, &lac, &cellid, &tech,
+	if (!extract_ss_info(result, &status, &lac, &cellid, &tech, &roaming,
 							&data->operator))
 		return;
 =

+	if (status =3D=3D QMI_NAS_REGISTRATION_STATE_REGISTERED) {
+		if (roaming =3D=3D ROAMING_STATUS_ON ||
+				(roaming =3D=3D ROAMING_STATUS_NO_CHANGE &&
+					data->is_roaming)) {
+			status =3D NETWORK_REGISTRATION_STATUS_ROAMING;
+			data->is_roaming =3D true;
+		} else
+			data->is_roaming =3D false;
+	} else
+		data->is_roaming =3D false;
+
 	ofono_netreg_status_notify(netreg, status, lac, cellid, tech);
 }
 =

@@ -179,6 +202,7 @@ static void get_ss_info_cb(struct qmi_result *result, v=
oid *user_data)
 	ofono_netreg_status_cb_t cb =3D cbd->cb;
 	struct netreg_data *data =3D cbd->user;
 	int status, lac, cellid, tech;
+	enum roaming_status roaming;
 =

 	DBG("");
 =

@@ -187,12 +211,23 @@ static void get_ss_info_cb(struct qmi_result *result,=
 void *user_data)
 		return;
 	}
 =

-	if (!extract_ss_info(result, &status, &lac, &cellid, &tech,
+	if (!extract_ss_info(result, &status, &lac, &cellid, &tech, &roaming,
 							&data->operator)) {
 		CALLBACK_WITH_FAILURE(cb, -1, -1, -1, -1, cbd->data);
 		return;
 	}
 =

+	if (status =3D=3D QMI_NAS_REGISTRATION_STATE_REGISTERED) {
+		if (roaming =3D=3D ROAMING_STATUS_ON ||
+				(roaming =3D=3D ROAMING_STATUS_NO_CHANGE &&
+					data->is_roaming)) {
+			status =3D NETWORK_REGISTRATION_STATUS_ROAMING;
+			data->is_roaming =3D true;
+		} else
+			data->is_roaming =3D false;
+	} else
+		data->is_roaming =3D false;
+
 	CALLBACK_WITH_SUCCESS(cb, status, lac, cellid, tech, cbd->data);
 }
 =

@@ -580,6 +615,7 @@ static int qmi_netreg_probe(struct ofono_netreg *netreg,
 	data->operator.tech =3D -1;
 =

 	data->current_rat =3D QMI_NAS_NETWORK_RAT_NO_CHANGE;
+	data->is_roaming =3D false;
 =

 	ofono_netreg_set_data(netreg, data);
 =

-- =

2.7.4


--===============4208473940397451525==--

