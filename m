Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01770217648
	for <ofono@lists.linux.dev>; Thu, 16 Apr 2026 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345418; cv=none; b=DXEqvCXasexpKkK4LAyab5sr0/3cykzfbGaySBj4YySPDB1bbHkiDlGgYnrAxjkCeBMQrJYx+TxeCJRgIy3bm3ly7/hwLr/UuDqaVCrLSPBQ7tL6T9N1eWVQMUrUQKYJ4ow3dnpHPtWxcPbTuMRsBBsZY5gPNVR5s6O2JxFxDTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345418; c=relaxed/simple;
	bh=99DI5te2Y392E3jpO84D7UBy3QOAaHV7eC9I3Zsu/6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYh0OfaM0fMEo2f/0mRlhQDJZnn30eLyjt1mxVPi1/Xb80H75WB2k5tlNtnu9rPTbp9zWx3GF/+QLhrBsEfJ2zak6cVMRGqwOiymqHr4CrTHr0QJ/GQI5/t2tTR8TZZ9ulD3+AaUODwH9FseLWj5ehrIdMKSxHsamuib9lB+aQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=d85AlF8N; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="d85AlF8N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1776345412; x=1776604612;
	bh=WMvbliPEnIGPmdaRV3j4Vk/f2KVmYCnD8KhP4R41wZE=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=d85AlF8N6DThHJbmNv1ZJ3TbjSs4mXETDTSM2/D0hUdrPBBeVrIlUFkTy8X0S231+
	 JvvWmzw5LwoECoXUI+MizJ83sKqNe+u5GpkWnMp87pfTyQX4PkacJtW2WvmdlU8W0V
	 XWAtUWlAzU8UgsDYFVRrT6BGDQql/PYyFRvEEa980QcEVNUSSari5nwiGmOY1s1Y6g
	 yxdR66+a8swFj1zeMpJwhum5ec5DWa4dmWbLao/20uLkVDj1RCwoBr5hamyhEzDhXo
	 g72hRvmhCUODdDmcSPswxH3A3yMwretxSVHs/7hqg+KuLIhamwzyG0KQn3Tvp1wSTD
	 Y+CHDxm6kVgfg==
X-Pm-Submission-Id: 4fxJSg4tf8z2ScmP
From: Sean Nyekjaer <sean@geanix.com>
To: denkenz@gmail.com,
	ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 1/2] sim7100: Add support for A7671 and A7672 models
Date: Thu, 16 Apr 2026 15:16:47 +0200
Message-ID: <20260416131649.2151345-1-sean@geanix.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the generic A76XX model handling with explicit detection of
A7671 and A7672 variants. Update model parsing and switch statements
accordingly.

Restrict PPP reset (AT+PPPTIM) handling to A7672, where it is supported.
---
 plugins/sim7100.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index c4fc5798..4148e0b2 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -51,7 +51,9 @@ static const char *cfun_prefix[] = { "+CFUN:", NULL };
 
 enum sim7x00_model {
 	SIMCOM_UNKNOWN = 0,
-	SIMCOM_A76XX,
+	SIMCOM_A7671,
+	SIMCOM_A7672,
+
 };
 
 struct sim7100_data {
@@ -144,7 +146,7 @@ static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_data)
 	if (!ok)
 		return;
 
-	if (data->model == SIMCOM_A76XX)
+	if (data->model == SIMCOM_A7672)
 		/* does the modem support reset of PPP state upon AT+CFUN=0? */
 		g_at_chat_send(data->at, "AT+PPPTIM?", NULL, ppptim_support_cb,
 			       modem, NULL);
@@ -174,14 +176,17 @@ static void cgmm_cb(gboolean ok, GAtResult *result, gpointer user_data)
 
 		DBG("modem model: %s", model);
 
-		if (g_str_has_prefix(model, "A76"))
-			data->model = SIMCOM_A76XX;
+		if (g_str_has_prefix(model, "A7671"))
+			data->model = SIMCOM_A7671;
+		else if (g_str_has_prefix(model, "A7672"))
+			data->model = SIMCOM_A7672;
 
 		break;
 	}
 
 	switch (data->model) {
-	case SIMCOM_A76XX:
+	case SIMCOM_A7671:
+	case SIMCOM_A7672:
 		/* ignore NO CARRIER on the AT channel when disconnecting PPP */
 		g_at_chat_blacklist_terminator(data->at,
 					G_AT_CHAT_TERMINATOR_NO_CARRIER);
@@ -318,7 +323,8 @@ static void sim7100_pre_sim(struct ofono_modem *modem)
 	ofono_devinfo_create(modem, 0, "atmodem", data->at);
 
 	switch (data->model) {
-	case SIMCOM_A76XX:
+	case SIMCOM_A7671:
+	case SIMCOM_A7672:
 		sim = ofono_sim_create(modem, OFONO_VENDOR_SIMCOM_A76XX,
 							"atmodem", data->at);
 		ofono_voicecall_create(modem, 0, "atmodem", data->at);
@@ -351,7 +357,8 @@ static void sim7100_post_sim(struct ofono_modem *modem)
 	ofono_phonebook_create(modem, 0, "atmodem", data->at);
 
 	switch (data->model) {
-	case SIMCOM_A76XX:
+	case SIMCOM_A7671:
+	case SIMCOM_A7672:
 		ofono_netreg_create(modem, OFONO_VENDOR_SIMCOM_A76XX,
 							"atmodem", data->at);
 		ofono_sms_create(modem, OFONO_VENDOR_SIMCOM_A76XX,
-- 
2.52.0

