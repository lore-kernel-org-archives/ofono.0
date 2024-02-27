Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED18A14533E
	for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048001; cv=none; b=d7VGXRkWmBnp4mJktpmAgrWBVjQEPA432BOLVpkLsD4fYVUu9Hr8HdG/zuqbmCPBzkpCdTGUR3IpJURAN71o5nX4YmgskYLQgaKUs3IbdrLVeNKyhBXmilFTnpU27UpWIiOX5XjXOHg7wcl/ngtkf7XGI+m39faEGi6UQYZsGzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048001; c=relaxed/simple;
	bh=RBiMYgH+lp1LcWsCjvRTWvdz7aZpoRdYNEs33SR4+Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKHljTWDaBoLNQthiyls5ZKrcLBjch+GEUMZ1HcLxgCXur29RRkkbTx++C8Y9BeZXH6pRKJJARHgk9xnz9WX0XTQzMIV/tvXOJANdOsOJVwPHWVo3lZI7EEBbPGRRq5I1VQ47N9ZRctDsb0dYXsS8XDENHVsLVnmmZ+b975PxLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtgFiaOF; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtgFiaOF"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ddf26eba3cso3477281a34.0
        for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 07:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709047999; x=1709652799; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Wh6VR9xzPdF7uIlQXwiCpNNf5KAHqKCRSnmQJBhuIg=;
        b=UtgFiaOFRD3mJVxLhXccazE3Aa7eKteQOu9htDrZMw9/4kP/OWsEeu0dcMls/GamoA
         1bwUkAhAaKpadvNwM/1m4Xr99TDYMb1Y7j+cIrtggDDwnAmhqXgs5U5OWfN2tBW/of7y
         rdsc1l6X7TiDsAeRRzCjLOis+PLh/Ah5HuSR+E5TGCbzGR7lktSo3S9Kt3EmpWxXCeVi
         hDC5vZTaCMNHV9vG9bBZQbBCuh8xP5gm0Gz5SsLg2yv+gtYBcTbva1FaNo4exMhUttj2
         GMiK3stFazPysuRYWo4iwTEt0t6IbDPwaGiWQ8oaw9QVocYvEcDmjBEa+dP7D8JJABp9
         8y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047999; x=1709652799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Wh6VR9xzPdF7uIlQXwiCpNNf5KAHqKCRSnmQJBhuIg=;
        b=CG3gQVFFg1ajOcP09vmArDp+hlZM8NhXeOB+ZM0hCv4IDCjL2MNtwz7tGtVrd70nAZ
         dcqDKm/wPCwL392/ICjC80TmazAjylsLfpuahmqsNzbxJ6/yAZ7lrIO3naoiaovQ3pwm
         lj+RalHsHLaRV2uHEbOUbok4uEHtQS2ByCAkpbxJw1KFH9aLXC2J8EP2MYjOb8Gt0Mtw
         YDR1USWxf3u7jG9+ER0AYPbNVzA1otcWb0prdNjzNMZWGM4Fo4giD94TC3sO7BIg/jEl
         yW64eiWpwOjNVbviCf+IKiOlbyTcx+25BiMNzcT0+TPLMW0NHFyW4MYKKZrkFAeaeooo
         WErQ==
X-Gm-Message-State: AOJu0YzJgW1ch5Cpk/ZCpP2jKvtsuysb9zJHU+3L5z0iLDGx06300iqH
	+zz427Q8LcbV/qDW5HxXktCFOYjN98SyoHi9f7W8DsIz7pqnruJXniOVTqRf
X-Google-Smtp-Source: AGHT+IGc1ypsI04AAMUVy3lWQ+GziF2q59vA1Ry5pnszaa2cwwq3hFLBq+gAh+TUaSqHpTJMabBHjA==
X-Received: by 2002:a05:6830:22db:b0:6e4:7b7e:72ba with SMTP id q27-20020a05683022db00b006e47b7e72bamr10759560otc.38.1709047998763;
        Tue, 27 Feb 2024 07:33:18 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id l13-20020a9d6a8d000000b006e477a4207fsm1538589otq.54.2024.02.27.07.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:33:18 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/3] lte: Fix invalid cleanup
Date: Tue, 27 Feb 2024 09:33:04 -0600
Message-ID: <20240227153314.1469536-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227153314.1469536-1-denkenz@gmail.com>
References: <20240227153314.1469536-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intent was to have l_free apply to the settings variable, not the
const ap variable.  Also, while here, fix dereferencing ap if it is
NULL.

Fixes: 69adffb51633 ("lte: Add provisioning support")
---
 src/lte.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/lte.c b/src/lte.c
index 05491c3a1391..d6de408492c7 100644
--- a/src/lte.c
+++ b/src/lte.c
@@ -63,8 +63,8 @@ static bool provision_default_attach_info(struct ofono_lte *lte,
 						const char *mcc, const char *mnc,
 						const char *spn)
 {
-	struct provision_db_entry *settings;
-	_auto_(l_free) const struct provision_db_entry *ap = NULL;
+	_auto_(l_free) struct provision_db_entry *settings = NULL;
+	const struct provision_db_entry *ap = NULL;
 	size_t count;
 	size_t i;
 
@@ -83,7 +83,7 @@ static bool provision_default_attach_info(struct ofono_lte *lte,
 		}
 	}
 
-	if (!is_valid_apn(ap->apn))
+	if (!ap || !is_valid_apn(ap->apn))
 		return false;
 
 	if (ap->username && strlen(ap->username) >
-- 
2.43.0

