Content-Type: multipart/mixed; boundary="===============0784677728565368830=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH 5/7] gril: added RIL constants for cell info list
Date: Thu, 07 Sep 2017 09:53:18 +0530
Message-ID: <1504758200-18624-5-git-send-email-nishanth.v@intel.com>
In-Reply-To: <1504758200-18624-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0784677728565368830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

added RIL_REQUEST_SET_UNSOL_CELL_INFO_LIST_RATE and
RIL_UNSOL_CELL_INFO_LIST and corresponding string
conversion
---
 gril/grilutil.c      | 4 ++++
 gril/ril_constants.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/gril/grilutil.c b/gril/grilutil.c
index 9e7cd31..89a6d6f 100644
--- a/gril/grilutil.c
+++ b/gril/grilutil.c
@@ -338,6 +338,8 @@ const char *ril_request_id_to_string(int req)
 		return "RIL_REQUEST_GET_CELL_INFO_LIST";
 	case RIL_REQUEST_SET_INITIAL_ATTACH_APN:
 		return "RIL_REQUEST_SET_INITIAL_ATTACH_APN";
+	case RIL_REQUEST_SET_UNSOL_CELL_INFO_LIST_RATE:
+		return "RIL_REQUEST_SET_UNSOL_CELL_INFO_LIST_RATE";
 	default:
 		return "<INVALID>";
 	}
@@ -416,6 +418,8 @@ const char *ril_unsol_request_to_string(int request)
 		return "UNSOL_EXIT_EMERGENCY_CALLBACK_MODE";
 	case RIL_UNSOL_RIL_CONNECTED:
 		return "UNSOL_RIL_CONNECTED";
+	case RIL_UNSOL_CELL_INFO_LIST:
+		return "RIL_UNSOL_CELL_INFO_LIST";
 	default:
 		return "<unknown request>";
 	}
diff --git a/gril/ril_constants.h b/gril/ril_constants.h
index cbc596e..b707136 100644
--- a/gril/ril_constants.h
+++ b/gril/ril_constants.h
@@ -348,6 +348,7 @@
 #define RIL_REQUEST_STK_SEND_ENVELOPE_WITH_STATUS 107
 #define RIL_REQUEST_VOICE_RADIO_TECH 108
 #define RIL_REQUEST_GET_CELL_INFO_LIST 109
+#define RIL_REQUEST_SET_UNSOL_CELL_INFO_LIST_RATE 110
 #define RIL_REQUEST_SET_INITIAL_ATTACH_APN 111
 =

 /* RIL Unsolicited Messages */
@@ -388,6 +389,7 @@
 #define RIL_UNSOL_EXIT_EMERGENCY_CALLBACK_MODE 1033
 #define RIL_UNSOL_RIL_CONNECTED 1034
 #define RIL_UNSOL_VOICE_RADIO_TECH_CHANGED 1035
+#define RIL_UNSOL_CELL_INFO_LIST 1036
 =

 /* Suplementary services Service class*/
 #define SERVICE_CLASS_NONE 0
-- =

1.9.1


--===============0784677728565368830==--

