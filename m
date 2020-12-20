Content-Type: multipart/mixed; boundary="===============8312458335248539521=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] huawei, util: Fix a couple of implicit enum conversions
Date: Sun, 20 Dec 2020 11:18:27 +0000
Message-ID: <20201220111827.2119273-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8312458335248539521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

GCC 10 warns about a couple of implicit conversions;

huawei: Member from the incorrect enum was returned,
both had the value 0, so the code would still work.

drivers/huaweimodem/radio-settings.c: In function =E2=80=98band_gsm_from_hu=
awei=E2=80=99:
drivers/huaweimodem/radio-settings.c:107:10: error: implicit conversion fro=
m =E2=80=98enum ofono_radio_band_umts=E2=80=99 to =E2=80=98enum ofono_radio=
_band_gsm=E2=80=99 [-Werror=3Denum-conversion]
  107 |   return OFONO_RADIO_BAND_UMTS_ANY;

util: smsutil and util has an enum each for representing
the same thing; The SMS alphabet. They share the same
values, so an explicit type cast makes GCC happy.

src/smsutil.c: In function =E2=80=98sms_text_prepare_with_alphabet=E2=80=99:
src/smsutil.c:3594:8: error: implicit conversion from =E2=80=98enum sms_alp=
habet=E2=80=99 to =E2=80=98enum gsm_dialect=E2=80=99 [-Werror=3Denum-conver=
sion]
 3594 |        alphabet, &used_locking,
---
 drivers/huaweimodem/radio-settings.c | 2 +-
 src/smsutil.c                        | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/huaweimodem/radio-settings.c b/drivers/huaweimodem/rad=
io-settings.c
index c8ebcba0..b3f31e56 100644
--- a/drivers/huaweimodem/radio-settings.c
+++ b/drivers/huaweimodem/radio-settings.c
@@ -104,7 +104,7 @@ static enum ofono_radio_band_gsm band_gsm_from_huawei(u=
nsigned int band)
 	size_t i;
 =

 	if (band =3D=3D HUAWEI_BAND_ANY)
-		return OFONO_RADIO_BAND_UMTS_ANY;
+		return OFONO_RADIO_BAND_GSM_ANY;
 =

 	for (i =3D ARRAY_SIZE(huawei_band_gsm_table) - 1; i > 0; i--) {
 		if (huawei_band_gsm_table[i].band_huawei & band)
diff --git a/src/smsutil.c b/src/smsutil.c
index 450a1d38..e6556df6 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -3575,6 +3575,7 @@ GSList *sms_text_prepare_with_alphabet(const char *to=
, const char *utf8,
 	GSList *r =3D NULL;
 	enum gsm_dialect used_locking;
 	enum gsm_dialect used_single;
+	enum gsm_dialect dialect;
 =

 	memset(&template, 0, sizeof(struct sms));
 	template.type =3D SMS_TYPE_SUBMIT;
@@ -3586,12 +3587,14 @@ GSList *sms_text_prepare_with_alphabet(const char *=
to, const char *utf8,
 	template.submit.vp.relative =3D 0xA7; /* 24 Hours */
 	sms_address_from_string(&template.submit.daddr, to);
 =

+	/* There are two enums for the same thing */
+	dialect =3D (enum gsm_dialect)alphabet;
 	/*
 	 * UDHI, UDL, UD and DCS actually depend on the contents of
 	 * the text, and also on the GSM dialect we use to encode it.
 	 */
 	gsm_encoded =3D convert_utf8_to_gsm_best_lang(utf8, -1, NULL, &written, 0,
-							alphabet, &used_locking,
+							dialect, &used_locking,
 							&used_single);
 	if (!gsm_encoded) {
 		size_t converted;
-- =

2.27.0

--===============8312458335248539521==--

