Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E0E14A85
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918661; cv=none; b=RFC5NeIvyZ3RWryxyLcRB4uWnDG+81AuBA3EV/mYOJf7nyXkDSUTOthBuD3HjTeA7K4fqucPH8YCjlnsNjVHhUpyePH4lvE0Xi9aKrK2V9HB4bW8rt03HWQyOUZIadCYdli0RAX5dGseOmq5z5SqLj3fdbeNJ6sUinirdbDVtVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918661; c=relaxed/simple;
	bh=853e0YTrzBxFVNKOal1wjGuQymxmWzwwLXGn6lxxpcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLtA9+r8ITFH3M7/TN8AHoPY3ds9zsHQkbYeG83UxY7M8NEHJYysHpjBefFSkAjPErt4+L4YDTJviaML1TOW1qznwHnCi90/hQry4jEj3tSB7nckQj8GYbNliemG+2mKjGXvCeOe0XBHuAk5stOrgYlWeu+cHm8O081g1n34uEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYlOwxXo; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYlOwxXo"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bbbc6e51d0so2283912b6e.3
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918659; x=1709523459; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNTikR/JRjgVCaEx1lI68Gv+EHJDEgHAwWpfcRYSlto=;
        b=hYlOwxXoGplCyXvI3o6IAXTf97qqhQvsvipnM7FpDoGAoa0rrlpVEVDf9Ft55opn4j
         rKNt3chTbOgBc7g1nTCYl5+K7p0qn7M46Ku6mJEtH8dxN46Fq8tKr4RRJnUPDWP3Vono
         vpmOUHwWyJL+KcGXCfwvjA2VuL+5lKv11JHt+vVVamqCLL4V+GIGoBDeRqCNTQsaR4zT
         t74id+T7aE6lYtrjIyaXqG1aozrF/pSQjUtKJrz3sPr3vzTWHVKV7umcQTkK+OrKeJF2
         uD30WStgSJv+hb8I14ryAHJlI9FlXfOK+2kozUdXi6vy4mTFKjDdWs66YU65CiRMJOMv
         Rakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918659; x=1709523459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNTikR/JRjgVCaEx1lI68Gv+EHJDEgHAwWpfcRYSlto=;
        b=pUt4uGONy16du4PV3QtoMUlNsTlJKegIW3clyc8YjREFAaymtZ8TupQ/cWgrhFLe5r
         5ROx1pL7NFqMXXdGuYcnZt3OfFIapXiCqtI5mGsEpfxVra9+UkieWtG8of2tz+S8SpNy
         qwfnmlpZQ65UcvgJW8eO00o2moDj5amfnpoN4RdGu9LtR8hwfIkM3cWGlC3U/LId85Qi
         j6Z3ALXfCcgzi8BJ5rWfHBzYwiHugBmUQ6zjG/7dU0VYGUOsQg8BIearCPuONAi53Lkj
         BzDEhPSiHqNYEcLqCcvU4Ym6TFzM6rgLsmM/CX9iVX1Prqa8qTE8rsmfD4jLWmMPkSRy
         Q1gw==
X-Gm-Message-State: AOJu0Yxb+NTSbVJNpSS+PlqMfxJxWNAXpx6AjDN2Jdf6oi2IJSmSpxxm
	rR/Ptk742FAKBK7UMhbYszBsAnIlum3owzl2V8OjTk9NIzq8liVStx7A4HfY
X-Google-Smtp-Source: AGHT+IHTDe3N5oRFnllLyeI1+cyLWjuSn7382KBPGz/c3CRTztgIn9zvfEWtb9zqq7rhkShEltuo4w==
X-Received: by 2002:aca:2812:0:b0:3c0:3266:d87c with SMTP id 18-20020aca2812000000b003c03266d87cmr5638289oix.45.1708918659231;
        Sun, 25 Feb 2024 19:37:39 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:39 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 20/22] network: Drop g_strdup use
Date: Sun, 25 Feb 2024 21:37:03 -0600
Message-ID: <20240226033724.1460079-20-denkenz@gmail.com>
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

Replace by l_strdup
---
 src/network.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/src/network.c b/src/network.c
index 7516d9d00210..fda19a24bfe5 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1124,21 +1124,12 @@ void __ofono_netreg_set_base_station_name(struct ofono_netreg *netreg,
 	if (netreg->base_station == NULL && name == NULL)
 		return;
 
-	if (netreg->base_station)
-		g_free(netreg->base_station);
-
-	if (name == NULL) {
-		netreg->base_station = NULL;
+	l_free(netreg->base_station);
+	netreg->base_station = l_strdup(name);
 
-		/*
-		 * We just got unregistered, set name to NULL
-		 * but don't emit signal
-		 */
-		if (netreg->current_operator == NULL)
-			return;
-	} else {
-		netreg->base_station = g_strdup(name);
-	}
+	/* We just got unregistered, set name to NULL, but don't emit signal */
+	if (!name && !netreg->current_operator)
+		return;
 
 	ofono_dbus_signal_property_changed(conn, path,
 					OFONO_NETWORK_REGISTRATION_INTERFACE,
@@ -1790,16 +1781,14 @@ static void netreg_unregister(struct ofono_atom *atom)
 	g_slist_free(netreg->operator_list);
 	netreg->operator_list = NULL;
 
-	if (netreg->base_station) {
-		g_free(netreg->base_station);
-		netreg->base_station = NULL;
-	}
+	l_free(netreg->base_station);
+	netreg->base_station = NULL;
 
 	if (netreg->settings) {
 		storage_close(netreg->imsi, SETTINGS_STORE,
 				netreg->settings, TRUE);
 
-		g_free(netreg->imsi);
+		l_free(netreg->imsi);
 		netreg->imsi = NULL;
 		netreg->settings = NULL;
 	}
@@ -1864,7 +1853,7 @@ static void netreg_load_settings(struct ofono_netreg *netreg)
 	if (netreg->settings == NULL)
 		return;
 
-	netreg->imsi = g_strdup(imsi);
+	netreg->imsi = l_strdup(imsi);
 
 	strmode = g_key_file_get_string(netreg->settings, SETTINGS_GROUP,
 					"Mode", NULL);
-- 
2.43.0

