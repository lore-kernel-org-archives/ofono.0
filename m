Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C92010EF
	for <ofono@lists.linux.dev>; Mon, 16 Dec 2024 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344448; cv=none; b=Eo6ocr6pDDJfaNBfWb4u2GJwyWiUWCC/Vtr1fgH6Sw+RvsTbx3+S4xaxvKT6KDjdERpIN7pVRNMC+n5VYEPv5yqSGawd7LnRll6mrHfB0gbu5c8ZipgqPTyk+FLNLOH2FSbAPusAFWeIn2jm07tvc8He3bsGb5pjqJSGifw7/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344448; c=relaxed/simple;
	bh=Z7FUISwGq3NCBE4HNzA5UaKjU//VkE0IqBFqt1tcncc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxxndpN8PacpxFV2YkFc0bKCz76UJ02ClQEG4rR1UHUP+B3r2sMx6z55xnZuYYBYBfoMVGIXa6z0qTO+Elq10TUyiQbTHYFmKACkBfzPDYxxbi3+k0IldX4wlX+m9iTxpUGCQke/XuHse+pTi9OHdjBMioZON2aKBrumDSif0/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cb1CFNRn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb1CFNRn"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso5079142a12.0
        for <ofono@lists.linux.dev>; Mon, 16 Dec 2024 02:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734344445; x=1734949245; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HaeFCI0v0RRUOYUOomKWEm8VK/jmjTKhzD6K3j9K0A=;
        b=cb1CFNRnrdiE6XU1IsM2CpkEPrL67SxB489jdPIIDuUx9tWSNYSHOYiK5osk05VGeU
         d/hDjn3hbpUYifTmj49lWwBUcF97aWZ+orTCuSkuK6Fwb+OkjtpqnWCEw/nA4J3lNVXo
         XNi0mZxJGmoGEXVOLxvE0n/0D2KymOyjOEbeSl04yVvSGREs7eL4coWC9fmleOUKoOmp
         63hZ3jhWfeFNXAZMChVSRk5dx1l6V2I43RnYAYFNWSt3b9zIGzkvC1gz2jaizmB3J+jw
         1n6yItCOHsNgH/iGDY4bQ4kOwyR0k5+kTJwGPF+TS8xZwXg0aS6ZWy/jK/mEiZV4AIbb
         wvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734344445; x=1734949245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HaeFCI0v0RRUOYUOomKWEm8VK/jmjTKhzD6K3j9K0A=;
        b=jmeV0ECEd9mEtirKOYJTn29VTvbG8PRQ/33cMRUN7fYvpogvx6CuuVOo/pWEPLX8QH
         QtLrAoevdIidPIv5237tNJo3JJXTWe1DHim/UEpZ30bQ1uqZh0Osw0FqgfAUiLLrScDJ
         SzS2BLlmrUgkCjyW7WJ6DH2askz47vehpupIzw7Et6A0bMuRoZfoQoovP8QnGDwDdNES
         muEiORSm7J7kY1LTq+bwcbKtnvhAfkhthHhmzwiyOahpzGmwN5QYTNmlyZu0qGdx44nV
         C6WzmA6HEoe21S8PwhxP+T4yU5glybDvBvh8/yDU6jKzVSBddqzxYM5F8+Yon3BDC3pQ
         6GcQ==
X-Gm-Message-State: AOJu0YyZ3pkXxtGcWS/8zaQ1TFcuH7kDB5RHjwsZ4UQnbZjTC1GP1m9p
	axRErlKeH/qvtNFxyIKmKnoIdDMrlXEhSa97zM3AcesjJykjzkEd2rS3/bj5
X-Gm-Gg: ASbGnculmkyb6HUxiXSCURUcCEdnIfjhtMnNNvSRlUlWE4jZFSHIO/ZbF1Q1mlD2OKf
	iTSni5A7nhcE2OR9KlJUX3dHvu+ed9yFmxYGzoNYJC2mCjwYBdfyIuDSmIKj3GrH/LWtolV6fDI
	n4HG/S8WAV0LLChzGbIXeUb0oc7MGPgfnuDaDSXMDoeguX5TEKwysB1q9p9/JSrnHIUBUNu3E+I
	iXY4STSlTqK3CSFXXy2nP1660rTRXzYx6Eyd05tpSqRILQJwLO62P9T
X-Google-Smtp-Source: AGHT+IEys/8VmrV8URIufPxa91LdRtfuRlvtGtuTwpQKy4a1Zz+RPJZrgKYnlRP503mmtQebC2u8Pw==
X-Received: by 2002:a05:6402:3550:b0:5d3:bc1d:e56d with SMTP id 4fb4d7f45d1cf-5d63c3bc40cmr11172255a12.31.1734344445498;
        Mon, 16 Dec 2024 02:20:45 -0800 (PST)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab604fsm3026099a12.2.2024.12.16.02.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 02:20:45 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH 2/3] atmodem: ussd: ensure ussd content fits in buffer
Date: Mon, 16 Dec 2024 12:19:43 +0200
Message-ID: <20241216102021.345566-2-absicsz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241216102021.345566-1-absicsz@gmail.com>
References: <20241216102021.345566-1-absicsz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: CVE-2024-7539
---
 drivers/atmodem/ussd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 32a9fe91..775c74d1 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -121,6 +121,11 @@ static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
 
 	DBG("response charset %d modem charset %d", charset, data->charset);
 
+	if (strlen(content) > sizeof(msg) * 2)
+		status = 4; /* Not supported */
+		goto out;
+	}
+
 	switch (charset) {
 	case SMS_CHARSET_7BIT:
 		switch (data->charset) {
-- 
2.45.2

