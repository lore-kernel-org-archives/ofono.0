Content-Type: multipart/mixed; boundary="===============6144255512514399613=="
MIME-Version: 1.0
From: Anirudh Gargi <anirudh.gargi@intel.com>
Subject: [PATCH] network: add support eutran sms only states
Date: Fri, 28 Sep 2018 11:01:12 +0530
Message-ID: <1538112672-18092-1-git-send-email-anirudh.gargi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6144255512514399613==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

EUTRAN SMS states mapped to registered and roaming respectively.
For the new CREG status (9/10) of CREG, it can be map to a new Dbus
CSFB property.

Added clarity in API doc for voice calling in case of lte.
---
 doc/network-api.txt |  4 +++-
 src/common.c        |  4 ++++
 src/common.h        | 19 +++++++++++++------
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/doc/network-api.txt b/doc/network-api.txt
index 83a2bc0..9c367c7 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -77,7 +77,9 @@ Properties	string Mode [readonly]
 =

 		string Status [readonly]
 =

-			The current registration status of a modem.
+			The current registration status of a modem. In case
+			technology is 'lte', 'registered' and 'roaming' may
+			not necessarily mean voice calling available.
 =

 			The possible values are:
 				"unregistered"  Not registered to any network
diff --git a/src/common.c b/src/common.c
index 3ccaf7c..0db412a 100644
--- a/src/common.c
+++ b/src/common.c
@@ -669,6 +669,10 @@ const char *registration_status_to_string(int status)
 		return "unknown";
 	case NETWORK_REGISTRATION_STATUS_ROAMING:
 		return "roaming";
+	case NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN:
+		return "registered";
+	case NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN:
+		return "roaming";
 	}
 =

 	return "";
diff --git a/src/common.h b/src/common.h
index 1b6b01d..f7bd3cb 100644
--- a/src/common.h
+++ b/src/common.h
@@ -37,12 +37,19 @@ enum access_technology {
 =

 /* 27.007 Section 7.2 <stat> */
 enum network_registration_status {
-	NETWORK_REGISTRATION_STATUS_NOT_REGISTERED =3D	0,
-	NETWORK_REGISTRATION_STATUS_REGISTERED =3D	1,
-	NETWORK_REGISTRATION_STATUS_SEARCHING =3D		2,
-	NETWORK_REGISTRATION_STATUS_DENIED =3D		3,
-	NETWORK_REGISTRATION_STATUS_UNKNOWN =3D		4,
-	NETWORK_REGISTRATION_STATUS_ROAMING =3D		5,
+	NETWORK_REGISTRATION_STATUS_NOT_REGISTERED =3D		0,
+	NETWORK_REGISTRATION_STATUS_REGISTERED =3D		1,
+	NETWORK_REGISTRATION_STATUS_SEARCHING =3D			2,
+	NETWORK_REGISTRATION_STATUS_DENIED =3D			3,
+	NETWORK_REGISTRATION_STATUS_UNKNOWN =3D			4,
+	NETWORK_REGISTRATION_STATUS_ROAMING =3D			5,
+	NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN =3D	6,
+	NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN =3D	7,
+	/*
+	 * Add along with new CSFB Dbus property.
+	NETWORK_REGISTRATION_STATUS_REGISTERED_NO_CSFB_EUTRAN =3D	9,
+	NETWORK_REGISTRATION_STATUS_ROAMING_NO_CSFB_EUTRAN =3D	10,
+	*/
 };
 =

 /* 27.007 Section 7.3 <stat> */
-- =

2.7.4


--===============6144255512514399613==--

