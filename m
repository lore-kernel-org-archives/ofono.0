Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8A4246356
	for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930226; cv=none; b=XY9xfmYSNM9Rs3cqabtbtFjR2yBF6HoQV4gTDlqmrTLoFdR3vvHmU7Z2lD3KsfytvyoJjYPf3eMH7N+bHnCdDfrYVGZ54Jy9zxbGyFxhl7/Swzr3PeFC4S7Zzc3nTApKvgU7p37jnQ85E5vGVmyH67NdlzBnCYaemtGcXzLWo1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930226; c=relaxed/simple;
	bh=hxDgDyW4EDBFNzu1SZjmH96bLCkyPyfz1qjCYv4XWHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YX9UB5GPQFeRSTm8hcqhRTRR1T50al5JQmeAc5FR02GACm81WASQUoghG9c3bu+kxggJ3X5G/J/MBi5lnnAUCQKInoT5tqZKkBV7AEmOzlUngod2gnmD4Nk0rQgDYeVFCjaT1oO4heSM2PC5U+xyUr8Dcn6Rkqc8DuV8P+oR6x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8V3BAg4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8V3BAg4"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so1561082a12.1
        for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 07:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733930223; x=1734535023; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1B+1SJ6jpp7A8lAf5W7I8QJvPkeTDkZlMmfs5hj4UkM=;
        b=h8V3BAg4owmEgr1egeadNEqqv+Z/eSMXjChS4KSbLL1ZMcTHrvBuXCQsq6H2jCT59a
         ktcsVqnNnCTW/wcJi0CAYmiZxAeoJ6L3oME5SM2e8Kt31m08BDn3qEYGuq78H3fVomix
         WM2ICc9lqXw9yrwihph8U62Nc32uv+d1Pm/av9w0oZCduw6+6wIVyH6KvG7npoXoA4nL
         7bW/KYCeSQQEbv2C3+R5w3Ni+fqObRWiKSSu2kHBVZiVxu6fVMo/VPK+4NcRz8S7nIlN
         OQi/2CdLPhsgyx3Es3I5Dk33VnLeWQbzhCTedR2gwDsgDccxjSPgSGgabpNSIS+uNydB
         85eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733930223; x=1734535023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1B+1SJ6jpp7A8lAf5W7I8QJvPkeTDkZlMmfs5hj4UkM=;
        b=ZNLGvrV7PghnaroeBpsLglepNbFHEdOYK91C7xeV5bwVMeL6rRCuhdBDJ0vjWpe9wn
         s63T2PsidTnEpIaNIAWikLrDPrm7LWP8V4/yAVMRw3ThuTohW+/CIRp5fCjQQKYu7sDR
         vbsp4chMgRXVjxjG6kAdPc9O2jXwkZ0Oimq9+H9r6LpjR5+M97xgpD0cWDsRG0XO1Fe7
         b+S49NaqjpB+AwOu3Bt+DR4b9PYtDMKTWA1XOdp4Xw8+bSdAyIIGK5nxXt2a26ser1Gz
         7/bEwaDhUrUJZiclvi7IswqsbjxTW33s52gdoYhnp4UR65k1XEwJQfHJLB4rPu726gVU
         ZPZg==
X-Gm-Message-State: AOJu0Yx7ZNKO4jbNlRE+yvGXNrlEOQYeaCmTW2ihspg+AYk8UTXmityW
	7Csv51nb/zEEy57W6lsH3pGhpPyJ6IWFqcEoszeipK8TISb+Lr9kYsvung==
X-Gm-Gg: ASbGncsuUL86AzmLUWQrkz7PXlYFwpgxsSOtGzmmBTS+DKEa/evhnWp/7eVmUJIqSnV
	zvr1ldNAtzVAFlfijxipRX00SntDIvRGgsdkK2roX5lAadx6diP5hhF1GxiAteGhHUUpSKNxkq0
	wzBJPbM5qwM3cvDCMbXCGn9mRqJ/cPRJ0i/dJGJxrOTyFzQmib7LlFFDukmYajl18YEw17CEjAF
	OY9oMut1DxCW3M8K9NDRFu6wtqc9hbfvyYGzTC7gwjfhvr5PE0SL3KEdWji31vdItxSewXADSY+
