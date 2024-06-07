Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76151155737
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800483; cv=none; b=s55WlFQwvJsVi3F2Z/V44byn/TI0zV7ajeR4o20mBd/JoS4FjFifJR+XCp9v+n2v5U85ea+JCx6Lv3Aybkk4SlHjFxIRcW5vmen0VgaPOfEdYKgewLtfqnadgAX+w5cOCGKaQuhEAVSVKxpLd/kQfblN3k5B7tU9Z560GiWNOe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800483; c=relaxed/simple;
	bh=TmbPi0t6lMR9o6JQl1euLlkz53pHRBKieCjN4fdjjCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBjNcml5YG1GGYIOQJzHLWOlgoQo9/tdbOmXtP28sLyhnH576YzaoOOrrto/OyYoV+3TXOQ72Erc8Ny/wdFc7crFkhYqxYVA7mXVHxn2j059uFmz7QAp5IXamUKnCNyvyPe/N3Y9adBtTzNCcB442Dy0lkXMKJJurvfM5dvBTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5u0iP8S; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5u0iP8S"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b96a95c5e8so1425622eaf.3
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800481; x=1718405281; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VB3dAwV+rcYkqWccEm3HngtfEkjDrHJbfnxDOIe0LXA=;
        b=e5u0iP8SXi12+xxebPetvpKphIF/27t2vB7FKq/G6f9b8geFKQUmK2dGejhg4q09f4
         o6P9l/jpjaMkVhSxcuOGS1LByXIDNDamhZ9FmKnTfdjlSv6M6yNAbtyIb4ulCdtVClri
         dAPUJc7MZNoOljBejtVG9N7uX3vqjPiswFLizUw6KVG/Q87o6PKqMS/cGhlegrHLn8h0
         Sn0ENDzgpmh5B3vieAqXZOjh7dbLEkuQ5sy22YxvYLwrbASp+b3bCGsQrhbK6wQw2hmy
         3h+ViIsOG+f9L0UObEfyaQ01nFhmYa/39lMmHed12UXGDaHtezR3tw2zyceHzBU01wpq
         K0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800481; x=1718405281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VB3dAwV+rcYkqWccEm3HngtfEkjDrHJbfnxDOIe0LXA=;
        b=qrjNd9hh4vhcLc9fiKkilb+39DUBd0dxAnYdkX5PU9MSQNmJv/7zn52GgqJbjEnOLK
         1z1vppmXQMReosuwfbQ9yha1nylXTugeWPUaxmu/zjBTtlSgVW9blaWkacNSsfwJsQch
         1B9QJgp4XIPOEZtyBjDtTkyX9mgNiFEvP0OAuGKixkeM4yjV1Yh7Re6ieGyrMKlFxER3
         5fyEL+Mk2ufeIOZNgxaFHp+Mha23i7+gS+SWsCMKGg/8cPbIKPq3G7nIUDcKi/bDG4xl
         +m2bxtoJg7mUr+nTeZDlgDkwKFhBMeKgPtOI4yCDCvVjfF/naT0rd06m0vrQnc8q+DVk
         8PWA==
X-Gm-Message-State: AOJu0YyBCYVTqJwrAFSApsFCzK9rLLA9/Xyd1M6jzG08vdStrlPFGER5
	PSm9aa+4IPoYoixEGg+FoEJA40Hvunlsb+aLfhfsbqGIE3gM3pFlh0K0Bg==
X-Google-Smtp-Source: AGHT+IHfBuI7q1c0S8z//LmR9sawKqG0G0EzwHCcoC5SMtlHHaZ6u0Aaf4XqHUgvyiU+umnBDLpfzA==
X-Received: by 2002:a4a:dd83:0:b0:5ba:d272:3223 with SMTP id 006d021491bc7-5bad27232d6mr765142eaf.4.1717800481266;
        Fri, 07 Jun 2024 15:48:01 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:48:00 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 15/23] qmi: location-reporting: Drop use of qmi_service_create_shared
Date: Fri,  7 Jun 2024 17:47:15 -0500
Message-ID: <20240607224746.903769-15-denkenz@gmail.com>
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

