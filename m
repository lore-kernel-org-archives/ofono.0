Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A871635B5
	for <ofono@lists.linux.dev>; Wed,  1 May 2024 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596709; cv=none; b=X6uQI9kKsWdP0wx5VIUBXPAjhUuzJeJ3ppvKPFFeNrJZwb3R1VGdsyP+qEDDGWL6EAKtczwpHJxfSgQFIJcQZWVZgCihnXcQD7+MCPS4snfVsFVZl5HQZG1Hm8cJwkJjb6/ud0dSIhQcitUUUt1cRGIwZJ/Cay5rp5qRzfs50FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596709; c=relaxed/simple;
	bh=T2uNYmn5yh7pCiWwKBH3OJrP0krP9UlMCXfsmOxYdYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LG1hKaRcyO8dEvftmcyCDu5eu1SRZU4EUq55LJ4CZuRSaGUk//V4zOKvD8VUl/Y6bueh1RY0viAEyLxtYyoy6GOsa0bE7crYuJhZTKh4DsJV0TWQLbXOSeyDZD3Hy3Bewe0QHH5pwbcPcEqJF7lYQRY5l8JMiw7kVizH++FjK8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7NnwE3V; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7NnwE3V"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-23d1c4c14ceso1134523fac.0
        for <ofono@lists.linux.dev>; Wed, 01 May 2024 13:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714596706; x=1715201506; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SshdI/Es0zzeCfaeppsP7uyYv8BqbEBkzHfg9iP7FVA=;
        b=i7NnwE3VTMGXNDDp2zWRlm7awkSQH/MIujCnJj5GnNgKFz3nUd49RKruHsbX4r5H5T
         XWvDlNCer8ehpS2TY4hd3fJloNas15o3fxbfYIkyRqh0nXJyPpWHJn6DzeULKqbeUnuu
         RtyOr+pDSURXfVxKFNI+VFwqMFtM96bCY6xZqo3FH2qFDF+7cBS7BrnqtFsG5d1qjLAy
         BLRiqFACmygL67TkORCYMGchp4JzwAYHypJMJ4nB4sJ8VTRPMArvHGkNN/NLHpgIa4Ep
         ZdCdArpDrEhdoUJBPZbvIhLgx9q2vzSCwHfUFyUDZC2IAKij534GpOjuJBLwMqiW9A3y
         oeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596706; x=1715201506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SshdI/Es0zzeCfaeppsP7uyYv8BqbEBkzHfg9iP7FVA=;
        b=N6C6XKS/kdqSV4JS5coLg9Itpi0byQCge7ZLaSAZBY4VL2g0/e/gwkiN661Rdi3zjY
         upyR+EQYyOCRJ+rPZrU2Wrd7OqJJ1HsRpE+sIRNAcBs971N1k2jUjzIpn0UIatwfriS+
         QWE+l87afuOpYX/YPaqzDOsI7k3scv5+NutlsQUPNUsPDwOc/PDABVzAFoiLdc9c1JGv
         4t4x4IXyUn2NKM3zvenazIM6gZhfd/SS+f3vxp+hPhEHnaBYYgVbx++Q1Zi61leJo95E
         yrFkoxXbdO34rbmBDE2zg0YxoFKmQKG5GG40/lR0uO3NT+2ka0ba9SRFtONKAQBDTd5F
         /rsA==
X-Gm-Message-State: AOJu0YxKcYqccYnT1EckGCyeDWnPl39cv9egYk2W6AIdmvYwlI4dWBcl
	NiSC1uStuouq35xxbamUg+7dsdNYn3Lp6CRH0p1acylMyTBl4EGuvvo25w==
X-Google-Smtp-Source: AGHT+IHIHgEk6XuXYNYsZsGXl2Vme3IptcCIMOgTOqpnm0awR/Mgm2LmGTRXKenK8ad5qK3uSr9YvA==
X-Received: by 2002:a05:6870:e40b:b0:23c:659b:fb3c with SMTP id n11-20020a056870e40b00b0023c659bfb3cmr4163481oag.19.1714596706726;
        Wed, 01 May 2024 13:51:46 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id or3-20020a0568715c0300b00234bc052521sm5883658oac.10.2024.05.01.13.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:51:46 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/6] qmi: gprs: register and listen to event reports
Date: Wed,  1 May 2024 15:51:24 -0500
Message-ID: <20240501205142.12777-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501205142.12777-1-denkenz@gmail.com>
References: <20240501205142.12777-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is mostly useful to obtain inter and intra RAT changes, data bearer
changes, data transfer statistics, etc.
---
 drivers/qmimodem/gprs.c | 88 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 9 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 0122998a090e..aac28db387bb 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -184,6 +184,13 @@ static void ss_info_notify(struct qmi_result *result, void *user_data)
 		ofono_gprs_status_notify(gprs, status);
 }
 
