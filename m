Content-Type: multipart/mixed; boundary="===============3328402405404258618=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH 2/6] gril: Added RIL_REQUEST_GET_CELL_INFO_LIST
Date: Thu, 31 Mar 2016 09:52:31 +0530
Message-ID: <1459398151-5806-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3328402405404258618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gril/grilutil.c      | 2 ++
 gril/ril_constants.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/gril/grilutil.c b/gril/grilutil.c
index 3970517..9e7cd31 100644
--- a/gril/grilutil.c
+++ b/gril/grilutil.c
@@ -334,6 +334,8 @@ const char *ril_request_id_to_string(int req)
 		return "RIL_REQUEST_ACKNOWLEDGE_INCOMING_GSM_SMS_WITH_PDU";
 	case RIL_REQUEST_STK_SEND_ENVELOPE_WITH_STATUS:
 		return "RIL_REQUEST_STK_SEND_ENVELOPE_WITH_STATUS";
+	case RIL_REQUEST_GET_CELL_INFO_LIST:
+		return "RIL_REQUEST_GET_CELL_INFO_LIST";
 	case RIL_REQUEST_SET_INITIAL_ATTACH_APN:
 		return "RIL_REQUEST_SET_INITIAL_ATTACH_APN";
 	default:
diff --git a/gril/ril_constants.h b/gril/ril_constants.h
index 6649353..cbc596e 100644
--- a/gril/ril_constants.h
+++ b/gril/ril_constants.h
@@ -347,6 +347,7 @@
 #define RIL_REQUEST_ACKNOWLEDGE_INCOMING_GSM_SMS_WITH_PDU 106
 #define RIL_REQUEST_STK_SEND_ENVELOPE_WITH_STATUS 107
 #define RIL_REQUEST_VOICE_RADIO_TECH 108
+#define RIL_REQUEST_GET_CELL_INFO_LIST 109
 #define RIL_REQUEST_SET_INITIAL_ATTACH_APN 111
 =

 /* RIL Unsolicited Messages */
-- =

1.9.1


--===============3328402405404258618==--

