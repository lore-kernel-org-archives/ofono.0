Content-Type: multipart/mixed; boundary="===============0640117934887352579=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH 3/3] unit: fix GCC 6.0 compilation issues
Date: Mon, 18 Apr 2016 13:45:36 +0200
Message-ID: <1460979936-18296-3-git-send-email-kubax.t.pawlak@intel.com>
In-Reply-To: <1460979936-18296-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0640117934887352579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Kuba Pawlak <kuba.t.pawlak@gmail.com>

-Werror=3Dunused-const-variable
---
 unit/test-rilmodem-cb.c | 23 -----------------------
 unit/test-stkutil.c     | 33 ---------------------------------
 2 files changed, 56 deletions(-)

diff --git a/unit/test-rilmodem-cb.c b/unit/test-rilmodem-cb.c
index d5b1d07ddb5354b0726bcfac615ebffa9925df3e..43c6fa173d6b2bf17e11c6766a3=
70a628256d590 100644
--- a/unit/test-rilmodem-cb.c
+++ b/unit/test-rilmodem-cb.c
@@ -234,29 +234,6 @@ static const struct cb_data testdata_query_invalid_3 =
=3D {
 	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
 };
 =

-/*
- * The following structure contains test data for a
- * RIL_REQUEST_GET_FACILITY_LOCK reply with an incomplete
- * integer parameter, which will trigger a malformed parcel
- * error.
- */
-static const guchar reply_get_facility_lock_data_invalid_4[] =3D {
-	0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00
-};
-
-static const struct cb_data testdata_query_invalid_4 =3D {
-	.start_func =3D trigger_query,
-	.lock =3D "OI",
-	.cls =3D BEARER_CLASS_VOICE,
-	.rtd =3D {
-		.req_data =3D req_get_facility_lock_parcel_1,
-		.req_size =3D sizeof(req_get_facility_lock_parcel_1),
-		.rsp_data =3D reply_get_facility_lock_data_invalid_4,
-		.rsp_size =3D sizeof(reply_get_facility_lock_data_invalid_4),
-	},
-	.error_type =3D OFONO_ERROR_TYPE_FAILURE,
-};
-
 /* RIL_REQUEST_SET_FACILITY_LOCK witht the following parameters:
  *
  * facility=3D"OI" (outgoing international calls)
diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 77ec3530b38c3f192c305d4128e1bcff89e2c927..bf6776eaf408c65effea7bbf2bc=
1dfa36cc4c0cb 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -16867,11 +16867,6 @@ static const struct terminal_response_test get_inp=
ut_response_data_181 =3D {
 	},
 };
 =

-static const unsigned char get_input_response_191b[] =3D {
-	0x81, 0x03, 0x01, 0x23, 0x01, 0x82, 0x02, 0x82,
-	0x81, 0x83, 0x01, 0x00, 0x8d, 0x00,
-};
-
 static const struct terminal_response_test get_input_response_data_191 =3D=
 {
 	/* Either get_input_response_191a or get_input_response_191b is ok */
 	.pdu =3D get_input_response_191a,
@@ -17349,11 +17344,6 @@ static const unsigned char poll_interval_response_=
111a[] =3D {
 	0x81, 0x83, 0x01, 0x00, 0x84, 0x02, 0x00, 0x01,
 };
 =

-static const unsigned char poll_interval_response_111b[] =3D {
-	0x81, 0x03, 0x01, 0x03, 0x00, 0x82, 0x02, 0x82,
-	0x81, 0x83, 0x01, 0x00, 0x84, 0x02, 0x01, 0x3c,
-};
-
 static const struct terminal_response_test poll_interval_response_data_111=
a =3D {
 	/* Either poll_interval_response_111a or b is ok */
 	.pdu =3D poll_interval_response_111a,
@@ -17476,26 +17466,6 @@ static const struct terminal_response_test refresh=
_response_data_131a =3D {
 	},
 };
 =

-static const unsigned char refresh_response_131b[] =3D {
-	0x81, 0x03, 0x01, 0x01, 0x02, 0x82, 0x02, 0x82,
-	0x81, 0x83, 0x01, 0x03,
-};
-
-static const struct terminal_response_test refresh_response_data_131b =3D {
-	.pdu =3D refresh_response_131b,
-	.pdu_len =3D sizeof(refresh_response_131b),
-	.response =3D {
-		.number =3D 1,
-		.type =3D STK_COMMAND_TYPE_REFRESH,
-		.qualifier =3D 0x02, /* USIM Initialization & File Change */
-		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
-		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
-		.result =3D {
-			.type =3D STK_RESULT_TYPE_REFRESH_WITH_EFS,
-		},
-	},
-};
-
 static const unsigned char refresh_response_141a[] =3D {
 	0x81, 0x03, 0x01, 0x01, 0x00, 0x82, 0x02, 0x82,
 	0x81, 0x83, 0x01, 0x00,
@@ -18338,9 +18308,6 @@ static const unsigned char provide_local_info_respo=
nse_131[] =3D {
 	0x06, 0x45, 0x91, 0xa4, 0x90,
 };
 =

-static const short bcch_channels_131[] =3D {
-};
-
 static const struct terminal_response_test
 		provide_local_info_response_data_131 =3D {
 	.pdu =3D provide_local_info_response_131,
-- =

1.9.3

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


--===============0640117934887352579==--

