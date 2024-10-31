Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A41BF311
	for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412407; cv=none; b=IL7F1EcnBx5eJYQ5BPVCNwKnVHAecrtKr2mWbYzM+cdADICij/erGQ0B4dDGRIiMUJnV0F2BwYL4uEq/Vwnw/wa3XjwU/jTewSBAUWsLLGGFJSHLyIaHwVdYj/3EwaOWmUnFKVtvk7XEDr3YtcjH7phNTwb8iL/J91ACeX4BLaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412407; c=relaxed/simple;
	bh=O9NDoYm5BfihaP6TQdznlFB2ncPu5Sx3anqsMe6AiWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OirHIuKX8h72jvfHb9A5Y8iip+r/QrMkeWcbfQVcVD2b2MfF75eZLqU8rPe8mV7KuJo1+9B03bQ19ktSi3OF3snAYeV96N2hWL/zqVSe3SVQNjvYzIg9Adqsg3RMRY4EcJ1vruBHeIyyMRypSCCmEWRUD/ACs8u0oZcKRSVshDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUzU/9/J; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUzU/9/J"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7181eb9ad46so708542a34.1
        for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730412401; x=1731017201; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTEFh79suQnSWdh1U1OosoBGup/bjYSedyxyg2O2A7g=;
        b=QUzU/9/JbPBGRD8FZmKvOAv/ICad/4DlLy9A6X/8jUDR2Zl7i5PoeTHPd2KxkAxKZ9
         WdpVdeXdSV+XYKUXaZQk47ET7xuSF503oX91NecPFBWlqUjrZqVTLflZOgm2f9rF28sZ
         8kAsudiBefvIdlG/hsXDl4AV/PRWwRTXlUWJamftxX38MjJXIB24wrXskv4XLPknk+HF
         6Bkbp5wVOsjiXk8wZ71Hl4sFQxNY21tio2xYD9+icp465MdIj50YARgDRSEOQKBazG/X
         wYaySeYtPMz7iTqKFSYLxq5jJx7QZCL9AQ2xmM/6Diltbu4JhDdol03pFkbiSQbvIlbP
         kYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412401; x=1731017201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTEFh79suQnSWdh1U1OosoBGup/bjYSedyxyg2O2A7g=;
        b=tHMDYZdy8AJXmQz4RkM+SAq3H7eycgh5iJx8G+SzpkFZZ3QFk4Jgc5nmMD/Qf7L8/d
         qCyx5iU8oE2ZiWjBO7a7SzSUmgyvs4nk9bY7xjkVLNi+2vqEYJaWcCvGB/e9fTAJtRJl
         EAmb8dTMZASgajUsF4bEJoY5HI6QO+G3W1xl8gOC/bhkg1Bg+TtM6x6wE0DKr9AzUCFx
         K+rE736kCZOCnnfPLaYNuwNlbeCEChKg9FzdrBHo+fJdihbHqE1zzLB0ipS5O5M7eWqs
         QDqZBEI2rzpCsMl+u0NAsThUyOUd6Wfcp5ABb171U+V3P+sJwjAIISHfLzkL0rHzH46M
         +mfw==
X-Gm-Message-State: AOJu0YzAdbkeDPeMrJZqGTlsXWwr4ZpyDNkmwV7dlmMEHbQ54e4P99sI
	j6CF3yqlUVpQGg+OEmWwxK8qQYK5BEWrkcox+wtfB5RCK1Tzvr/8U2Tfow==
X-Google-Smtp-Source: AGHT+IEE6tEWTL7IyjNMDorF26XFyK3tOBed1gy115igVdZWts48yc+MM9Rz4ts0xH1hzv/gFknMrQ==
X-Received: by 2002:a05:6830:6e91:b0:716:a8d5:d501 with SMTP id 46e09a7af769-71868229580mr21226051a34.19.1730412400710;
        Thu, 31 Oct 2024 15:06:40 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cccf4a7sm507577a34.73.2024.10.31.15.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:06:40 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 02/13] gobi: Clear out service request queue on shutdown
Date: Thu, 31 Oct 2024 17:06:09 -0500
Message-ID: <20241031220638.1582166-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031220638.1582166-1-denkenz@gmail.com>
References: <20241031220638.1582166-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not doing so can result in a crash on subsequent .enable() calls

ofonod[365853]: #0  0x743188e15ae0 in /usr/lib/libc.so.6
ofonod[365853]: #1  0x472b94 in request_service_cb() at plugins/gobi.c:475
ofonod[365853]: #2  0x45ce9f in qmux_create_client_callback() at drivers/qmimodem/qmi.c:1448
ofonod[365853]: #3  0x45bd87 in __rx_ctl_message() at drivers/qmimodem/qmi.c:993
ofonod[365853]: #4  0x45bf97 in received_qmux_data() at drivers/qmimodem/qmi.c:1041
ofonod[365853]: #5  0x597df3 in io_callback() at ell/io.c:105 (discriminator 1)
ofonod[365853]: #6  0x59674a in l_main_iterate() at ell/main.c:461
ofonod[365853]: #7  0x508898 in event_check() at src/main.c:183
ofonod[365853]: #8  0x743189073ae1 in /usr/lib/libglib-2.0.so.0
ofonod[365853]: #9  0x7431890d4816 in /usr/lib/libglib-2.0.so.0
ofonod[365853]: #10 0x743189073787 in /usr/lib/libglib-2.0.so.0
ofonod[365853]: #11 0x508d35 in main() at src/main.c:302
ofonod[365853]: #12 0x743188dfec88 in /usr/lib/libc.so.6
ofonod[365853]: #13 0x743188dfed4c in /usr/lib/libc.so.6
---
 plugins/gobi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index cb20824cc424..b2c9c3d50ea4 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -251,6 +251,10 @@ static void shutdown_cb(void *user_data)
 	DBG("");
 
 	data->discover_attempts = 0;
+	memset(&data->service_requests, 0, sizeof(data->service_requests));
+	data->cur_service_request = 0;
+	data->num_service_requests = 0;
+	data->features = 0;
 
 	qmi_qmux_device_free(data->device);
 	data->device = NULL;
-- 
2.45.2

