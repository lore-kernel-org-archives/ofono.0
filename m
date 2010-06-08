Content-Type: multipart/mixed; boundary="===============2990229583794711476=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v2] Readout technology form Option HSO modems
Date: Tue, 08 Jun 2010 10:28:49 +0200
Message-ID: <20100608082849.GA7584@pc0043.bmw-carit.intra>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2990229583794711476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To find out which the current technology is on
we have to issue OCTI and OWCTI. OCTI returns
2G information and OWCTI returns 3G information.
OWCTI overrules OCTI.

The OSSYSI unsolicited command tells which
of information should be considered. Unfortunately,
AT_OSSYSI? only returns error.

OSSYSI 0 -> TECH_GPRS (use OCTI for details)
OSSYSI 2 -> TECH_UMTS (use OUWCTI for details)

OCTI 1 -> GSM
OCTI 2 -> GPRS
OCTI 3 -> EDGE

OUWCTI 1 -> UMTS
OUWCTI 2 -> HSDPA
OUWCTI 3 -> HSUPA
OUWCTI 4 -> HSPA
---

I have uploaded the log ouput here http://pastebin.com/xHkS9kfP

Walking around our building I can force the modem to switch from UMTS
to EDGE and back. Between the switching OCTI and OUWCTI both report
the value 0, which I read as no technology. option_octi_ouwcti_to_tech
returns then -1. Which is fine I guess, but there will be no
Technology property changed signal send out:

static void set_registration_technology(struct ofono_netreg *netreg, int te=
ch)
{
	 const char *tech_str =3D registration_tech_to_string(tech);
	 DBusConnection *conn =3D ofono_dbus_get_connection();
	 const char *path =3D __ofono_atom_get_path(netreg->atom);

	 netreg->technology =3D tech;

	 if (netreg->technology =3D=3D -1)
	    return;
[...]
}

I see that if netreg->technology is -1 then there won't be a Technolgy
property at all in get_properties. While this is okay for modems which
don't support this feature at all, I think this is the wrong behaviour
in this case when the modem switches from EDGE to nothing. What do you
thing about introducing an empty Technology (e.g. "")?

v2: back to original version. rely only on notifications
v1: fire OCTI, OWCTI in cregs callback. =

v0: initial version

 drivers/atmodem/network-registration.c |  115 ++++++++++++++++++++++++++++=
+---
 1 files changed, 105 insertions(+), 10 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index f5ccbb1..77c02c4 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -54,10 +54,86 @@ struct netreg_data {
 	int signal_index; /* If strength is reported via CIND */
 	int signal_min; /* min strength reported via CIND */
 	int signal_max; /* max strength reported via CIND */
+	int status;
+	int lac;
+	int ci;
 	int tech;
+	int ossysi; /* option hso 2G/3G info */
+	int octi; /* option hso 2G info details */
+	int ouwcti; /* otpion hso 3G info details */
 	unsigned int vendor;
 };
 =

