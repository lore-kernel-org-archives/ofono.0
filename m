Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45D2155739
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800485; cv=none; b=IBuc9Khmzx2NPuk1AwF/WfZ6u5OOy4NNLdIO0n760oVLnc+9q9HvszlvQmAvezwwjPT9uHL/y/F/Zh9m0N7qXQwc00oqKhfe+NxA9ptQAanNra2v/ZTf/9I16wn+p375haFWQkOiGpyMkli+kaFwDtBh29Z5rtlPzQiyms3YGqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800485; c=relaxed/simple;
	bh=Ag4Dr3TRKxyCd0YUF1cbsz5x4LzgSplw+sy8TzzxOuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQ7iNwwBa8j+YeIgBkl/JK9Gemmnfxl8rR5cZpFO1yVwyKskOlJWQ/Ir/0UOud0j3Xkdz4C6e2RfqbRNI0jgpBhDzqXJIuBmvDUqbqNsjsVJqUsp1lERUxIU+MzldMOTB1nLlQCbzVTZ/ydQ1S0FvY0hkAdxX7lWnW7N9XLqQXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMuSOadb; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMuSOadb"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ba1f60eb96so1411789eaf.3
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800483; x=1718405283; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nm/h3HBvKrpECxnwWyPq33GZzL3flx+/+BpmZcecDTo=;
        b=RMuSOadbcEvI01D81AkWSEGZhAQiWimgpQgiKj3dC2nUO71VL54viDacB8SI6qsD6H
         xhbNc9Ya9JNMIXKgTYi+0zQ+u0dZvE/6SM9PPYiWBenzsTV7OPaoUwE3ieyGZcUCzvFN
         EZ8TW1Xjf6EGNFHIXkbIZmSiqhiFl6PmcIoa5oi63caL0xYBy5XePuNoUcENM9Opma35
         /jL1mhUUSvXxBcxFj1AHEkxDhXYtF8oEUNBPIZShY0E3aN+/f0d/u50eVfLIwZcAQWu3
         WnplGuPgvnn22E8l9CMBV8eiZF1UB0FmfbSaBwSK/nTYqsLJzu8msMIFJDMuHmHTZkKP
         pjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800483; x=1718405283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nm/h3HBvKrpECxnwWyPq33GZzL3flx+/+BpmZcecDTo=;
        b=FfwLVe/Ypzr20OH2DrwfP5T8QqpAp0lQBhLM98IZL/8Hzmy+ZhmDgIaW+3l1BBbc7p
         mT4y2pwDi9ICB3qtpBHKhHDkM3jVke764ZBFrUxEfE2IGXTch7zEbjIdbCrSxclWFhOJ
         popWfiiktCoPVD6FQMqpSv1vjr1iAhkrALvgciIkfpQko9kUFUfVzgvWM2jtGbXiq0tl
         H84GkCtEhELToUO9QS/3ru/02/DqqQ+sEH01N7B/nQOnXEM8XBv4nJgo5I+tGcZY7cdm
         +6AzMMh12LYeCoTGux9PB78EGw+wHex/YAxzCH2PN9xNqO9szrfYSmEXECH1uftlp/yL
         H2fQ==
X-Gm-Message-State: AOJu0Yz6azUAXn86wfuX+/mw+LWpS8x46+wh2f+cOpVACQ57wU6qnSgH
	FZT7+GGJQ5w5Wto8FTw/1/6ezMQmu3uWxDiseq0Ng+frLfJYagdOTanhFA==
X-Google-Smtp-Source: AGHT+IFecDAou0XdfT1VCrCUrStctl6xa8oiS2IbxqYlDCV9q4oSV2tk0PQ2BF+2npgyEPagxk5yww==
X-Received: by 2002:a05:6820:2211:b0:5b9:f802:ba19 with SMTP id 006d021491bc7-5baae76fb7emr3928514eaf.5.1717800482618;
        Fri, 07 Jun 2024 15:48:02 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:48:02 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 17/23] qmi: netreg: Drop use of qmi_service_create_shared
Date: Fri,  7 Jun 2024 17:47:17 -0500
Message-ID: <20240607224746.903769-17-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240607224746.903769-1-denkenz@gmail.com>
References: <20240607224746.903769-1-denkenz@gmail.com>
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
index ce43213a86a1..9c0ea4f6bbcc 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -840,7 +840,8 @@ static void gobi_post_online(struct ofono_modem *modem)
 	DBG("%p", modem);
 
 	if (data->features & GOBI_NAS) {
-		ofono_netreg_create(modem, 0, "qmimodem", data->device);
+		ofono_netreg_create(modem, 0, "qmimodem",
+						qmi_service_clone(data->nas));
 		ofono_netmon_create(modem, 0, "qmimodem", data->device);
 	}
 
-- 
2.45.0

