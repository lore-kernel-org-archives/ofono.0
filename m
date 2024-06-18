Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76675143876
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740957; cv=none; b=tj+52z4iL23JZJbQrwoH/IhP4WDMc28EG3KCt9/DrsV1eAKMg+8CF5CNAVOH1nbh7X6I9FhikQJLrkOowh+Ahad0UNTzjztAWTJk46JIoJnnGLf5PJJpS8p440pSmIp4x/FJnE6ojKZtQGLnjDw7pHWn1DUUI/QlIjfeodppIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740957; c=relaxed/simple;
	bh=jhZSc7mmecQDcJyyp7Wo7xsMqmbFD4HSRjTKXpfRInk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oflVndQWfXWaQsRihEWwuWSnsO5WWdDV53tYyoXs+/MHdwg5TCsXb+dg5QU8B62Eam7rLUBMlAnwEq1OngePhNtMhi/zkzQCv+FWCxSfwgyH6SRFTPRZD+oh2UDuhqBKkr8Kte+FglqSRzZSH6u6BQogiR5eIs5KxB+kgkGfLXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQt68dee; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQt68dee"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5ba090b0336so2828593eaf.1
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740955; x=1719345755; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/a5GQJiVGU59uFyb+ZmHYVCwEBORjMl826K6459n2W4=;
        b=YQt68deeAv7h7GnokEpOt/tE2WGUZrqWAFTXjxAne/4P7winLusbUvmYwmA3NJIu9B
         FsUMeX5Coz6k02qVOA9QMyVwKSuhsDCt9uMqq19fxRuECdPKqEmsqxOeBzkvKJDr+56S
         +gWkda1ajLEzhguc2rWbSq31ndZSD483T3LC90TV2uBXrYMEvZt+rtPJSelVs5FfPxfp
         LYDO3R7zprc2lLsvpcc/bfLIOIiEd6kDroT56GVOvpbdWhVMv1IRfQ1I/10yeH72t5Xz
         ueZZZimMoCpzyv987IzVPR0ROYYVbXn+rfVlfW7lgRqSlbN014WAB2yWZKW66qnFLa+q
         jfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740955; x=1719345755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/a5GQJiVGU59uFyb+ZmHYVCwEBORjMl826K6459n2W4=;
        b=VcnTc7iTdh0MbuSfuxq4UTxwniO7dUZyeX5E/W3e9JnKNLPKy3MLG5yovL80+e+HiY
         8w4NsSUkF6i/9p2+5pw02Ctk+bEhFrPV6zRNboE3+YHGnuMKSY6zxG9vbIzrWertVmpt
         f3vyFm/Fi9A1oaszP66sdbTCTo/CFTEW16bvPtJsQQlxM5lkn0Eg2yambnjI8g8wvZA1
         6kaySCIvAskp1EqjmpVOZkLpBJNqmmlxSNfmDivpRFkeMeCv/NpD6TedG9/hi3Mx07nE
         WFTvz1xisa94rRC/iKCPzjz+DP5CR8m3VPqTZFXVrEv4UFH9UpDYUk2VLPQQDfWL7Nv1
         w2PQ==
X-Gm-Message-State: AOJu0Yx8wf2N4fL3ix7mqtTv8wHaQqIreh0sHBjNmDKiYI+X7U/7Atno
	N/R1CHyUjY8bdt3pmQqBe3cDbdHt+5VKJGYbseqTpDtVS3PKHuEYvaX0Fw==
X-Google-Smtp-Source: AGHT+IHa+mG7OGVgoo0zktNfJmiuTwTYEd0WGJ7vV/cZ8nWCmBM3nTrzo6iTullch0y+Q5rkATxgew==
X-Received: by 2002:a05:6871:5209:b0:254:b3cc:a6d8 with SMTP id 586e51a60fabf-25c94a200famr944778fac.32.1718740955149;
        Tue, 18 Jun 2024 13:02:35 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:34 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 03/33] qmi: Drop unused major/minor information
Date: Tue, 18 Jun 2024 15:01:45 -0500
Message-ID: <20240618200231.1129282-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240618200231.1129282-1-denkenz@gmail.com>
References: <20240618200231.1129282-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QMI radio-settings, ussd and voicecall atoms request and store the
service version major/minor numbers, but never use this information.
Remove this functionality until needed.
---
 drivers/qmimodem/radio-settings.c | 4 ----
 drivers/qmimodem/ussd.c           | 3 ---
 drivers/qmimodem/voicecall.c      | 4 ----
 3 files changed, 11 deletions(-)

diff --git a/drivers/qmimodem/radio-settings.c b/drivers/qmimodem/radio-settings.c
index 8463c84bf1ed..cf0b747eb681 100644
--- a/drivers/qmimodem/radio-settings.c
+++ b/drivers/qmimodem/radio-settings.c
@@ -21,8 +21,6 @@
 struct settings_data {
 	struct qmi_service *nas;
 	struct qmi_service *dms;
-	uint16_t major;
-	uint16_t minor;
 };
 
 static void get_system_selection_pref_cb(struct qmi_result *result,
@@ -211,8 +209,6 @@ static int qmi_radio_settings_probev(struct ofono_radio_settings *rs,
 	data->dms = dms;
 	data->nas = nas;
 
-	qmi_service_get_version(data->nas, &data->major, &data->minor);
-
 	ofono_radio_settings_set_data(rs, data);
 
 	return 0;
diff --git a/drivers/qmimodem/ussd.c b/drivers/qmimodem/ussd.c
index 6637ae759c55..51c3aaef7a19 100644
--- a/drivers/qmimodem/ussd.c
+++ b/drivers/qmimodem/ussd.c
@@ -24,8 +24,6 @@
 
 struct ussd_data {
 	struct qmi_service *voice;
-	uint16_t major;
-	uint16_t minor;
 };
 
 static int validate_ussd_data(const struct qmi_ussd_data *data, uint16_t size)
@@ -156,7 +154,6 @@ static int qmi_ussd_probe(struct ofono_ussd *ussd,
 	data = l_new(struct ussd_data, 1);
 	data->voice = voice;
 
-	qmi_service_get_version(data->voice, &data->major, &data->minor);
 	qmi_service_register(data->voice, QMI_VOICE_USSD_IND,
 					async_ind, ussd, NULL);
 	qmi_service_register(data->voice, QMI_VOICE_ASYNC_ORIG_USSD,
diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index c7a5230f9680..aed662da7ef6 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -24,8 +24,6 @@
 
 struct voicecall_data {
 	struct qmi_service *voice;
-	uint16_t major;
-	uint16_t minor;
 	struct l_queue *call_list;
 	struct ofono_phone_number dialed;
 	char *full_dtmf;
@@ -721,8 +719,6 @@ static int qmi_voicecall_probe(struct ofono_voicecall *vc,
 	data->voice = voice;
 	data->call_list = l_queue_new();
 
-	qmi_service_get_version(data->voice, &data->major, &data->minor);
-
 	qmi_service_register(data->voice, QMI_VOICE_ALL_CALL_STATUS_IND,
 				all_call_status_ind, vc, NULL);
 
-- 
2.45.0

