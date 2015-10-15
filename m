Content-Type: multipart/mixed; boundary="===============2545881046318524858=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 03/10] rilmodem: Adapt to movement of parcel processing
Date: Thu, 15 Oct 2015 18:46:56 +0200
Message-ID: <1444927623-31141-4-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1444927623-31141-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2545881046318524858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/call-barring.c         |   4 +-
 drivers/rilmodem/call-forwarding.c      |   6 +-
 drivers/rilmodem/call-settings.c        |   4 +-
 drivers/rilmodem/call-volume.c          |   4 +-
 drivers/rilmodem/devinfo.c              |   2 +-
 drivers/rilmodem/gprs-context.c         |   6 +-
 drivers/rilmodem/gprs.c                 |   6 +-
 drivers/rilmodem/network-registration.c |   6 +-
 drivers/rilmodem/radio-settings.c       |   4 +-
 drivers/rilmodem/rilutil.c              | 623 ++++++++++++++++++++++++++++=
++++
 drivers/rilmodem/rilutil.h              |  14 +
 drivers/rilmodem/sim.c                  |   6 +-
 drivers/rilmodem/sms.c                  |   6 +-
 drivers/rilmodem/ussd.c                 |   4 +-
 drivers/rilmodem/voicecall.c            |   6 +-
 15 files changed, 669 insertions(+), 32 deletions(-)

diff --git a/drivers/rilmodem/call-barring.c b/drivers/rilmodem/call-barrin=
g.c
index 6a19556..c2bd9bc 100644
--- a/drivers/rilmodem/call-barring.c
+++ b/drivers/rilmodem/call-barring.c
@@ -28,8 +28,8 @@
 #include <ofono/modem.h>
 =

 #include "common.h"
-#include "grilrequest.h"
-#include "grilreply.h"
+#include "rilrequest.h"
+#include "rilreply.h"
 #include "call-barring.h"
 #include "rilmodem.h"
 #include "ril_constants.h"
diff --git a/drivers/rilmodem/call-forwarding.c b/drivers/rilmodem/call-for=
warding.c
index 7965e7d..6a66514 100644
--- a/drivers/rilmodem/call-forwarding.c
+++ b/drivers/rilmodem/call-forwarding.c
@@ -38,9 +38,9 @@
 #include <ofono/call-forwarding.h>
 =

 #include "gril.h"
-#include "grilrequest.h"
-#include "grilreply.h"
-#include "grilunsol.h"
+#include "rilrequest.h"
+#include "rilreply.h"
+#include "rilunsol.h"
 =

 #include "rilmodem.h"
 =

diff --git a/drivers/rilmodem/call-settings.c b/drivers/rilmodem/call-setti=
ngs.c
index 5603fbd..9f3f79b 100644
--- a/drivers/rilmodem/call-settings.c
+++ b/drivers/rilmodem/call-settings.c
@@ -40,8 +40,8 @@
 =

 #include "gril.h"
 #include "grilutil.h"
-#include "grilrequest.h"
-#include "grilreply.h"
+#include "rilrequest.h"
+#include "rilreply.h"
 =

 #include "rilmodem.h"
 #include "ril_constants.h"
diff --git a/drivers/rilmodem/call-volume.c b/drivers/rilmodem/call-volume.c
index 4e88772..06452d2 100644
--- a/drivers/rilmodem/call-volume.c
+++ b/drivers/rilmodem/call-volume.c
@@ -42,8 +42,8 @@
 =

 #include "rilmodem.h"
 #include "parcel.h"
