Content-Type: multipart/mixed; boundary="===============2877639873367939823=="
MIME-Version: 1.0
From: Anirudh Gargi <anirudh.gargi@intel.com>
Subject: [PATCH] sms: allow sms send for EUTRAN sms only state
Date: Fri, 28 Sep 2018 11:16:58 +0530
Message-ID: <1538113618-18564-1-git-send-email-anirudh.gargi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2877639873367939823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Patch to be considered, if support for EUTRAN SMS states accepted.

SMS registered flag while sending sms to consider the new EUTRAN
registered status also.
---
 src/sms.c | 2 ++
 1 file changed, 2 insertions(+)

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


--===============2877639873367939823==--

