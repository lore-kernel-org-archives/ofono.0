Content-Type: multipart/mixed; boundary="===============0853125831364730857=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH 3/3] hfp: define driver specific dial string validation
Date: Thu, 06 Aug 2015 18:57:01 +0200
Message-ID: <1438880221-23834-5-git-send-email-kubax.t.pawlak@intel.com>
In-Reply-To: <1438880221-23834-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0853125831364730857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HFP spec only covers ATD behaviour for vocecalls.
If a string starts with '8' or '#' this is a USSD code
Reject a request like that.
---
 drivers/hfpmodem/voicecall.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index f1e9096940328f05415cf5a6f3bed9ceaf447fe3..1b34f76646fc78b835960959b04=
7e4a2d3a739fd 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -695,6 +695,40 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

+static ofono_bool_t hfp_valid_number_format(const char *number)
+{
+	int len =3D strlen(number);
+	int begin =3D 0;
+	int i;
+
+	if (!len)
+		return FALSE;
+
+	if (number[0] =3D=3D '+')
+		begin =3D 1;
+
+	if (number[0] =3D=3D '*' || number[0] =3D=3D '#')
+		return FALSE;
+
+	if (begin =3D=3D len)
+		return FALSE;
+
+	if ((len - begin) > OFONO_MAX_PHONE_NUMBER_LENGTH)
+		return FALSE;
+
+	for (i =3D begin; i < len; i++) {
+		if (number[i] >=3D '0' && number[i] <=3D '9')
+			continue;
+
+		if (number[i] =3D=3D '*' || number[i] =3D=3D '#')
+			continue;
+
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
 static void no_carrier_notify(GAtResult *result, gpointer user_data)
 {
 	DBG("");
@@ -1252,7 +1286,8 @@ static struct ofono_voicecall_driver driver =3D {
 	.transfer		=3D hfp_transfer,
 	.deflect		=3D NULL,
 	.swap_without_accept	=3D NULL,
-	.send_tones		=3D hfp_send_dtmf
+	.send_tones		=3D hfp_send_dtmf,
+	.validate_dial =3D hfp_valid_number_format
 };
 =

 void hfp_voicecall_init(void)
-- =

1.7.11.7

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Prof. Dr. Hermann Eul
Chairperson of the Supervisory Board: Tiffany Doon Silva
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


--===============0853125831364730857==--

