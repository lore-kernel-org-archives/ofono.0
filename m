Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ADCDDDC
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918651; cv=none; b=kScDW+vET1CZ+OPcLLLKv0L6KM0FR2quvCjEHhXWLyQvg24lujW0oEPoLnb7Z5fd1PLvfHS6JeHYGSKRZUOcnOpApZDarBaXWsUkbMSXf62n4qM6cc/Oj/FEyNN60/g22Au1aGhdJarMZSlulOVh40CkpP8IwarPTIzYFBpqIRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918651; c=relaxed/simple;
	bh=Yqg6kM9jR4uTfPXFa5wbUMQJuQmlI0viVhGWa228Coc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nn9dq80IZTjf0UjefbCmT7DW8IMyyFQldaAILrw7mbpGuHPrwO9HuaQs7xotNPMAre/EBcuSDTmCZoK8XFI8g7WgRXPodBLltcogae37fPe9KUBPC94Bz66vpm6fLOXKHFKCf9NGmxnWkk0S8CxoXjyJPkCxr0IVtNs6XoUONCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYJt8BaX; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYJt8BaX"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bd72353d9fso1764544b6e.3
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918648; x=1709523448; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXVZJWfzInCZJjgsnorccpxG/jTaPR6G0g9QoTxxzi0=;
        b=fYJt8BaX5qcMsdExYks1d62/uKYCV0iAcGbGcfYHUnscRb7uZBtej1xNhjotCvn4nq
         WZmtQLaZymrkK2A+gh4aRULmyjQy5HpvTgVZ+nRRPF2oBAuGm1CkQOeepAWaHeDcgUtT
         LFUtnhN60WNCQ+c0bAPKjGQrZgtyYSEc4t6ttEAl728CpxpQJSHlUh8RutBIXAH7UD4E
         CJswia/lR5XeZSKJMlFcs2wLWBKGbz/r+J3IYMPrReJiQ3n87FA0E8587OpF4qARBn+R
         NoDyDu2XOZn4uS3eJBLEktXtgo3YCSz7LNdbHOhUGmTorz72io0TgZg+gdN7B8w4z37x
         8l1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918648; x=1709523448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXVZJWfzInCZJjgsnorccpxG/jTaPR6G0g9QoTxxzi0=;
        b=wnYwQ18ETsesPd/I3zf2qhXRK1aChkCocz0l2ulXMU7xWIMHmjtagPGBgvAjWEr5h3
         /GScZLZQdc208HPDb2fPsk2aYL8ZYhWQlYC7DfFjV12lZb88Ci45H0MQ/BScctvh95h7
         he436/MakbrYERI9UBAO1ivgu7Zqs1sdf4GZfz6wKfcLmomSl76siad65EEC/dStJ2DQ
         2KPUpomdCqnV6zn1GpEWHabrCHLwSnMJzp8gsS2LhXVZLGkTQr9rRHJU/TZhhB4dHi8+
         H3HKTERUsHoZ/3rkYx4vXxssPi8KOO/vqz4YgVenEYd5OMfSHxcB91Oq3dBXtRobk+SX
         hhJw==
X-Gm-Message-State: AOJu0Yy3okKdCFtf2HaRAmUWKtb/S6QwbZvFMXgFzZpITknt86AdFNfp
	XElaInJTYAkiGw+b+k77qgsbDT2KCjcAwte5eipRM0zEr2a2ORGmCuc/3hHs
X-Google-Smtp-Source: AGHT+IFpJiSl920Sqrpe/kHW4Gxds5Y+tLSQbhxOIs1ODRtWZUhr6DXwoVSzrcOrbPlApmd1p/JF1Q==
X-Received: by 2002:a05:6808:aa9:b0:3c1:66ec:5aa with SMTP id r9-20020a0568080aa900b003c166ec05aamr6687843oij.22.1708918648678;
        Sun, 25 Feb 2024 19:37:28 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:28 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 04/22] voicecall: Remove g_strfreev and g_strdupv use
Date: Sun, 25 Feb 2024 21:36:47 -0600
Message-ID: <20240226033724.1460079-4-denkenz@gmail.com>
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

Replace by l_strfreev and l_strv_copy
---
 src/voicecall.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 6d677a9a7487..6882153aa671 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1092,14 +1092,11 @@ static int voicecalls_path_list(struct ofono_voicecall *vc, GSList *call_list,
 	int i;
 	struct voicecall *v;
 
-	*objlist = g_new0(char *, g_slist_length(call_list) + 1);
-
-	if (*objlist == NULL)
-		return -1;
+	*objlist = l_new(char *, g_slist_length(call_list) + 1);
 
 	for (i = 0, l = call_list; l; l = l->next, i++) {
 		v = l->data;
-		(*objlist)[i] = g_strdup(voicecall_build_path(vc, v->call));
+		(*objlist)[i] = l_strdup(voicecall_build_path(vc, v->call));
 	}
 
 	return 0;
@@ -1926,7 +1923,7 @@ static void multiparty_callback_common(struct ofono_voicecall *vc,
 
 	dbus_message_iter_close_container(&iter, &array_iter);
 
-	g_strfreev(objpath_list);
+	l_strfreev(objpath_list);
 }
 
 static void private_chat_callback(const struct ofono_error *error, void *data)
@@ -2747,9 +2744,9 @@ check:
 void ofono_voicecall_en_list_notify(struct ofono_voicecall *vc,
 						char **nw_en_list)
 {
-	g_strfreev(vc->nw_en_list);
+	l_strfreev(vc->nw_en_list);
 
-	vc->nw_en_list = g_strdupv(nw_en_list);
+	vc->nw_en_list = l_strv_copy(nw_en_list);
 	set_new_ecc(vc);
 }
 
@@ -2882,7 +2879,7 @@ static void voicecall_unregister(struct ofono_atom *atom)
 	free_sim_ecc_numbers(vc, FALSE);
 
 	if (vc->nw_en_list) {
-		g_strfreev(vc->nw_en_list);
+		l_strfreev(vc->nw_en_list);
 		vc->nw_en_list = NULL;
 	}
 
-- 
2.43.0

