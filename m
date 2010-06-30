Content-Type: multipart/mixed; boundary="===============7802135369585233180=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/6][RfC] stkutil: Move scaddr field to gsm_sms in
 stk_command_send_sms
Date: Wed, 30 Jun 2010 17:24:15 +0200
Message-ID: <1277911458-4984-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1277911458-4984-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7802135369585233180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c       |   58 +++++++++++----
 src/stkutil.h       |    1 -
 unit/test-stkutil.c |  205 ++++++++++++++++++++++++++++-------------------=
----
 3 files changed, 156 insertions(+), 108 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 6f072e7..e92add3 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2633,7 +2633,6 @@ static enum stk_command_parse_result parse_select_ite=
m(
 static void destroy_send_sms(struct stk_command *command)
 {
 	g_free(command->send_sms.alpha_id);
-	g_free(command->send_sms.address.number);
 	g_free(command->send_sms.cdma_sms.array);
 }
 =

@@ -2644,6 +2643,7 @@ static enum stk_command_parse_result parse_send_sms(
 	struct stk_command_send_sms *obj =3D &command->send_sms;
 	enum stk_command_parse_result status;
 	struct gsm_sms_tpdu gsm_tpdu;
+	struct stk_address sc_address =3D { 0, NULL };
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
@@ -2655,7 +2655,7 @@ static enum stk_command_parse_result parse_send_sms(
 	status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_ADDRESS, 0,
-				&obj->address,
+				&sc_address,
 				STK_DATA_OBJECT_TYPE_GSM_SMS_TPDU, 0,
 				&gsm_tpdu,
 				STK_DATA_OBJECT_TYPE_CDMA_SMS_TPDU, 0,
@@ -2671,35 +2671,63 @@ static enum stk_command_parse_result parse_send_sms(
 	command->destructor =3D destroy_send_sms;
 =

 	if (status !=3D STK_PARSE_RESULT_OK)
-		return status;
+		goto out;
 =

-	if (gsm_tpdu.len =3D=3D 0 && obj->cdma_sms.len =3D=3D 0)
-		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+	if (gsm_tpdu.len =3D=3D 0 && obj->cdma_sms.len =3D=3D 0) {
+		status =3D STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+		goto out;
+	}
 =

-	if (gsm_tpdu.len > 0 && obj->cdma_sms.len > 0)
-		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+	if (gsm_tpdu.len > 0 && obj->cdma_sms.len > 0) {
+		status =3D STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+		goto out;
+	}
 =

 	/* We don't process CDMA pdus for now */
 	if (obj->cdma_sms.len > 0)
-		return STK_PARSE_RESULT_OK;
+		goto out;
 =

 	/* packing is needed */
 	if (command->qualifier & 0x01) {
 		if (sms_decode_unpacked_stk_pdu(gsm_tpdu.tpdu, gsm_tpdu.len,
-							&obj->gsm_sms) !=3D TRUE)
+							&obj->gsm_sms) !=3D
+				TRUE) {
 			status =3D STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
-		return status;
+			goto out;
+		}
+
+		goto set_addr;
 	}
 =

 	if (sms_decode(gsm_tpdu.tpdu, gsm_tpdu.len, TRUE,
-				gsm_tpdu.len, &obj->gsm_sms) =3D=3D FALSE)
-		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+				gsm_tpdu.len, &obj->gsm_sms) =3D=3D FALSE) {
+		status =3D STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+		goto out;
+	}
 =

 	if (obj->gsm_sms.type !=3D SMS_TYPE_SUBMIT &&
-			obj->gsm_sms.type !=3D SMS_TYPE_COMMAND)
-		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+			obj->gsm_sms.type !=3D SMS_TYPE_COMMAND) {
+		status =3D STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+		goto out;
+	}
 =