-#include "grilrequest.h"
-#include "grilreply.h"
+#include "rilrequest.h"
+#include "rilreply.h"
 =

 struct cv_data {
 	GRil *ril;
diff --git a/drivers/rilmodem/devinfo.c b/drivers/rilmodem/devinfo.c
index 2811837..4d2bcf5 100644
--- a/drivers/rilmodem/devinfo.c
+++ b/drivers/rilmodem/devinfo.c
@@ -39,7 +39,7 @@
 #include "gril.h"
 =

 #include "rilmodem.h"
-#include "grilreply.h"
+#include "rilreply.h"
 =

 /*
  * TODO: The functions in this file are stubbed out, and
diff --git a/drivers/rilmodem/gprs-context.c b/drivers/rilmodem/gprs-contex=
t.c
index 2021533..ad2499c 100644
--- a/drivers/rilmodem/gprs-context.c
+++ b/drivers/rilmodem/gprs-context.c
@@ -40,9 +40,9 @@
 =

 #include "ofono.h"
 =

-#include "grilreply.h"
-#include "grilrequest.h"
-#include "grilunsol.h"
+#include "rilreply.h"
+#include "rilrequest.h"
+#include "rilunsol.h"
 =

 #include "gprs.h"
 #include "rilmodem.h"
diff --git a/drivers/rilmodem/gprs.c b/drivers/rilmodem/gprs.c
index 75dcfcc..76db3d1 100644
--- a/drivers/rilmodem/gprs.c
+++ b/drivers/rilmodem/gprs.c
@@ -44,9 +44,9 @@
 #include "common.h"
 #include "rilmodem.h"
 =

-#include "grilreply.h"
-#include "grilrequest.h"
-#include "grilunsol.h"
+#include "rilreply.h"
+#include "rilrequest.h"
+#include "rilunsol.h"
 #include "gprs.h"
 =

 /* Time between get data status retries */
diff --git a/drivers/rilmodem/network-registration.c b/drivers/rilmodem/net=
work-registration.c
index 6808a29..de93540 100644
--- a/drivers/rilmodem/network-registration.c
+++ b/drivers/rilmodem/network-registration.c
@@ -41,9 +41,9 @@
 #include "gril.h"
 #include "rilmodem.h"
 =

-#include "grilreply.h"
-#include "grilrequest.h"
-#include "grilunsol.h"
+#include "rilreply.h"
+#include "rilrequest.h"
+#include "rilunsol.h"
 =

 struct netreg_data {
 	GRil *ril;
diff --git a/drivers/rilmodem/radio-settings.c b/drivers/rilmodem/radio-set=
tings.c
index 9153e5b..4feeea8 100644
--- a/drivers/rilmodem/radio-settings.c
+++ b/drivers/rilmodem/radio-settings.c
@@ -41,8 +41,8 @@
 =

 #include "rilmodem.h"
 =

-#include "grilrequest.h"
-#include "grilreply.h"
+#include "rilrequest.h"
+#include "rilreply.h"
 #include "radio-settings.h"
 =

 static void ril_set_rat_cb(struct ril_msg *message, gpointer user_data)
diff --git a/drivers/rilmodem/rilutil.c b/drivers/rilmodem/rilutil.c
index c173940..7b00dc0 100644
--- a/drivers/rilmodem/rilutil.c
+++ b/drivers/rilmodem/rilutil.c
@@ -39,6 +39,13 @@
 #include "util.h"
 #include "ril_constants.h"
 =

+/* Constants used by CALL_LIST, and SETUP_DATA_CALL RIL requests */
+#define PROTO_IP_STR "IP"
+#define PROTO_IPV6_STR "IPV6"
+#define PROTO_IPV4V6_STR "IPV4V6"
+
+static char temp_str[32];
+
 struct ril_util_sim_state_query {
 	GRil *ril;
 	guint cpin_poll_source;
@@ -192,3 +199,619 @@ void ril_util_sim_state_query_free(struct ril_util_si=
m_state_query *req)
 =

 	g_free(req);
 }
+
+const char *ril_ofono_protocol_to_ril_string(guint protocol)
+{
+	char *result;
+
+	switch (protocol) {
+	case OFONO_GPRS_PROTO_IPV6:
+		result =3D PROTO_IPV6_STR;
+		break;
+	case OFONO_GPRS_PROTO_IPV4V6:
+		result =3D PROTO_IPV4V6_STR;
+		break;
+	case OFONO_GPRS_PROTO_IP:
+		result =3D PROTO_IP_STR;
+		break;
+	default:
+		result =3D NULL;
+	}
+
+	return result;
+}
+
+int ril_protocol_string_to_ofono_protocol(gchar *protocol_str)
+{
+	int result;
+
+	if (g_strcmp0(protocol_str, PROTO_IPV6_STR) =3D=3D 0)
+		result =3D OFONO_GPRS_PROTO_IPV6;
+	else if (g_strcmp0(protocol_str, PROTO_IPV4V6_STR) =3D=3D 0)
+		result =3D OFONO_GPRS_PROTO_IPV4V6;
+	else if (g_strcmp0(protocol_str, PROTO_IP_STR) =3D=3D 0)
+		result =3D OFONO_GPRS_PROTO_IP;
+	else
+		result =3D -1;
+
+	return result;
+}
+
+const char *ril_appstate_to_string(int app_state)
+{
+	switch (app_state) {
+	case RIL_APPSTATE_UNKNOWN:
+		return "UNKNOWN";
+	case RIL_APPSTATE_DETECTED:
+		return "DETECTED";
+	case RIL_APPSTATE_PIN:
+		return "PIN";
+	case RIL_APPSTATE_PUK:
+		return "PUK";
+	case RIL_APPSTATE_SUBSCRIPTION_PERSO:
+		return "";
+	case RIL_APPSTATE_READY:
+		return "READY";
+	default:
+		return "<INVALID>";
+	}
+}
+
+const char *ril_apptype_to_string(int app_type)
+{
+
+	switch (app_type) {
+	case RIL_APPTYPE_UNKNOWN:
+		return "UNKNOWN";
+	case RIL_APPTYPE_SIM:
+		return "SIM";
+	case RIL_APPTYPE_USIM:
+		return "USIM";
+	case RIL_APPTYPE_RUIM:
+		return "RUIM";
+	case RIL_APPTYPE_CSIM:
+		return "CSIM";
+	case RIL_APPTYPE_ISIM:
+		return "ISIM";
+	default:
+		return "<INVALID>";
+	}
+}
+
+const char *ril_authtype_to_string(int auth_type)
+{
+	switch (auth_type) {
+	case RIL_AUTH_NONE:
+		return "NONE";
+	case RIL_AUTH_PAP:
+		return "PAP";
+	case RIL_AUTH_CHAP:
+		return "CHAP";
+	case RIL_AUTH_BOTH:
+		return "BOTH";
+	case RIL_AUTH_ANY:
+		return "ANY";
+	default:
+		return "<INVALID>";
+	}
+}
+
+const char *ril_cardstate_to_string(int card_state)
+{
+	switch (card_state) {
+	case RIL_CARDSTATE_ABSENT:
+		return "ABSENT";
+	case RIL_CARDSTATE_PRESENT:
+		return "PRESENT";
+	case RIL_CARDSTATE_ERROR:
+		return "ERROR";
+	default:
+		return "<INVALID>";
+	}
+}
+
+const char *ril_error_to_string(int error)
+{
+	switch (error) {
+	case RIL_E_SUCCESS: return "SUCCESS";
+	case RIL_E_RADIO_NOT_AVAILABLE: return "RADIO_NOT_AVAILABLE";
+	case RIL_E_GENERIC_FAILURE: return "GENERIC_FAILURE";
+	case RIL_E_PASSWORD_INCORRECT: return "PASSWORD_INCORRECT";
+	case RIL_E_SIM_PIN2: return "SIM_PIN2";
+	case RIL_E_SIM_PUK2: return "SIM_PUK2";
+	case RIL_E_REQUEST_NOT_SUPPORTED: return "REQUEST_NOT_SUPPORTED";
+	case RIL_E_CANCELLED: return "CANCELLED";
+	case RIL_E_OP_NOT_ALLOWED_DURING_VOICE_CALL:
+		return "OP_NOT_ALLOWED_DURING_VOICE_CALL";
+	case RIL_E_OP_NOT_ALLOWED_BEFORE_REG_TO_NW:
+		return "OP_NOT_ALLOWED_BEFORE_REG_TO_NW";
+	case RIL_E_SMS_SEND_FAIL_RETRY: return "SMS_SEND_FAIL_RETRY";
+	case RIL_E_SIM_ABSENT: return "SIM_ABSENT";
+	case RIL_E_SUBSCRIPTION_NOT_AVAILABLE:
+		return "SUBSCRIPTION_NOT_AVAILABLE";
+	case RIL_E_MODE_NOT_SUPPORTED: return "MODE_NOT_SUPPORTED";
+	case RIL_E_FDN_CHECK_FAILURE: return "FDN_CHECK_FAILURE";
+	case RIL_E_ILLEGAL_SIM_OR_ME: return "ILLEGAL_SIM_OR_ME";
+	case RIL_E_DIAL_MODIFIED_TO_USSD: return "DIAL_MODIFIED_TO_USSD";
+	case RIL_E_DIAL_MODIFIED_TO_SS: return "DIAL_MODIFIED_TO_SS";
+	case RIL_E_DIAL_MODIFIED_TO_DIAL: return "DIAL_MODIFIED_TO_DIAL";
+	case RIL_E_USSD_MODIFIED_TO_DIAL: return "USSD_MODIFIED_TO_DIAL";
+	case RIL_E_USSD_MODIFIED_TO_SS: return "USSD_MODIFIED_TO_SS";
+	case RIL_E_USSD_MODIFIED_TO_USSD: return "USSD_MODIFIED_TO_USSD";
+	case RIL_E_SS_MODIFIED_TO_DIAL: return "SS_MODIFIED_TO_DIAL";
+	case RIL_E_SS_MODIFIED_TO_USSD: return "SS_MODIFIED_TO_USSD";
+	case RIL_E_SS_MODIFIED_TO_SS: return "SS_MODIFIED_TO_SS";
+	case RIL_E_SUBSCRIPTION_NOT_SUPPORTED:
+		return "SUBSCRIPTION_NOT_SUPPORTED";
+	default: return "<unknown errno>";
+	}
+}
+
+const char *ril_pinstate_to_string(int pin_state)
+{
+	switch (pin_state) {
+	case RIL_PINSTATE_UNKNOWN:
+		return "UNKNOWN";
+	case RIL_PINSTATE_ENABLED_NOT_VERIFIED:
+		return "ENABLED_NOT_VERIFIED";
+	case RIL_PINSTATE_ENABLED_VERIFIED:
+		return "ENABLED_VERIFIED";
+	case RIL_PINSTATE_DISABLED:
+		return "DISABLED";
+	case RIL_PINSTATE_ENABLED_BLOCKED:
+		return "ENABLED_BLOCKED";
+	case RIL_PINSTATE_ENABLED_PERM_BLOCKED:
+		return "ENABLED_PERM_BLOCKED";
+	default:
+		return "<INVALID>";
+	}
+}
+
+const char *ril_radio_state_to_string(int radio_state)
+{
+	switch (radio_state) {
+	case RADIO_STATE_OFF:
+		return "OFF";
+	case RADIO_STATE_UNAVAILABLE:
+		return "UNAVAILABLE";
+	case RADIO_STATE_SIM_NOT_READY:
+		return "SIM_NOT_READY";
+	case RADIO_STATE_SIM_LOCKED_OR_ABSENT:
+		return "SIM_LOCKED_OR_ABSENT";
+	case RADIO_STATE_SIM_READY:
+		return "SIM_READY";
+	case RADIO_STATE_ON:
+		return "ON";
+	default:
+		return "<INVALID>";
+	}
+}
+
+const char *ril_radio_tech_to_string(int radio_tech)
+{
+	switch (radio_tech) {
+	case RADIO_TECH_UNKNOWN:
+		return "UNKNOWN";
+	case RADIO_TECH_GPRS:
+		return "GPRS";
+	case RADIO_TECH_EDGE:
+		return	"EDGE";
+	case RADIO_TECH_UMTS:
+		return "UMTS";
+	case RADIO_TECH_IS95A:
+		return "IS95A";
+	case RADIO_TECH_IS95B:
+		return "IS95B";
+	case RADIO_TECH_1xRTT:
+		return "1xRTT";
+	case RADIO_TECH_EVDO_0:
+		return "EVDO_0";
+	case RADIO_TECH_EVDO_A:
+		return "EVDO_A";
+	case RADIO_TECH_HSDPA:
+		return "HSDPA";
+	case RADIO_TECH_HSUPA:
+		return "HSUPA";
+	case RADIO_TECH_HSPA:
+		return "HSPA";
+	case RADIO_TECH_EVDO_B:
+		return "EVDO_B";
+	case RADIO_TECH_EHRPD:
+		return "EHRPD";
+	case RADIO_TECH_LTE:
+		return "LTE";
+	case RADIO_TECH_HSPAP:
+		return "HSPAP";
+	case RADIO_TECH_GSM:
+		return "GSM";
+	case MTK_RADIO_TECH_HSDPAP:
+		return "MTK_HSDPAP";
+	case MTK_RADIO_TECH_HSDPAP_UPA:
+		return "MTK_HSDPAP_UPA";
+	case MTK_RADIO_TECH_HSUPAP:
+		return "MTK_HSUPAP";
+	case MTK_RADIO_TECH_HSUPAP_DPA:
+		return "MTK_HSUPAP_DPA";
+	case MTK_RADIO_TECH_DC_DPA:
+		return "MTK_DC_DPA";
+	case MTK_RADIO_TECH_DC_UPA:
+		return "MTK_DC_UPA";
+	case MTK_RADIO_TECH_DC_HSDPAP:
+		return "MTK_DC_HSDPAP";
+	case MTK_RADIO_TECH_DC_HSDPAP_UPA:
+		return "MTK_DC_HSDPAP_UPA";
+	case MTK_RADIO_TECH_DC_HSDPAP_DPA:
+		return "MTK_DC_HSDPAP_DPA";
+	case MTK_RADIO_TECH_DC_HSPAP:
+		return "MTK_DC_HSPAP";
+	default:
+		if (g_snprintf(temp_str, sizeof(temp_str),
+				"<INVALID (%d)>",
+				radio_tech))
+			return temp_str;
+		else
+			return "<INVALID>";
+	}
+}
+
+const char *ril_request_id_to_string(int req)
+{
+	switch (req) {
+	case RIL_REQUEST_GET_SIM_STATUS:
+		return "RIL_REQUEST_GET_SIM_STATUS";
+	case RIL_REQUEST_ENTER_SIM_PIN:
+		return "RIL_REQUEST_ENTER_SIM_PIN";
+	case RIL_REQUEST_ENTER_SIM_PUK:
+		return "RIL_REQUEST_ENTER_SIM_PUK";
+	case RIL_REQUEST_ENTER_SIM_PIN2:
+		return "RIL_REQUEST_ENTER_SIM_PIN2";
+	case RIL_REQUEST_ENTER_SIM_PUK2:
+		return "RIL_REQUEST_ENTER_SIM_PUK2";
+	case RIL_REQUEST_CHANGE_SIM_PIN:
+		return "RIL_REQUEST_CHANGE_SIM_PIN";
+	case RIL_REQUEST_CHANGE_SIM_PIN2:
+		return "RIL_REQUEST_CHANGE_SIM_PIN2";
+	case RIL_REQUEST_ENTER_NETWORK_DEPERSONALIZATION:
+		return "RIL_REQUEST_ENTER_NETWORK_DEPERSONALIZATION";
+	case RIL_REQUEST_GET_CURRENT_CALLS:
+		return "RIL_REQUEST_GET_CURRENT_CALLS";
+	case RIL_REQUEST_DIAL:
+		return "RIL_REQUEST_DIAL";
+	case RIL_REQUEST_GET_IMSI:
+		return "RIL_REQUEST_GET_IMSI";
+	case RIL_REQUEST_HANGUP:
+		return "RIL_REQUEST_HANGUP";
+	case RIL_REQUEST_HANGUP_WAITING_OR_BACKGROUND:
+		return "RIL_REQUEST_HANGUP_WAITING_OR_BACKGROUND";
+	case RIL_REQUEST_HANGUP_FOREGROUND_RESUME_BACKGROUND:
+		return "RIL_REQUEST_HANGUP_FOREGROUND_RESUME_BACKGROUND";
+	case RIL_REQUEST_SWITCH_HOLDING_AND_ACTIVE:
+		return "RIL_REQUEST_SWITCH_HOLDING_AND_ACTIVE";
+	case RIL_REQUEST_CONFERENCE:
+		return "RIL_REQUEST_CONFERENCE";
+	case RIL_REQUEST_UDUB:
+		return "RIL_REQUEST_UDUB";
+	case RIL_REQUEST_LAST_CALL_FAIL_CAUSE:
+		return "RIL_REQUEST_LAST_CALL_FAIL_CAUSE";
+	case RIL_REQUEST_SIGNAL_STRENGTH:
+		return "RIL_REQUEST_SIGNAL_STRENGTH";
+	case RIL_REQUEST_VOICE_REGISTRATION_STATE:
+		return "RIL_REQUEST_VOICE_REGISTRATION_STATE";
+	case RIL_REQUEST_DATA_REGISTRATION_STATE:
+		return "RIL_REQUEST_DATA_REGISTRATION_STATE";
+	case RIL_REQUEST_OPERATOR:
+		return "RIL_REQUEST_OPERATOR";
+	case RIL_REQUEST_RADIO_POWER:
+		return "RIL_REQUEST_RADIO_POWER";
+	case RIL_REQUEST_DTMF:
+		return "RIL_REQUEST_DTMF";
+	case RIL_REQUEST_SEND_SMS:
+		return "RIL_REQUEST_SEND_SMS";
+	case RIL_REQUEST_SEND_SMS_EXPECT_MORE:
+		return "RIL_REQUEST_SEND_SMS_EXPECT_MORE";
+	case RIL_REQUEST_SETUP_DATA_CALL:
+		return "RIL_REQUEST_SETUP_DATA_CALL";
+	case RIL_REQUEST_SIM_IO:
+		return "RIL_REQUEST_SIM_IO";
+	case RIL_REQUEST_SEND_USSD:
+		return "RIL_REQUEST_SEND_USSD";
+	case RIL_REQUEST_CANCEL_USSD:
+		return "RIL_REQUEST_CANCEL_USSD";
+	case RIL_REQUEST_GET_CLIR:
+		return "RIL_REQUEST_GET_CLIR";
+	case RIL_REQUEST_SET_CLIR:
+		return "RIL_REQUEST_SET_CLIR";
+	case RIL_REQUEST_QUERY_CALL_FORWARD_STATUS:
+		return "RIL_REQUEST_QUERY_CALL_FORWARD_STATUS";
+	case RIL_REQUEST_SET_CALL_FORWARD:
+		return "RIL_REQUEST_SET_CALL_FORWARD";
+	case RIL_REQUEST_QUERY_CALL_WAITING:
+		return "RIL_REQUEST_QUERY_CALL_WAITING";
+	case RIL_REQUEST_SET_CALL_WAITING:
+		return "RIL_REQUEST_SET_CALL_WAITING";
+	case RIL_REQUEST_SMS_ACKNOWLEDGE:
+		return "RIL_REQUEST_SMS_ACKNOWLEDGE ";
+	case RIL_REQUEST_GET_IMEI:
+		return "RIL_REQUEST_GET_IMEI";
+	case RIL_REQUEST_GET_IMEISV:
+		return "RIL_REQUEST_GET_IMEISV";
+	case RIL_REQUEST_ANSWER:
+		return "RIL_REQUEST_ANSWER";
+	case RIL_REQUEST_DEACTIVATE_DATA_CALL:
+		return "RIL_REQUEST_DEACTIVATE_DATA_CALL";
+	case RIL_REQUEST_QUERY_FACILITY_LOCK:
+		return "RIL_REQUEST_QUERY_FACILITY_LOCK";
+	case RIL_REQUEST_SET_FACILITY_LOCK:
+		return "RIL_REQUEST_SET_FACILITY_LOCK";
+	case RIL_REQUEST_CHANGE_BARRING_PASSWORD:
+		return "RIL_REQUEST_CHANGE_BARRING_PASSWORD";
+	case RIL_REQUEST_QUERY_NETWORK_SELECTION_MODE:
+		return "RIL_REQUEST_QUERY_NETWORK_SELECTION_MODE";
+	case RIL_REQUEST_SET_NETWORK_SELECTION_AUTOMATIC:
+		return "RIL_REQUEST_SET_NETWORK_SELECTION_AUTOMATIC";
+	case RIL_REQUEST_SET_NETWORK_SELECTION_MANUAL:
+		return "RIL_REQUEST_SET_NETWORK_SELECTION_MANUAL";
+	case RIL_REQUEST_QUERY_AVAILABLE_NETWORKS:
+		return "RIL_REQUEST_QUERY_AVAILABLE_NETWORKS";
+	case RIL_REQUEST_DTMF_START:
+		return "RIL_REQUEST_DTMF_START";
+	case RIL_REQUEST_DTMF_STOP:
+		return "RIL_REQUEST_DTMF_STOP";
+	case RIL_REQUEST_BASEBAND_VERSION:
+		return "RIL_REQUEST_BASEBAND_VERSION";
+	case RIL_REQUEST_SEPARATE_CONNECTION:
+		return "RIL_REQUEST_SEPARATE_CONNECTION";
+	case RIL_REQUEST_SET_MUTE:
+		return "RIL_REQUEST_SET_MUTE";
+	case RIL_REQUEST_GET_MUTE:
+		return "RIL_REQUEST_GET_MUTE";
+	case RIL_REQUEST_QUERY_CLIP:
+		return "RIL_REQUEST_QUERY_CLIP";
+	case RIL_REQUEST_LAST_DATA_CALL_FAIL_CAUSE:
+		return "RIL_REQUEST_LAST_DATA_CALL_FAIL_CAUSE";
+	case RIL_REQUEST_DATA_CALL_LIST:
+		return "RIL_REQUEST_DATA_CALL_LIST";
+	case RIL_REQUEST_RESET_RADIO:
+		return "RIL_REQUEST_RESET_RADIO";
+	case RIL_REQUEST_OEM_HOOK_RAW:
+		return "RIL_REQUEST_OEM_HOOK_RAW";
+	case RIL_REQUEST_OEM_HOOK_STRINGS:
+		return "RIL_REQUEST_OEM_HOOK_STRINGS";
+	case RIL_REQUEST_SCREEN_STATE:
+		return "RIL_REQUEST_SCREEN_STATE";
+	case RIL_REQUEST_SET_SUPP_SVC_NOTIFICATION:
+		return "RIL_REQUEST_SET_SUPP_SVC_NOTIFICATION";
+	case RIL_REQUEST_WRITE_SMS_TO_SIM:
+		return "RIL_REQUEST_WRITE_SMS_TO_SIM";
+	case RIL_REQUEST_DELETE_SMS_ON_SIM:
+		return "RIL_REQUEST_DELETE_SMS_ON_SIM";
+	case RIL_REQUEST_SET_BAND_MODE:
+		return "RIL_REQUEST_SET_BAND_MODE";
+	case RIL_REQUEST_QUERY_AVAILABLE_BAND_MODE:
+		return "RIL_REQUEST_QUERY_AVAILABLE_BAND_MODE";
+	case RIL_REQUEST_STK_GET_PROFILE:
+		return "RIL_REQUEST_STK_GET_PROFILE";
+	case RIL_REQUEST_STK_SET_PROFILE:
+		return "RIL_REQUEST_STK_SET_PROFILE";
+	case RIL_REQUEST_STK_SEND_ENVELOPE_COMMAND:
+		return "RIL_REQUEST_STK_SEND_ENVELOPE_COMMAND";
+	case RIL_REQUEST_STK_SEND_TERMINAL_RESPONSE:
+		return "RIL_REQUEST_STK_SEND_TERMINAL_RESPONSE";
+	case RIL_REQUEST_STK_HANDLE_CALL_SETUP_REQUESTED_FROM_SIM:
+		return "RIL_REQUEST_STK_HANDLE_CALL_SETUP_REQUESTED_FROM_SIM";
+	case RIL_REQUEST_EXPLICIT_CALL_TRANSFER:
+		return "RIL_REQUEST_EXPLICIT_CALL_TRANSFER";
+	case RIL_REQUEST_SET_PREFERRED_NETWORK_TYPE:
+		return "RIL_REQUEST_SET_PREFERRED_NETWORK_TYPE";
+	case RIL_REQUEST_GET_PREFERRED_NETWORK_TYPE:
+		return "RIL_REQUEST_GET_PREFERRED_NETWORK_TYPE";
+	case RIL_REQUEST_GET_NEIGHBORING_CELL_IDS:
+		return "RIL_REQUEST_GET_NEIGHBORING_CELL_IDS";
+	case RIL_REQUEST_SET_LOCATION_UPDATES:
+		return "RIL_REQUEST_SET_LOCATION_UPDATES";
+	case RIL_REQUEST_CDMA_SET_SUBSCRIPTION_SOURCE:
+		return "RIL_REQUEST_CDMA_SET_SUBSCRIPTION_SOURCE";
+	case RIL_REQUEST_CDMA_SET_ROAMING_PREFERENCE:
+		return "RIL_REQUEST_CDMA_SET_ROAMING_PREFERENCE";
+	case RIL_REQUEST_CDMA_QUERY_ROAMING_PREFERENCE:
+		return "RIL_REQUEST_CDMA_QUERY_ROAMING_PREFERENCE";
+	case RIL_REQUEST_SET_TTY_MODE:
+		return "RIL_REQUEST_SET_TTY_MODE";
+	case RIL_REQUEST_QUERY_TTY_MODE:
+		return "RIL_REQUEST_QUERY_TTY_MODE";
+	case RIL_REQUEST_CDMA_SET_PREFERRED_VOICE_PRIVACY_MODE:
+		return "RIL_REQUEST_CDMA_SET_PREFERRED_VOICE_PRIVACY_MODE";
+	case RIL_REQUEST_CDMA_QUERY_PREFERRED_VOICE_PRIVACY_MODE:
+		return "RIL_REQUEST_CDMA_QUERY_PREFERRED_VOICE_PRIVACY_MODE";
+	case RIL_REQUEST_CDMA_FLASH:
+		return "RIL_REQUEST_CDMA_FLASH";
+	case RIL_REQUEST_CDMA_BURST_DTMF:
+		return "RIL_REQUEST_CDMA_BURST_DTMF";
+	case RIL_REQUEST_CDMA_VALIDATE_AND_WRITE_AKEY:
+		return "RIL_REQUEST_CDMA_VALIDATE_AND_WRITE_AKEY";
+	case RIL_REQUEST_CDMA_SEND_SMS:
+		return "RIL_REQUEST_CDMA_SEND_SMS";
+	case RIL_REQUEST_CDMA_SMS_ACKNOWLEDGE:
+		return "RIL_REQUEST_CDMA_SMS_ACKNOWLEDGE";
+	case RIL_REQUEST_GSM_GET_BROADCAST_SMS_CONFIG:
+		return "RIL_REQUEST_GSM_GET_BROADCAST_SMS_CONFIG";
+	case RIL_REQUEST_GSM_SET_BROADCAST_SMS_CONFIG:
+		return "RIL_REQUEST_GSM_SET_BROADCAST_SMS_CONFIG";
+	case RIL_REQUEST_GSM_SMS_BROADCAST_ACTIVATION:
+		return "RIL_REQUEST_GSM_SMS_BROADCAST_ACTIVATION";
+	case RIL_REQUEST_CDMA_GET_BROADCAST_SMS_CONFIG:
+		return "RIL_REQUEST_CDMA_GET_BROADCAST_SMS_CONFIG";
+	case RIL_REQUEST_CDMA_SET_BROADCAST_SMS_CONFIG:
+		return "RIL_REQUEST_CDMA_SET_BROADCAST_SMS_CONFIG";
+	case RIL_REQUEST_CDMA_SMS_BROADCAST_ACTIVATION:
+		return "RIL_REQUEST_CDMA_SMS_BROADCAST_ACTIVATION";
+	case RIL_REQUEST_CDMA_SUBSCRIPTION:
+		return "RIL_REQUEST_CDMA_SUBSCRIPTION";
+	case RIL_REQUEST_CDMA_WRITE_SMS_TO_RUIM:
+		return "RIL_REQUEST_CDMA_WRITE_SMS_TO_RUIM";
+	case RIL_REQUEST_CDMA_DELETE_SMS_ON_RUIM:
+		return "RIL_REQUEST_CDMA_DELETE_SMS_ON_RUIM";
+	case RIL_REQUEST_DEVICE_IDENTITY:
+		return "RIL_REQUEST_DEVICE_IDENTITY";
+	case RIL_REQUEST_EXIT_EMERGENCY_CALLBACK_MODE:
+		return "RIL_REQUEST_EXIT_EMERGENCY_CALLBACK_MODE";
+	case RIL_REQUEST_GET_SMSC_ADDRESS:
+		return "RIL_REQUEST_GET_SMSC_ADDRESS";
+	case RIL_REQUEST_SET_SMSC_ADDRESS:
+		return "RIL_REQUEST_SET_SMSC_ADDRESS";
+	case RIL_REQUEST_REPORT_SMS_MEMORY_STATUS:
+		return "RIL_REQUEST_REPORT_SMS_MEMORY_STATUS";
+	case RIL_REQUEST_REPORT_STK_SERVICE_IS_RUNNING:
+		return "RIL_REQUEST_REPORT_STK_SERVICE_IS_RUNNING";
+	case RIL_REQUEST_CDMA_GET_SUBSCRIPTION_SOURCE:
+		return "RIL_REQUEST_CDMA_GET_SUBSCRIPTION_SOURCE";
+	case RIL_REQUEST_ISIM_AUTHENTICATION:
+		return "RIL_REQUEST_ISIM_AUTHENTICATION";
+	case RIL_REQUEST_ACKNOWLEDGE_INCOMING_GSM_SMS_WITH_PDU:
+		return "RIL_REQUEST_ACKNOWLEDGE_INCOMING_GSM_SMS_WITH_PDU";
+	case RIL_REQUEST_STK_SEND_ENVELOPE_WITH_STATUS:
+		return "RIL_REQUEST_STK_SEND_ENVELOPE_WITH_STATUS";
+	case RIL_REQUEST_SET_INITIAL_ATTACH_APN:
+		return "RIL_REQUEST_SET_INITIAL_ATTACH_APN";
+	default:
+		return "<INVALID>";
+	}
+}
+
+const char *ril_unsol_request_to_string(int request)
+{
+	switch (request) {
+	case RIL_UNSOL_RESPONSE_RADIO_STATE_CHANGED:
+		return "UNSOL_RESPONSE_RADIO_STATE_CHANGED";
+	case RIL_UNSOL_RESPONSE_CALL_STATE_CHANGED:
+		return "UNSOL_RESPONSE_CALL_STATE_CHANGED";
+	case RIL_UNSOL_RESPONSE_VOICE_NETWORK_STATE_CHANGED:
+		return "UNSOL_RESPONSE_VOICE_NETWORK_STATE_CHANGED";
+	case RIL_UNSOL_RESPONSE_NEW_SMS:
+		return "UNSOL_RESPONSE_NEW_SMS";
+	case RIL_UNSOL_RESPONSE_NEW_SMS_STATUS_REPORT:
+		return "UNSOL_RESPONSE_NEW_SMS_STATUS_REPORT";
+	case RIL_UNSOL_RESPONSE_NEW_SMS_ON_SIM:
+		return "UNSOL_RESPONSE_NEW_SMS_ON_SIM";
+	case RIL_UNSOL_ON_USSD:
+		return "UNSOL_ON_USSD";
+	case RIL_UNSOL_ON_USSD_REQUEST:
+		return "UNSOL_ON_USSD_REQUEST(obsolete)";
+	case RIL_UNSOL_NITZ_TIME_RECEIVED:
+		return "UNSOL_NITZ_TIME_RECEIVED";
+	case RIL_UNSOL_SIGNAL_STRENGTH:
+		return "UNSOL_SIGNAL_STRENGTH";
+	case RIL_UNSOL_SUPP_SVC_NOTIFICATION:
+		return "UNSOL_SUPP_SVC_NOTIFICATION";
+	case RIL_UNSOL_STK_SESSION_END:
+		return "UNSOL_STK_SESSION_END";
+	case RIL_UNSOL_STK_PROACTIVE_COMMAND:
+		return "UNSOL_STK_PROACTIVE_COMMAND";
+	case RIL_UNSOL_STK_EVENT_NOTIFY:
+		return "UNSOL_STK_EVENT_NOTIFY";
+	case RIL_UNSOL_STK_CALL_SETUP:
+		return "UNSOL_STK_CALL_SETUP";
+	case RIL_UNSOL_SIM_SMS_STORAGE_FULL:
+		return "UNSOL_SIM_SMS_STORAGE_FUL";
+	case RIL_UNSOL_SIM_REFRESH:
+		return "UNSOL_SIM_REFRESH";
+	case RIL_UNSOL_DATA_CALL_LIST_CHANGED:
+		return "UNSOL_DATA_CALL_LIST_CHANGED";
+	case RIL_UNSOL_CALL_RING:
+		return "UNSOL_CALL_RING";
+	case RIL_UNSOL_RESPONSE_SIM_STATUS_CHANGED:
+		return "UNSOL_RESPONSE_SIM_STATUS_CHANGED";
+	case RIL_UNSOL_RESPONSE_CDMA_NEW_SMS:
+		return "UNSOL_NEW_CDMA_SMS";
+	case RIL_UNSOL_RESPONSE_NEW_BROADCAST_SMS:
+		return "UNSOL_NEW_BROADCAST_SMS";
+	case RIL_UNSOL_CDMA_RUIM_SMS_STORAGE_FULL:
+		return "UNSOL_CDMA_RUIM_SMS_STORAGE_FULL";
+	case RIL_UNSOL_RESTRICTED_STATE_CHANGED:
+		return "UNSOL_RESTRICTED_STATE_CHANGED";
+	case RIL_UNSOL_ENTER_EMERGENCY_CALLBACK_MODE:
+		return "UNSOL_ENTER_EMERGENCY_CALLBACK_MODE";
+	case RIL_UNSOL_CDMA_CALL_WAITING:
+		return "UNSOL_CDMA_CALL_WAITING";
+	case RIL_UNSOL_CDMA_OTA_PROVISION_STATUS:
+		return "UNSOL_CDMA_OTA_PROVISION_STATUS";
+	case RIL_UNSOL_CDMA_INFO_REC:
+		return "UNSOL_CDMA_INFO_REC";
+	case RIL_UNSOL_OEM_HOOK_RAW:
+		return "UNSOL_OEM_HOOK_RAW";
+	case RIL_UNSOL_RINGBACK_TONE:
+		return "UNSOL_RINGBACK_TONE";
+	case RIL_UNSOL_RESEND_INCALL_MUTE:
+		return "UNSOL_RESEND_INCALL_MUTE";
+	case RIL_UNSOL_CDMA_SUBSCRIPTION_SOURCE_CHANGED:
+		return "UNSOL_CDMA_SUBSCRIPTION_SOURCE_CHANGED";
+	case RIL_UNSOL_CDMA_PRL_CHANGED:
+		return "UNSOL_CDMA_PRL_CHANGED";
+	case RIL_UNSOL_EXIT_EMERGENCY_CALLBACK_MODE:
+		return "UNSOL_EXIT_EMERGENCY_CALLBACK_MODE";
+	case RIL_UNSOL_RIL_CONNECTED:
+		return "UNSOL_RIL_CONNECTED";
+	default:
+		return "<unknown request>";
+	}
+}
+
+const char *ril_pdp_fail_to_string(int status)
+{
+	switch (status) {
+	case PDP_FAIL_NONE:
+		return "NONE";
+	case PDP_FAIL_OPERATOR_BARRED:
+		return "OPERATOR_BARRED";
+	case PDP_FAIL_INSUFFICIENT_RESOURCES:
+		return "INSUFFICIENT_RESOURCES";
+	case PDP_FAIL_MISSING_UKNOWN_APN:
+		return "MISSING_UKNOWN_APN";
+	case PDP_FAIL_UNKNOWN_PDP_ADDRESS_TYPE:
+		return "UNKNOWN_PDP_ADDRESS_TYPE";
+	case PDP_FAIL_USER_AUTHENTICATION:
+		return "USER_AUTHENTICATION";
+	case PDP_FAIL_ACTIVATION_REJECT_GGSN:
+		return "ACTIVATION_REJECT_GGSN";
+	case PDP_FAIL_ACTIVATION_REJECT_UNSPECIFIED:
+		return "ACTIVATION_REJECT_UNSPECIFIED";
+	case PDP_FAIL_SERVICE_OPTION_NOT_SUPPORTED:
+		return "SERVICE_OPTION_NOT_SUPPORTED";
+	case PDP_FAIL_SERVICE_OPTION_NOT_SUBSCRIBED:
+		return "SERVICE_OPTION_NOT_SUBSCRIBED";
+	case PDP_FAIL_SERVICE_OPTION_OUT_OF_ORDER:
+		return "SERVICE_OPTION_OUT_OF_ORDER";
+	case PDP_FAIL_NSAPI_IN_USE:
+		return "NSAPI_IN_USE";
+	case PDP_FAIL_REGULAR_DEACTIVATION:
+		return "REGULAR_DEACTIVATION";
+	case PDP_FAIL_ONLY_IPV4_ALLOWED:
+		return "ONLY_IPV4_ALLOWED";
+	case PDP_FAIL_ONLY_IPV6_ALLOWED:
+		return "ONLY_IPV6_ALLOWED";
+	case PDP_FAIL_ONLY_SINGLE_BEARER_ALLOWED:
+		return "ONLY_SINGLE_BEARER_ALLOWED";
+	case PDP_FAIL_PROTOCOL_ERRORS:
+		return "PROTOCOL_ERRORS";
+	case PDP_FAIL_VOICE_REGISTRATION_FAIL:
+		return "VOICE_REGISTRATION_FAIL";
+	case PDP_FAIL_DATA_REGISTRATION_FAIL:
+		return "DATA_REGISTRATION_FAIL";
+	case PDP_FAIL_SIGNAL_LOST:
+		return "SIGNAL_LOST";
+	case PDP_FAIL_PREF_RADIO_TECH_CHANGED:
+		return "PREF_RADIO_TECH_CHANGED";
+	case PDP_FAIL_RADIO_POWER_OFF:
+		return "RADIO_POWER_OFF";
+	case PDP_FAIL_TETHERED_CALL_ACTIVE:
+		return "TETHERED_CALL_ACTIVE";
+	case PDP_FAIL_ERROR_UNSPECIFIED:
+		return "ERROR_UNSPECIFIED";
+	default:
+		if (g_snprintf(temp_str, sizeof(temp_str),
+				"<UNKNOWN (%d)>", status))
+			return temp_str;
+		else
+			return "<UNKNOWN>";
+	}
+}
diff --git a/drivers/rilmodem/rilutil.h b/drivers/rilmodem/rilutil.h
index 25aed2e..e94af24 100644
--- a/drivers/rilmodem/rilutil.h
+++ b/drivers/rilmodem/rilutil.h
@@ -26,6 +26,7 @@
 #include <modem.h>
 #include <sim.h>
 #include <gprs-context.h>
+#include <gril.h>
 =

 /* TODO: create a table lookup*/
 #define PREFIX_30_NETMASK "255.255.255.252"
@@ -109,6 +110,19 @@ struct ril_util_sim_state_query *ril_util_sim_state_qu=
ery_new(GRil *ril,
 						void *userdata,
 						GDestroyNotify destroy);
 void ril_util_sim_state_query_free(struct ril_util_sim_state_query *req);
+const char *ril_ofono_protocol_to_ril_string(guint protocol);
+int ril_protocol_string_to_ofono_protocol(gchar *protocol_str);
+const char *ril_appstate_to_string(int app_state);
+const char *ril_apptype_to_string(int app_type);
+const char *ril_authtype_to_string(int auth_type);
+const char *ril_cardstate_to_string(int card_state);
+const char *ril_error_to_string(int error);
+const char *ril_pinstate_to_string(int pin_state);
+const char *ril_radio_state_to_string(int radio_state);
+const char *ril_radio_tech_to_string(int radio_tech);
+const char *ril_request_id_to_string(int req);
+const char *ril_unsol_request_to_string(int request);
+const char *ril_pdp_fail_to_string(int status);
 =

 struct cb_data {
 	void *cb;
diff --git a/drivers/rilmodem/sim.c b/drivers/rilmodem/sim.c
index 1014845..af40397 100644
--- a/drivers/rilmodem/sim.c
+++ b/drivers/rilmodem/sim.c
@@ -48,9 +48,9 @@
 #include "ril_constants.h"
 #include "rilmodem.h"
 =

-#include "grilreply.h"
-#include "grilrequest.h"
-#include "grilunsol.h"
+#include "rilreply.h"
+#include "rilrequest.h"
+#include "rilunsol.h"
 =

 #include "drivers/infineonmodem/infineon_constants.h"
 =

diff --git a/drivers/rilmodem/sms.c b/drivers/rilmodem/sms.c
index 14816e5..232a3f0 100644
--- a/drivers/rilmodem/sms.c
+++ b/drivers/rilmodem/sms.c
@@ -42,9 +42,9 @@
 #include "util.h"
 =

 #include "rilmodem.h"
-#include "grilrequest.h"
-#include "grilreply.h"
-#include "grilunsol.h"
+#include "rilrequest.h"
+#include "rilreply.h"
+#include "rilunsol.h"
 =

 struct sms_data {
 	GRil *ril;
diff --git a/drivers/rilmodem/ussd.c b/drivers/rilmodem/ussd.c
index 04985ec..1fa602f 100644
--- a/drivers/rilmodem/ussd.c
+++ b/drivers/rilmodem/ussd.c
@@ -40,8 +40,8 @@
 =

 #include "gril.h"
 #include "grilutil.h"
-#include "grilrequest.h"
-#include "grilunsol.h"
+#include "rilrequest.h"
+#include "rilunsol.h"
 =

 #include "rilmodem.h"
 =

diff --git a/drivers/rilmodem/voicecall.c b/drivers/rilmodem/voicecall.c
index 3fa4b37..7aa10ce 100644
--- a/drivers/rilmodem/voicecall.c
+++ b/drivers/rilmodem/voicecall.c
@@ -40,9 +40,9 @@
 #include <ofono/voicecall.h>
 =

 #include "gril.h"
-#include "grilrequest.h"
-#include "grilreply.h"
-#include "grilunsol.h"
+#include "rilrequest.h"
+#include "rilreply.h"
+#include "rilunsol.h"
 =

 #include "common.h"
 #include "rilmodem.h"
-- =

2.1.4


--===============2545881046318524858==--

