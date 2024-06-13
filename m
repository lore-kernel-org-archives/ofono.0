Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB401494BC
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314910; cv=none; b=RazhmlGYSQmtSb7FpGPEDQ6qmdvFOB1TTIipttD3vJ/t83e61TF1wLSR3PPlX0usefv4pfk1p4hjY8kPHPmO7c+h5WIr46iXqQ5w96TlPcD2qPyiiUxe13vBPZFSHnyP8fiTLX9CpCDDpfGEEr9Uv3H6ykJu9ysdRc29T/zPpAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314910; c=relaxed/simple;
	bh=c27u9gd96zTJsRU93FRYvSz0q/ey+JRPWh2N89SS8g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9NzFrpfyJTRY8kh+EUWArmDFjQuCX+Ax4ZwpYuAiHDyekA6NGMfWJJgq3YVhOo7tygQHfqpZoKQYP8cTHmIo91zNnzvyKvGLXjHFK8EhzfpsazRl/D+HchC/d5fo2hswvYVNTpzT8+msbd6Kw1eDBU7Q7F+7RwF9kDSIRxejmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzGJssGx; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzGJssGx"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f8edde24b3so879302a34.2
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314908; x=1718919708; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6UH8GaMDRcfJBcwdkJWRkoS3tpfxDmSHlfCgha2m4A=;
        b=DzGJssGx+ZOg3lZ4ymgPtJmmL10wmJWOMh1AahpJseSUp5CP+C0zOR00gsdCCopvvz
         ESPRBgoM2e6ZOfGTyPxmr7B/pWtEI58tuv0Y9natesYVgKYxh36iv/w1UOlaPO2X9xTB
         HVnoNCm1UEyeov2D96r5C62GaQxX6DA0wBMijllK8BXjxWHOeQotn3tR+SHDQf/4lIYb
         nt/TSKItK+NmDdtNIXtJR5SgGF7u05wHCcV14X2OoJhVXw4FSbVgNlfjnNhqHrlIVDxP
         fXrA7y2rEk9by1l3Ig0JIuSsTWgkNlYFqVZeAHidvivXF8QGrQ5ykqypDNi97TXRwiMG
         TSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314908; x=1718919708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6UH8GaMDRcfJBcwdkJWRkoS3tpfxDmSHlfCgha2m4A=;
        b=ujC8FFRAvqGTb9NfDKA+KyZa5eRcLj0UWxr2jsrSY2Kyrwxjw1Fn3b3gnnOGdrV/kw
         2QuNvsB2qHCHLcRM1NOgm28uBo1lp9STfK2hw6yqP/OJhLKrM1ZSWRDy9BHY7IuuE3AT
         Oi2PS7WCAOAWKvmxZL2+zNA4HGOZ10juxzJjTh0hiBN8XbuGSVbmIiFHEhULwN4CzasY
         iGMwjAqps90kcSNhUrdVNJBVoX7rYovEe333VNHQSK92Uk2AqzY7SRpN8BLmhTP98S2k
         CCkRUiTc1kLIx/w0TRZuwu9JGnJ/4NOY2NTzoJY7p0ANNEKX/nbBW/H+n0TDl9nzxDPq
         v1aA==
X-Gm-Message-State: AOJu0Yx8ak//mNzb2/zuNSm1+o8bE+pBU2G6DAR6NzpSHKdQXTVzoTCb
	hQrbinDIjFVRdT/j2s8j6WxLZKPCW3qM1Uvd7aJqZk03UPLuKpufLZQsWw==
X-Google-Smtp-Source: AGHT+IGHhzjIxIPbCIc1eLC/QdPN8BqfoBtf5+Ne5Um8hh9akSe1SoLVsjoWUtto0tkxXFRaSODLgQ==
X-Received: by 2002:a05:6870:3282:b0:256:d14c:6858 with SMTP id 586e51a60fabf-2584289476dmr889597fac.10.1718314908177;
        Thu, 13 Jun 2024 14:41:48 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:47 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 17/23] qmi: netreg: Drop use of qmi_service_create_shared
Date: Thu, 13 Jun 2024 16:41:26 -0500
Message-ID: <20240613214134.1056517-17-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240613214134.1056517-1-denkenz@gmail.com>
References: <20240613214134.1056517-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While here, drop all indication registration id members.  Explicitly
unregistering from an indication is not required.  All indication
registrations will be automatically dropped when the service handle
is freed using qmi_service_free()
---
 drivers/qmimodem/network-registration.c | 86 +++++--------------------
 plugins/gobi.c                          |  3 +-
 2 files changed, 17 insertions(+), 72 deletions(-)

diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/network-registration.c
index 78957a677d2d..c0c9338d1c23 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -31,10 +31,6 @@ struct netreg_data {
 	int lac;
 	int cellid;
 	bool is_roaming;
-	uint16_t event_indication_id;
-	uint16_t signal_info_indication_id;
-	uint16_t system_info_indication_id;
-	uint16_t serving_system_indication_id;
 };
 
 enum roaming_status {
@@ -587,23 +583,16 @@ static void register_indications_cb(struct qmi_result *result,
 
 	ofono_netreg_register(netreg);
 
-	data->event_indication_id =
-		qmi_service_register(data->nas, QMI_NAS_EVENT_REPORT,
+	qmi_service_register(data->nas, QMI_NAS_EVENT_REPORT,
 					event_notify, netreg, NULL);
 
-	data->serving_system_indication_id =
-		qmi_service_register(data->nas,
-					QMI_NAS_SERVING_SYSTEM_INDICATION,
+	qmi_service_register(data->nas, QMI_NAS_SERVING_SYSTEM_INDICATION,
 					ss_info_notify, netreg, NULL);
 
-	data->system_info_indication_id =
-		qmi_service_register(data->nas,
-					QMI_NAS_SYSTEM_INFO_INDICATION,
+	qmi_service_register(data->nas, QMI_NAS_SYSTEM_INFO_INDICATION,
 					system_info_notify, netreg, NULL);
 
-	data->signal_info_indication_id =
-		qmi_service_register(data->nas,
-					QMI_NAS_SIGNAL_INFO_INDICATION,
+	qmi_service_register(data->nas, QMI_NAS_SIGNAL_INFO_INDICATION,
 					signal_info_notify, netreg, NULL);
 }
 
@@ -636,10 +625,10 @@ error:
 	ofono_netreg_remove(netreg);
 }
 
-static void create_nas_cb(struct qmi_service *service, void *user_data)
+static int qmi_netreg_probe(struct ofono_netreg *netreg,
+				unsigned int vendor, void *user_data)
 {
-	struct ofono_netreg *netreg = user_data;
-	struct netreg_data *data = ofono_netreg_get_data(netreg);
+	struct qmi_service *nas = user_data;
 	struct qmi_param *param;
 	static const uint8_t PARAM_REPORT_SIGNAL_STRENGTH = 0x10;
 	static const uint8_t PARAM_REPORT_RF_INFO = 0x11;
@@ -650,46 +639,28 @@ static void create_nas_cb(struct qmi_service *service, void *user_data)
 	} __attribute__((__packed__)) ss = { .report = 0x01,
 			.count = 5, .dbm[0] = -55, .dbm[1] = -65,
 			.dbm[2] = -75, .dbm[3] = -85, .dbm[4] = -95 };
+	struct netreg_data *data;
 
 	DBG("");
 
-	if (!service) {
-		ofono_error("Failed to request NAS service");
-		goto error;
-	}
-
-	data->nas = service;
-
 	param = qmi_param_new();
-
 	qmi_param_append(param, PARAM_REPORT_SIGNAL_STRENGTH, sizeof(ss), &ss);
 	qmi_param_append_uint8(param, PARAM_REPORT_RF_INFO, 0x01);
 
-	if (qmi_service_send(data->nas, QMI_NAS_SET_EVENT_REPORT, param,
-					set_event_report_cb, netreg, NULL) > 0)
-		return;
-
-	qmi_param_free(param);
-error:
-	ofono_netreg_remove(netreg);
-}
-
-static int qmi_netreg_probe(struct ofono_netreg *netreg,
-				unsigned int vendor, void *user_data)
-{
-	struct qmi_device *device = user_data;
-	struct netreg_data *data;
-
-	DBG("");
+	if (!qmi_service_send(nas, QMI_NAS_SET_EVENT_REPORT, param,
+					set_event_report_cb, netreg, NULL)) {
+		qmi_param_free(param);
+		qmi_service_free(nas);
+		return -EIO;
+	}
 
 	data = l_new(struct netreg_data, 1);
-
+	data->nas = nas;
 	data->operator.name[0] = '\0';
 	data->operator.mcc[0] = '\0';
 	data->operator.mnc[0] = '\0';
 	data->operator.status = -1;
 	data->operator.tech = -1;
-
 	data->current_rat = QMI_NAS_NETWORK_RAT_NO_CHANGE;
 	data->is_roaming = false;
 	data->lac = -1;
@@ -697,9 +668,6 @@ static int qmi_netreg_probe(struct ofono_netreg *netreg,
 
 	ofono_netreg_set_data(netreg, data);
 
-	qmi_service_create_shared(device, QMI_SERVICE_NAS,
-					create_nas_cb, netreg, NULL);
-
 	return 0;
 }
 
@@ -711,31 +679,7 @@ static void qmi_netreg_remove(struct ofono_netreg *netreg)
 
 	ofono_netreg_set_data(netreg, NULL);
 
-	if (data->event_indication_id) {
-		qmi_service_unregister(data->nas, data->event_indication_id);
-		data->event_indication_id = 0;
-	}
-
-	if (data->serving_system_indication_id) {
-		qmi_service_unregister(data->nas,
-					data->serving_system_indication_id);
-		data->serving_system_indication_id = 0;
-	}
-
-	if (data->system_info_indication_id) {
-		qmi_service_unregister(data->nas,
-					data->system_info_indication_id);
-		data->system_info_indication_id = 0;
-	}
-
-	if (data->signal_info_indication_id) {
-		qmi_service_unregister(data->nas,
-					data->signal_info_indication_id);
-		data->signal_info_indication_id = 0;
-	}
-
 	qmi_service_free(data->nas);
-
 	l_free(data);
 }
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index da27930c1e94..34aa363cf82e 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -829,7 +829,8 @@ static void gobi_post_online(struct ofono_modem *modem)
 	DBG("%p", modem);
 
 	if (data->features & GOBI_NAS) {
-		ofono_netreg_create(modem, 0, "qmimodem", data->device);
+		ofono_netreg_create(modem, 0, "qmimodem",
+						qmi_service_clone(data->nas));
 		ofono_netmon_create(modem, 0, "qmimodem", data->device);
 	}
 
-- 
2.45.0

