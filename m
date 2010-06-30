Content-Type: multipart/mixed; boundary="===============6632026237370084949=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/6] test-stkutil: Fix always true condition.
Date: Wed, 30 Jun 2010 17:24:16 +0200
Message-ID: <1277911458-4984-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1277911458-4984-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6632026237370084949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  274 ++++++++++++++++++++++++++++++++++++++++++-----=
----
 1 files changed, 227 insertions(+), 47 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 7fa485b..c489c8c 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -225,8 +225,8 @@ static void check_gsm_sms(const struct sms *command,
 		g_assert(cs->srr =3D=3D ts->srr);
 		g_assert(cs->mr =3D=3D ts->mr);
 =

-		g_assert(cs->daddr.number_type =3D=3D cs->daddr.number_type);
-		g_assert(cs->daddr.numbering_plan =3D=3D cs->daddr.numbering_plan);
+		g_assert(cs->daddr.number_type =3D=3D ts->daddr.number_type);
+		g_assert(cs->daddr.numbering_plan =3D=3D ts->daddr.numbering_plan);
 		g_assert(g_str_equal(cs->daddr.address, ts->daddr.address));
 =

 		g_assert(cs->pid =3D=3D ts->pid);
@@ -7794,7 +7794,11 @@ static struct send_sms_test send_sms_data_111 =3D {
 		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "012345678",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "012345678",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF4,
 			.udl =3D 12,
@@ -7817,7 +7821,11 @@ static struct send_sms_test send_sms_data_121 =3D {
 		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "012345678",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "012345678",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 7,
@@ -7840,7 +7848,11 @@ static struct send_sms_test send_sms_data_131 =3D {
 		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "012345678",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "012345678",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 13,
@@ -7863,7 +7875,11 @@ static struct send_sms_test send_sms_data_141 =3D {
 		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "012345678",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "012345678",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 160,
@@ -7889,7 +7905,11 @@ static struct send_sms_test send_sms_data_151 =3D {
 		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "012345678",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "012345678",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 160,
@@ -7915,7 +7935,11 @@ static struct send_sms_test send_sms_data_161 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -7937,7 +7961,11 @@ static struct send_sms_test send_sms_data_171 =3D {
 		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "012345678",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "012345678",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF4,
 			.udl =3D 12,
@@ -7959,7 +7987,11 @@ static struct send_sms_test send_sms_data_181 =3D {
 		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "012345678",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "012345678",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF4,
 			.udl =3D 12,
@@ -7982,7 +8014,11 @@ static struct send_sms_test send_sms_data_211 =3D {
 		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "012345678",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "012345678",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0x08,
 			.udl =3D 24,
@@ -8005,7 +8041,11 @@ static struct send_sms_test send_sms_data_212 =3D {
 		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "012345678",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "012345678",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0x08,
 			.udl =3D 24,
@@ -8028,7 +8068,11 @@ static struct send_sms_test send_sms_data_213 =3D {
 		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "012345678",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "012345678",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0x08,
 			.udl =3D 24,
@@ -8051,7 +8095,11 @@ static struct send_sms_test send_sms_data_311 =3D {
 		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "012345678",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "012345678",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF4,
 			.udl =3D 12,
@@ -8078,7 +8126,11 @@ static struct send_sms_test send_sms_data_321 =3D {
 		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "012345678",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "012345678",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF4,
 			.udl =3D 12,
@@ -8100,7 +8152,11 @@ static struct send_sms_test send_sms_data_411 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8122,7 +8178,11 @@ static struct send_sms_test send_sms_data_412 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8140,7 +8200,11 @@ static struct send_sms_test send_sms_data_421 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8162,7 +8226,11 @@ static struct send_sms_test send_sms_data_422 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8180,7 +8248,11 @@ static struct send_sms_test send_sms_data_431 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8202,7 +8274,11 @@ static struct send_sms_test send_sms_data_432 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8220,7 +8296,11 @@ static struct send_sms_test send_sms_data_441 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8242,7 +8322,11 @@ static struct send_sms_test send_sms_data_442 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8264,7 +8348,11 @@ static struct send_sms_test send_sms_data_443 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8282,7 +8370,11 @@ static struct send_sms_test send_sms_data_451 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8304,7 +8396,11 @@ static struct send_sms_test send_sms_data_452 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8326,7 +8422,11 @@ static struct send_sms_test send_sms_data_453 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8344,7 +8444,11 @@ static struct send_sms_test send_sms_data_461 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8366,7 +8470,11 @@ static struct send_sms_test send_sms_data_462 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8388,7 +8496,11 @@ static struct send_sms_test send_sms_data_463 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8406,7 +8518,11 @@ static struct send_sms_test send_sms_data_471 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8428,7 +8544,11 @@ static struct send_sms_test send_sms_data_472 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8450,7 +8570,11 @@ static struct send_sms_test send_sms_data_473 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8468,7 +8592,11 @@ static struct send_sms_test send_sms_data_481 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8490,7 +8618,11 @@ static struct send_sms_test send_sms_data_482 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8512,7 +8644,11 @@ static struct send_sms_test send_sms_data_483 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8530,7 +8666,11 @@ static struct send_sms_test send_sms_data_491 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8552,7 +8692,11 @@ static struct send_sms_test send_sms_data_492 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8574,7 +8718,11 @@ static struct send_sms_test send_sms_data_493 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8592,7 +8740,11 @@ static struct send_sms_test send_sms_data_4101 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8614,7 +8766,11 @@ static struct send_sms_test send_sms_data_4102 =3D {
 		{}, SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "01",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "01",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0xF0,
 			.udl =3D 1,
@@ -8638,7 +8794,11 @@ static struct send_sms_test send_sms_data_511 =3D {
 		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "012345678",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "012345678",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0x08,
 			.udl =3D 4,
@@ -8662,7 +8822,11 @@ static struct send_sms_test send_sms_data_512 =3D {
 		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "012345678",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "012345678",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0x08,
 			.udl =3D 4,
@@ -8686,7 +8850,11 @@ static struct send_sms_test send_sms_data_513 =3D {
 		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "012345678",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "012345678",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0x08,
 			.udl =3D 4,
@@ -8709,7 +8877,11 @@ static struct send_sms_test send_sms_data_611 =3D {
 		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "012345678",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "012345678",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0x08,
 			.udl =3D 8,
@@ -8732,7 +8904,11 @@ static struct send_sms_test send_sms_data_612 =3D {
 		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "012345678",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "012345678",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0x08,
 			.udl =3D 8,
@@ -8755,7 +8931,11 @@ static struct send_sms_test send_sms_data_613 =3D {
 		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
-			.daddr.address =3D "012345678",
+			.daddr =3D {
+				.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+				.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+				.address =3D "012345678",
+			},
 			.pid =3D 0x40,
 			.dcs =3D 0x08,
 			.udl =3D 8,
-- =

1.7.1.86.g0e460.dirty


--===============6632026237370084949==--

