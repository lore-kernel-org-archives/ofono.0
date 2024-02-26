Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1042814008
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918662; cv=none; b=gO2Z5emaExEjZH/4UWeW8aWgPg6v/GBZ4Q/nx3hcA5vQOXZh2f4Awcu3/Iwcuk9Wh/SWDqv+KVgaF0OjNWskEVXrJQ/ziZmdnpqA9wMGR+brAG/P2HggJnR8XybmPfFGhZDihVAMWAD1HZPAG4ZfWujCOqQBTkzmFxymNa83zWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918662; c=relaxed/simple;
	bh=11P2oredsF+yUwdvM/TKGuixsdJi1fMi7rABCm1N5EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dk3KYpYOT2vZ4r8SnRAxX8w7lUtuAHSlNwA9T0d1yjOKCXVWxBf0hWCgkzxnb1DhLjDsHgLuQoj0kyk8ctBDpDZtvgqGBQwFMRfTu8YrwHR9eFq845Bk3c5v3x1e7b3VaSzj7BU9VNDnkvhWCRsTrDFLijCX8yL9xzltVqyCetY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmhGFYVp; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmhGFYVp"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c1a1e1e539so550835b6e.1
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918660; x=1709523460; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tv1gqC2kJaY7yJt4YSIu2jLBteRfGngAD12zojg11lw=;
        b=VmhGFYVpDq1NOSNkOo2CT0VVZDa8kBcDSByfsz4a2AOR3C/aZO9Vlcl4rmpKg4Yyu7
         bDyZx9Jzkwm1+gu81yWBM/svNdC4KBW97zqJD1zf4nmFLOr0p2j3WCRmGLlnOPy6ck9X
         qvfwbRdFMbPTMcBp1Ogjpwb4gxKkl5yBhxeV9+iCvpInQVrl4WsOT7nEO423aJUnglgT
         ipBPolrngfpJOmk92ouBKOx8JNViIZsRUWxsaJKxcvkNPP9ONNVm3M026H8te2u+K1Zm
         7TArHukTJHhIqiCsXxAW81Z3Tu1MnDBTsdu53Fxf5xKJMmoYNAL7ARZ53gE3aI/mrRDG
         LDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918660; x=1709523460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tv1gqC2kJaY7yJt4YSIu2jLBteRfGngAD12zojg11lw=;
        b=Emi2Pyv4SUBPPJrDTkXyrISGBdQG9LDpGFqmXB6b60x4lVvYjxMU505YIK5BrLW0h+
         rlWZFjssZ6NgPuprM1OI3aM51Duh0NW8x56qicAORbY6KmyIxLB8ed7tiWXl8n+S9GRo
         0+2CZ+SqAMjdtm7X01+6WaVCQFRKg26goN1ZsHkbHP4Qxd/2MF2fxztFHEtzQlcw/yzH
         33eO2TmQxCpdn0KRn28sMBBiuGFmNTGTj3RkAYtPTlmAdVY+szp7UKWgadtz3EDjJ9j7
         2XiWCEbkJ6qF6Yhvc/E3T2lktYaYd3WbMEyQzYVgkxsUdoE7lDfqUyRYdWmHCegk2+Ca
         7Vqg==
X-Gm-Message-State: AOJu0YzBiMDL9sctCfLnAyXImhVOGONcaCCdaPQbeE37ZprCpYFKa2YJ
	9KAJJEA2FoJ5MaiBDx8qUiqz/DOI/Lt2s2AdSWURCV1CGAzMbc2/Q25cICZg
X-Google-Smtp-Source: AGHT+IE16Gbot7T2VXJZenTTM4IrcTxi5mGl3OkvD/8K20JJVQSr0NOXL+q1mADzZMBH0/QvIx3Mlw==
X-Received: by 2002:a54:4003:0:b0:3c1:8dcb:bdbb with SMTP id x3-20020a544003000000b003c18dcbbdbbmr6633905oie.20.1708918659916;
        Sun, 25 Feb 2024 19:37:39 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:39 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 21/22] voicecall: Drop use of g_strdup
Date: Sun, 25 Feb 2024 21:37:04 -0600
Message-ID: <20240226033724.1460079-21-denkenz@gmail.com>
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

Replace with l_strdup
---
 src/voicecall.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 6882153aa671..fb211b48e2f2 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -160,7 +160,7 @@ static void add_to_en_list(struct ofono_voicecall *vc, char **list)
 	int i = 0;
 
 	while (list[i])
-		g_hash_table_insert(vc->en_list, g_strdup(list[i++]), NULL);
+		g_hash_table_insert(vc->en_list, l_strdup(list[i++]), NULL);
 }
 
 static const char *disconnect_reason_to_string(enum ofono_disconnect_reason r)
@@ -302,7 +302,7 @@ static void dial_request_finish(struct ofono_voicecall *vc)
 		dial_req->cb(dial_req->call ? dial_req->call->call : NULL,
 				dial_req->user_data);
 
-	g_free(dial_req->message);
+	l_free(dial_req->message);
 	g_free(dial_req);
 	vc->dial_req = NULL;
 }
