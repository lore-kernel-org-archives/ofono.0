Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD25337F
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122163; cv=none; b=s8toStJ/yctVT1wt9M6oOObju/2BYgLvII6D7vDOnQtynod3pzels51MY4t9Ke4Wz86O5lX/8f0CUaDurS9oyiCd7N5u+ptBorFGNSGJWv2vpGln6RbLAnYtcBgvcpTZcPW/RCVYyY0duO/LSn208DvDhYLDP30fjMzaszeqFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122163; c=relaxed/simple;
	bh=j8l3Fp3PW4BOpy63MNEM9SvQN4B+Ywm2uNjjgwlpAoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sn8JPFEQJMsE2vW8Y1kKoXMgGHsdc53/GgmoWQMDWfapk6YpQLJ5RdHHED5UBmlr695OmINScOK3tdKOntkWgkKMWZVeBvFd12oxK7bABk0Ts+HZObjvE1WYYw7njPUrYHN2kxe2v0+S+ctG0v8pEM5pR6ekcZGAjaH8DTqKkjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4bmgqVL; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4bmgqVL"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e519d73850so1414649a34.2
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711122161; x=1711726961; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eMyaSEp4kL4adxi1Q9+/pXvSoD/evuGdShsvZRKch8=;
        b=D4bmgqVLeTj8eUK0e8DUEo/hWGA+9IeXqXSFHERJtYmIDkIaaPP9RU9ldtcadjRGEF
         YmNhc6ZR1gb6hxJ5LtMwlV+VxMGIG/UW9JIxNr5J+a2Dw+1ZMc+0JsYFu3CT/hwhv5iu
         c7d7a9FYUuC8tBog/vUraSGbzXQyIHDYFBv9DTomVrjOaapgz7CQ/Dg/6MqXhEvSZLns
         B786PhopuVkcnety0J/lReZOdgX99+FDYDiD9lT0eHuMjTTwCGhJOmaRXyaziOEIY1II
         mA3CoUSnwjqCqm/Tketp095+ubEY1BNhs2GkwPwEbvpcZO6cfYek/I/WADKOk30rvEhl
         IOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122161; x=1711726961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eMyaSEp4kL4adxi1Q9+/pXvSoD/evuGdShsvZRKch8=;
        b=fpF0ts5QtLUIQQv54+9nlvVBAArtMWdtStN5dC/oZ9rMuuud6Ri/1QnEYojShm8Ufo
         yPrlmDPTS3G0U9CQFVTBIvDKyrAq6aRWxTeIH1F1/KCiyy+7ItAMVrlZqFkZecXzYthF
         f2CA5M3H7F9jXw5RYyXJCAduY5blz15t5q9rponCJmdBrsR4cBbd6TKhSGcun+c4HuXb
         pkFsKU8MpaSZRh92+xZrQIcE5oA9QZqTOfMSaBVCa39Ydzzf50ayZ/9zfR3aWwTM91Z0
         cQnBLJxpehmRJvB1aJx9ugL4k+xWBj6aoV3nMUQYw5R6heosDHwvRxEqDbPSzX0aViyu
         Dxkw==
X-Gm-Message-State: AOJu0YxVsSQJfMvbnOZwVYjejhKbQdJqLVRPkZRpK3p6hDjBaEkDICNA
	Z+VyEwMHRZO7q642cc0OxFveDSqXXIbjQ4xyM8GNi7N+HfCrQfGqtv8jMPzA
X-Google-Smtp-Source: AGHT+IH1vWf2VAGEYENlub3hHANyZR95V6YrLp4DPt53tgI2iLmiBRRZBdL2hklkNTSUZmsJ4CTjSQ==
X-Received: by 2002:a05:6830:204d:b0:6e6:775f:c217 with SMTP id f13-20020a056830204d00b006e6775fc217mr2672479otp.35.1711122161458;
        Fri, 22 Mar 2024 08:42:41 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id u12-20020a9d4d8c000000b006e6763530e1sm386538otk.61.2024.03.22.08.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:42:41 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 07/11] gemalto: Set modem lte capable
Date: Fri, 22 Mar 2024 10:42:20 -0500
Message-ID: <20240322154234.2720542-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322154234.2720542-1-denkenz@gmail.com>
References: <20240322154234.2720542-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 plugins/gemalto.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 358d56a7aaf1..219354f7300e 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -217,11 +217,17 @@ static void sim_state_cb(gboolean present, gpointer user_data)
 {
 	struct ofono_modem *modem = user_data;
 	struct gemalto_data *data = ofono_modem_get_data(modem);
+	const char *model = ofono_modem_get_string(modem, "Model");
 
 	at_util_sim_state_query_free(data->sim_state_query);
 	data->sim_state_query = NULL;
 
 	data->have_sim = present;
+
+	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x) ||
+			!g_strcmp0(model, GEMALTO_MODEL_ELS81x))
+		ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
+
 	ofono_modem_set_powered(modem, TRUE);
 
 	/* Register for specific sim status reports */
@@ -609,7 +615,7 @@ static void gemalto_post_sim(struct ofono_modem *modem)
 		ofono_gprs_add_context(gprs, gc);
 
 	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x) ||
-	    !g_strcmp0(model, GEMALTO_MODEL_ELS81x))
+			!g_strcmp0(model, GEMALTO_MODEL_ELS81x))
 		ofono_lte_create(modem, OFONO_VENDOR_GEMALTO,
 						"atmodem", data->app);
 }
-- 
2.43.0

