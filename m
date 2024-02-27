Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DED13A89E
	for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047999; cv=none; b=fBegdHOu08JJt9zgwGKEzLQMZcY1p0LxoeOS0tnI3VwymljyDgYzczNoHj/AVhqkrexkFQW+q865zDJ9ibDNuiQka6k0iXbtnLWhwyj7tfqFOqDU8W9tBR9a8luoGI/C6YXH37t3D2V5U46tlIyuWw7iqsP6mYWFqtwC1dDDNAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047999; c=relaxed/simple;
	bh=FqH937Zd2Psp4Ink2Vg12UW8H1hSlLSy03467Vq1FwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T3F8UGHrGGoFJXoYgfeYNlRVJI2FVbmjowliK5zjivv2a3rrTLElioZdN55ScRJwigLE4t0WNxTih9d8++sBBhiVuSKpSNugibLss/rmfvDvBHVQUs5IWXBhrv3BPOilCf5THUCn5hpX7xJZu3bva+ZEywzWRSMJCTdsB2a5sFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwwqCStA; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwwqCStA"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e48153c13aso2014614a34.3
        for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 07:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709047997; x=1709652797; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kRPZ/wEqfgaM52yETEmxo8qlwUembmUhN8sHz5fGjXE=;
        b=SwwqCStAs5zCSPsB6YFxruYfy8clLRrnr00rzspAGkZXbkZupozBB5PbydPyDpZklN
         VwDVc0jM7DKbna/SSiRu69TYsuRBdFjIvttHGe0p4QJTHGCEhwaCB/C+UGmnwFaUCbXN
         llPwbQ+oUWdphAxqUMa91pFTJ21ii0Ne54JkTRshFowjDdZ0c53EP7bALagoxe086LRP
         I0z5f8qdM9zFMTioIfdKC3mg/CJyhk981VG5k5J1gtNWIC5BsRc9ALPaW2jWCEgTWNJ/
         8DM3YbRo7tGJxg67iQDgjks2p7DMrCgeSVl3osCTvYIy2Uf8aN/O71Gd8+IjEHKxM+NN
         DXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047997; x=1709652797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRPZ/wEqfgaM52yETEmxo8qlwUembmUhN8sHz5fGjXE=;
        b=Zo7D6bk5tzjWSZTI2exIODl7VYtEgt/KvYDdsWRtC3ES16YmsaJ/SYggzfbOU58PpP
         S7LgesW17gCoaaCdJwmyRI/qDima0O1DIzOpd062rJIKJKTl0TLWTO1Zrz+KPbrG+X/m
         pfVzjru2hDAN3mCdyuzbDWT6fM7mgAI6wtHLY/0ww1WF7+/yDHiPfYpvd5Mvrmdi88AS
         fLa3yG9lt+oS5g1ht8GnW/cheYf9RMoI4xiwqtEmxEr41wxxz+48z7gtZJjJueNFFptS
         W8I04WRYLJ/xpu4Toah3VAd6Rj3LskFKhWM8qyBDZ4CDgG9HU0vMZP1IwIjhEQO3GMtD
         Wilg==
X-Gm-Message-State: AOJu0Yx3781jucPnw/DEAWS6jLN7MIVK+JkqhWl6FbtSVKjjYqQupJzf
	k9HZYORStcFEjo/bmixp1IUjie7JaxRkR0F9nrJPoP6p4rkSxmtLLS6kJ8qz
X-Google-Smtp-Source: AGHT+IGEHUKKnT2e4YKBgGnjSFtFMs5uYdQD3InC0Apq8YM/DNkoJAKHkBOGPTUv2qfKKNn8ugiBcA==
X-Received: by 2002:a9d:6249:0:b0:6e4:a1a1:8d78 with SMTP id i9-20020a9d6249000000b006e4a1a18d78mr4588710otk.2.1709047997349;
        Tue, 27 Feb 2024 07:33:17 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id l13-20020a9d6a8d000000b006e477a4207fsm1538589otq.54.2024.02.27.07.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:33:16 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/3] voicecall: Fix memory leak
Date: Tue, 27 Feb 2024 09:33:02 -0600
Message-ID: <20240227153314.1469536-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'number' is obtained using g_key_file_get_string (which returns a newly
allocated string), but is never freed.
---
 src/voicecall.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index d10fe15a423d..f979c46fe132 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -3462,7 +3462,7 @@ static void emulator_dial_callback(const struct ofono_error *error, void *data)
 	struct ofono_voicecall *vc = data;
 	gboolean need_to_emit;
 	struct voicecall *v;
-	const char *number;
+	char *number;
 	GError *err = NULL;
 
 	number = g_key_file_get_string(vc->settings, SETTINGS_GROUP,
@@ -3484,6 +3484,8 @@ static void emulator_dial_callback(const struct ofono_error *error, void *data)
 
 	if (need_to_emit)
 		voicecalls_emit_call_added(vc, v);
+
+	g_free(number);
 }
 
 static void emulator_dial(struct ofono_emulator *em, struct ofono_voicecall *vc,
@@ -3585,7 +3587,7 @@ static void emulator_bldn_cb(struct ofono_emulator *em,
 			struct ofono_emulator_request *req, void *userdata)
 {
 	struct ofono_voicecall *vc = userdata;
-	const char *number;
+	char *number = NULL;
 	struct ofono_error result;
 	GError *error = NULL;
 
@@ -3608,6 +3610,8 @@ fail:
 		result.type = OFONO_ERROR_TYPE_FAILURE;
 		ofono_emulator_send_final(em, &result);
 	};
+
+	g_free(number);
 }
 
 static void emulator_hfp_watch(struct ofono_atom *atom,
-- 
2.43.0

