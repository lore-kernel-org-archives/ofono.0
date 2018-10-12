Content-Type: multipart/mixed; boundary="===============2467194199805949457=="
MIME-Version: 1.0
From: Nandini Rebello <nandini.rebello@intel.com>
Subject: [PATCH] sms: support 8 national lang in Alphabet property
Date: Fri, 12 Oct 2018 13:41:44 +0530
Message-ID: <1539331904-3482-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2467194199805949457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding support for 8 additional languages for GSM 7 bit.
---
 src/sms.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/src/sms.c b/src/sms.c
index 857776a..66df8dd 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -174,6 +174,22 @@ static const char *sms_alphabet_to_string(enum sms_alp=
habet alphabet)
 		return "bengali";
 	case SMS_ALPHABET_GUJARATI:
                 return "gujarati";
+	case SMS_ALPHABET_HINDI:
+		return "hindi";
+	case SMS_ALPHABET_KANNADA:
+		return "kannada";
+	case SMS_ALPHABET_MALAYALAM:
+		return "malayalam";
+	case SMS_ALPHABET_ORIYA:
+		return "oriya";
+	case SMS_ALPHABET_PUNJABI:
+		return "punjabi";
+	case SMS_ALPHABET_TAMIL:
+		return "tamil";
+	case SMS_ALPHABET_TELUGU:
+		return "telugu";
+	case SMS_ALPHABET_URDU:
+		return "urdu";
 	case SMS_ALPHABET_DEFAULT:
 		return "default";
 	}
@@ -196,6 +212,22 @@ static gboolean sms_alphabet_from_string(const char *s=
tr,
                 *alphabet =3D SMS_ALPHABET_BENGALI;
 	else if (g_str_equal(str, "gujarati"))
                 *alphabet =3D SMS_ALPHABET_GUJARATI;
+	else if (g_str_equal(str, "hindi"))
+		*alphabet =3D SMS_ALPHABET_HINDI;
+	else if (g_str_equal(str, "kannada"))
+		*alphabet =3D SMS_ALPHABET_KANNADA;
+	else if (g_str_equal(str, "malayalam"))
+		*alphabet =3D SMS_ALPHABET_MALAYALAM;
+	else if (g_str_equal(str, "oriya"))
+		*alphabet =3D SMS_ALPHABET_ORIYA;
+	else if (g_str_equal(str, "punjabi"))
+		*alphabet =3D SMS_ALPHABET_PUNJABI;
+	else if (g_str_equal(str, "tamil"))
+		*alphabet =3D SMS_ALPHABET_TAMIL;
+	else if (g_str_equal(str, "telugu"))
+		*alphabet =3D SMS_ALPHABET_TELUGU;
+	else if (g_str_equal(str, "urdu"))
+		*alphabet =3D SMS_ALPHABET_URDU;
 	else
 		return FALSE;
 =

-- =

2.7.4


--===============2467194199805949457==--

