Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98FD246BB9
	for <ofono@lists.linux.dev>; Fri, 25 Jul 2025 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446024; cv=none; b=a2kXsvuvrINTxe4WtZaZB5jYCjzMn9gfNqYLfMhQYah4PgXi6GHhfrKEAlVBb0Tdd6B3CzNZD6r7NO45sLxC4Lu0+1ZhVmYgkOXf8F9e3xK8RXraei9Btz38PL/sux8JTJCDIJLB+n84pZYJpe4M5mbL31bmmjfFUei4dmVRack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446024; c=relaxed/simple;
	bh=REBIpAWr895xLcwVkbHMINCw797pRuX93MwqP7LuGnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K/A6MHKIudrzolEJ1K2rE5t+17a7Z/wg2rEWsRzIwUwkrzGfyJdPyCZW6XQYl7KjVMBFIfZLdnE+T+9HVO5HhM7LdYcNPXKwSCXPWgsCiMxK/IT81upFAmMe6VEyGvoONiFpBht3nEQERhKTrMadCXhETQsetcrN2Go6UPxr0RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaMgoOsg; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaMgoOsg"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso408957966b.2
        for <ofono@lists.linux.dev>; Fri, 25 Jul 2025 05:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753446019; x=1754050819; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ynj4toN741UP4pW41BfwZYQNQtezeZJh5e/Bt4d8Bw=;
        b=MaMgoOsgF13PlHzU3luCRxrCjVTRhjKQQ4aDKce79iB9dF8SMjt/9khenUH4cDjm6r
         2o8LMuABWFT0kqNn2sFOMjRzRKzmEgHH+Tbh/hIFRO2HlKHbHk41Wv/ATJhz0h6D9xrH
         aVtAUHpX+Ay3cuKsejBbRlWbFewVsEWiyNBq2D7S3no1ZQP0TAs5Wph/bfTIybi4U8Qz
         Ajn8/B9bzmW5Kn9WWy7SY94v2j9yH6gScpOhz21nn0beWIwNpR2Z4htQJS7mNYMKWt/x
         eh+Es7pRTb+ayLvPhJ2K1hu/sMnrQdiVe2P75+VmB2Svy1c5xthmqdxoFLQ3B105gOJp
         Y8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753446019; x=1754050819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Ynj4toN741UP4pW41BfwZYQNQtezeZJh5e/Bt4d8Bw=;
        b=HfkuCb2F0e2YadT8feiu0MQbfEqUj6zsQbCUdXplR6bKWtqTG4z9mcm/vhwoYa+DL6
         iyEILD2x4y6Jn8l5AA8i9Er9tks4jPLJaj3Be1mY9b7oawn5C2C2s8p6ukA1Ug+yxo1n
         Gq+pXAAm/gtpXZPF21+8+gC/UqC7z2mrBjKTDZe/qI8NANs9qhplzmnVAVqIdQBpgSmu
         hpozo8ezGlGSEBk0sXqjAzW8xETo6j/ziUrU7ABDB1HTtG5JrYAAosP8SWgdAwvw6cSh
         +TJ51eCtBBkyLJIDNtyLTX+z0WNuY7GGVKjfdyqxCZEK6tpuzhkLlg9kDYJV8j6/VHvg
         bI+A==
X-Gm-Message-State: AOJu0YwHaNrQ7nydp8+q+qgsU9v9Gwbi72EkRDkkaAQkbUvebvn9bP92
	YRC4AWuRJo+I+QXJ4Th4KoQ4+nkE5OlMPz8HTDa5IbHgHLV3vqqhLQhupdS0eA==
X-Gm-Gg: ASbGncu3+x0g7Uo3aSoKW+2nxFvrdFPxv+AomvFJUvYKS/WZ8DFr3Eek39MuKAYI4ti
	l+r5hcvuNbmlmeMP+ZcsFDgXhZKiXEtsNpK71fNzh4hokwAHMnTPilXoVvO+GPrNv4aOwajqx9G
	DAUmFyUbA1tH4QfAeSyVKUJpBBW1AO4bxOy8Ko5gzHxqJ4b/3I4Nc9Z0KvKpjGT3l+O1GogH5Ar
	Shwdkor+HlICPnGBRoDAykC4mUutJlRZZgUSmbhATXizCWpWiVqBrrsgdok3pt+Y4G5DckKnCUs
	pJwDV6a3fsjevNUbTIw0RPhmOs9lPk2sIU3JIdjQ3LWE0b5/Rik14aYOyKLL4fvLSgN0tTAyQvs
	PABE7m3CwlUtnusMB6YbLpVogV7c8e5FPBiVdZ7HKBt8I
X-Google-Smtp-Source: AGHT+IH+qJYw+5kXvUBTuDPX0RUIGswf7JF1LqgapZTHwjBOXGZ4ivUezPasSGbH62HNyuTZpLMBJw==
X-Received: by 2002:a17:906:c149:b0:ade:32fa:739e with SMTP id a640c23a62f3a-af61c2b410fmr181594766b.2.1753446018406;
        Fri, 25 Jul 2025 05:20:18 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6e769sm264898866b.45.2025.07.25.05.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 05:20:18 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 2/6] gobi: fix start_service_requests() return type
Date: Fri, 25 Jul 2025 15:19:50 +0300
Message-Id: <20250725121954.650668-3-ivo.g.dimitrov.75@gmail.com>
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

No need to change bool->uint32_t
---
 plugins/gobi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 027c4dba..24c68fde 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -527,7 +527,7 @@ error:
 	shutdown_device(modem);
 }
 
-static uint32_t start_service_requests(struct ofono_modem *modem)
+static bool start_service_requests(struct ofono_modem *modem)
 {
 	struct gobi_data *data = ofono_modem_get_data(modem);
 	unsigned int i;
@@ -570,7 +570,7 @@ static void rmnet_get_interfaces_cb(int error, unsigned int n_interfaces,
 				sizeof(struct rmnet_ifinfo) * n_interfaces);
 	data->n_premux = n_interfaces;
 
-	if (start_service_requests(modem) > 0)
+	if (start_service_requests(modem))
 		return;
 error:
 	shutdown_device(modem);
@@ -618,7 +618,7 @@ static void enable_set_mtu_cb(int error, uint16_t type,
 		goto error;
 	}
 
-	if (start_service_requests(modem) > 0)
+	if (start_service_requests(modem))
 		return;
 error:
 	shutdown_device(modem);
-- 
2.25.1

