Content-Type: multipart/mixed; boundary="===============1153390308819127669=="
MIME-Version: 1.0
From: Tommi Kenakkala <tommi.kenakkala@tieto.com>
Subject: [PATCH 2/2] unit: SMS-DELIVER decoding/encoding test for long
 alphanum address
Date: Fri, 13 Feb 2015 14:23:46 +0200
Message-ID: <1423830226-32024-3-git-send-email-tommi.kenakkala@tieto.com>
In-Reply-To: <1423830226-32024-1-git-send-email-tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1153390308819127669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-sms.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/unit/test-sms.c b/unit/test-sms.c
index 7b644df..259594e 100644
--- a/unit/test-sms.c
+++ b/unit/test-sms.c
@@ -38,6 +38,12 @@ static const char *simple_deliver =3D "07911326040000F0"
 		"040B911346610089F60000208062917314480CC8F71D14969741F977FD07";
 static const char *alnum_sender =3D "0791447758100650"
 		"040DD0F334FC1CA6970100008080312170224008D4F29CDE0EA7D9";
+static const char *unicode_deliver =3D "04819999990414D0FBFD7EBFDFEFF77BFE=
1E001"
+		"9512090801361807E00DC00FC00C400E400D600F600C500E500D800F800C"
+		"600E600C700E700C900E900CA00EA00DF003100320033003400350036003"
+		"7003800390030002000540068006900730020006D0065007300730061006"
+		"7006500200069007300200036003300200075006E00690063006F0064006"
+		"5002000630068006100720073002E";
 static const char *simple_submit =3D "0011000B916407281553F80000AA"
 		"0AE8329BFD4697D9EC37";
 =

@@ -362,6 +368,38 @@ static void test_deliver_encode(void)
 	g_assert(strcmp(alnum_sender, encoded_pdu) =3D=3D 0);
 =

 	g_free(encoded_pdu);
+
+	/* test unicode_deliver*/
+	decoded_pdu =3D decode_hex(unicode_deliver, -1, &pdu_len, 0);
+	g_assert(decoded_pdu);
+	g_assert(pdu_len =3D=3D (long)strlen(unicode_deliver) / 2);
+
+	ret =3D sms_decode(decoded_pdu, pdu_len, FALSE, 149, &sms);
+
+	g_free(decoded_pdu);
+
+	g_assert(ret);
+	g_assert(sms.type =3D=3D SMS_TYPE_DELIVER);
+
+	ret =3D sms_encode(&sms, &encoded_pdu_len, &encoded_tpdu_len, pdu);
+
+	if (g_test_verbose()) {
+		int i;
+
+		for (i =3D 0; i < encoded_pdu_len; i++)
+			g_print("%02X", pdu[i]);
+		g_print("\n");
+	}
+
+	g_assert(ret);
+	g_assert(encoded_tpdu_len =3D=3D 149);
+	g_assert(encoded_pdu_len =3D=3D pdu_len);
+
+	encoded_pdu =3D encode_hex(pdu, encoded_pdu_len, 0);
+
+	g_assert(strcmp(unicode_deliver, encoded_pdu) =3D=3D 0);
+
+	g_free(encoded_pdu);
 }
 =

 static void test_simple_submit(void)
-- =

1.7.9.5


--===============1153390308819127669==--

