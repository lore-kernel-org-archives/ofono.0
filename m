Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7E143C7B
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314901; cv=none; b=KosnmhhvcOT8uicx7/lL8FqIKPIC9M2vZfz1N0V/f6gcuFNc8+6IDTuWfWfNRhSfpD65IajDIiY66Y77GI02RsoCj74gPtZAV9kWiVTVEuRxLu6WNoPSYwqMbZd0aHT1GUHDODtJd78f/g69rQBODzCREBZYsku5VJwmVtrBKhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314901; c=relaxed/simple;
	bh=oenWwScYhH6lxXUYh72CYQlds6Qy0EszKgFxHy7c5uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdtEjFiEzy71SkBqxx4SSqsEtNDo3kusY8KjHAXuNhdBeS5fcntmfMZRZkJqIwLE4m3s/nvem5VYc6DX9wlfyhZapa6M+A7JhNKVLbaIByq1HtQr2A404SzQ/m/UTTeGiH5LFCwNSenH5PO/JdVSl+nmOaHITyt/D9lArt2yypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jmu5KFD7; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jmu5KFD7"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f9b4d69f53so831853a34.0
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314899; x=1718919699; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8iTzLM1WfsArapDmALWmBs5nYg7z9haFIa9C4W82QQ=;
        b=Jmu5KFD7AeBeTG78YmU3yqUDImv1APlPUopgM+KC9UhteyEc/Lh5QzN/Pi4JYZfe37
         Y8kX/EI3vUPtQ6f54J7Cccw2Fim895GObsE+FCfVz21GeLrKRQGowB3LxlQl0gaRYud1
         bTTY9MTo6JmRuduBA312OvlR4RKJS9LnhM+K9TA/bbl/DjNAJUGFI/2ATgbvSU5vwZIi
         j10JDJ6eNlgMQa+BUH6t96PDqI4J/6CHJhvg9Fu2AAJhQnv6UKObl6FUgqnT46cEvMkr
         assmuOZY9tcTsrBN/7i9eV7JDCMl5003DmpKBVhPZ8DvX2VWHSi2NZ1p2gaUMHnwulrY
         +bfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314899; x=1718919699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8iTzLM1WfsArapDmALWmBs5nYg7z9haFIa9C4W82QQ=;
        b=uIAVpDhGDMCSLn1Xoca39hZoWg8nYGOsTwV43L9D8OI2oieiP6EtQ/kOdj47/qhCAb
         38iE8E2aUrZy+k5g1ylWCajcBnBh0E6FO5Fp9+pyLumhooPJr1ICj2RufT9ObN16tc3p
         M2BnQ924yi+ZYQRwRkjD11a0qoK3yfHd8xfzd3UAMeG5OKFzo+mul1gZM0Ch8qmJx5eR
         OZ4ZfQmVhqz7AmHYwBK5CoSfiFTH6mxZI3EtSf4vRr6d76hM0GKB/ktMqf6DoXYa8+uO
         1tdxHjZ8xAemInt0bhcbBmzTx6XiSAblu9usiUC9XE3mp4kz5HiDVs5SdYqyWsbXw0Q2
         eWSw==
X-Gm-Message-State: AOJu0YxaxkgySzH7Q8+gXfCZVIzkYqUM6/n1eEo22WdQ74aP7is1Ljjo
	6rhdREiY8MEavN/yAT/qC7y0PIxgbvlrzn10CzYsdqRYVfCyN47HWwRHFA==
X-Google-Smtp-Source: AGHT+IHZSQLVgqqNB1ZsQq822OXlPqC69r3ybBa6R4n0aHMdcTPFiEfGgnukqkvj8YBbRVYw7qKXnw==
X-Received: by 2002:a05:6870:89a0:b0:254:9c46:8877 with SMTP id 586e51a60fabf-258428de7fcmr808332fac.16.1718314898655;
        Thu, 13 Jun 2024 14:41:38 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:38 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 04/23] unit: Update unit tests to the new API
Date: Thu, 13 Jun 2024 16:41:13 -0500
Message-ID: <20240613214134.1056517-4-denkenz@gmail.com>
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

---
 unit/test-rilmodem-cb.c  | 9 +++++++--
 unit/test-rilmodem-cs.c  | 9 +++++++--
 unit/test-rilmodem-sms.c | 9 +++++++--
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/unit/test-rilmodem-cb.c b/unit/test-rilmodem-cb.c
index 75e7e02076f6..984ea4efc64e 100644
--- a/unit/test-rilmodem-cb.c
+++ b/unit/test-rilmodem-cb.c
@@ -407,11 +407,16 @@ extern struct ofono_driver_desc __start___call_barring[];
 struct ofono_call_barring *ofono_call_barring_create(struct ofono_modem *modem,
 							unsigned int vendor,
 							const char *driver,
-							void *data)
+							...)
 {
-	struct rilmodem_cb_data *rsd = data;
+	struct rilmodem_cb_data *rsd;
 	struct ofono_call_barring *cb = g_new0(struct ofono_call_barring, 1);
 	int retval;
+	va_list args;
+
+	va_start(args, driver);
+	rsd = va_arg(args, void *);
+	va_end(args);
 
 	cbdriver = __start___call_barring[0].driver;
 
diff --git a/unit/test-rilmodem-cs.c b/unit/test-rilmodem-cs.c
index 414ded61022e..8c65fb1f6bb4 100644
--- a/unit/test-rilmodem-cs.c
+++ b/unit/test-rilmodem-cs.c
@@ -383,11 +383,16 @@ extern struct ofono_driver_desc __start___call_settings[];
 struct ofono_call_settings *ofono_call_settings_create(struct ofono_modem *modem,
 							unsigned int vendor,
 							const char *driver,
-							void *data)
+							...)
 {
-	struct rilmodem_cs_data *rcd = data;
+	struct rilmodem_cs_data *rcd;
 	struct ofono_call_settings *cs = g_new0(struct ofono_call_settings, 1);
 	int retval;
+	va_list args;
+
+	va_start(args, driver);
+	rcd = va_arg(args, void *);
+	va_end(args);
 
 	csdriver = __start___call_settings[0].driver;
 
diff --git a/unit/test-rilmodem-sms.c b/unit/test-rilmodem-sms.c
index 347922c309b6..8d85d23ce92a 100644
--- a/unit/test-rilmodem-sms.c
+++ b/unit/test-rilmodem-sms.c
@@ -414,11 +414,16 @@ extern struct ofono_driver_desc __start___sms[];
 struct ofono_sms *ofono_sms_create(struct ofono_modem *modem,
 					unsigned int vendor,
 					const char *driver,
-					void *data)
+					...)
 {
-	struct rilmodem_sms_data *rsd = data;
+	struct rilmodem_sms_data *rsd;
 	struct ofono_sms *sms = g_new0(struct ofono_sms, 1);
 	int retval;
+	va_list args;
+
+	va_start(args, driver);
+	rsd = va_arg(args, void *);
+	va_end(args);
 
 	smsdriver = __start___sms[0].driver;
 
-- 
2.45.0

