Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34855242D7F
	for <ofono@lists.linux.dev>; Fri, 25 Jul 2025 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446024; cv=none; b=SR2bhzUd4VWeKCqeKBkv1ANQm52HXkE4Oux3f0eeaYX6J4KPf6KdlkOfqE0T7OfEzUo7AoCEaykklEcAKDBdu8ADA+EYAAsvhu5897+uyV/pH6UxGmmoLVk0ML0mY6BLO5pGyczH4OGb7uCJLh9YekabUqhiIKTP96M+YvbUN3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446024; c=relaxed/simple;
	bh=Y1eQDeHhsDtigcC/HZv9ri3BfkpDcXNy0nNIdZJqxtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XwwqlSmCPaDy9bCMuoggsvS8e4V+UJbRBq8e0QxlTkGD9KbRLd+2tvjyxkVXZcMbee1m88omi9w1JbWp3U0XDx+CF9vVoKnngYjEfPJcqSfp1/ob0lM8w2RsLARCXLyh1EEmElgTincxKERsUHn0y159jU0o8TESy7qQEKgEBiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISHVAOmp; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISHVAOmp"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so2926694a12.0
        for <ofono@lists.linux.dev>; Fri, 25 Jul 2025 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753446020; x=1754050820; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPcYDm7eCCgPjD9njRmIRVwa3ONuc9d3jhrppN220ok=;
        b=ISHVAOmpiE7mSWMJkKi6eMxEMG1RNxLmo3x4uE7N0mHoi17qRGNChrxevUpesWVgdx
         Tgou436smlNe9RjJC+gQzio1YByBojiqtZYRgc5wPSV8mRZUPosevUW4t0PNKYBkPIRW
         /5fUgSAC9a4wVf067FP75qEcVGQxbfjf7bIg7H/ED3Q+cXglXK7IE/tZ/fGfOsufV7XR
         dIK06hNZhWZNNcuiD5hpbgeW5RLO2jtqbJ7yljtdM3m/5hcPLjcpfRrUqASqfhSsuWa7
         e+LOfcHQ9ASS/W5/659a1JyVF/9YoM4kn94Thwf1KFEeNlLxNOzkE2C4pJNSO2sPNsP9
         S2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753446020; x=1754050820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPcYDm7eCCgPjD9njRmIRVwa3ONuc9d3jhrppN220ok=;
        b=UAWHgPLHeJpc5nZjrJN2CCFrNzYvICpKM0eXZvKQUW+z3PpLmKK+gl2Ay67HfxFwzj
         RSpyrmWnPTxRydFOs9tA2LV+nVoZC8qrjFCaNV9L/T1nbWgbnmeMdhkLKJGviNUMh2wj
         PqDI/8R5Iq6Ca2dtNIGhpFmW2ufsFUQXGNLazQk+nRLNXBHf/EYsQl1Wq6gHWb50r0AY
         jdAomv/qWepGwdLQ0pYcNB3Br2YEOHIWvbSlefh+PoiPU6ErhkTl5rHS0xXVrmx6KETS
         TTuflV51Ic15JtQ99EDyPlOT6WqZQFJq94qfMRCKUyBc3turBiOnDuvqXJarWlnecN+F
         rTEQ==
X-Gm-Message-State: AOJu0Yyrn9EZadA/qr++RXVtA+7A4Q+W7Hy4G6yHAcRjRrG28xMPLrXg
	I2SLWq/DkDw6vqutxWmEs66PsxdT9G/maTnT2IJe+NZ8ak1jtPZhPzSlX0TVcA==
X-Gm-Gg: ASbGncvddERzbBevYr92fKeMIOin7ZEow8J+MJG1Mq+gBLpY9e6A1ul4NQtz/fBE6Wu
	BhuYgeqwTd24qyo5cyvc1/rPNNCMuPP2r0defsaaFvtKne8XvHED/EoV+pXL6oJ81BDnF7Hiau/
	imKAj/1z4D4QkZRh5MyC0mQNL5oBXRDv8Hy+jopg5VusspVj02/G0EiA2kfXTUuhNJGqtrIy0Do
	oO0TyIDUBXpzqqyYdvyOy1z6IvyxR+COvC0qyTtqbOVAGEL61UnsYAreD3bn1gG1Jwj+wtUjT71
	EIbjWm1BYBTi1XBr72+kxdzD5z800mzEDk6q6JakyY51pb7udh8aE+hCJSFT+gLsdktuY9j6q+Q
	dF7wXExcddxHXtimOk1kBGUJUhwM6KpEGFSnvycr/HQvx
X-Google-Smtp-Source: AGHT+IGb+/juS3fgvnNDPvkZm8Xb4YPcW2WIuZpAunPte/lg3sFL6BcKB2oad/OZvcItEUWaxS9nVw==
X-Received: by 2002:a17:907:1c08:b0:adb:229f:6b71 with SMTP id a640c23a62f3a-af61b004396mr183391066b.5.1753446019934;
        Fri, 25 Jul 2025 05:20:19 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6e769sm264898866b.45.2025.07.25.05.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 05:20:19 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 4/6] gobi: Do not try to create WDA service if modem does not support it
Date: Fri, 25 Jul 2025 15:19:52 +0300
Message-Id: <20250725121954.650668-5-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250725121954.650668-1-ivo.g.dimitrov.75@gmail.com>
References: <20250725121954.650668-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix create_wda_cb() qmi_qmux_device_create_client() result check while at
it
---
 plugins/gobi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 8af449ae..f908f935 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -717,7 +717,7 @@ static void create_wda_cb(struct qmi_service *service, void *user_data)
 		DBG("Failed to request WDA service, assume 802.3");
 
 		if (qmi_qmux_device_create_client(data->device, QMI_SERVICE_DMS,
-					request_service_cb, modem, NULL) > 0)
+					request_service_cb, modem, NULL))
 			return;
 
 		goto error;
@@ -797,8 +797,11 @@ static void discover_cb(void *user_data)
 	if (data->features & GOBI_UIM)
 		add_service_request(data, &data->uim, QMI_SERVICE_UIM);
 
-	if (qmi_qmux_device_create_client(data->device, QMI_SERVICE_WDA,
-						create_wda_cb, modem, NULL))
+	if (data->features & GOBI_WDA) {
+		if (qmi_qmux_device_create_client(data->device,
+				QMI_SERVICE_WDA, create_wda_cb, modem, NULL))
+			return;
+	} else if (start_service_requests(modem))
 		return;
 
 error:
-- 
2.25.1