-	return STK_PARSE_RESULT_OK;
+set_addr:
+	if (sc_address.number =3D=3D NULL)
+		goto out;
+
+	if (strlen(sc_address.number) > 20) {
+		status =3D STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+		goto out;
+	}
+
+	strcpy(obj->gsm_sms.sc_addr.address, sc_address.number);
+	obj->gsm_sms.sc_addr.numbering_plan =3D sc_address.ton_npi & 15;
+	obj->gsm_sms.sc_addr.number_type =3D (sc_address.ton_npi >> 4) & 7;
+
+out:
+	g_free(sc_address.number);
+
+	return status;
 }
 =

 static void destroy_send_ss(struct stk_command *command)
diff --git a/src/stkutil.h b/src/stkutil.h
index ca4817e..978a229 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1118,7 +1118,6 @@ struct stk_command_select_item {
 =

 struct stk_command_send_sms {
 	char *alpha_id;
-	struct stk_address address;
 	struct sms gsm_sms;
 	struct stk_common_byte_array cdma_sms;
 	struct stk_icon_id icon_id;
diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 8b7e254..7fa485b 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -207,6 +207,11 @@ static void check_response_length(const struct stk_res=
ponse_length *command,
 static void check_gsm_sms(const struct sms *command,
 					const struct sms_test *test)
 {
+	g_assert(command->sc_addr.number_type =3D=3D test->sc_addr.number_type);
+	g_assert(command->sc_addr.numbering_plan =3D=3D
+			test->sc_addr.numbering_plan);
+	g_assert(g_str_equal(command->sc_addr.address, test->sc_addr.address));
+
 	switch (test->type) {
 	case SMS_TYPE_SUBMIT: {
 		const struct sms_submit *cs =3D &command->submit;
@@ -7156,7 +7161,6 @@ struct send_sms_test {
 	unsigned int pdu_len;
 	unsigned char qualifier;
 	char *alpha_id;
-	struct stk_address address;
 	struct sms_test gsm_sms;
 	struct stk_common_byte_array cdma_sms;
 	struct stk_icon_id icon_id;
@@ -7781,12 +7785,13 @@ static struct send_sms_test send_sms_data_111 =3D {
 	.pdu_len =3D sizeof(send_sms_111),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Send SM",
-	.address =3D {
-		.ton_npi =3D 0x91,
-		.number =3D "112233445566778"
-	},
 	.gsm_sms =3D {
-		{}, SMS_TYPE_SUBMIT,
+		{
+			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+			.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+			.address =3D "112233445566778",
+		},
+		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
 			.daddr.address =3D "012345678",
@@ -7803,12 +7808,13 @@ static struct send_sms_test send_sms_data_121 =3D {
 	.pdu_len =3D sizeof(send_sms_121),
 	.qualifier =3D 0x01,
 	.alpha_id =3D "Send SM",
-	.address =3D {
-		.ton_npi =3D 0x91,
-		.number =3D "112233445566778"
-	},
 	.gsm_sms =3D {
-		{}, SMS_TYPE_SUBMIT,
+		{
+			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+			.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+			.address =3D "112233445566778",
+		},
+		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
 			.daddr.address =3D "012345678",
@@ -7825,12 +7831,13 @@ static struct send_sms_test send_sms_data_131 =3D {
 	.pdu_len =3D sizeof(send_sms_131),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Short Message",
-	.address =3D {
-		.ton_npi =3D 0x91,
-		.number =3D "112233445566778"
-	},
 	.gsm_sms =3D {
-		{}, SMS_TYPE_SUBMIT,
+		{
+			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+			.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+			.address =3D "112233445566778",
+		},
+		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
 			.daddr.address =3D "012345678",
@@ -7847,12 +7854,13 @@ static struct send_sms_test send_sms_data_141 =3D {
 	.pdu_len =3D sizeof(send_sms_141),
 	.qualifier =3D 0x01,
 	.alpha_id =3D "The address data object holds the RP_Destination_Address",
-	.address =3D {
-		.ton_npi =3D 0x91,
-		.number =3D "112233445566778"
-	},
 	.gsm_sms =3D {
-		{}, SMS_TYPE_SUBMIT,
+		{
+			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+			.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+			.address =3D "112233445566778",
+		},
+		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
 			.daddr.address =3D "012345678",
@@ -7872,12 +7880,13 @@ static struct send_sms_test send_sms_data_151 =3D {
 	.pdu_len =3D sizeof(send_sms_151),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "The address data object holds the RP Destination Address",
-	.address =3D {
-		.ton_npi =3D 0x91,
-		.number =3D "112233445566778"
-	},
 	.gsm_sms =3D {
-		{}, SMS_TYPE_SUBMIT,
+		{
+			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+			.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+			.address =3D "112233445566778",
+		},
+		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
 			.daddr.address =3D "012345678",
@@ -7919,12 +7928,13 @@ static struct send_sms_test send_sms_data_171 =3D {
 	.pdu =3D send_sms_171,
 	.pdu_len =3D sizeof(send_sms_171),
 	.qualifier =3D 0x00,
-	.address =3D {
-		.ton_npi =3D 0x91,
-		.number =3D "112233445566778"
-	},
 	.gsm_sms =3D {
-		{}, SMS_TYPE_SUBMIT,
+		{
+			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+			.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+			.address =3D "112233445566778",
+		},
+		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
 			.daddr.address =3D "012345678",
@@ -7940,12 +7950,13 @@ static struct send_sms_test send_sms_data_181 =3D {
 	.pdu =3D send_sms_181,
 	.pdu_len =3D sizeof(send_sms_181),
 	.qualifier =3D 0x00,
-	.address =3D {
-		.ton_npi =3D 0x91,
-		.number =3D "112233445566778"
-	},
 	.gsm_sms =3D {
-		{}, SMS_TYPE_SUBMIT,
+		{
+			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+			.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+			.address =3D "112233445566778",
+		},
+		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
 			.daddr.address =3D "012345678",
@@ -7962,12 +7973,13 @@ static struct send_sms_test send_sms_data_211 =3D {
 	.pdu_len =3D sizeof(send_sms_211),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=
=99=D0=A2=D0=95",
-	.address =3D {
-		.ton_npi =3D 0x91,
-		.number =3D "112233445566778"
-	},
 	.gsm_sms =3D {
-		{}, SMS_TYPE_SUBMIT,
+		{
+			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+			.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+			.address =3D "112233445566778",
+		},
+		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
 			.daddr.address =3D "012345678",
@@ -7984,12 +7996,13 @@ static struct send_sms_test send_sms_data_212 =3D {
 	.pdu_len =3D sizeof(send_sms_212),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=
=99=D0=A2=D0=95",
-	.address =3D {
-		.ton_npi =3D 0x91,
-		.number =3D "112233445566778"
-	},
 	.gsm_sms =3D {
-		{}, SMS_TYPE_SUBMIT,
+		{
+			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+			.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+			.address =3D "112233445566778",
+		},
+		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
 			.daddr.address =3D "012345678",
@@ -8006,12 +8019,13 @@ static struct send_sms_test send_sms_data_213 =3D {
 	.pdu_len =3D sizeof(send_sms_213),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=
=99=D0=A2=D0=95",
-	.address =3D {
-		.ton_npi =3D 0x91,
-		.number =3D "112233445566778"
-	},
 	.gsm_sms =3D {
-		{}, SMS_TYPE_SUBMIT,
+		{
+			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+			.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+			.address =3D "112233445566778",
+		},
+		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
 			.daddr.address =3D "012345678",
@@ -8028,12 +8042,13 @@ static struct send_sms_test send_sms_data_311 =3D {
 	.pdu_len =3D sizeof(send_sms_311),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "NO ICON",
-	.address =3D {
-		.ton_npi =3D 0x91,
-		.number =3D "112233445566778"
-	},
 	.gsm_sms =3D {
-		{}, SMS_TYPE_SUBMIT,
+		{
+			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+			.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+			.address =3D "112233445566778",
+		},
+		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
 			.daddr.address =3D "012345678",
@@ -8054,12 +8069,13 @@ static struct send_sms_test send_sms_data_321 =3D {
 	.pdu_len =3D sizeof(send_sms_321),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Send SM",
-	.address =3D {
-		.ton_npi =3D 0x91,
-		.number =3D "112233445566778"
-	},
 	.gsm_sms =3D {
-		{}, SMS_TYPE_SUBMIT,
+		{
+			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+			.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+			.address =3D "112233445566778",
+		},
+		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
 			.daddr.address =3D "012345678",
@@ -8613,12 +8629,13 @@ static struct send_sms_test send_sms_data_511 =3D {
 	.pdu_len =3D sizeof(send_sms_511),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "=E4=B8=AD=E4=B8=80",
-	.address =3D {
-		.ton_npi =3D 0x91,
-		.number =3D "112233445566778"
-	},
 	.gsm_sms =3D {
-		{}, SMS_TYPE_SUBMIT,
+		{
+			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+			.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+			.address =3D "112233445566778",
+		},
+		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
 			.daddr.address =3D "012345678",
@@ -8636,12 +8653,13 @@ static struct send_sms_test send_sms_data_512 =3D {
 	.pdu_len =3D sizeof(send_sms_512),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "=E4=B8=AD=E4=B8=80",
-	.address =3D {
-		.ton_npi =3D 0x91,
-		.number =3D "112233445566778"
-	},
 	.gsm_sms =3D {
-		{}, SMS_TYPE_SUBMIT,
+		{
+			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+			.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+			.address =3D "112233445566778",
+		},
+		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
 			.daddr.address =3D "012345678",
@@ -8659,12 +8677,13 @@ static struct send_sms_test send_sms_data_513 =3D {
 	.pdu_len =3D sizeof(send_sms_513),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "=E4=B8=AD=E4=B8=80",
-	.address =3D {
-		.ton_npi =3D 0x91,
-		.number =3D "112233445566778"
-	},
 	.gsm_sms =3D {
-		{}, SMS_TYPE_SUBMIT,
+		{
+			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+			.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+			.address =3D "112233445566778",
+		},
+		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
 			.daddr.address =3D "012345678",
@@ -8681,12 +8700,13 @@ static struct send_sms_test send_sms_data_611 =3D {
 	.pdu_len =3D sizeof(send_sms_611),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "80=E3=83=AB0",
-	.address =3D {
-		.ton_npi =3D 0x91,
-		.number =3D "112233445566778"
-	},
 	.gsm_sms =3D {
-		{}, SMS_TYPE_SUBMIT,
+		{
+			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+			.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+			.address =3D "112233445566778",
+		},
+		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
 			.daddr.address =3D "012345678",
@@ -8703,12 +8723,13 @@ static struct send_sms_test send_sms_data_612 =3D {
 	.pdu_len =3D sizeof(send_sms_612),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "81=E3=83=AB1",
-	.address =3D {
-		.ton_npi =3D 0x91,
-		.number =3D "112233445566778"
-	},
 	.gsm_sms =3D {
-		{}, SMS_TYPE_SUBMIT,
+		{
+			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+			.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+			.address =3D "112233445566778",
+		},
+		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
 			.daddr.address =3D "012345678",
@@ -8725,12 +8746,13 @@ static struct send_sms_test send_sms_data_613 =3D {
 	.pdu_len =3D sizeof(send_sms_613),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "82=E3=83=AB2",
-	.address =3D {
-		.ton_npi =3D 0x91,
-		.number =3D "112233445566778"
-	},
 	.gsm_sms =3D {
-		{}, SMS_TYPE_SUBMIT,
+		{
+			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
+			.numbering_plan =3D SMS_NUMBERING_PLAN_ISDN,
+			.address =3D "112233445566778",
+		},
+		SMS_TYPE_SUBMIT,
 		{.submit =3D {
 			.mr =3D 0x00,
 			.daddr.address =3D "012345678",
@@ -8760,7 +8782,6 @@ static void test_send_sms(gconstpointer data)
 	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_NETWORK);
 =

 	check_alpha_id(command->send_sms.alpha_id, test->alpha_id);
-	check_address(&command->send_sms.address, &test->address);
 	check_gsm_sms(&command->send_sms.gsm_sms, &test->gsm_sms);
 	check_cdma_sms_tpdu(&command->send_sms.cdma_sms, &test->cdma_sms);
 	check_icon_id(&command->send_sms.icon_id, &test->icon_id);
-- =

1.7.1.86.g0e460.dirty


--===============7802135369585233180==--

