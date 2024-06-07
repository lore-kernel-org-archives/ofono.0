Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F841553A6
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800479; cv=none; b=uSMbLCOnSBZvuuvS1h2MpOk9GpIHTlpCIGZk1DPhCVa0UYGjp1Qswy2zm8dUya5W0aP/1VDRqsJl9gMNV6Vu/ksuy7Jv/yUFXwDQ7ZN/Q1raJLyJu6Lwsfrfl2MEm3NZ3m5GIJ0Ms/ozdjNwvBEpE6wcjF1TWIaXy9CZyUb8Fbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800479; c=relaxed/simple;
	bh=+mCCg2JDyv1dxn4CSJ/k7Jv3gcLtJLqcn7eoEFlrnGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWFhZho5Fx7yVd3XoUcMqPmxZ2wpRWf1DlIdCDiR2BRcP8ypfFNEkrKyVar/CEDPDv2D0RRjqnjtWuzmI9FqN25D2tPX4BaJFxZ9Ul3wWOVZw1E8VzYEG/z5TEjUwjnUlfYsMOeiCx9IlEMLbNZsSfAkFX3v1ueBUwH72JbuQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dt7LMVaV; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt7LMVaV"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c9cc681ee7so1051081b6e.1
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800477; x=1718405277; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VD5FsEpnpFUnveyu9tmrPSXCDTwYqAAmo87emNrQQQk=;
        b=dt7LMVaVuTcEV+781MhiB2rocJdnKj4H3Sfp62acEIoSxcj4KvoXLCyX7RXObWymX7
         FvqSJMCm/5C65tlF1WcKvAJLXrONwPrOO8c8Pp6MO/hKOBRr6NOfI4Q9ozK7q0KOwE8o
         gG02UbAvcOz2NyAeOIGgLuOBo++VC8NUx8rXWVM/pbXD25579+aY4nUrRP5MnK3NNEPC
         ga36MEyCtUeYvlCOCPLmcLeOfWfU/55APNrmdCTY82VbVxtSPASaNXPQXcw1++TE7jmD
         0pJafS3eiJ8H+nbDalPimuKqNsjfRGOmAjbTBHioIczeF+75mf6CIJKTkZF2/OEqKaXE
         yG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800477; x=1718405277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VD5FsEpnpFUnveyu9tmrPSXCDTwYqAAmo87emNrQQQk=;
        b=TZDsEDWGXlIzAaKk7rhShbDwDAlxaw4ofL6T25wf71QRhWS4tcux6B/vDRkO/MaoTx
         JTne0Z/4o6kRJpNzUgZgcQyJbBP8yHGlSCwFS2bXqApNUC/rB7ifRcOujBk4/OwCDwCj
         UaShxpTFexu55XqHZ2/PrtCh8tqBxFFjErVu79qP/BmBTVDtFI8RKyDwG/THyCKFcO/d
         2e062HSOh7lEkd6RlHSdRVaqMxp0Te49e+lYHbvvQ5TCB8y4QBBPJEwS3/JYevEneT+0
         8h2zikLFDc2aM5beLX0ktYarveYScRUzZycrk90VEMEsGN9+y40AfegrPBf4fvyjssEo
         8fRw==
X-Gm-Message-State: AOJu0YyZ0P8sIfwrgJrmrVbnbKTOBYb0A21FsQ6fek6dhoBcqX0cI1TJ
	rj54QkImjiCTKJ6wufoFpIGemv45xyUZiymTCcdG4JxUb7CKAQYZe8bQ9w==
X-Google-Smtp-Source: AGHT+IGDvjhQhI6C5odXExCcw55h4NvRwZ/BTRfQ4AtW80YAqfl/dnrLSMbY209CPqPfFGjYwMBARQ==
X-Received: by 2002:a05:6808:1694:b0:3c9:9e8e:52f3 with SMTP id 5614622812f47-3d209bac258mr3270810b6e.17.1717800476888;
        Fri, 07 Jun 2024 15:47:56 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:47:56 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 11/23] qmi: call-barring: Drop use of qmi_service_create_shared
Date: Fri,  7 Jun 2024 17:47:11 -0500
Message-ID: <20240607224746.903769-11-denkenz@gmail.com>
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
 drivers/qmimodem/call-barring.c | 29 ++++-------------------------
 plugins/gobi.c                  |  3 ++-
 2 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/qmimodem/call-barring.c b/drivers/qmimodem/call-barring.c
index 2209b4049c13..8da805cfe6ca 100644
--- a/drivers/qmimodem/call-barring.c
+++ b/drivers/qmimodem/call-barring.c
@@ -190,39 +190,19 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 
-static void create_voice_cb(struct qmi_service *service, void *user_data)
-{
-	struct ofono_call_barring *barr = user_data;
-	struct call_barring_data *bd = ofono_call_barring_get_data(barr);
-
-	DBG("");
-
-	if (!service) {
-		ofono_error("Failed to request Voice service");
-		ofono_call_barring_remove(barr);
-		return;
-	}
-
-	bd->voice = service;
-
-	ofono_call_barring_register(barr);
-}
-
 static int qmi_call_barring_probe(struct ofono_call_barring *barr,
 					unsigned int vendor, void *user_data)
 {
-	struct qmi_device *device = user_data;
+	struct qmi_service *voice = user_data;
 	struct call_barring_data *bd;
 
 	DBG("");
 
 	bd = l_new(struct call_barring_data, 1);
+	bd->voice = voice;
 
 	ofono_call_barring_set_data(barr, bd);
 
-	qmi_service_create_shared(device, QMI_SERVICE_VOICE,
-					create_voice_cb, barr, NULL);
-
 	return 0;
 }
 
@@ -234,13 +214,12 @@ static void qmi_call_barring_remove(struct ofono_call_barring *barr)
 
 	ofono_call_barring_set_data(barr, NULL);
 
-	if (bd->voice)
-		qmi_service_free(bd->voice);
-
+	qmi_service_free(bd->voice);
 	l_free(bd);
 }
 
 static const struct ofono_call_barring_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= qmi_call_barring_probe,
 	.remove			= qmi_call_barring_remove,
 	.set			= qmi_set,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index f81fb8243bf8..1688d5478d59 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -847,7 +847,8 @@ static void gobi_post_online(struct ofono_modem *modem)
 	if (data->features & GOBI_VOICE) {
 		ofono_ussd_create(modem, 0, "qmimodem", data->device);
 		ofono_call_settings_create(modem, 0, "qmimodem", data->device);
-		ofono_call_barring_create(modem, 0, "qmimodem", data->device);
+		ofono_call_barring_create(modem, 0, "qmimodem",
+						qmi_service_clone(data->voice));
 		ofono_call_forwarding_create(modem, 0, "qmimodem",
 						data->device);
 	}
-- 
2.45.0

