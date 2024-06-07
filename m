Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8830C12FF6A
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800473; cv=none; b=oJ5mgvbEUfL4GXXAboqSptmHktmAYqRGJXaisv9lc/6wm8WOUej6/KvLok2FX/rFw4Rj49u135uOg8xuHj+7mfG0hqbqFaZ+o0wxAnXugX+GOXG9SK/3aDH4UjBWRU6qo15/6fz4TuVBweKwVi91APCz7spEVZUhZVe+cBqdnU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800473; c=relaxed/simple;
	bh=oenWwScYhH6lxXUYh72CYQlds6Qy0EszKgFxHy7c5uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMW18dKnO7jwZBiJtGKVyGRDhSHU86S/i5bFnd+JVNWKEXSc73YNNuG0rjTb2XUjBXeC+9yO46RVrVQNGl7bRdI/4Enl1UO60ZEjRVrQF4qhB8srVdHWp/YxVsm1s5IqrQ6A4r7GQsXqJF1mH26NvpJ95T7md0veDLYELj3jLVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsnsnGoD; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsnsnGoD"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ba74c25fb3so1450877eaf.0
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800471; x=1718405271; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8iTzLM1WfsArapDmALWmBs5nYg7z9haFIa9C4W82QQ=;
        b=EsnsnGoDLWIMGTkDslhXD7zaiLQ7O11xNhfCx+pHENGDB4DgvG+ziBnRIhwXi5e8/C
         oONdg2vf26qhYSwIEs3nR65TDQdWtbhIESLe0+w3SK4eJhTUlPvFXfhXT4qr4QPi0j1k
         Ew8YFy136RVsvgMHTF7qvjTDPQeW+GaAtIyybK8AFID60M969UVswYzm1UCG2fnafRHV
         hBc9yV2BNTvWL7e207T0BTTFCMlb/s/Nk06FWKU/amg0g/OnHu5cJJoK5FH4GSxJ6+jl
         oZzvPAbuz5oM6Gux66AUGFgFR0Jw8Dn8lETKQWejVpxzHS7axCjIVcQRAuBrzMadF9aJ
         Pr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800471; x=1718405271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8iTzLM1WfsArapDmALWmBs5nYg7z9haFIa9C4W82QQ=;
        b=gq4TLUm6BY8nyFGpCapCqlQwu3UoSmVn9vc5DlTlQeOGgEmriQKKU54mvIyl7iyQRA
         zbt6PgKInfCIS9aR+mrNXC+Ym3V51yoVDAUcX5h50FBPq4YPwKRiIryVSDvESNt1H9Sb
         ZLDl1AAM5Fvx+hjXbH6lAqZneYr8/YnFt7JtlvsuG38ya6IeUgQ2yb0fYjV9QtPbHwEQ
         pPsR6Sh1U823R6wybKhIT/WEtKCZWTI02SE9wG79Z2Pe/PZpLIxNbbob3RD9jw9jUknT
         zVp5eHP0WkVfOklH4+ZQSkNgDi2L2O0sxgT+7LMMFEzHgjNQAyzKjOAConpm/8skrA84
         eXyA==
X-Gm-Message-State: AOJu0Yx8U7QZyqzqOXTCZkh00Cs+FxBWJ+vUncYEhucSdbLaYco5npnM
	t7yIFbi+Hd+aaGxJHaaWlF8nGJibGw1u3uwA5+Dwifh60Ur9Gg5zwmA//A==
X-Google-Smtp-Source: AGHT+IGI7tY9t6G18rofcOFvLfOWr0q/Lx1eUVhEevaeEDqsiV6Ei34XLS5nnhjvgFZA1hDGgZ9whA==
X-Received: by 2002:a05:6820:1ad3:b0:5b7:3502:6543 with SMTP id 006d021491bc7-5baae780cfamr4649225eaf.7.1717800471416;
        Fri, 07 Jun 2024 15:47:51 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:47:51 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 04/23] unit: Update unit tests to the new API
Date: Fri,  7 Jun 2024 17:47:04 -0500
Message-ID: <20240607224746.903769-4-denkenz@gmail.com>
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

