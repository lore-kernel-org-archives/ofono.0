Content-Type: multipart/mixed; boundary="===============0218135268008760489=="
MIME-Version: 1.0
From: Anirudh Gargi <anirudh.gargi@intel.com>
Subject: [PATCH] sms: fix send sms in case of lte registration
Date: Tue, 11 Sep 2018 09:22:25 +0530
Message-ID: <1536637945-31075-1-git-send-email-anirudh.gargi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0218135268008760489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

CREG status 6 and 7 added in network registration status, sms atom
to consider new states also.
---
 src/common.h | 14 ++++++++------
 src/sms.c    |  2 ++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/common.h b/src/common.h
index 1b6b01d..b826228 100644
--- a/src/common.h
+++ b/src/common.h
@@ -37,12 +37,14 @@ enum access_technology {
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
+	NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN =3D 	7,
 };
 =

 /* 27.007 Section 7.3 <stat> */
diff --git a/src/sms.c b/src/sms.c
index b86158e..c604e05 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -782,6 +782,8 @@ static void netreg_status_watch(int status, int lac, in=
t ci, int tech,
 	switch (status) {
 	case NETWORK_REGISTRATION_STATUS_REGISTERED:
 	case NETWORK_REGISTRATION_STATUS_ROAMING:
+	case NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN:
+	case NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN:
 		sms->registered =3D TRUE;
 		break;
 	default:
-- =

2.7.4


--===============0218135268008760489==--

