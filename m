Content-Type: multipart/mixed; boundary="===============1682278762733922272=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] atmodem: added inline function to parse AT+CESQ result for
 signal strenght It complements the function at_util_convert_signal_strength
 for AT+CSQ,
 which does not apply well to 3G and not at all to LTE. The AT+CESQ returns 3
 sets of values, one for each technology (2G, 3G, LTE).
Date: Thu, 20 Sep 2018 05:23:59 +0200
Message-ID: <1537413839-3460-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1682278762733922272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/atutil.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 7113a4c..57573cb 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -115,6 +115,20 @@ static inline int at_util_convert_signal_strength(int =
strength)
 	return result;
 }
 =

+static inline int at_util_convert_signal_strength_cesq(int strength_GSM, i=
nt strength_UTRAN, int strength_EUTRAN)
+{
+	int result =3D -1;
+
+	if (strength_GSM !=3D 99)
+		result =3D (strength_GSM * 100) / 63;
+	else if (strength_UTRAN !=3D 255)
+		result =3D (strength_UTRAN * 100) / 96;
+	else if (strength_EUTRAN !=3D 255)
+		result =3D (strength_EUTRAN * 100) / 97;
+
+	return result;
+}
+
 #define CALLBACK_WITH_FAILURE(cb, args...)		\
 	do {						\
 		struct ofono_error cb_e;		\
-- =

1.9.1


--===============1682278762733922272==--

