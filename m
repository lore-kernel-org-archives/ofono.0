Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47706DF67
	for <ofono@lists.linux.dev>; Mon,  4 Mar 2024 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584513; cv=none; b=pnmMdj4gqeR0PUd//CP3t99Ae4wzib7Rx3DzqzEgDcC29jFOQLVAlxOUIFguCLwdJuaonehKhvEPbJF65FBQ9ZNwKwROYmrrBUq6tGo7cZO+8p9xyYWhIkr250xglg7spX4/+2QHjILy14HJRQbtluOqDfIYvud8JezQntIeDXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584513; c=relaxed/simple;
	bh=2CUfWYq3y27tOaRpFJ/cbfcDnKbyFcS47qA/7tKm8z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2X8IAUVOjl47jIxAJoGoBN3q6ReXoomfuy/HxEJBtQ4Zh5pAUSlB2KHqxk0WPCCSdD6SMfujLen4UgNsOknmFvgdxRjjtOXLJ3oMuPC6bRdA7dh3gWIW0wacR+f/UVXPB6HhZvLeXfRiYkw+Ng2M732RxpnoJzUruc+qN0M4Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnkzrVnK; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnkzrVnK"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c1ea5f29a6so978287b6e.0
        for <ofono@lists.linux.dev>; Mon, 04 Mar 2024 12:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709584510; x=1710189310; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSoC2qhrdyWQr14EwBaZrLgwGrmKcZu62+6s24z+/GQ=;
        b=fnkzrVnKMQEHwnmzkGzzhyWnhaXKy4tIOG3lnNPUGLSo162fVJy8kiQszUO0D4n934
         wngTuU4aCPFq7eZJAd39U9+AAM4xjwYvxXjLrta3IhHXvh28OwALa10I5W7EgZns9uJ1
         O8inw5p914cluVq4vwXbAG655JXLGy4DAj1ulGbjcpjiI29mRTd3jPWr7kYuYBomflX4
         WyNKLGSbUFPymxmqCZ1EQNvAb8NLzJlaW0uNh41/BRpiia6rsXLaMf5h4oDS0ya1jGVh
         cevxnMzJvO49tzOOqvBCM+BUnVALmZKEG+/xG5Z8FVE3RSbOPYn3hmNjabnr75bSKlIg
         4NaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709584510; x=1710189310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSoC2qhrdyWQr14EwBaZrLgwGrmKcZu62+6s24z+/GQ=;
        b=uOAhgvXWf5pkZCvHjku8WNJlAvaooVS92iPMSS1ixIETbEiINFFmD/mbqYUWcTuFcA
         H+vWajHG9jjF05HFHVAi8wkWhSaVvjTXRQ8vWbB0emcMWAo8Bhf4DUn6ihp04ucM8ndd
         McffNn9wJS/P59MS9bJBMIX/JXjwim/JR6M0bG/1HbjEmyY3PVaH/GXrnQXW1sl3VnK0
         cm4qzYWIYlyzxGgsjMtbS+3GEyqZfcebcDXMmr+Cil7vFi4TLRI4TGF92mg8F6+ITi6S
         Y15qjc3kTHjsyfF+6PgN1iFmqweZwfX1n+0Xr/1JSyz8KPL9bCINlpaqKKcdmdDBqMFa
         KEhA==
X-Gm-Message-State: AOJu0Ywz0LV6O+uLoMFye8hO3PClbO7O7rtCrqO5WmLki/CsUqwzkyEV
	Fs6w7o2iAVXVHle7HpO1S3fkInCaDgbGVKn0/zLUcM0qR2qnRIXCqASpcORw
X-Google-Smtp-Source: AGHT+IFqX1wysD4sTXJ9oWoT/WhzehLyd9mpSv6jY4SlU67Ci5Kax2cAF/g8fjdvXiGJ63ffx/ANyA==
X-Received: by 2002:a05:6808:eca:b0:3c1:c7cb:13f6 with SMTP id q10-20020a0568080eca00b003c1c7cb13f6mr13139597oiv.22.1709584510462;
        Mon, 04 Mar 2024 12:35:10 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 1-20020aca2101000000b003c0408e5b06sm1642582oiz.55.2024.03.04.12.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:35:10 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/5] gobi: Replace g_try_new0 / g_free with ell equivalents
Date: Mon,  4 Mar 2024 14:34:52 -0600
Message-ID: <20240304203506.1725220-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304203506.1725220-1-denkenz@gmail.com>
References: <20240304203506.1725220-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 plugins/gobi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 99a7d5564ed8..8d3b7ef4cdfc 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -101,9 +101,7 @@ static int gobi_probe(struct ofono_modem *modem)
 
 	DBG("%p", modem);
 
-	data = g_try_new0(struct gobi_data, 1);
-	if (!data)
-		return -ENOMEM;
+	data = l_new(struct gobi_data, 1);
 
 	kernel_driver = ofono_modem_get_string(modem, "KernelDriver");
 	DBG("kernel_driver: %s", kernel_driver);
@@ -149,7 +147,7 @@ static void gobi_remove(struct ofono_modem *modem)
 
 	qmi_device_free(data->device);
 
-	g_free(data);
+	l_free(data);
 }
 
 static void shutdown_cb(void *user_data)
-- 
2.43.0

