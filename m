Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54F31AE0AF
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895111; cv=none; b=P+IkPq6KD0VBDPnh9i2215Ph/dcUEpW8VBHzTXSQ1qXxQ5yiPilON7Es5PPlyP25J5OD29GRE1xAwrzp7qocmiDpWTQ42W3bYENOBnC2SdN3AfSB5AYTKfKQOCaLPGV5e3UWqTF0d1+DfmXtHCWSTTI9Mxk6OKTDXvWJgA7LCfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895111; c=relaxed/simple;
	bh=jhZSc7mmecQDcJyyp7Wo7xsMqmbFD4HSRjTKXpfRInk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mypefVxZ+tS4+guYClEsvegRhxVP1vnpDaWORHA8N9NIJzHZX5kgF/VwHQH0+0yRVmNuP8r0k7Asbxb0wYayJ8yO/xJINQ+Ad6ApnUvZ71pRN3VlIYl3dDFNqsVtKjN07yFJao1u5k+z4CJIZ6FkAQIsljQ8z/+SZgfBsECI1cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jirqcVtc; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jirqcVtc"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c9cc681ee7so404794b6e.1
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895109; x=1719499909; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/a5GQJiVGU59uFyb+ZmHYVCwEBORjMl826K6459n2W4=;
        b=jirqcVtc74bLGcWQdiJ00rCG3uwgvL7V93gmwbpG6iE9CMTL6tJ0uleqjYfYKxjIjq
         Xn4vxkFwKbnWXzWYMv0EswSChDsvcMm6qSJ88mmQVzbId6drw+iQA+NSNgMHOQBNUsXw
         PxfSgyUJgvPjmjPtaDUyqiX5VOJzASf2lqJdvnDvE1Z8U8NXFlUoJjQrV2IlMmrdFlu6
         XkHDgKd4v2Iz6h/+1q+GGdoc5E86mo5T+1ykBIGFxeF7VEJZGscK5uDbCemwcrMQIoTc
         byPVRV8rKpfHoAbI6w1A9vOnd37zH6gxdUnEYdSShhOuD58603pl57KzsPOlnLBjbHRA
         DJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895109; x=1719499909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/a5GQJiVGU59uFyb+ZmHYVCwEBORjMl826K6459n2W4=;
        b=VRQmpEyVMTiRB66S4HBuvREFtSYw+l+uibEk2dGWJsdh+1K720SIEXBmIhC8jBSVpm
         qe2dByJPlg5ZMEGKrUOOpwnEGw+IuI3YOHX5TRU0JkZ8SrVn4cNGmdF41MdyM/efD8Tc
         AT2MS/OQ1K5LmY4k4AvY0OEv3fAO2+e2CTP5Br6WPW4gLg9YiaeZVnTSVJb02qOp8BDk
         CEYHfw6X9Vgc1yb1gPsIOwS8n2uc0I0pGZs9hfdZpEi26BO6uvJ7OW8yonSyYJi68Mtd
         eCBDNo5CkfaHwuIi16TA2B6w3WAEXqftsg/rQYadwdRqhzaFEhPC8aMT7Daa0ZaSqIHR
         R2Ww==
X-Gm-Message-State: AOJu0YzC/jlpFzPbuP6evUpe39CnGiivjkI/2apZtzQn+qIMFBjM7CwX
	zK53BFV4coJYcps3RkBhiwb6Ud/9I99K1r/2QKDu7/h+7jLlIAn53UX9wA==
X-Google-Smtp-Source: AGHT+IGog4fxaur9G51IERSpENQk97EhCEzSP0BSE7dItTcRo0nnvYAfySt7INz6arupjD3Y6Mwurw==
X-Received: by 2002:a05:6808:1827:b0:3d2:ec:d3ee with SMTP id 5614622812f47-3d50f131660mr3580164b6e.27.1718895108677;
        Thu, 20 Jun 2024 07:51:48 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:51:48 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 03/33] qmi: Drop unused major/minor information
Date: Thu, 20 Jun 2024 09:50:50 -0500
Message-ID: <20240620145139.1135899-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620145139.1135899-1-denkenz@gmail.com>
References: <20240620145139.1135899-1-denkenz@gmail.com>
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

