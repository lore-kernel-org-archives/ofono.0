Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A30D14A85
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918657; cv=none; b=pizBQe+inYCKCkoFzSVmgwlwMjiHHWq14DTv1f2Mg+i0rjtHZFnqNFfRt777Uq5Vd8Z7opHfl+zkcvKZs+uuLPOqY4OXwL/15ZocOLSUDnikZx99zkyZ6/s5jubsn8j9niivImKpqr1ZNIldDTGl2d/bBFRZ9lYAZg+nKehz75c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918657; c=relaxed/simple;
	bh=al6R+Fbw2u0FbgEYPR2ioNipISnepMJdBchYdrlaREk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFWbMYypmKcfiNaeqFmd43lEQ8y/2B8URx9uVXbAGOLzFDkrmUmHLw7Z847Ul1HKPzaO1UY4sbbzJPyynE40iqX2MQZrjMSMWVRm7eiHRDF2Dd/WTFxzltiy1m3HyUNSLMfsppbJQqau3ZnbUOCvo2FJFpL2wQwWmgc5sMwPQVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2S9vLyW; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2S9vLyW"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bbd6ea06f5so1535515b6e.1
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918655; x=1709523455; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxMZhn4kJzl8zbmdJ0ph9eFxnbpZvzk3LUVfXjg3RgQ=;
        b=N2S9vLyWzscRqScZWXwnkzHFZqI8vDDbL0Ei5ZOoCZ2IDfPP1BMDHgqRUeTzukuZ/i
         +I2QyqA8Uu4vIoALK7ZiXHrTdpZAJDrtKzoQcffZazjBNeyG/SV/lr1wNIK5Meh916jG
         ojoB6JJKXOS6t/R14J3D3rYWXA0HuFV45Bghd39wd0iRSAJm2TX5w8BTTNlXTaGDud8D
         VkeCkIP2HsU0orPKWXDPmoJ9Go4ixr5xhk620VOPENwQU0BxM5EgueXiXkBX83pMi2hn
         lGkgsxASduXmcTVum2SU2lJSAgbhswiCZzuqjBsj+TDxzSCJXC5Op8LxJYCuBhyi79a9
         Kukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918655; x=1709523455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxMZhn4kJzl8zbmdJ0ph9eFxnbpZvzk3LUVfXjg3RgQ=;
        b=POYdkRYxqDv7umT87V/AcLmQ0MjcPwHqCQU1B5NjRjZ5m38S24aa79bn0Uz3g6TOef
         galgGJYsXe6fTZ7Gwm4jpXSKR+Ac6d1kmJGAQu3bDEwwe/CZVyvCmRdB4xj19pAx7FAw
         AyQSdP7T4lzJSa/p6ndLQ6q5DFeNLO8/EPLXOWPhSP7MY+1e1+Cb95es9ZqCRJmwtVT+
         CuHaq2oDyWJklOMdmOlsO5zoILztYNsgmBOh4AkSCT4y5T6JbKwePZth4hgHq6fagOcO
         JBrsw0TfKyjmfv9O/T+qJaaKvC8oF6yfhfcmU41uitXXMhoIkv1iuNQIOHhvoioZZcPJ
         elNw==
X-Gm-Message-State: AOJu0YxKYvlNpsAYpJ3KKzwA8GcXZ4IUoq14Tr3I3clhfzP68JZtS2h3
	51f3Pg5eYIVPCVAlLiKp4LMA9kK4FvYm4C+ue6l+Vs6ccqTYoPymgn67zKC1
X-Google-Smtp-Source: AGHT+IHL21ukQOmSuNdsGt4fIXQhcZfujAMWLsl0haa5uO3T5Nfqwo4dpj8MqwYd149naxa7XBBLbQ==
X-Received: by 2002:a05:6808:a8b:b0:3c1:8043:3f6c with SMTP id q11-20020a0568080a8b00b003c180433f6cmr2076279oij.11.1708918655195;
        Sun, 25 Feb 2024 19:37:35 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:34 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 14/22] gprs: Remove use of g_str_has_prefix
Date: Sun, 25 Feb 2024 21:36:57 -0600
Message-ID: <20240226033724.1460079-14-denkenz@gmail.com>
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

Replace with l_str_has_prefix
---
 src/gprs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 67f0d7803525..ae0d5ae8a387 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1968,7 +1968,7 @@ static struct pri_context *find_usable_context(struct ofono_gprs *gprs,
 		 * web.provider.com but it apepars as
 		 * web.provider.com.mncX.mccY.gprs .
 		 */
-		if (g_str_has_prefix(apn, pri_ctx->context.apn))
+		if (l_str_has_prefix(apn, pri_ctx->context.apn))
 			return pri_ctx;
 	}
 
@@ -3304,8 +3304,8 @@ static void gprs_load_settings(struct ofono_gprs *gprs, const char *imsi)
 		if (g_str_equal(groups[i], SETTINGS_GROUP))
 			continue;
 
-		if (!g_str_has_prefix(groups[i], "context")) {
-			if (!g_str_has_prefix(groups[i], "primarycontext"))
+		if (!l_str_has_prefix(groups[i], "context")) {
+			if (!l_str_has_prefix(groups[i], "primarycontext"))
 				goto remove;
 
 			legacy = TRUE;
-- 
2.43.0

