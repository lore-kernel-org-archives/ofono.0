Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45D01A01C5
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391186; cv=none; b=cufRcYuL1pyrTWtfCFgYdNS0SuLXSerNoJ4mPEZXB3eaeCm43R2ldqVR3GFJfi7tJsjQ1iZ0v68aIOQ/fHMAg+rOGTtA2bqJd8UI1pRIfumyXggWXMX5gsJCi5TL/6UXKGwZVoOjLL5wHRLPZ8Hnc9s38ya6PI3XdGNrUZfj5jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391186; c=relaxed/simple;
	bh=jhZSc7mmecQDcJyyp7Wo7xsMqmbFD4HSRjTKXpfRInk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FT06tJZ8NmP9dsV5D8iYYF0HjLQWmHqb0fxtLHlPkubJNi7Xelu0LHdbBcWMIi6H7EBMBWGYqyrvEpMxC+iVxemmsagyZmsgNYRwwWI49Rhv5w1L9Sr2P2dV1zBsIqM6x3vgh0SO+RsEPkND1Zs/jdO4WGulSVcyoomZlioFUS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV105X8K; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV105X8K"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24c9f6338a4so1179606fac.1
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391184; x=1718995984; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/a5GQJiVGU59uFyb+ZmHYVCwEBORjMl826K6459n2W4=;
        b=GV105X8KyOoxD7LkgUBJeKKG2Bm6ZHnB/+eAu89F+A3etGa5XTl682u2hFDoGuejWs
         BtWr7OZDxrYr078/r7+NCzxrDuPru32VJ+4aWq76O7BPJFDmtEFF9DUrO6gK4zSaaZeb
         UH9a0yAWkTmmk3VzEgxAtILNHyNvnMEdHN+Y1jlg14hexNHjrWSL2K7k3qKiAG/Dxerg
         FVVPIGz3TpmqwXvaVwkeTkft3Gf0uInBbEiTTGiZaBotmVOyoChQ3QZqyo2cxmfGrTIz
         ISRey9gIlLlv3uIDeN/oT059aQ7SaToEQHrmgOqUsqUyr6YA+UviaTURV1tqXTNZlv3Q
         mGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391184; x=1718995984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/a5GQJiVGU59uFyb+ZmHYVCwEBORjMl826K6459n2W4=;
        b=pSFMSmcF3tYe/b3jX0VburCbCfTYTPp6Bji876Nz26RK1C90bDkKKoU8M017+phvXo
         iKug8EcKsN1SaCFu3DHcTKyoZte7TSeyRSngYPDe9PpcJl4ab9EzNroi7IPoqGCYRirH
         v1rkhBYCAm/nLtCN+tdApbfH9gufhdP4pbv59uGJJsj1OFUoxSIcg0HULyT1uLAwsr2r
         CkND6e4ECGdOfdGEA+hBH69Cx5SLIX08vFHRUlt4t14AX3WhnpJeKw0Fmd8hJJb5NDZM
         r9uNzxgqzLixQkLZIk4NEuQufBRhitomT/aex10lcVUawE3GIFQCdnBYdGidE1k0v6IZ
         11Ng==
X-Gm-Message-State: AOJu0YyJEjCOLFPSskrL0unD6bDXKJzjdP9SVP+OwMjLILfnOSRD7Nx8
	ImvDDYB+gtTj9POlLg8t8sUFcxhUd9rdF+b3kafH1jQg3Fl/2/8XJ8fYRQ==
X-Google-Smtp-Source: AGHT+IFj/ncJyVNvnrrNxeodLABnEozDz17p8yE7m1l0NinU9g9x1mJBvfQ+7ZEeTlVmVlTlVOhw7g==
X-Received: by 2002:a05:6870:7b41:b0:258:5143:a21a with SMTP id 586e51a60fabf-2585143a77emr1461199fac.13.1718391183730;
        Fri, 14 Jun 2024 11:53:03 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:03 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 03/27] qmi: Drop unused major/minor information
Date: Fri, 14 Jun 2024 13:52:15 -0500
Message-ID: <20240614185300.1086701-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614185300.1086701-1-denkenz@gmail.com>
References: <20240614185300.1086701-1-denkenz@gmail.com>
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

