Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF9360EC9
	for <ofono@lists.linux.dev>; Wed,  2 Sep 2026 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336967; cv=none; b=gv7eIQcLFMypkAaXUkQA3fYe5aLRS/Cs97jDC5Riss0hlCkyCufYEjzZokpG5gQ66coN755/IN/7Nytz4/0P4s/bJnj+Q+c1Y+y2rTiFK8n8TR9zg8FC8hzyiUx3viGg2mw7SDWMckwBRug1cKkUvyboIdNt/8FZTpH2IrKnTTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336967; c=relaxed/simple;
	bh=0eK3hmTJsHUKwpzZVS8YcWKkmu7DZzZ8i6gmPOFs1tA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tkx5xU0w79k0zgbcqNC68LkrTUgAen73726MozXnKYv3vp0EVB2ps7mfs5EfnPFWUy63md06f93lcppdsXCgSFn1N4e2nN7R17CvUslqYFkYatLAqYJ5XUAS73AaHsfWunDEGCGlsRPPuuQEtMFX6PCUTFf9nMiculeHEJYiQko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me; spf=pass smtp.mailfrom=ik.me; dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b=Y+L3mYn0; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ik.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b="Y+L3mYn0"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hZbCD0mMXzjtj;
	Wed,  2 Sep 2026 10:15:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ik.me; s=20200325;
	t=1788336951; bh=+JBv/RWmaoysKtfcTqJEeOOxsCw4mRulYEqntS8MA80=;
	h=From:To:Cc:Subject:Date:From;
	b=Y+L3mYn0MJfxgyY5pdtAeu3wpxfRpzq+6/4/Fu6IW/oV6v8EjtK8H8axGi5I+/2nn
	 EJmwvMUgQOYNbt4d5AMOcg1rpGfhYGVTL9VSof5Oqf90rUa9E+KldscaTpayQWpZK3
	 jT0erNVSKgaTzqXh8FpUbRwdMHQRR8cDQYjGO8kA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hZbCC2jFWz4pm;
	Wed,  2 Sep 2026 10:15:51 +0200 (CEST)
From: Anthony Viallard <anthony.viallard@ik.me>
To: ofono@lists.linux.dev
Cc: Anthony Viallard <viallard@syscom-instruments.com>
Subject: [PATCH] simcom: enable +CMT URC acknowledgement with AT+CNMA=1
Date: Wed,  2 Sep 2026 10:15:43 +0200
Message-ID: <20260902081543.519293-1-anthony.viallard@ik.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: :d3398d4e1cbdfe3:ham:b522586e8275f92
X-Infomaniak-Routing: alpha

From: Anthony Viallard <viallard@syscom-instruments.com>

Allow SIMCOM modems to acknowledge +CMT URCs using AT+CNMA=1.

This was previously disabled for all SIMCOM modules because SIM900 does not
support AT+CNMA (see commit c2176381). However, this limitation appears to be
specific to the SIM900. The SIM7600 supports AT+CNMA, and the SIM5360 also
appears to support it.

Without sending the acknowledgement, the modem keeps the SMS stack waiting for
it, preventing SMS transmission. As a result, AT+CMGS returns
"+CMS ERROR: 343".
---
 drivers/atmodem/sms.c | 3 ++-
 plugins/sim900.c      | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 0668c631..33a846a3 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -451,7 +451,7 @@ static void at_cmt_notify(GAtResult *result, gpointer user_data)
 	decode_hex_own_buf(hexpdu, -1, &pdu_len, 0, pdu);
 	ofono_sms_deliver_notify(sms, pdu, pdu_len, tpdu_len);
 
-	if (data->vendor != OFONO_VENDOR_SIMCOM &&
+	if (data->vendor != OFONO_VENDOR_SIMCOM_SIM900 &&
 			data->vendor != OFONO_VENDOR_DROID)
 		at_ack_delivery(sms);
 	return;
@@ -984,6 +984,7 @@ static void at_cnmi_query_cb(gboolean ok, GAtResult *result, gpointer user_data)
 	case OFONO_VENDOR_HUAWEI:
 	case OFONO_VENDOR_NOVATEL:
 	case OFONO_VENDOR_OPTION_HSO:
+	case OFONO_VENDOR_SIMCOM_SIM900:
 		goto out;
 	default:
 		break;
diff --git a/plugins/sim900.c b/plugins/sim900.c
index 36c4c834..432ab900 100644
--- a/plugins/sim900.c
+++ b/plugins/sim900.c
@@ -68,7 +68,7 @@ static void mux_ready_notify(GAtResult *result, gpointer user_data)
 	struct ofono_gprs *gprs = NULL;
 	struct ofono_gprs_context *gc;
 
-	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
+	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM_SIM900, "atmodem",
 					data->dlcs[SMS_DLC]);
 
 	gprs = ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS_DLC]);
@@ -406,7 +406,7 @@ static void sim900_post_sim(struct ofono_modem *modem)
 	if (data->modem_type == SIM900) {
 		ofono_phonebook_create(modem, 0, "atmodem",
 						data->dlcs[VOICE_DLC]);
-		ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
+		ofono_sms_create(modem, OFONO_VENDOR_SIMCOM_SIM900, "atmodem",
 						data->dlcs[SMS_DLC]);
 
 		gprs = ofono_gprs_create(modem, 0, "atmodem",
-- 
2.53.0

