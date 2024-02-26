Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2D14008
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918652; cv=none; b=Jyh39j/P9E8wjd7W3tJECT9Kw5gULTJqgKGemjOc5d8/GzeAQTjOzBsbgtHrp/l9R5gghKDPSUB/tZKJZ2+93m69qDsW/xHuVwf3oRlPubGqsKC8Y/rezkH7t9m0Shkp6NVDBFC2xTBR2p9Wy53I/qES8YUY9LwE9+5JI4OGimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918652; c=relaxed/simple;
	bh=XfbBq4ogu2sbPA3Mhw8F4sg8oBYPKL1RxnOmDlT+yo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZoxWhZd/QME0UU3fXp+eaWZM/MIVyjIrOcYnm4rra3uEqf4yF+QNRYePhcg+uXQvt9XDmyiLIn3rsn9E1QPTxYaxpc+spNbMZl3JQdkU/DEuUo8lfS/s5YZCaBuE7hsJhyszSXvf9B/LH6HC1HN4kxLrPcw6iv0r297P8ApERM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8YVBrjv; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8YVBrjv"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bb9d54575cso2237829b6e.2
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918650; x=1709523450; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuZPdQ0vSqtzIJ9QYWHZgSsXjY8uGUzkPguuHwrq99k=;
        b=Y8YVBrjvsTeqOVdhMFeGjwi3Czq7Q7Zu+A/+DarmPZfRF7QRNcKrAJxITgvoTry+AN
         u46JIa4TKax9p2s4knfV5awXjp4ApHURpw9i/wixyKp1uzJCZvZc/7rW+M7ZRHm3vamH
         zH+Ms6eqxnD1VrhJPTbjwoPJU9r9LFut9tQGfGn85fiH2kkYi3zx7U3UEvi+ni0p3Fjg
         GTkTOZf1ZJOqek+bI56OTH/x3mwbX3Q8aqOLQfIGrM6MRcCEerUKeTlsfNgowZLFACCu
         4JUpRw8+NnJZLhFvwg8qQfB5EwDfXFaQhhZhXxe2Qv80dl8QxMJVwDJ3rOsOQvYRRy2C
         qZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918650; x=1709523450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuZPdQ0vSqtzIJ9QYWHZgSsXjY8uGUzkPguuHwrq99k=;
        b=Ji39sQEBm9Eb+Pv3BmMgOoU8Zb7ZnPwqpF8j6iiU2I34ANIqRBvbJfERcQOrzi0cUu
         UvqAWcA02w20INJhd/BqO0AxLocmauBQUJCu3MgVcdUyC9DPEUKZ5wN/j9CL7S8o/bA+
         1/k6DtbCyURU+I8ifG1sbdweOOArx3+PI6ayUoQdzx41/ghiGWn/3WMdzYMF5Kx8ciSz
         JfeqDQ7CHOJrM++IG6bV/qsAc41/xUTn8j5usOJQA0upha1Hfhbgqs6tALVii4Tm3yQY
         6C9/AiNLPAZXWnTRS/ePGiOepuQRVg1thxXASJsiCO81TCk1bnDc+42FW5mxZmmWFJkt
         HBrg==
X-Gm-Message-State: AOJu0YxG0O+rrsADjHJPtiQJqwJisX/f80g8yAy6YwkQpaRdp0evx9h4
	DGjXJK1LCkxgyLFO8sKkqEtEhz8bS6oYEaNxxD5sF1eeaIqLfoQOuX6Xtx8E
X-Google-Smtp-Source: AGHT+IGQ34c/Hpb0VFjPJ/Vd7j1qdIOjoC9v025FCDbAAudOb/0NYyhlIHplZ3jIKW1+w7AhnLgnOQ==
X-Received: by 2002:a05:6808:d49:b0:3c1:9caf:c0b2 with SMTP id w9-20020a0568080d4900b003c19cafc0b2mr3987834oik.7.1708918650047;
        Sun, 25 Feb 2024 19:37:30 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:29 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 06/22] ifxmodem: Remove g_strfreev use
Date: Sun, 25 Feb 2024 21:36:49 -0600
Message-ID: <20240226033724.1460079-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226033724.1460079-1-denkenz@gmail.com>
References: <20240226033724.1460079-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace by l_strfreev
---
 drivers/ifxmodem/voicecall.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index b5e880ff4162..19304910db38 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -28,6 +28,7 @@
 #include <stdio.h>
 #include <errno.h>
 
+#include <ell/ell.h>
 #include <glib.h>
 
 #include <ofono/log.h>
@@ -797,7 +798,7 @@ static void xlema_notify(GAtResult *result, gpointer user_data)
 	int index, total_cnt;
 	const char *number;
 	int len;
-	int count = (vd->en_list == NULL) ? 0 : g_strv_length(vd->en_list);
+	int count = l_strv_length(vd->en_list);
 
 	g_at_result_iter_init(&iter, result);
 
@@ -826,10 +827,10 @@ static void xlema_notify(GAtResult *result, gpointer user_data)
 		goto done;
 
 	if (vd->en_list == NULL)
-		vd->en_list = g_new0(char *, total_cnt + 1);
+		vd->en_list = l_new(char *, total_cnt + 1);
 
 	len = strspn(number, "0123456789");
-	vd->en_list[count] = g_strndup(number, len);
+	vd->en_list[count] = l_strndup(number, len);
 
 	if (number[len] != '\0')
 		ofono_warn("Malformed emergency number: %.*s", len, number);
@@ -841,7 +842,7 @@ done:
 	if (vd->en_list) {
 		ofono_voicecall_en_list_notify(vc, vd->en_list);
 
-		g_strfreev(vd->en_list);
+		l_strfreev(vd->en_list);
 		vd->en_list = NULL;
 	}
 }
@@ -866,7 +867,7 @@ static void xlema_read(gboolean ok, GAtResult *result, gpointer user_data)
 	while (g_at_result_iter_next(&iter, "+XLEMA:"))
 		num += 1;
 
-	vd->en_list = g_new0(char *, num + 1);
+	vd->en_list = l_new(char *, num + 1);
 
 	num = 0;
 	g_at_result_iter_init(&iter, result);
@@ -882,7 +883,7 @@ static void xlema_read(gboolean ok, GAtResult *result, gpointer user_data)
 			continue;
 
 		len = strspn(number, "0123456789");
-		vd->en_list[num++] = g_strndup(number, len);
+		vd->en_list[num++] = l_strndup(number, len);
 
 		if (number[len] != '\0')
 			ofono_warn("Malformed emergency number: %.*s",
@@ -891,7 +892,7 @@ static void xlema_read(gboolean ok, GAtResult *result, gpointer user_data)
 
 	ofono_voicecall_en_list_notify(vc, vd->en_list);
 
-	g_strfreev(vd->en_list);
+	l_strfreev(vd->en_list);
 	vd->en_list = NULL;
 }
 
@@ -1011,7 +1012,7 @@ static void ifx_voicecall_remove(struct ofono_voicecall *vc)
 
 	g_slist_free_full(vd->calls, g_free);
 
-	g_strfreev(vd->en_list);
+	l_strfreev(vd->en_list);
 
 	ofono_voicecall_set_data(vc, NULL);
 
-- 
2.43.0

