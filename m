Content-Type: multipart/mixed; boundary="===============1565585816392750430=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 2/2] teststk: Use sim bcd version
Date: Thu, 27 May 2010 17:24:34 +0800
Message-ID: <1274952274-17712-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1274952274-17712-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1565585816392750430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   90 +++++++++++++++++++++++++----------------------=
---
 1 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 8117ec7..45138f1 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -7561,7 +7561,7 @@ static struct setup_call_test setup_call_data_111 =3D=
 {
 	.alpha_id_usr_cfm =3D "Not busy",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	}
 };
 =

@@ -7572,7 +7572,7 @@ static struct setup_call_test setup_call_data_141 =3D=
 {
 	.alpha_id_usr_cfm =3D "On hold",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	}
 };
 =

@@ -7583,7 +7583,7 @@ static struct setup_call_test setup_call_data_151 =3D=
 {
 	.alpha_id_usr_cfm =3D "Disconnect",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	}
 };
 =

@@ -7594,7 +7594,7 @@ static struct setup_call_test setup_call_data_181 =3D=
 {
 	.alpha_id_usr_cfm =3D "Capability config",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.ccp =3D {
 		.len =3D 0x02,
@@ -7634,7 +7634,7 @@ static struct setup_call_test setup_call_data_1111 =
=3D {
 	.alpha_id_usr_cfm =3D "Called party",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.subaddr =3D {
 		.len =3D 0x07,
@@ -7649,7 +7649,7 @@ static struct setup_call_test setup_call_data_1121 =
=3D {
 	.alpha_id_usr_cfm =3D "Duration",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.duration =3D {
 		.unit =3D STK_DURATION_TYPE_SECONDS,
@@ -7664,7 +7664,7 @@ static struct setup_call_test setup_call_data_211 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL"
 };
@@ -7676,7 +7676,7 @@ static struct setup_call_test setup_call_data_311 =3D=
 {
 	.alpha_id_usr_cfm =3D "Set up call Icon 3.1.1",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.icon_id_usr_cfm =3D {
 		.qualifier =3D STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY,
@@ -7691,7 +7691,7 @@ static struct setup_call_test setup_call_data_321 =3D=
 {
 	.alpha_id_usr_cfm =3D "Set up call Icon 3.2.1",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.icon_id_usr_cfm =3D {
 		.qualifier =3D STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY,
@@ -7706,7 +7706,7 @@ static struct setup_call_test setup_call_data_331 =3D=
 {
 	.alpha_id_usr_cfm =3D "Set up call Icon 3.3.1",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.icon_id_usr_cfm =3D {
 		.qualifier =3D STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY,
@@ -7721,7 +7721,7 @@ static struct setup_call_test setup_call_data_341 =3D=
 {
 	.alpha_id_usr_cfm =3D "Set up call Icon 3.4.1",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.icon_id_usr_cfm =3D {
 		.qualifier =3D STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY,
@@ -7741,7 +7741,7 @@ static struct setup_call_test setup_call_data_411 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 1",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 1",
 	.text_attr_usr_cfm =3D {
@@ -7761,7 +7761,7 @@ static struct setup_call_test setup_call_data_412 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 2",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 2"
 };
@@ -7773,7 +7773,7 @@ static struct setup_call_test setup_call_data_421 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 1",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 1",
 	.text_attr_usr_cfm =3D {
@@ -7793,7 +7793,7 @@ static struct setup_call_test setup_call_data_422 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 2",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 2"
 };
@@ -7805,7 +7805,7 @@ static struct setup_call_test setup_call_data_431 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 1",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 1",
 	.text_attr_usr_cfm =3D {
@@ -7825,7 +7825,7 @@ static struct setup_call_test setup_call_data_432 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 2",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 2"
 };
@@ -7837,7 +7837,7 @@ static struct setup_call_test setup_call_data_441 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 1",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 1",
 	.text_attr_usr_cfm =3D {
@@ -7857,7 +7857,7 @@ static struct setup_call_test setup_call_data_442 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 2",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 2",
 	.text_attr_usr_cfm =3D {
@@ -7877,7 +7877,7 @@ static struct setup_call_test setup_call_data_443 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 3",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 3"
 };
@@ -7889,7 +7889,7 @@ static struct setup_call_test setup_call_data_451 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 1",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 1",
 	.text_attr_usr_cfm =3D {
@@ -7909,7 +7909,7 @@ static struct setup_call_test setup_call_data_452 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 2",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 2",
 	.text_attr_usr_cfm =3D {
@@ -7929,7 +7929,7 @@ static struct setup_call_test setup_call_data_453 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 3",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 3"
 };
@@ -7941,7 +7941,7 @@ static struct setup_call_test setup_call_data_461 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 1",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 1",
 	.text_attr_usr_cfm =3D {
@@ -7961,7 +7961,7 @@ static struct setup_call_test setup_call_data_462 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 2",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 2",
 	.text_attr_usr_cfm =3D {
@@ -7981,7 +7981,7 @@ static struct setup_call_test setup_call_data_463 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 3",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 3"
 };
@@ -7993,7 +7993,7 @@ static struct setup_call_test setup_call_data_471 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 1",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 1",
 	.text_attr_usr_cfm =3D {
@@ -8013,7 +8013,7 @@ static struct setup_call_test setup_call_data_472 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 2",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 2",
 	.text_attr_usr_cfm =3D {
@@ -8033,7 +8033,7 @@ static struct setup_call_test setup_call_data_473 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 3",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 3"
 };
@@ -8045,7 +8045,7 @@ static struct setup_call_test setup_call_data_481 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 1",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 1",
 	.text_attr_usr_cfm =3D {
@@ -8065,7 +8065,7 @@ static struct setup_call_test setup_call_data_482 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 2",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 2",
 	.text_attr_usr_cfm =3D {
@@ -8085,7 +8085,7 @@ static struct setup_call_test setup_call_data_483 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 3",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 3"
 };
@@ -8097,7 +8097,7 @@ static struct setup_call_test setup_call_data_491 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 1",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 1",
 	.text_attr_usr_cfm =3D {
@@ -8117,7 +8117,7 @@ static struct setup_call_test setup_call_data_492 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 2",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 2",
 	.text_attr_usr_cfm =3D {
@@ -8137,7 +8137,7 @@ static struct setup_call_test setup_call_data_493 =3D=
 {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 3",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 3"
 };
@@ -8149,7 +8149,7 @@ static struct setup_call_test setup_call_data_4101 =
=3D {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 1",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 1",
 	.text_attr_usr_cfm =3D {
@@ -8169,7 +8169,7 @@ static struct setup_call_test setup_call_data_4102 =
=3D {
 	.alpha_id_usr_cfm =3D "CONFIRMATION 2",
 	.addr =3D {
 		.ton_npi =3D 0x91,
-		.number =3D "012340123456a1a2"
+		.number =3D "012340123456c1c2"
 	},
 	.alpha_id_call_setup =3D "CALL 2"
 };
@@ -11115,7 +11115,7 @@ static struct send_dtmf_test send_dtmf_data_111 =3D=
 {
 	.pdu =3D send_dtmf_111,
 	.pdu_len =3D sizeof(send_dtmf_111),
 	.qualifier =3D 0x00,
-	.dtmf =3D "1a2"
+	.dtmf =3D "1c2"
 };
 =

 static struct send_dtmf_test send_dtmf_data_121 =3D {
@@ -11130,7 +11130,7 @@ static struct send_dtmf_test send_dtmf_data_131 =3D=
 {
 	.pdu =3D send_dtmf_131,
 	.pdu_len =3D sizeof(send_dtmf_131),
 	.qualifier =3D 0x00,
-	.dtmf =3D "1aaaaaaaaaa2"
+	.dtmf =3D "1cccccccccc2"
 };
 =

 static struct send_dtmf_test send_dtmf_data_211 =3D {
@@ -11138,7 +11138,7 @@ static struct send_dtmf_test send_dtmf_data_211 =3D=
 {
 	.pdu_len =3D sizeof(send_dtmf_211),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Basic Icon",
-	.dtmf =3D "1a2",
+	.dtmf =3D "1c2",
 	.icon_id =3D {
 		.qualifier =3D STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY,
 		.id =3D 0x01
@@ -11150,7 +11150,7 @@ static struct send_dtmf_test send_dtmf_data_221 =3D=
 {
 	.pdu_len =3D sizeof(send_dtmf_221),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Colour Icon",
-	.dtmf =3D "1a2",
+	.dtmf =3D "1c2",
 	.icon_id =3D {
 		.qualifier =3D STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY,
 		.id =3D 0x02
@@ -11162,7 +11162,7 @@ static struct send_dtmf_test send_dtmf_data_231 =3D=
 {
 	.pdu_len =3D sizeof(send_dtmf_231),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Send DTMF",
-	.dtmf =3D "1a2",
+	.dtmf =3D "1c2",
 	.icon_id =3D {
 		.qualifier =3D STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY,
 		.id =3D 0x01
@@ -11174,7 +11174,7 @@ static struct send_dtmf_test send_dtmf_data_311 =3D=
 {
 	.pdu_len =3D sizeof(send_dtmf_311),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=
=99=D0=A2=D0=95",
-	.dtmf =3D "1a2"
+	.dtmf =3D "1c2"
 };
 =

 static struct send_dtmf_test send_dtmf_data_411 =3D {
@@ -11454,7 +11454,7 @@ static struct send_dtmf_test send_dtmf_data_511 =3D=
 {
 	.pdu_len =3D sizeof(send_dtmf_511),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "=E4=BD=A0=E5=A5=BD",
-	.dtmf =3D "1a2"
+	.dtmf =3D "1c2"
 };
 =

 static struct send_dtmf_test send_dtmf_data_611 =3D {
@@ -11462,7 +11462,7 @@ static struct send_dtmf_test send_dtmf_data_611 =3D=
 {
 	.pdu_len =3D sizeof(send_dtmf_611),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "=E3=83=AB",
-	.dtmf =3D "1a2"
+	.dtmf =3D "1c2"
 };
 =

 static void test_send_dtmf(gconstpointer data)
-- =

1.7.0.4


--===============1565585816392750430==--