@@ -354,7 +354,7 @@ static int tone_queue(struct ofono_voicecall *vc, const char *tone_str,
 	if (entry == NULL)
 		return -ENOMEM;
 
-	entry->tone_str = g_strdup(tone_str);
+	entry->tone_str = l_strdup(tone_str);
 	entry->left = entry->tone_str;
 	entry->cb = cb;
 	entry->user_data = data;
@@ -381,7 +381,7 @@ static void tone_request_finish(struct ofono_voicecall *vc,
 	if (entry->destroy)
 		entry->destroy(entry->user_data);
 
-	g_free(entry->tone_str);
+	l_free(entry->tone_str);
 	g_free(entry);
 }
 
@@ -688,7 +688,7 @@ static void voicecall_destroy(gpointer userdata)
 	struct voicecall *voicecall = (struct voicecall *)userdata;
 
 	g_free(voicecall->call);
-	g_free(voicecall->message);
+	l_free(voicecall->message);
 
 	g_free(voicecall);
 }
@@ -2623,7 +2623,7 @@ static void set_new_ecc(struct ofono_voicecall *vc)
 	g_hash_table_destroy(vc->en_list);
 
 	vc->en_list = g_hash_table_new_full(g_str_hash, g_str_equal,
-							g_free, NULL);
+							l_free, NULL);
 
 	/* Emergency numbers from modem/network */
 	if (vc->nw_en_list)
@@ -2634,7 +2634,7 @@ static void set_new_ecc(struct ofono_voicecall *vc)
 		GSList *l;
 
 		for (l = vc->sim_en_list; l; l = l->next)
-			g_hash_table_insert(vc->en_list, g_strdup(l->data),
+			g_hash_table_insert(vc->en_list, l_strdup(l->data),
 							NULL);
 	} else
 		add_to_en_list(vc, (char **) default_en_list_no_sim);
@@ -2653,7 +2653,7 @@ static void free_sim_ecc_numbers(struct ofono_voicecall *vc, gboolean old_only)
 	 */
 	if (old_only == FALSE) {
 		if (vc->new_sim_en_list) {
-			g_slist_free_full(vc->new_sim_en_list, g_free);
+			g_slist_free_full(vc->new_sim_en_list, l_free);
 			vc->new_sim_en_list = NULL;
 		}
 
@@ -2661,7 +2661,7 @@ static void free_sim_ecc_numbers(struct ofono_voicecall *vc, gboolean old_only)
 	}
 
 	if (vc->sim_en_list) {
-		g_slist_free_full(vc->sim_en_list, g_free);
+		g_slist_free_full(vc->sim_en_list, l_free);
 		vc->sim_en_list = NULL;
 	}
 }
@@ -2692,7 +2692,7 @@ static void ecc_g2_read_cb(int ok, int total_length, int record,
 
 		if (en[0] != '\0')
 			vc->sim_en_list = g_slist_prepend(vc->sim_en_list,
-								g_strdup(en));
+								l_strdup(en));
 	}
 
 	vc->flags |= VOICECALL_FLAG_SIM_ECC_READY;
@@ -2723,7 +2723,7 @@ static void ecc_g3_read_cb(int ok, int total_length, int record,
 
 	if (en[0] != '\0')
 		vc->new_sim_en_list = g_slist_prepend(vc->new_sim_en_list,
-							g_strdup(en));
+							l_strdup(en));
 
 	if (record != total)
 		return;
@@ -2827,7 +2827,7 @@ static void voicecall_load_settings(struct ofono_voicecall *vc)
 	if (vc->settings == NULL)
 		return;
 
-	vc->imsi = g_strdup(imsi);
+	vc->imsi = l_strdup(imsi);
 }
 
 static void voicecall_close_settings(struct ofono_voicecall *vc)
@@ -2835,7 +2835,7 @@ static void voicecall_close_settings(struct ofono_voicecall *vc)
 	if (vc->settings) {
 		storage_close(vc->imsi, SETTINGS_STORE, vc->settings, TRUE);
 
-		g_free(vc->imsi);
+		l_free(vc->imsi);
 		vc->imsi = NULL;
 		vc->settings = NULL;
 	}
@@ -3657,7 +3657,7 @@ void ofono_voicecall_register(struct ofono_voicecall *vc)
 	ofono_modem_add_interface(modem, OFONO_VOICECALL_MANAGER_INTERFACE);
 
 	vc->en_list = g_hash_table_new_full(g_str_hash, g_str_equal,
-							g_free, NULL);
+							l_free, NULL);
 
 	/*
 	 * Start out with the 22.101 mandated numbers, if we have a SIM and
@@ -3838,7 +3838,7 @@ int __ofono_voicecall_dial(struct ofono_voicecall *vc,
 	if (req == NULL)
 		return -ENOMEM;
 
-	req->message = g_strdup(message);
+	req->message = l_strdup(message);
 	req->icon_id = icon_id;
 	req->interaction = interaction;
 	req->cb = cb;
@@ -4003,7 +4003,7 @@ void __ofono_voicecall_set_alpha_and_icon_id(struct ofono_voicecall *vc,
 
 	req = g_new0(struct dial_request, 1);
 
-	req->message = g_strdup(message);
+	req->message = l_strdup(message);
 	req->icon_id = icon_id;
 
 	req->ph.type = addr_type;
@@ -4021,7 +4021,7 @@ void __ofono_voicecall_clear_alpha_and_icon_id(struct ofono_voicecall *vc)
 	DBG("%p, %p", vc, vc->dial_req);
 
 	if (vc->dial_req) {
-		g_free(vc->dial_req->message);
+		l_free(vc->dial_req->message);
 		vc->dial_req->message = NULL;
 
 		g_free(vc->dial_req);
-- 
2.43.0

