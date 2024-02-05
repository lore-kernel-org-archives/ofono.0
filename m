Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D2B58ABB
	for <ofono@lists.linux.dev>; Mon,  5 Feb 2024 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707168761; cv=none; b=nsoB0uwfaK3M6VrShcVAf6vveLph3PLi3cvfI/pkbSsvplbXLLr6ldEVyVVDVsI15Do2kJWWlWHwPyB6mhAbe/JSud4Imf4ua2/V1TiwpQm2spOXGyaIToroMM2Vfbterb3HMRXxxKiaaFdgPaSk0KwPDr9kysnxyBQrTUxLzN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707168761; c=relaxed/simple;
	bh=p2Rp7y9jYTVlSOlcLLc10yBJfZYukLIsypUfp8jcSIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQfLdhByY2A6ciHD0wY0uZgij116h08oLVVsLUZu4GMssXbbP14AqFSn0H+TQz0PmVX6k0j7bx1xzoiNE739grdNvN3SP4HNpa8HnorCbhx5/JXqRsDDbzoOaOwQTdWg4omCrR3/pLhX+/NImBOQSHGoAFkgDYFpt3wWY3twNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M43I/rKr; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M43I/rKr"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e117eec348so95227a34.2
        for <ofono@lists.linux.dev>; Mon, 05 Feb 2024 13:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707168759; x=1707773559; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rW7lExWa4Tga5wjI9e2Nk+n83htnkzYELoCacuFZ6B4=;
        b=M43I/rKriuOEiG8oBDX/If66FIGIVTgM3T2s+LB4V/m9IInYWOWVO86i4AxIvyNvXO
         FQ90D9uEa1BqelToA8BSBh4TK/F3o56zaCLrzD2OcMi3XT1IGe7lvhsu3Q1HVVmLNe5+
         ow4/qH0iBW+KIx3Sj9OAJRRxdZQzFbGk8Lv3WbvwgQUZTDSsGnuV/nEGlgein8bxBs7o
         5rMz6yApfYtJCLdkixfOIbwEIeranoXoXrgbb4N07G6Dk2aR2khtCh2fyjM20AVMffOJ
         sstu5NOT7gpzfHf9vFy52+K3jHqzXSJESgcKdRhnAlUPs4kfWjD1AKMrz6drdQ3eDORm
         SFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707168759; x=1707773559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rW7lExWa4Tga5wjI9e2Nk+n83htnkzYELoCacuFZ6B4=;
        b=HPioerfKHN9+babLWvM8N20nDE24cruP52R9tZ0ZI5PWTRwz0LYHWsDNUld941NlPY
         8sdgHvLin5+bJIzqb0cW2+2H39LYI4r17uQW5fskRWOHI0BFDLGd13asTvb7J7/xGGma
         KtDrt8E0lX6OYnETAe4kAoijKTYYukXduPvq3dbQpcUWUQkQLSZWrQGmEwSbX3GWZITs
         456XjEnKe8NXKCCOjp91lSPY3bR5192vWaD+SbVr2S2OMq0ky/HCs+rPAbFSs4i1jKiD
         qlBpx5qZPOYTiYQ5MrS5bd10olm6CvGtNVqRlTQllqAenZdpsRhXmTurKLbzoJ/gTiBs
         vRvA==
X-Gm-Message-State: AOJu0YwRK8bbGceGVqgzNM7XAwjMTptu5ahNsTNuqL515lUwZFenZz8j
	XIaQltbTThxB6MLLiD1S53HnEuIxsBUIPBqnZTZQaJ2fxaCBE69mMXIJbBeg
X-Google-Smtp-Source: AGHT+IGUJrww7eQ04cNf2MuR4iQCtq8ptOpBCxcbsSxaDieMSf2NUFPusG6I/Fo/17KHX2meEO7vTA==
X-Received: by 2002:a05:6870:64a1:b0:218:565c:b6ba with SMTP id cz33-20020a05687064a100b00218565cb6bamr1073734oab.19.1707168759195;
        Mon, 05 Feb 2024 13:32:39 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id mk10-20020a0568700d0a00b002190606a99esm153722oab.53.2024.02.05.13.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:32:38 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/6] core: Remove g_utf8_strlen use
Date: Mon,  5 Feb 2024 15:31:23 -0600
Message-ID: <20240205213150.1001245-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205213150.1001245-1-denkenz@gmail.com>
References: <20240205213150.1001245-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace with l_utf8_strlen
---
 src/smsutil.c  | 2 +-
 src/stkagent.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index d07960190103..f46507f00e1c 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -549,7 +549,7 @@ gboolean sms_encode_address_field(const struct sms_address *in, gboolean sc,
 		unsigned char *r;
 
 		/* TP-OA's 10 octets transport 11 8-bit chars */
-		if (g_utf8_strlen(addr, strlen(addr)) > 11)
+		if (l_utf8_strlen(addr) > 11)
 			return FALSE;
 
 		gsm = convert_utf8_to_gsm(in->address, len, NULL, &written, 0);
diff --git a/src/stkagent.c b/src/stkagent.c
index 6c1f6d57093f..8748ec63022c 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -838,7 +838,7 @@ static void get_input_cb(DBusPendingCall *call, void *data)
 		goto error;
 	}
 
-	len = g_utf8_strlen(string, -1);
+	len = l_utf8_strlen(string);
 
 	if (len < agent->min_length || len > agent->max_length) {
 		ofono_error("Length not acceptable");
-- 
2.43.0

