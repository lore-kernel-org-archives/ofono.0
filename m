Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF761192B84
	for <ofono@lists.linux.dev>; Wed,  4 Dec 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733300583; cv=none; b=dCGLri77Nvz4QOcGkzqOsux3BZ7x0pGNdI8o7J1Ya648WoTRbFwiBwzDYL6YM3eEUj8ZEXBvyRR2Vn5+F/MGM6/YQ+JEaLP048ISp4wTB7LqCvYqOE8JMmGUxekv2+FZH//SqTJlyfwfunB4HhMAkzGRzFj8P8b584BlhbpKn54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733300583; c=relaxed/simple;
	bh=ORqD/zY0IL7sjadDt1AumLr3LTn3Qm/ubf3DtZiQ7eM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nkgl06cHvsZ7Bmi+4pcznDbnc941C7B/C3JbQNlwkZmStBKCG9QMhu8jTMDKJQfHMYOCcnuWHmye3Bh66EbDrivews9StBbSJHuAOZdOfzdY7ltuGv05tKfXf6Jn3YPay5VTsKxzws/qSekcIc3bL2YVOFZQtbrU4iLiLtpuluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBd9OA+l; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBd9OA+l"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e87b25f0so334593f8f.0
        for <ofono@lists.linux.dev>; Wed, 04 Dec 2024 00:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733300580; x=1733905380; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qC8iM8I33k01/VrjmK/4c5a5dPF4PXizXOU87eoG1oU=;
        b=aBd9OA+lrAaOoxgTQbs/PzvIXKU0DYogyEj5foRYbyXB+SgbOzwU66lZ1nrzdqsik8
         Jilpt9vfnKa8tppVAPekGZrCNL6HBTEaLp0GscSR5CevK1/tattkD8jfjIDJp6UBdj0W
         9PsPyVYeSbKI2+hZ7z8AQZqLhpzKDAAawCIyHI4JMgyZzTnWlKFXJqsZNfc8AyWUoc88
         0npDDQeD4LDr1RLYjSDOrnRXhsJCD+rTJ0CXMxlfUa9iz5yRsj0A66d7tlHjZedzS2b0
         vZur0mM2v1DLhJvfcO/ljuhpTlyTGOIfQQFsfb7Spd5wux1Lj3GEmFP9miMy3M8npGf3
         kjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733300580; x=1733905380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qC8iM8I33k01/VrjmK/4c5a5dPF4PXizXOU87eoG1oU=;
        b=FhJsmN8mGggTdmmyi8eLrxPnG9CnUq3Oq71jYnuNLBTBfd8oDXW38F5r7e/HJbtYoa
         Y0EkIcF/SUXFcAfNVPdNfLsRCyP9zkyvefTCbdM7tIo120ZxAnSLCts9FFaSSvAsqeB1
         njbY6X9wM88ZXfqwv0B1dtVqRW4zlOHxZ0i/PGIx8Oqd8tFXuySHnCbsf6HXKCWtBN2/
         oge97xuOTg9gFdbtezpb+eiup8cqN49bNgLZpGwvksculdXUQ6EraHptewKBt2nk0Tj7
         2YiWQVV/HO8S21vbqSF709whVYmcpLzpqGcjHKm/wy899GIt5H+QKiE2cxHWyZkiFHaD
         lL7w==
X-Gm-Message-State: AOJu0YyuBMCKprE/UbGSZnJLWgWRbDplQVAeeC7fXjVIan4/yOOko6g2
	+V03V4bybW7/1NtDQPcogqDZsxjsjjYZ0TkHnQJYWOexDD6RzUYt5+LQbw==
X-Gm-Gg: ASbGnctJ0UdmC/zxwgRl6Xi+Ne76ak56hV3b0kvo+rNZvMejpNC7tfjQx8v8VZQEIaC
	yfPSdOqMJ2mH8xLHKTQtSs3DMTIDBCXUjVn/houtd6620mcEuJoalmWjF7op/ONBlK/rwwwHc+W
	w+3kitY0wyCFRCHj4b43Bo27utBcyxtUiWd+dNfbCKUaCt1nnjjvA7XloALlrdEN64GpqovQK1F
	8LpU/PXDxkkC6pq6prH62Js5ELiyqZLRG70sys8+Xw+h9FB3g==
X-Google-Smtp-Source: AGHT+IHIK1YYwCLEXqU8tz+3wHeBebjInswr9X4N3//deiZiUkCvJezllNndZXVzjNhx+oKt/dPnWg==
X-Received: by 2002:a05:6000:1f81:b0:385:faf5:ebc8 with SMTP id ffacd0b85a97d-385faf5efabmr6145193f8f.21.1733300579815;
        Wed, 04 Dec 2024 00:22:59 -0800 (PST)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e3cbe250sm12112703f8f.94.2024.12.04.00.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 00:22:59 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH 1/2] smsutil: check deliver reports fit in buffer
Date: Wed,  4 Dec 2024 10:18:51 +0200
Message-ID: <20241204082207.24692-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes CVE-2023-4235
---
 src/smsutil.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/smsutil.c b/src/smsutil.c
index 8f578c22..bdb1d04f 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -1226,10 +1226,16 @@ static gboolean decode_deliver_report(const unsigned char *pdu, int len,
 			return FALSE;
 
 		if (out->type == SMS_TYPE_DELIVER_REPORT_ERROR) {
+			if (expected > (int) sizeof(out->deliver_err_report.ud))
+				return FALSE;
+
 			out->deliver_err_report.udl = udl;
 			memcpy(out->deliver_err_report.ud,
 					pdu + offset, expected);
 		} else {
+			if (expected > (int) sizeof(out->deliver_ack_report.ud))
+				return FALSE;
+
 			out->deliver_ack_report.udl = udl;
 			memcpy(out->deliver_ack_report.ud,
 					pdu + offset, expected);
-- 
2.45.2