+static int option_octi_to_tech(struct netreg_data *nd)
+{
+	int tech =3D -1;
+	switch (nd->octi) {
+	case 1:	/* GSM */
+		tech =3D 0;
+		break;
+	case 2: /* GPRS */
+		tech =3D 1;
+		break;
+	case 3:	/* EDGE */
+		tech =3D 3;
+	}
+
+	return tech;
+}
+
+static int option_ouwcti_to_tech(struct netreg_data *nd)
+{
+	int tech =3D -1;
+
+	switch (nd->ouwcti) {
+	case 1: /* UMTS */
+		tech =3D 2;
+		break;
+	case 2: /* HSDPA */
+		tech =3D 4;
+		break;
+	case 3: /* HSUPA */
+		tech =3D 5;
+		break;
+	case 4: /* HSPA */
+		tech =3D 6;
+	}
+
+	return tech;
+}
+
+static void option_octi_ouwcti_to_tech(struct netreg_data *nd)
+{
+	int tech =3D -1;
+	int tech_2g, tech_3g;
+
+	switch (nd->ossysi) {
+	case -1:
+		tech_2g =3D option_octi_to_tech(nd);
+		tech_3g =3D option_ouwcti_to_tech(nd);
+
+		/* 3G tech takes precedence over 2G tech */
+		if (tech_3g =3D=3D -1) =

+			tech =3D tech_2g;
+		else
+			tech =3D tech_3g;
+		break;
+	case 0: /* 2G */
+		tech =3D option_octi_to_tech(nd);
+		break;
+	case 2: /* 3G */
+		tech =3D option_ouwcti_to_tech(nd);
+		break;
+	case 3: /* Unknown */
+		break;
+	}
+
+	DBG("ossysi %d octi %d ouwcti %d tech %d",
+		nd->ossysi, nd->octi, nd->ouwcti, tech);
+
+	nd->tech =3D tech;
+}
+
 static void extract_mcc_mnc(const char *str, char *mcc, char *mnc)
 {
 	/* Three digit country code */
@@ -535,7 +611,8 @@ static void option_osigq_notify(GAtResult *result, gpoi=
nter user_data)
 =

 static void option_ouwcti_notify(GAtResult *result, gpointer user_data)
 {
-	int mode;
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	GAtResultIter iter;
 =

 	g_at_result_iter_init(&iter, result);
@@ -543,15 +620,19 @@ static void option_ouwcti_notify(GAtResult *result, g=
pointer user_data)
 	if (!g_at_result_iter_next(&iter, "_OUWCTI:"))
 		return;
 =

-	if (!g_at_result_iter_next_number(&iter, &mode))
+	if (!g_at_result_iter_next_number(&iter, &nd->ouwcti))
 		return;
 =

-	ofono_info("OWCTI mode: %d", mode);
+	option_octi_ouwcti_to_tech(nd);
+	if (nd->ouwcti > 0)
+		ofono_netreg_status_notify(netreg,
+				nd->status, nd->lac, nd->ci, nd->tech);
 }
 =

 static void option_octi_notify(GAtResult *result, gpointer user_data)
 {
-	int mode;
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	GAtResultIter iter;
 =

 	g_at_result_iter_init(&iter, result);
@@ -559,10 +640,14 @@ static void option_octi_notify(GAtResult *result, gpo=
inter user_data)
 	if (!g_at_result_iter_next(&iter, "_OCTI:"))
 		return;
 =

-	if (!g_at_result_iter_next_number(&iter, &mode))
+	if (!g_at_result_iter_next_number(&iter, &nd->octi))
 		return;
 =

-	ofono_info("OCTI mode: %d", mode);
+	option_octi_ouwcti_to_tech(nd);
+	if (nd->octi > 0)
+		ofono_netreg_status_notify(netreg,
+				nd->status, nd->lac, nd->ci, nd->tech);
+
 }
 =

 static void ciev_notify(GAtResult *result, gpointer user_data)
@@ -626,7 +711,8 @@ static void cind_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 =

 static void option_ossysi_notify(GAtResult *result, gpointer user_data)
 {
-	int mode;
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	GAtResultIter iter;
 =

 	g_at_result_iter_init(&iter, result);
@@ -634,10 +720,13 @@ static void option_ossysi_notify(GAtResult *result, g=
pointer user_data)
 	if (!g_at_result_iter_next(&iter, "_OSSYSI:"))
 		return;
 =

-	if (!g_at_result_iter_next_number(&iter, &mode))
+	if (!g_at_result_iter_next_number(&iter, &nd->ossysi))
 		return;
 =

-	ofono_info("OSSYSI mode: %d", mode);
+	option_octi_ouwcti_to_tech(nd);
+	if (nd->tech > 0)
+		ofono_netreg_status_notify(netreg,
+				nd->status, nd->lac, nd->ci, nd->tech);
 }
 =

 static void huawei_rssi_notify(GAtResult *result, gpointer user_data)
@@ -926,7 +1015,7 @@ static void at_creg_set_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 =

 		g_at_chat_send(nd->chat, "AT_OSSYS?", none_prefix,
 				NULL, NULL, NULL);
-		g_at_chat_send(nd->chat, "AT_OWCTI?", none_prefix,
+		g_at_chat_send(nd->chat, "AT_OUWCTI?", none_prefix,
 				NULL, NULL, NULL);
 		g_at_chat_send(nd->chat, "AT_OCTI?", none_prefix,
 				NULL, NULL, NULL);
@@ -1021,7 +1110,13 @@ static int at_netreg_probe(struct ofono_netreg *netr=
eg, unsigned int vendor,
 =

 	nd->chat =3D chat;
 	nd->vendor =3D vendor;
+	nd->status =3D -1;
+	nd->lac =3D -1;
+	nd->ci =3D -1;
 	nd->tech =3D -1;
+	nd->ossysi =3D -1;
+	nd->octi =3D -1;
+	nd->ouwcti =3D -1;
 	ofono_netreg_set_data(netreg, nd);
 =

 	g_at_chat_send(chat, "AT+CREG=3D?", creg_prefix,
-- =

1.6.6.1


--===============2990229583794711476==--

