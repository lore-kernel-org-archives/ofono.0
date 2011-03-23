Content-Type: multipart/mixed; boundary="===============4876984494816922720=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] common: fix buffer length in phone_number_to_string
Date: Wed, 23 Mar 2011 18:16:35 +0100
Message-ID: <1300900595-32375-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4876984494816922720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

update buffer length related to OFONO_MAX_PHONE_NUMBER_LENGTH change
78c1e96bf9601b5e5d31d04413baa1265a1c284f
---
 src/common.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/common.c b/src/common.c
index 520360c..e65a677 100644
--- a/src/common.c
+++ b/src/common.c
@@ -422,16 +422,16 @@ int mmi_service_code_to_bearer_class(int code)
 =

 const char *phone_number_to_string(const struct ofono_phone_number *ph)
 {
-	static char buffer[64];
+	static char buffer[OFONO_MAX_PHONE_NUMBER_LENGTH + 2];
 =

 	if (ph->type =3D=3D 145 && (strlen(ph->number) > 0) &&
 			ph->number[0] !=3D '+') {
 		buffer[0] =3D '+';
-		strncpy(buffer + 1, ph->number, 62);
-		buffer[63] =3D '\0';
+		strncpy(buffer + 1, ph->number, OFONO_MAX_PHONE_NUMBER_LENGTH);
+		buffer[OFONO_MAX_PHONE_NUMBER_LENGTH + 1] =3D '\0';
 	} else {
-		strncpy(buffer, ph->number, 63);
-		buffer[63] =3D '\0';
+		strncpy(buffer, ph->number, OFONO_MAX_PHONE_NUMBER_LENGTH + 1);
+		buffer[OFONO_MAX_PHONE_NUMBER_LENGTH + 1] =3D '\0';
 	}
 =

 	return buffer;
-- =

1.7.1


--===============4876984494816922720==--