---
 drivers/qmimodem/location-reporting.c | 50 ++++++++-------------------
 plugins/gobi.c                        |  5 ++-
 2 files changed, 16 insertions(+), 39 deletions(-)

diff --git a/drivers/qmimodem/location-reporting.c b/drivers/qmimodem/location-reporting.c
index 669e9e6fdd41..1c9b9c9c3663 100644
--- a/drivers/qmimodem/location-reporting.c
+++ b/drivers/qmimodem/location-reporting.c
@@ -172,67 +172,46 @@ static void qmi_location_reporting_disable(struct ofono_location_reporting *lr,
 }
 
 static void set_event_cb(struct qmi_result *result, void *user_data)
-{
-	struct ofono_location_reporting *lr = user_data;
-
-	DBG("");
-
-	ofono_location_reporting_register(lr);
-}
-
-static void create_pds_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_location_reporting *lr = user_data;
 	struct location_data *data = ofono_location_reporting_get_data(lr);
-	struct qmi_param *param;
 
 	DBG("");
 
-	if (!service) {
-		ofono_error("Failed to request PDS service");
-		ofono_location_reporting_remove(lr);
-		return;
-	}
-
-	data->pds = service;
-
 	qmi_service_register(data->pds, QMI_PDS_EVENT,
 					event_notify, lr, NULL);
-
 	qmi_service_register(data->pds, QMI_PDS_STATE_IND,
 					state_notify, lr, NULL);
 
-	param = qmi_param_new();
-
-	qmi_param_append_uint8(param, QMI_PDS_PARAM_REPORT_NMEA, 0x01);
-	qmi_param_append_uint8(param, QMI_PDS_PARAM_REPORT_NMEA_DEBUG, 0x00);
-
-	if (qmi_service_send(data->pds, QMI_PDS_SET_EVENT, param,
-					set_event_cb, lr, NULL) > 0)
-		return;
-
-	qmi_param_free(param);
-
 	ofono_location_reporting_register(lr);
 }
 
 static int qmi_location_reporting_probe(struct ofono_location_reporting *lr,
 					unsigned int vendor, void *user_data)
 {
-	struct qmi_device *device = user_data;
+	struct qmi_service *pds = user_data;
 	struct location_data *data;
+	struct qmi_param *param;
 
 	DBG("");
 
-	data = l_new(struct location_data, 1);
+	param = qmi_param_new();
+	qmi_param_append_uint8(param, QMI_PDS_PARAM_REPORT_NMEA, 0x01);
+	qmi_param_append_uint8(param, QMI_PDS_PARAM_REPORT_NMEA_DEBUG, 0x00);
+
+	if (!qmi_service_send(pds, QMI_PDS_SET_EVENT, param,
+					set_event_cb, lr, NULL)) {
+		qmi_param_free(param);
+		qmi_service_free(pds);
+		return -EIO;
+	}
 
+	data = l_new(struct location_data, 1);
+	data->pds = pds;
 	data->fd = -1;
 
 	ofono_location_reporting_set_data(lr, data);
 
-	qmi_service_create_shared(device, QMI_SERVICE_PDS, create_pds_cb, lr,
-					NULL);
-
 	return 0;
 }
 
@@ -245,7 +224,6 @@ static void qmi_location_reporting_remove(struct ofono_location_reporting *lr)
 	ofono_location_reporting_set_data(lr, NULL);
 
 	qmi_service_free(data->pds);
-
 	l_free(data);
 }
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 6dee928acdea..f27d6c23e34a 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -737,9 +737,8 @@ static void gobi_pre_sim(struct ofono_modem *modem)
 		ofono_voicecall_create(modem, 0, "qmimodem",
 					qmi_service_clone(data->voice));
 
-	if (data->features & GOBI_PDS)
-		ofono_location_reporting_create(modem, 0, "qmimodem",
-							data->device);
+	if (data->features & GOBI_PDS) /* exclusive use, no need to clone */
+		ofono_location_reporting_create(modem, 0, "qmimodem", data->pds);
 }
 
 static void gobi_setup_gprs(struct ofono_modem *modem)
-- 
2.45.0

