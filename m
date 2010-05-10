Content-Type: multipart/mixed; boundary="===============3124404556840152885=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 03/19] stk: Unify variable names to use abbreviation
Date: Mon, 10 May 2010 18:38:46 +0800
Message-ID: <1273487942-27213-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273487942-27213-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3124404556840152885==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c       |    8 +-
 src/stkutil.h       |    8 +-
 unit/test-stkutil.c |  161 +++++++++++++++++++++++++----------------------=
----
 3 files changed, 88 insertions(+), 89 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 09fbec9..5bddb93 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2095,7 +2095,7 @@ static gboolean parse_display_text(struct stk_command=
 *command,
 				STK_DATA_OBJECT_TYPE_DURATION, 0,
 				&obj->duration,
 				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
-				&obj->text_attribute,
+				&obj->text_attr,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
@@ -2169,13 +2169,13 @@ static gboolean parse_get_input(struct stk_command =
*command,
 				&obj->text,
 				STK_DATA_OBJECT_TYPE_RESPONSE_LENGTH,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
-				&obj->response_length,
+				&obj->resp_len,
 				STK_DATA_OBJECT_TYPE_DEFAULT_TEXT, 0,
 				&obj->default_text,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
 				&obj->icon_id,
 				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
-				&obj->text_attribute,
+				&obj->text_attr,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
@@ -2228,7 +2228,7 @@ static gboolean parse_send_sms(struct stk_command *co=
mmand,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
 				&obj->icon_id,
 				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
-				&obj->text_attribute,
+				&obj->text_attr,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
diff --git a/src/stkutil.h b/src/stkutil.h
index 41c03a7..70c6b01 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -794,7 +794,7 @@ struct stk_command_display_text {
 	struct stk_icon_id icon_id;
 	ofono_bool_t immediate_response;
 	struct stk_duration duration;
-	struct stk_text_attribute text_attribute;
+	struct stk_text_attribute text_attr;
 	struct stk_frame_id frame_id;
 };
 =

@@ -808,10 +808,10 @@ struct stk_command_get_inkey {
 =

 struct stk_command_get_input {
 	char *text;
-	struct stk_response_length response_length;
+	struct stk_response_length resp_len;
 	char *default_text;
 	struct stk_icon_id icon_id;
-	struct stk_text_attribute text_attribute;
+	struct stk_text_attribute text_attr;
 	struct stk_frame_id frame_id;
 };
 =

@@ -820,7 +820,7 @@ struct stk_command_send_sms {
 	struct stk_address address;
 	struct sms gsm_sms;
 	struct stk_icon_id icon_id;
-	struct stk_text_attribute text_attribute;
+	struct stk_text_attribute text_attr;
 	struct stk_frame_id frame_id;
 };
 =

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index abb82c9..6d57109 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -113,7 +113,7 @@ struct display_text_test {
 	struct stk_icon_id icon_id;
 	ofono_bool_t immediate_response;
 	struct stk_duration duration;
-	struct stk_text_attribute text_attribute;
+	struct stk_text_attribute text_attr;
 	struct stk_frame_id frame_id;
 };
 =

@@ -352,8 +352,8 @@ static void test_display_text(gconstpointer data)
 	check_common_bool(command->display_text.immediate_response,
 						test->immediate_response);
 	check_duration(&command->display_text.duration, &test->duration);
-	check_text_attr(&command->display_text.text_attribute,
-						&test->text_attribute);
+	check_text_attr(&command->display_text.text_attr,
+						&test->text_attr);
 	check_frame_id(&command->display_text.frame_id, &test->frame_id);
 =

 	stk_command_free(command);
@@ -1299,10 +1299,10 @@ struct get_input_test {
 	unsigned int pdu_len;
 	unsigned char qualifier;
 	char *text;
-	struct stk_response_length response_length;
+	struct stk_response_length resp_len;
 	char *default_text;
 	struct stk_icon_id icon_id;
-	struct stk_text_attribute text_attribute;
+	struct stk_text_attribute text_attr;
 	struct stk_frame_id frame_id;
 };
 =

@@ -1864,7 +1864,7 @@ static struct get_input_test get_input_data_111 =3D {
 	.pdu_len =3D sizeof(get_input_111),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 12345",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -1875,7 +1875,7 @@ static struct get_input_test get_input_data_121 =3D {
 	.pdu_len =3D sizeof(get_input_121),
 	.qualifier =3D 0x08,
 	.text =3D "Enter 67*#+",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -1886,7 +1886,7 @@ static struct get_input_test get_input_data_131 =3D {
 	.pdu_len =3D sizeof(get_input_131),
 	.qualifier =3D 0x01,
 	.text =3D "Enter AbCdE",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -1897,7 +1897,7 @@ static struct get_input_test get_input_data_141 =3D {
 	.pdu_len =3D sizeof(get_input_141),
 	.qualifier =3D 0x04,
 	.text =3D "Password 1<SEND>2345678",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 4,
 		.max =3D 8
 	}
@@ -1908,7 +1908,7 @@ static struct get_input_test get_input_data_151 =3D {
 	.pdu_len =3D sizeof(get_input_151),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 1..9,0..9,0(1)",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 1,
 		.max =3D 20
 	}
@@ -1919,7 +1919,7 @@ static struct get_input_test get_input_data_161 =3D {
 	.pdu_len =3D sizeof(get_input_161),
 	.qualifier =3D 0x00,
 	.text =3D "<GO-BACKWARDS>",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 0,
 		.max =3D 8
 	}
@@ -1930,7 +1930,7 @@ static struct get_input_test get_input_data_171 =3D {
 	.pdu_len =3D sizeof(get_input_171),
 	.qualifier =3D 0x00,
 	.text =3D "<ABORT>",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 0,
 		.max =3D 8
 	}
@@ -1944,7 +1944,7 @@ static struct get_input_test get_input_data_181 =3D {
 		"***4444444444###***5555555555###***6666666666###"
 		"***7777777777###***8888888888###***9999999999###"
 		"***0000000000###",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 160,
 		.max =3D 160
 	}
@@ -1955,7 +1955,7 @@ static struct get_input_test get_input_data_191 =3D {
 	.pdu_len =3D sizeof(get_input_191),
 	.qualifier =3D 0x00,
 	.text =3D "<SEND>",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 0,
 		.max =3D 1
 	}
@@ -1966,7 +1966,7 @@ static struct get_input_test get_input_data_1101 =3D {
 	.pdu_len =3D sizeof(get_input_1101),
 	.qualifier =3D 0x00,
 	.text =3D NULL,
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 1,
 		.max =3D 5
 	}
@@ -1977,7 +1977,7 @@ static struct get_input_test get_input_data_211 =3D {
 	.pdu_len =3D sizeof(get_input_211),
 	.qualifier =3D 0x00,
 	.text =3D "<TIME-OUT>",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 0,
 		.max =3D 10
 	}
@@ -1988,7 +1988,7 @@ static struct get_input_test get_input_data_311 =3D {
 	.pdu_len =3D sizeof(get_input_311),
 	.qualifier =3D 0x01,
 	.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=95",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -2001,7 +2001,7 @@ static struct get_input_test get_input_data_321 =3D {
 	.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=
=A2=D0=95"
 		"=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=
=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=95"
 		"=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=
=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -2012,7 +2012,7 @@ static struct get_input_test get_input_data_411 =3D {
 	.pdu_len =3D sizeof(get_input_411),
 	.qualifier =3D 0x03,
 	.text =3D "Enter Hello",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 12,
 		.max =3D 12
 	}
@@ -2023,7 +2023,7 @@ static struct get_input_test get_input_data_421 =3D {
 	.pdu_len =3D sizeof(get_input_421),
 	.qualifier =3D 0x03,
 	.text =3D "Enter Hello",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 0xFF
 	}
@@ -2034,7 +2034,7 @@ static struct get_input_test get_input_data_511 =3D {
 	.pdu_len =3D sizeof(get_input_511),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 12345",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	},
@@ -2046,7 +2046,7 @@ static struct get_input_test get_input_data_521 =3D {
 	.pdu_len =3D sizeof(get_input_521),
 	.qualifier =3D 0x00,
 	.text =3D "Enter:",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 160,
 		.max =3D 160
 	},
@@ -2061,7 +2061,7 @@ static struct get_input_test get_input_data_611 =3D {
 	.pdu_len =3D sizeof(get_input_611),
 	.qualifier =3D 0x00,
 	.text =3D "<NO-ICON>",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 0,
 		.max =3D 10
 	},
@@ -2076,7 +2076,7 @@ static struct get_input_test get_input_data_621 =3D {
 	.pdu_len =3D sizeof(get_input_621),
 	.qualifier =3D 0x00,
 	.text =3D "<BASIC-ICON>",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 0,
 		.max =3D 10
 	},
@@ -2091,7 +2091,7 @@ static struct get_input_test get_input_data_631 =3D {
 	.pdu_len =3D sizeof(get_input_631),
 	.qualifier =3D 0x00,
 	.text =3D "<NO-ICON>",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 0,
 		.max =3D 10
 	},
@@ -2106,7 +2106,7 @@ static struct get_input_test get_input_data_641 =3D {
 	.pdu_len =3D sizeof(get_input_641),
 	.qualifier =3D 0x00,
 	.text =3D "<COLOUR-ICON>",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 0,
 		.max =3D 10
 	},
@@ -2121,7 +2121,7 @@ static struct get_input_test get_input_data_711 =3D {
 	.pdu_len =3D sizeof(get_input_711),
 	.qualifier =3D 0x80,
 	.text =3D "Enter 12345",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -2132,11 +2132,11 @@ static struct get_input_test get_input_data_811 =3D=
 {
 	.pdu_len =3D sizeof(get_input_811),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 12345",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	},
-	.text_attribute =3D {
+	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
 	}
@@ -2147,7 +2147,7 @@ static struct get_input_test get_input_data_812 =3D {
 	.pdu_len =3D sizeof(get_input_812),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 22222",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -2158,11 +2158,11 @@ static struct get_input_test get_input_data_821 =3D=
 {
 	.pdu_len =3D sizeof(get_input_821),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 12345",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	},
-	.text_attribute =3D {
+	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x01, 0xB4 }
 	}
@@ -2173,7 +2173,7 @@ static struct get_input_test get_input_data_822 =3D {
 	.pdu_len =3D sizeof(get_input_822),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 22222",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -2184,11 +2184,11 @@ static struct get_input_test get_input_data_831 =3D=
 {
 	.pdu_len =3D sizeof(get_input_831),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 12345",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	},
-	.text_attribute =3D {
+	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x02, 0xB4 }
 	}
@@ -2199,7 +2199,7 @@ static struct get_input_test get_input_data_832 =3D {
 	.pdu_len =3D sizeof(get_input_832),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 22222",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -2210,11 +2210,11 @@ static struct get_input_test get_input_data_841 =3D=
 {
 	.pdu_len =3D sizeof(get_input_841),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 12345",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	},
-	.text_attribute =3D {
+	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x04, 0xB4 }
 	}
@@ -2225,11 +2225,11 @@ static struct get_input_test get_input_data_842 =3D=
 {
 	.pdu_len =3D sizeof(get_input_842),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 22222",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	},
-	.text_attribute =3D {
+	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
 	}
@@ -2240,7 +2240,7 @@ static struct get_input_test get_input_data_843 =3D {
 	.pdu_len =3D sizeof(get_input_843),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 33333",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -2251,11 +2251,11 @@ static struct get_input_test get_input_data_851 =3D=
 {
 	.pdu_len =3D sizeof(get_input_851),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 12345",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	},
-	.text_attribute =3D {
+	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x08, 0xB4 }
 	}
@@ -2266,11 +2266,11 @@ static struct get_input_test get_input_data_852 =3D=
 {
 	.pdu_len =3D sizeof(get_input_852),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 22222",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	},
-	.text_attribute =3D {
+	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
 	}
@@ -2281,7 +2281,7 @@ static struct get_input_test get_input_data_853 =3D {
 	.pdu_len =3D sizeof(get_input_853),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 33333",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -2292,11 +2292,11 @@ static struct get_input_test get_input_data_861 =3D=
 {
 	.pdu_len =3D sizeof(get_input_861),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 12345",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	},
-	.text_attribute =3D {
+	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x10, 0xB4 }
 	}
@@ -2307,11 +2307,11 @@ static struct get_input_test get_input_data_862 =3D=
 {
 	.pdu_len =3D sizeof(get_input_862),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 22222",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	},
-	.text_attribute =3D {
+	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
 	}
@@ -2322,7 +2322,7 @@ static struct get_input_test get_input_data_863 =3D {
 	.pdu_len =3D sizeof(get_input_863),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 33333",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -2333,11 +2333,11 @@ static struct get_input_test get_input_data_871 =3D=
 {
 	.pdu_len =3D sizeof(get_input_871),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 12345",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	},
-	.text_attribute =3D {
+	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x20, 0xB4 }
 	}
@@ -2348,11 +2348,11 @@ static struct get_input_test get_input_data_872 =3D=
 {
 	.pdu_len =3D sizeof(get_input_872),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 22222",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	},
-	.text_attribute =3D {
+	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
 	}
@@ -2363,7 +2363,7 @@ static struct get_input_test get_input_data_873 =3D {
 	.pdu_len =3D sizeof(get_input_873),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 33333",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -2374,11 +2374,11 @@ static struct get_input_test get_input_data_881 =3D=
 {
 	.pdu_len =3D sizeof(get_input_881),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 12345",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	},
-	.text_attribute =3D {
+	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x40, 0xB4 }
 	}
@@ -2389,11 +2389,11 @@ static struct get_input_test get_input_data_882 =3D=
 {
 	.pdu_len =3D sizeof(get_input_882),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 22222",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	},
-	.text_attribute =3D {
+	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
 	}
@@ -2404,7 +2404,7 @@ static struct get_input_test get_input_data_883 =3D {
 	.pdu_len =3D sizeof(get_input_883),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 33333",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -2415,11 +2415,11 @@ static struct get_input_test get_input_data_891 =3D=
 {
 	.pdu_len =3D sizeof(get_input_891),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 12345",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	},
-	.text_attribute =3D {
+	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x80, 0xB4 }
 	}
@@ -2430,11 +2430,11 @@ static struct get_input_test get_input_data_892 =3D=
 {
 	.pdu_len =3D sizeof(get_input_892),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 22222",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	},
-	.text_attribute =3D {
+	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
 	}
@@ -2445,7 +2445,7 @@ static struct get_input_test get_input_data_893 =3D {
 	.pdu_len =3D sizeof(get_input_893),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 33333",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -2456,11 +2456,11 @@ static struct get_input_test get_input_data_8101 =
=3D {
 	.pdu_len =3D sizeof(get_input_8101),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 12345",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	},
-	.text_attribute =3D {
+	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
 	}
@@ -2471,7 +2471,7 @@ static struct get_input_test get_input_data_8102 =3D {
 	.pdu_len =3D sizeof(get_input_8102),
 	.qualifier =3D 0x00,
 	.text =3D "Enter 22222",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -2482,7 +2482,7 @@ static struct get_input_test get_input_data_911 =3D {
 	.pdu_len =3D sizeof(get_input_911),
 	.qualifier =3D 0x01,
 	.text =3D "=E4=BD=A0=E5=A5=BD",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -2496,7 +2496,7 @@ static struct get_input_test get_input_data_921 =3D {
 		"=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=
=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=
=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD"
 		"=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=
=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=
=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD"
 		"=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=
=BD=E4=BD=A0=E5=A5=BD",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -2507,7 +2507,7 @@ static struct get_input_test get_input_data_1011 =3D {
 	.pdu_len =3D sizeof(get_input_1011),
 	.qualifier =3D 0x03,
 	.text =3D "Enter Hello",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 2,
 		.max =3D 2
 	}
@@ -2518,7 +2518,7 @@ static struct get_input_test get_input_data_1021 =3D {
 	.pdu_len =3D sizeof(get_input_1021),
 	.qualifier =3D 0x03,
 	.text =3D "Enter Hello",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 0xFF
 	}
@@ -2529,7 +2529,7 @@ static struct get_input_test get_input_data_1111 =3D {
 	.pdu_len =3D sizeof(get_input_1111),
 	.qualifier =3D 0x01,
 	.text =3D "=E3=83=AB",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -2543,7 +2543,7 @@ static struct get_input_test get_input_data_1121 =3D {
 		"=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=
=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=
=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB"
 		"=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=
=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=
=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB"
 		"=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=
=AB=E3=83=AB=E3=83=AB",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 5
 	}
@@ -2554,7 +2554,7 @@ static struct get_input_test get_input_data_1211 =3D {
 	.pdu_len =3D sizeof(get_input_1211),
 	.qualifier =3D 0x03,
 	.text =3D "Enter Hello",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 2,
 		.max =3D 2
 	}
@@ -2565,7 +2565,7 @@ static struct get_input_test get_input_data_1221 =3D {
 	.pdu_len =3D sizeof(get_input_1221),
 	.qualifier =3D 0x03,
 	.text =3D "Enter Hello",
-	.response_length =3D {
+	.resp_len =3D {
 		.min =3D 5,
 		.max =3D 0xFF
 	}
@@ -2591,12 +2591,11 @@ static void test_get_input(gconstpointer data)
 	if (test->text)
 		g_assert(command->get_input.text);
 	check_text(command->get_input.text, test->text);
-	check_response_length(&command->get_input.response_length,
-				&test->response_length);
+	check_response_length(&command->get_input.resp_len, &test->resp_len);
 	check_text(command->get_input.default_text, test->default_text);
 	check_icon_id(&command->get_input.icon_id, &test->icon_id);
-	check_text_attr(&command->get_input.text_attribute,
-						&test->text_attribute);
+	check_text_attr(&command->get_input.text_attr,
+						&test->text_attr);
 	check_frame_id(&command->get_input.frame_id, &test->frame_id);
 =

 	stk_command_free(command);
-- =

1.7.0.4


--===============3124404556840152885==--

