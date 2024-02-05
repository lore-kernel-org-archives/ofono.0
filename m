Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BF558AC0
	for <ofono@lists.linux.dev>; Mon,  5 Feb 2024 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707168763; cv=none; b=jVpawq2PFpCv2z2iEFUQc+tK7nvb6y5lK+0AryIrBPAtG84YVIGjkbS0yKFdAm89hVR//ZLNqfELV2xbIlDstdk/MLLjvslB/qB93SlDh+60K+c3ejq0aJfsae5fzCVArM4w6jiMvAuX9FY9lYtIN2Eyo5Qmj6eyr5VlcIosO2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707168763; c=relaxed/simple;
	bh=Sth1Y5d3wfddusa/fWnoWxESmrVfSp01yY8QfCKBTtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Riwo+MhesxDSwtiKf72fhNHsOzCJoJuX2BEM6cgd1PM5z7Qi3NdjyhEXfKPZwZ1sx3jma6K1y55YQbeHAMykMzYl5ZCWY8K+GwKqNwk1LyErdi5RaG+A7NwGvHcOEk4VMs9ugU5IPPsrxy1x6c1k/OWE9K5LKCywQ9l02HvOp4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDPSRlXj; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDPSRlXj"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-20536d5c5c7so3711309fac.2
        for <ofono@lists.linux.dev>; Mon, 05 Feb 2024 13:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707168760; x=1707773560; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuCnxgWeX73XqQSGNZVoSjukxaLZ9KhJ2hLj/t2v71E=;
        b=mDPSRlXj+bskKKP11xxefasDGnKsGTN/5jA86whAAycspQdERp3/Q0iRS3W0oqL132
         VtRxfdwt3UQ0ijy20k2y/LXLSWFyyb2nZl+aQIgg5aqEx3zEJAF6MgdFlX886Vz1fTYf
         4YAkXeiT+LujUxpbfE+pqOjr6XMHQ5IvgCta/JVZ670v4D47qKIWOSmiNr4ObZQoZK/1
         2Q+ArXwp/c6QXYQBK6uP3qEb21ccbpnWNSjoiDKmVypgYse+0wmP8M+WvzMNXC9pnu4z
         68FfNVr4KXXYcWr+gVK6w1O4/xPq4A2Xdj2fiRJ/Q2X/IaI2nUhWwPn1tmiqHpHp5FP8
         LNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707168760; x=1707773560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HuCnxgWeX73XqQSGNZVoSjukxaLZ9KhJ2hLj/t2v71E=;
        b=KVK6z0soWtQXhXTMNepwtHPwA55qYXc39/DF71QbkTjt5sPKuwi5bOoxp7/+mYcOL5
         BkPiEjegnd0GZ/OsMu4EMhQN8lIObBcrIhozlGIbeOB/1rsEEXUUVi3R2K18GK1F4lMq
         kloFr3NE75aoHQxjo+9bbG4xRGKbI4jkrWoTyQWelEoAiYx9OTAnmhd1oTsfWjkiMmG8
         Ghy6RYrFTJeL30Yj/kpeDkrTl6gi3M4h6un5auqOSaYCsU1vNlpr+hOIHuo7dOUMY56B
         FVcrGhOHO0oKw7zCKD7rV9MsI/ZZFd1kJ3iDfbohcrx/RKEusmXt7WtP8WCxygnJEb8J
         06YA==
X-Gm-Message-State: AOJu0YwoFzaPuXQJhmMAgiIK7GpMnFdpHFZXr6hXgsL5SLstvhDMhQ5w
	nVipZw62YEVnTPgfTdVBWxM2E3aDZRx/kvwnh04U/F0mcZ2IV1A4UslrJ8Pj
X-Google-Smtp-Source: AGHT+IE8+PGZ/raIY/sxTSHAAduUBn/5YmvyDDMugX5EvdBkJnkwBwrbtHUlyG7YWKnxC43387dnMw==
X-Received: by 2002:a05:6870:b52a:b0:219:710b:512c with SMTP id v42-20020a056870b52a00b00219710b512cmr1001195oap.55.1707168760676;
        Mon, 05 Feb 2024 13:32:40 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id mk10-20020a0568700d0a00b002190606a99esm153722oab.53.2024.02.05.13.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:32:40 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/6] qmimodem: Drop use of g_utf8_validate
Date: Mon,  5 Feb 2024 15:31:25 -0600
Message-ID: <20240205213150.1001245-4-denkenz@gmail.com>
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

Use l_utf8_validate instead.
---
 drivers/qmimodem/network-registration.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/network-registration.c
index 3fa0c9e442fb..6bc8fbc5d226 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -32,6 +32,8 @@
 #include <ofono/modem.h>
 #include <ofono/netreg.h>
 
+#include <ell/ell.h>
+
 #include "qmi.h"
 #include "nas.h"
 #include "util.h"
@@ -153,7 +155,7 @@ static bool extract_ss_info(struct qmi_result *result, int *status,
 		 * plmn-desc. When that happens, libdbus will abort ofono.
 		 * If non-utf-8 characters are detected, use mccmnc string.
 		 */
-		if (g_utf8_validate(plmn->desc, opname_len, NULL)) {
+		if (l_utf8_validate(plmn->desc, opname_len, NULL)) {
 			strncpy(operator->name, plmn->desc, opname_len);
 			operator->name[opname_len] = '\0';
 		} else
-- 
2.43.0