X-Google-Smtp-Source: AGHT+IGmWa9Ac0Tn5U6sYd5jHHs90wB0X4mcCVusH50/GBisQbzGABw/3u9mbtqkbjiSdKzbA0FHRQ==
X-Received: by 2002:a17:907:9518:b0:aa6:6ee6:1b83 with SMTP id a640c23a62f3a-aa6b16d6d39mr303169366b.20.1733930222703;
        Wed, 11 Dec 2024 07:17:02 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa692846ac8sm412771766b.168.2024.12.11.07.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:17:02 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v2] qmi: radio-settings: Do not unconditionally try to enable unsupported modes
Date: Wed, 11 Dec 2024 17:16:33 +0200
Message-Id: <20241211151633.495534-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <acedcbad-dd01-4423-9fb7-3c90081ca5a7@gmail.com>
References: <acedcbad-dd01-4423-9fb7-3c90081ca5a7@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At least the modem in Motorola Droid 4 errors out if anything else but GSM
and UMTS bits are set when selecting preferred mode. That happens if 'any'
mode is set.

Fix that by querying supported modes and passing only those for 'any' mode.
---
 drivers/qmimodem/radio-settings.c | 111 +++++++++++++++++++++---------
 1 file changed, 77 insertions(+), 34 deletions(-)

