Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD525024E
	for <ofono@lists.linux.dev>; Tue, 28 May 2024 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716924756; cv=none; b=QKvBJuSBwgPKi0uL5UhCCv1Ka+WqwSXg7gInoD9BA/jlSbFCjlNHu6d8mjDWs0VxGB7/ZIGLgKeeHM+JFltEQg5WGys8g8K9jXCUZK1wGs4z5bUgXPal1/bwdcgzMEWYU5LAELi6m4caLXkK2rRRu56jCWu6etvjhZ6+sT94G48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716924756; c=relaxed/simple;
	bh=0D0p/8Kp3OoQExtgqDmAynXZDXvJ8SgQyeN0nhHAs0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4HSu+v316hiTw2WFekArfBK1zyhMrlh8cfESVaenit8V1/ZPPVcCTUT6UNdsOJc6YT1UqVZTFXFWW+sNulPDyfcoas3IXR4WNVxXHT87aTOfYGQcum5kEOJXDF24lwOVqHD2CsdJGtHzb/7gTBXgEKjJUHZRRWtKzBkoSFDJuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4LKHDL/; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4LKHDL/"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b9c7ae2c98so487761eaf.3
        for <ofono@lists.linux.dev>; Tue, 28 May 2024 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716924754; x=1717529554; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3CVvgFIfWCnZzpiTjvVe9pN2eG5j6cHqk5YDi7p2iQ=;
        b=P4LKHDL/VEqvadZfCTuX3KvF07YaVbUzUqgzKFCS4HYFkggjnyRXZresqM1cfW5DVK
         y2bsU+TQ8+oC1XcqIFeQVawZSgDovquD1afcSTHOsgYB4wNMZb+DN64m7PjZDi29ZeYR
         tiSsyZdLPGvmmKHeySujHMN1tF/rZWTzPc1Wdb0n8wk/b6crRg15+mmocAYmGj9A0TM/
         blbo54TL+Rpamwnh395y1Yd369bitZ4ia4raJ9GZ4VW0irgQwK6V1HLVjebb6kouvimQ
         xDCqdu5QUJwTCAA1UKH5+DX3cDQqC74WDMNKTY4eQfJLUNZ9UI1rSQRNvcj7BF8LhgCX
         +m8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716924754; x=1717529554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3CVvgFIfWCnZzpiTjvVe9pN2eG5j6cHqk5YDi7p2iQ=;
        b=Z7CLUixRrTpuwfmzzuTsaJH7SdKBGdUTgVDnTVKutS2VOqhCYFBsi8Y/LBxXoHHcz2
         CUtQz1Kink+VKzxo95BS2WZDFYnoVa8rpDqrGgk02CGmCZ/egbm0MlhMKbBenvpoHGf7
         BRVPxty6bzyuCnyfvjKVlipDV3C/EsT9HK/tr1WDL7QiCbB5nszv2+Eqf5BHyGGL8S2P
         GPcG9B45BFICdnNX4EO8rgdQAx3e5hJcPT5CH/fPn203UWnCfQvyVWVymyoqbYSfg5AE
         zV20PGfXgXWEQnX46lGyA7wg+TbiyfXc+7tq6BVujDKXSvpXK0Uxz0bxQOXK7vJH70Nm
         a1Fw==
X-Gm-Message-State: AOJu0YzyuymRJ+IrtFO93wtTnAnxbHdJYGj5PDvTfu/S7PLK2mbOlgXj
	6lkNbGHnjKNVJVc8czonecitth1NF7VloNUfRLVo2CIh2s8CK1kZzRqblg==
X-Google-Smtp-Source: AGHT+IFqC03HWi0dgLGc5DqvphyRGPKFjJ8PEmcFZGg/BgjbR6rDshVP1az3W7gvzSYVQftBz/66rA==
X-Received: by 2002:a4a:ca0c:0:b0:5b9:d198:e4c2 with SMTP id 006d021491bc7-5b9d198e860mr544442eaf.1.1716924754032;
        Tue, 28 May 2024 12:32:34 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b96c699953sm2278337eaf.31.2024.05.28.12.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:32:33 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 3/3] qmi: Use l_basename instead of basename
Date: Tue, 28 May 2024 14:32:21 -0500
Message-ID: <20240528193229.225499-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240528193229.225499-1-denkenz@gmail.com>
References: <20240528193229.225499-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/qmimodem/qmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index ce42e23c57f2..5b016f2d1227 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1154,13 +1154,13 @@ static char *get_device_interface(struct qmi_device *device)
 	char * const driver_names[] = { "usbmisc", "usb" };
 	unsigned int i;
 	char file_path[PATH_MAX];
-	char *file_name;
+	const char *file_name;
 	char *interface = NULL;
 
 	if (!get_device_file_name(device, file_path, sizeof(file_path)))
 		return NULL;
 
-	file_name = basename(file_path);
+	file_name = l_basename(file_path);
 
 	for (i = 0; i < L_ARRAY_SIZE(driver_names) && !interface; i++) {
 		char *sysfs_path;
-- 
2.45.0

