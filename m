Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC8D156CF
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918657; cv=none; b=YJb3yqP/muJX88ub97IsjuFcICSVQIgnyNxLVpXDGLRQ7Sl3sZYUYiyJrUZkz9xEb/6g3uM0B3K4wKRsk0yeM4e59tH0JK0ALmP13dqazMGjIBik5ifNvVWUtHOFqX2Vc+mnd8FVd4ibL3E2VWQlcpgry72+i3fv7HvvFWy39xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918657; c=relaxed/simple;
	bh=r2GcZxnhBIq0PcPjxFp2pLCICfCDt8K7XPVzx49zWjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/TzhoOqqnPGnRpualHq6ywwzakRjwPQTEDLAYsU08AU8ePwN5j//DzdiC2A+28c6Cn99wzG9MTQm+ZtqjjwXB+nNeNZx7iWFjZ0Z6BIvUUOLOWqCOrQKe/wzdsfGB/AkIvAb80OGPHDXQ0GJliBJm5HIwgKqdyfmXZrbKPUfZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYQFQi//; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYQFQi//"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c1993331a7so1082432b6e.1
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918654; x=1709523454; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiPsyDLa3KfVrmhaONLGjgtJdYBAbMGnB5WjyJn9lrM=;
        b=JYQFQi//xGEk0emXWaWOSMaWmE3esLuhf0Tm1LHjnnDtE5U8nRD95HqEloqtEHx3hd
         Yb9aTmWKbsVhZmWvRKXP61GgTzQME5Y+AYpdOxdlkKsD3xq9msoZ/PTtw2Na46UooJf1
         V90a9MYMgMiw7L9YQfJmm4vamrLGhXF2mwzj1rO/wq5yDiT8HWnVWj/EBCwBNbyS1m2S
         QXednffCOdi7zHF0q7EuawVhazI+CNCjQZ+xcz1QIRU6GI9bni1fLdyceD12RI+NvGK2
         YNNW4cfbpG8V095ADDZbu+wn2PiWztqIcHm1jLlOp/ik/onYp1Z43tEmNnIZc4EbHuUa
         DTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918654; x=1709523454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiPsyDLa3KfVrmhaONLGjgtJdYBAbMGnB5WjyJn9lrM=;
        b=INZ3kCxwpm2Fby3wOZ0bFz8oDk+X/eQB5WquxJTADl1zbRqoA/E2vkvFBxgaJ7LRji
         0ujwrhH67C2LFmxfRBMZ4ZJcbLUvoQkEOYjZWCjHXnOUXki6DyTZCscIEfj1KBwZR0hP
         nWjPqD9Rny5wEYMvgD94z6Vkq5D+WJxrxfS+Pu69zA/4LSHyxeUiZSb3A+XpK8vIFBy1
         SwA0JAjgXMtR6s7RY8JfRHEJZxgDbY/nDt5Ggnxr/V7YYnFjMYj4MmxuqJqBbRXdnjUi
         d0DPklllBUvYxp5Jehknkyl9pYdcujfgwTo+iNMb7AJI1mYGkEo7QfbTYkI/f/Va4Xxy
         PJuA==
X-Gm-Message-State: AOJu0Yyq4IBw77dL52sD0bsfQPrptj+SY6D0L1wg7RmiKm55ld8nKABi
	fnkg6DmuFwVOtm40QDcuRvgXR1bOw6+rCRxUNUbcY28fCb+3PdCbmEnlKpEs
X-Google-Smtp-Source: AGHT+IEA1PV4tsWaDrLwc65aXaIZAOtYRNFFYDGMgSl2/B+/iJK35BZi4DYfcAyLax3S/ZEeQulABQ==
X-Received: by 2002:a05:6808:10ce:b0:3c1:784b:d67e with SMTP id s14-20020a05680810ce00b003c1784bd67emr8175932ois.10.1708918654551;
        Sun, 25 Feb 2024 19:37:34 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:34 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 13/22] sim: Replace g_strndup use with l_strndup
Date: Sun, 25 Feb 2024 21:36:56 -0600
Message-ID: <20240226033724.1460079-13-denkenz@gmail.com>
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

---
 src/sim.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index db65d22f40fd..d941415a4879 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1661,7 +1661,7 @@ static void impi_read_cb(int ok, int total_length, int record,
 	}
 
 	if (validate_utf8_tlv(data))
-		sim->impi = g_strndup((const char *)data + 2, data[1]);
+		sim->impi = l_strndup((const char *)data + 2, data[1]);
 }
 
 static void discover_apps_cb(const struct ofono_error *error,
@@ -2721,8 +2721,7 @@ static void sim_free_main_state(struct ofono_sim *sim)
 		sim->isim_context = NULL;
 	}
 
-	if (sim->impi)
-		g_free(sim->impi);
+	l_free(sim->impi);
 
 	if (sim->aid_list) {
 		g_slist_free_full(sim->aid_list,
-- 
2.43.0