+static void event_report_notify(struct qmi_result *result, void *user_data)
+{
+	DBG("");
+
+	qmi_result_print_tlvs(result);
+}
+
 static void attach_detach_cb(struct qmi_result *result, void *user_data)
 {
 	struct cb_data *cbd = user_data;
@@ -275,6 +282,74 @@ static void qmi_attached_status(struct ofono_gprs *gprs,
 	l_free(cbd);
 }
 
+static void set_event_report_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_gprs *gprs = user_data;
+	struct gprs_data *data = ofono_gprs_get_data(gprs);
+	uint16_t error;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error)) {
+		ofono_error("Get default profile error: %hd", error);
+		goto error;
+	}
+
+	/*
+	 * First get the SS info - the modem may already be connected,
+	 * and the state-change notification may never arrive
+	 */
+	qmi_service_send(data->nas, QMI_NAS_GET_SERVING_SYSTEM, NULL,
+					ss_info_notify, gprs, NULL);
+
+	ofono_gprs_register(gprs);
+	return;
+error:
+	ofono_gprs_remove(gprs);
+}
+
+static int set_event_report_request(struct ofono_gprs *gprs)
+{
+	static const uint8_t PARAM_CHANNEL_RATE = 0x10;
+	static const uint8_t PARAM_TRANSFER_STATISTICS = 0x11;
+	static const uint8_t PARAM_DATA_BEARER_TECHNOLOGY = 0x12;
+	static const uint8_t PARAM_DORMANCY_STATUS = 0x13;
+	static const uint8_t PARAM_CURRENT_DATA_BEARER_TECHNOLOGY = 0x15;
+	static const uint8_t PARAM_PREFERRED_DATA_SYSTEM = 0x18;
+	static const uint8_t PARAM_DATA_SYSTEM_STATUS = 0x1A;
+	static const uint8_t PARAM_LIMITED_DATA_SYSTEM_STATUS = 0x1C;
+	static const uint8_t PARAM_PDN_FILTER_REMOVALS = 0x1D;
+	static const uint8_t PARAM_DATA_BEARER_TECHNOLOGY_EXTENDED = 0x1E;
+
+	struct gprs_data *data = ofono_gprs_get_data(gprs);
+	struct {
+		uint8_t interval;
+		uint32_t indicators;
+	} __attribute((packed)) ts = {
+		.interval = 5,
+		.indicators = ~0, /* register for everything */
+	};
+	struct qmi_param *param = qmi_param_new();
+
+	qmi_param_append_uint8(param, PARAM_CHANNEL_RATE, 1);
+	qmi_param_append(param, PARAM_TRANSFER_STATISTICS, sizeof(ts), &ts);
+	qmi_param_append_uint8(param, PARAM_DATA_BEARER_TECHNOLOGY, 1);
+	qmi_param_append_uint8(param, PARAM_DORMANCY_STATUS, 1);
+	qmi_param_append_uint8(param, PARAM_CURRENT_DATA_BEARER_TECHNOLOGY, 1);
+	qmi_param_append_uint8(param, PARAM_PREFERRED_DATA_SYSTEM, 1);
+	qmi_param_append_uint8(param, PARAM_DATA_SYSTEM_STATUS, 1);
+	qmi_param_append_uint8(param, PARAM_LIMITED_DATA_SYSTEM_STATUS, 1);
+	qmi_param_append_uint8(param, PARAM_PDN_FILTER_REMOVALS, 1);
+	qmi_param_append_uint8(param, PARAM_DATA_BEARER_TECHNOLOGY_EXTENDED, 1);
+
+	if (qmi_service_send(data->wds, QMI_WDS_EVENT_REPORT,
+				param, set_event_report_cb, gprs, NULL) > 0)
+		return 0;
+
+	qmi_param_free(param);
+	return -EIO;
+}
+
 static void get_default_profile_number_cb(struct qmi_result *result,
 								void *user_data)
 {
@@ -300,15 +375,8 @@ static void get_default_profile_number_cb(struct qmi_result *result,
 	data->default_profile = index;
 	ofono_gprs_set_cid_range(gprs, index, index);
 
-	/*
-	 * First get the SS info - the modem may already be connected,
-	 * and the state-change notification may never arrive
-	 */
-	qmi_service_send(data->nas, QMI_NAS_GET_SERVING_SYSTEM, NULL,
-					ss_info_notify, gprs, NULL);
-
-	ofono_gprs_register(gprs);
-	return;
+	if (set_event_report_request(gprs) >= 0)
+		return;
 error:
 	ofono_gprs_remove(gprs);
 }
@@ -353,6 +421,8 @@ static void create_wds_cb(struct qmi_service *service, void *user_data)
 	}
 
 	data->wds = service;
+	qmi_service_register(data->wds, QMI_WDS_EVENT_REPORT,
+				event_report_notify, gprs, NULL);
 
 	if (get_default_profile_number_request(gprs) >= 0)
 		return;
-- 
2.44.0

