Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A730719D8B5
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800477; cv=none; b=WIDaBxbTr3EYsbWjjjMFMfKxOnSgeEHp+wU5Z7+w3uGtVLEtvaDIoGJP8payUZRoXmdI0pHUcSOxauYjaKHa8E3BldAOBFbpNYeEMmTdD5Ol62nLruGHLEbtLOg2Nj4TXQsQuDYB+e4D5emcCX8i1d+Aem+Eh5fwlENi/YiMW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800477; c=relaxed/simple;
	bh=OJCTEr//bHTKfFyKhWyff2cibYrVj+6uWeZiPKxYXgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gm9A5NU57dvRj0Rs0b4Nunfu53C6s1dDo91NWY3eL3R1ST+lmzPWlkQYg5fI7ajRGzfyYS3A4oalS8yAq4yZoKhM0YTaQwj9YWqeFpI99UqTLRlaBKQDb2zrQWFwe0q5do729xT5+MiYnOV88sk83PbD4o9brOXDv7C9ECgYLBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBAdwVFl; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBAdwVFl"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ba33b08550so1425443eaf.2
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800475; x=1718405275; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvlkyCcO7kbBQkBzwIIrUUUWp9H7a3gMrqwzAqckpJI=;
        b=nBAdwVFlm4GpWd9ALKvZbYWDb7sj48VcqfdVAqsDJi28XVOu8ouf+8ZKw2axPu1w4V
         J57j69dILItSgZ2YZ4gFu6hdkp900TkRmb60GRqwkn+xcxMaNRVn6CZJ0CcFQVh61tcP
         fpl9SCrBaC/szk3oN0s16VaVqE01uLbQ4B5YGNGjiHkJalke0fP5jESGorym17LJTYfj
         HjHhGiGs+pKhvRVOJ1aT0HcCLNVuMDYZs8KOaBtM1pUNmsdgBFY9weVfsR4+jW0c/M7K
         uEhGrHuXrzJj0OKlfz3kHoeEmCf1Ydqk8rYNmsGgcHpvbuVYCTsSaJL+wu7q741erMVS
         lqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800475; x=1718405275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvlkyCcO7kbBQkBzwIIrUUUWp9H7a3gMrqwzAqckpJI=;
        b=c/BjCxKFl7bqt8uZxTQzId0i40x3Bboyhwbs0Pa3yyK1wBDo9CFnBmsgrShAraRx6w
         RCj8XZI8c6GFgh3NSC8GMsGj/PXB785lNxN9uKm5PS31vuNk8YhOASCHrzolGD7jftsm
         70QQXjJca9lz+G2bKlhkC0w0EN0ejsAxDWXwbPUMjT/3fGd3uuVBCqipsE/tdB/YJk+/
         M1bNblhe1Uxaq/ILmJ0oBZ5NPxnxj3canfel5qMf6qgF/Y9HQO7/JBM27sSgCq0qsZuw
         335tnuttIL3+Y5R8FfzYq8Atd6zG0agit4re2qNQgU1r8QDfYhTNb7F3wJT1L6FqtrlV
         HKsA==
X-Gm-Message-State: AOJu0YwttNwYf4RiLNwQo/rZAc0TTek/Ev/QEOA8sLp+v/c4TCCtwo9A
	WOiC6YpkNSaN6BMAAZk9kRz3AGx7R27aT06RZlifrKuI9GmBBsaTfIFuNw==
X-Google-Smtp-Source: AGHT+IEQFHTLQXpDlX1WlrXRdqGb7TFs0eGGaTH5Ne7XEMVCah5SJRk1eVWHYFkAIzA+WjuhpC/5sg==
X-Received: by 2002:a05:6820:161f:b0:5b1:bf03:d1c6 with SMTP id 006d021491bc7-5baae50bfe2mr4365520eaf.1.1717800474530;
        Fri, 07 Jun 2024 15:47:54 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:47:54 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 08/23] qmi: devinfo: Drop use of qmi_service_create_shared
Date: Fri,  7 Jun 2024 17:47:08 -0500
Message-ID: <20240607224746.903769-8-denkenz@gmail.com>
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

Send qmi_service directly to the devinfo atom, which will clone it
during probe, obtaining its own lightweight handle.
---
 drivers/qmimodem/devinfo.c | 45 +++++++-------------------------------
 plugins/gobi.c             |  2 +-
 2 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/drivers/qmimodem/devinfo.c b/drivers/qmimodem/devinfo.c
index b74e535aaeb8..2e514cfa3265 100644
--- a/drivers/qmimodem/devinfo.c
+++ b/drivers/qmimodem/devinfo.c
@@ -192,53 +192,25 @@ error:
 	ofono_devinfo_register(devinfo);
 }
 
-static void qmi_query_caps(struct ofono_devinfo *devinfo)
-{
-	struct devinfo_data *data = ofono_devinfo_get_data(devinfo);
-
-	DBG("");
-
-	if (qmi_service_send(data->dms, QMI_DMS_GET_CAPS, NULL,
-					get_caps_cb, devinfo, NULL) > 0)
-		return;
-
-	ofono_devinfo_register(devinfo);
-}
-
-static void create_dms_cb(struct qmi_service *service, void *user_data)
-{
-	struct ofono_devinfo *devinfo = user_data;
-	struct devinfo_data *data = ofono_devinfo_get_data(devinfo);
-
-	DBG("");
-
-	if (!service) {
-		ofono_error("Failed to request DMS service");
-		ofono_devinfo_remove(devinfo);
-		return;
-	}
-
-	data->dms = service;
-	data->device_is_3gpp = false;
-
-	qmi_query_caps(devinfo);
-}
-
 static int qmi_devinfo_probe(struct ofono_devinfo *devinfo,
 				unsigned int vendor, void *user_data)
 {
-	struct qmi_device *device = user_data;
+	struct qmi_service *dms = user_data;
 	struct devinfo_data *data;
 
 	DBG("");
 
+	if (!qmi_service_send(dms, QMI_DMS_GET_CAPS, NULL,
+					get_caps_cb, devinfo, NULL)) {
+		qmi_service_free(dms);
+		return -EIO;
+	}
+
 	data = l_new(struct devinfo_data, 1);
+	data->dms = dms;
 
 	ofono_devinfo_set_data(devinfo, data);
 
-	qmi_service_create_shared(device, QMI_SERVICE_DMS,
-					create_dms_cb, devinfo, NULL);
-
 	return 0;
 }
 
@@ -251,7 +223,6 @@ static void qmi_devinfo_remove(struct ofono_devinfo *devinfo)
 	ofono_devinfo_set_data(devinfo, NULL);
 
 	qmi_service_free(data->dms);
-
 	l_free(data);
 }
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index c82dd70d25e1..1a31e7a2b17d 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -725,7 +725,7 @@ static void gobi_pre_sim(struct ofono_modem *modem)
 
 	DBG("%p", modem);
 
-	ofono_devinfo_create(modem, 0, "qmimodem", data->device);
+	ofono_devinfo_create(modem, 0, "qmimodem", qmi_service_clone(data->dms));
 
 	if (data->features & GOBI_UIM)
 		sim_driver = "qmimodem";
-- 
2.45.0