diff --git a/drivers/qmimodem/radio-settings.c b/drivers/qmimodem/radio-settings.c
index cf0b747e..0a1d5622 100644
--- a/drivers/qmimodem/radio-settings.c
+++ b/drivers/qmimodem/radio-settings.c
@@ -21,6 +21,7 @@
 struct settings_data {
 	struct qmi_service *nas;
 	struct qmi_service *dms;
+	unsigned int rat_mode_any;
 };
 
 static void get_system_selection_pref_cb(struct qmi_result *result,
@@ -98,27 +99,22 @@ static void qmi_set_rat_mode(struct ofono_radio_settings *rs, unsigned int mode,
 {
 	struct settings_data *data = ofono_radio_settings_get_data(rs);
 	struct cb_data *cbd = cb_data_new(cb, user_data);
-	uint16_t pref = QMI_NAS_RAT_MODE_PREF_ANY;
+	uint16_t pref = 0;
 	struct qmi_param *param;
 
 	DBG("");
 
-	switch (mode) {
-	case OFONO_RADIO_ACCESS_MODE_ANY:
-		pref = QMI_NAS_RAT_MODE_PREF_ANY;
-		break;
-	case OFONO_RADIO_ACCESS_MODE_GSM:
-		pref = QMI_NAS_RAT_MODE_PREF_GSM;
-		break;
-	case OFONO_RADIO_ACCESS_MODE_UMTS:
-		pref = QMI_NAS_RAT_MODE_PREF_UMTS;
-		break;
-	case OFONO_RADIO_ACCESS_MODE_LTE:
-		pref = QMI_NAS_RAT_MODE_PREF_LTE;
-		break;
-	case OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_GSM:
-		pref = QMI_NAS_RAT_MODE_PREF_LTE|QMI_NAS_RAT_MODE_PREF_GSM;
-		break;
+	if (mode == OFONO_RADIO_ACCESS_MODE_ANY)
+		pref = data->rat_mode_any;
+	else {
+		if (mode & OFONO_RADIO_ACCESS_MODE_GSM)
+			pref |= QMI_NAS_RAT_MODE_PREF_GSM;
+
+		if (mode & OFONO_RADIO_ACCESS_MODE_UMTS)
+			pref |= QMI_NAS_RAT_MODE_PREF_UMTS;
+
+		if (mode & OFONO_RADIO_ACCESS_MODE_LTE)
+			pref |= QMI_NAS_RAT_MODE_PREF_LTE;
 	}
 
 	param = qmi_param_new();
@@ -136,40 +132,53 @@ static void qmi_set_rat_mode(struct ofono_radio_settings *rs, unsigned int mode,
 	l_free(cbd);
 }
 
-static void get_caps_cb(struct qmi_result *result, void *user_data)
+static unsigned int _update_available_rats(struct settings_data *rsd,
+					const struct qmi_dms_device_caps *caps)
 {
-	struct cb_data *cbd = user_data;
-	ofono_radio_settings_available_rats_query_cb_t cb = cbd->cb;
-	const struct qmi_dms_device_caps *caps;
-	unsigned int available_rats;
-	uint16_t len;
+	unsigned int available_rats = 0;
 	uint8_t i;
 
-	DBG("");
-
-	if (qmi_result_set_error(result, NULL))
-		goto error;
+	rsd->rat_mode_any = 0;
 
-	caps = qmi_result_get(result, QMI_DMS_RESULT_DEVICE_CAPS, &len);
-	if (!caps)
-		goto error;
-
-	available_rats = 0;
 	for (i = 0; i < caps->radio_if_count; i++) {
 		switch (caps->radio_if[i]) {
 		case QMI_DMS_RADIO_IF_GSM:
 			available_rats |= OFONO_RADIO_ACCESS_MODE_GSM;
+			rsd->rat_mode_any |= QMI_NAS_RAT_MODE_PREF_GSM;
 			break;
 		case QMI_DMS_RADIO_IF_UMTS:
+			rsd->rat_mode_any |= QMI_NAS_RAT_MODE_PREF_UMTS;
 			available_rats |= OFONO_RADIO_ACCESS_MODE_UMTS;
 			break;
 		case QMI_DMS_RADIO_IF_LTE:
 			available_rats |= OFONO_RADIO_ACCESS_MODE_LTE;
+			rsd->rat_mode_any |= QMI_NAS_RAT_MODE_PREF_LTE;
 			break;
 		}
 	}
 
-	CALLBACK_WITH_SUCCESS(cb, available_rats, cbd->data);
+	return available_rats;
+}
+
+static void get_caps_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+	struct ofono_radio_settings *rs = cbd->user;
+	struct settings_data *rsd = ofono_radio_settings_get_data(rs);
+	ofono_radio_settings_available_rats_query_cb_t cb = cbd->cb;
+	const struct qmi_dms_device_caps *caps;
+	uint16_t len;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL))
+		goto error;
+
+	caps = qmi_result_get(result, QMI_DMS_RESULT_DEVICE_CAPS, &len);
+	if (!caps)
+		goto error;
+
+	CALLBACK_WITH_SUCCESS(cb, _update_available_rats(rsd, caps), cbd->data);
 
 	return;
 
@@ -187,6 +196,8 @@ static void qmi_query_available_rats(struct ofono_radio_settings *rs,
 	if (!rsd->dms)
 		goto error;
 
+	cbd->user = rs;
+
 	if (qmi_service_send(rsd->dms, QMI_DMS_GET_CAPS, NULL,
 					get_caps_cb, cbd, l_free) > 0)
 		return;
@@ -196,6 +207,32 @@ error:
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 
+static void get_rat_mode_any_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_radio_settings *rs = user_data;
+	struct settings_data *rsd = ofono_radio_settings_get_data(rs);
+	const struct qmi_dms_device_caps *caps;
+	uint16_t len;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL))
+		goto error;
+
+	caps = qmi_result_get(result, QMI_DMS_RESULT_DEVICE_CAPS, &len);
+	if (!caps)
+		goto error;
+
+	_update_available_rats(rsd, caps);
+	ofono_radio_settings_register(rs);
+
+	return;
+
+error:
+	ofono_error("Failed to get RAT modes");
+	ofono_radio_settings_remove(rs);
+}
+
 static int qmi_radio_settings_probev(struct ofono_radio_settings *rs,
 					unsigned int vendor, va_list args)
 {
@@ -205,6 +242,13 @@ static int qmi_radio_settings_probev(struct ofono_radio_settings *rs,
 
 	DBG("");
 
+	if (!qmi_service_send(dms, QMI_DMS_GET_CAPS, NULL,
+					get_rat_mode_any_cb, rs, NULL)) {
+		qmi_service_free(dms);
+		qmi_service_free(nas);
+		return -EIO;
+	}
+
 	data = l_new(struct settings_data, 1);
 	data->dms = dms;
 	data->nas = nas;
@@ -229,7 +273,6 @@ static void qmi_radio_settings_remove(struct ofono_radio_settings *rs)
 }
 
 static const struct ofono_radio_settings_driver driver = {
-	.flags		= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probev		= qmi_radio_settings_probev,
 	.remove		= qmi_radio_settings_remove,
 	.set_rat_mode	= qmi_set_rat_mode,
-- 
2.25.1

