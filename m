Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5DB16D4D2
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716585; cv=none; b=cKRvAai9QIufHDG2unth34oCHSiznOcgPEn9RGeQNYQEnVQ+9rgExU2Cxot+72Go5Uq5kP5hqHPggj/vnYl7fD+LCRm0UbTL9Cc4wK3iEZkMDVIULt9DI7kxjO0+MR0N2BTRtY5+jGzsuVOzNFBYzbn61697splHhZplmDPH3A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716585; c=relaxed/simple;
	bh=vO4r9cGq68fYR+sL1wt5HYkj6S6KPSzAJWZb1HayTkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kahcMhfX2cRuFOr033JiaiyQQhGba9SBlwN4ogJEVuhuqonvOuhwlxB3Xx/PzjfxDeE0qOabSMDrNj1B5IV+bwZP1NZ+amVs+ZyWC0ifoaR4hdYF0dQr6tL57AMOWyr8muJpL3qZ7U+qBs2xqrlTuOMI6eBNpA4Rfi4UknTBues=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kdiy6E9O; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kdiy6E9O"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-708b273b437so363514a34.0
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716583; x=1721321383; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhDPhgBnW28NGD1DexG3TdcWj7WvUa/k14wm4z0A/Pg=;
        b=Kdiy6E9OYsa+6GaIrkzGiMrxIXnSfsc4+uLHYIdbxEEN0b2urE2MIULQkCTl2+/egD
         EnBFjPr5nGHaPf/QUKj5wJ6feWjX5qT+DbVXpkppFr36YeS6LOG6BSQ4BsbsCO0rkqKV
         8r+d/4a/7zclT7CMFv75kD6TvxysAulXzSNgx+XWvZT394oflYstQZsstuhG+CL5YVMT
         5MpWETjo7zo0RSd41Wq3Nm1Jjc5SiY/zxpUGjkGN4VKJsuNllTNda6RTmwl+/Tjp8WIe
         od1fo632YHvpUuHEC+B/mJY93gEt/h5aoivFddr1L4dSHbAbZ+wPsixXQsb2Om/YJgNJ
         uobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716583; x=1721321383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhDPhgBnW28NGD1DexG3TdcWj7WvUa/k14wm4z0A/Pg=;
        b=eoUja702mb94bSomuysUJoprYG+/t+/tv31+l1i/t8mkVtDm+8A66a4vptPUdYMFjQ
         rfG8s9YRTJfknRrbDcluFt/ajJgrV0y34KTZvKVhOeTCbQiqC+u8fAy6zDD0a3hTL5Gn
         VeDJ6G52iEc7lT2m5D9KSBSjJ9LSsd+9fxYKNKpsHnXRrG1d/hyG6iXaxUUDDJ4SDqAW
         KdVKRnvXW/LoAulaVD1RQxSrexTWVtBX6Rm4TWB/MIEUduR/wd9Sm5Rak73wtFTV7Bvt
         IA5yr+xhq186xi4Gat1AU2f1YdQetI/NIL0HT9gDu0vxN9RdQGUg1JoHC/76RQ8Nt4AW
         b5dw==
X-Gm-Message-State: AOJu0YwtjFChvY8xRAqlgubmtVyM6tCQGKdSyybQYN77HuLhrlnaXnwl
	5CMhZ+Mi0c8xwR/QLn7c+ILHJjF/VoYEisSveXCxcJQEw7g8b9UjYmo/gQ==
X-Google-Smtp-Source: AGHT+IHNeDn4XqNSZW769bnq8W0PMMwxajShI3pOmq0pqyNIdUVa3TwO4dYNNgfaZTf2lklUIdLwOw==
X-Received: by 2002:a9d:68c2:0:b0:703:651b:382f with SMTP id 46e09a7af769-70375a05a7bmr9162654a34.3.1720716582668;
        Thu, 11 Jul 2024 09:49:42 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70378d3adecsm1027524a34.3.2024.07.11.09.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:49:42 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 07/11] qmi: gprs-context: Treat IP family TLV as mandatory
Date: Thu, 11 Jul 2024 11:49:29 -0500
Message-ID: <20240711164936.1688973-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711164936.1688973-1-denkenz@gmail.com>
References: <20240711164936.1688973-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, while here, coalesce two debugging statements into one.
---
 drivers/qmimodem/gprs-context.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index f29f10720710..203a320a42af 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -46,10 +46,10 @@ static void pkt_status_notify(struct qmi_result *result, void *user_data)
 	if (!status)
 		return;
 
-	DBG("conn status %d", status->status);
+	if (!qmi_result_get_uint8(result, RESULT_IP_FAMILY, &ip_family))
+		return;
 
-	if (qmi_result_get_uint8(result, RESULT_IP_FAMILY, &ip_family))
-		DBG("ip family %d", ip_family);
+	DBG("conn status %d ip family %d", status->status, ip_family);
 
 	switch (status->status) {
 	case QMI_WDS_CONNECTION_STATUS_DISCONNECTED:
-- 
2.45.2

