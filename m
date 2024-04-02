Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBD21E531
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097067; cv=none; b=ZdMG6shCnw3d7pwBsINUVLIeAshu/66A3yb1EvYLdlGaQW3dckmpyRI+f/vfzg5hv7VlP9aV581592jKs7qsP6Fzsc0/Q82AV8chX95gwStqnbKQaVg3isZRpLivBdjQENHwJ8YgA3ZCkYfGD/RElrsvg39MLAYS9WNxSYwdaW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097067; c=relaxed/simple;
	bh=VIVvtDsq+G5WYkgS7BSz4Z7jw6G1tAM7WGFCd31MXL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmY90NISjrIJjvWfHsN11dlusB5f7Dz+xIv5EnCe4DnYGDGmJNeVSuL0IzPn6b9wMdNyYyaVUPRplJ3perrYgHPFMP+62btjE4kHihk9MOX/q14761gkTqAep7XWjeHAOG5Ws2l5Uyh6iXwGVZpkxar+EBqUP3I5F2YLo70cyME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9958Hn6; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9958Hn6"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c4e99e7fa9so87776b6e.0
        for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 15:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712097065; x=1712701865; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUbKF21gV6LrGLntC6qJNUd+XWJqU7cqRFbMu1fiPwo=;
        b=X9958Hn6JNGYnLX5vmBuUDMPnRKCc/ZSyHUJqBIWeE3PFi/U+WiwmM3L/sHs49bV0q
         WXEJigZW6UK8Xp+/zkSghHTQS6g9TKDkR6Bn/9VIzx2rhxRlmWajLLEvh6k3JsQbAbPr
         H5edAW5WCL9yhoIfwL9ejTWofpT83joAc2IiNn+OevwU2tD7bfyQceWh3MhVeqVAwCou
         LDHLeVWWCGgiQt5aK3gnqz1qXExfea9EDZiY4uqko3Ux1Z5Ej6bqWLuIAoi56tvsNV0O
         hOqouoSdzyXuC1KQh821XntJ4iFu9oJ8Wk13VGxDas3zSn8luyZMQbrylqbobmj6VTzC
         l7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712097065; x=1712701865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUbKF21gV6LrGLntC6qJNUd+XWJqU7cqRFbMu1fiPwo=;
        b=wSl5EFngJuOZemIGADHBjlhoNTDS0vA2k7OAc151QmA0fvNNX66sT87W9Iz3u6CTg5
         mgQAGgjZ11B94H5syFIje1NvjFZEL/4OoEiHweDMpmQ13n9JXYgwPQL3ptzbuJ7CA49r
         2ZrEwNSLk50XOYXVlBH2gox6ZyT0S7AbdOabqwtXe1SHqodw36kbrTwX01rZNftIV1dI
         IcAeu8WF1o1+TNxvodFtrZX1MuwRDfyFaHeiOaiBsTU4iPtdNl27tJU1RTzsUfPbMuL2
         bUryqR8PDFAW92ULQRlodD19JuG2gBLPdOG/7Apl0aeioKoS060MBwXVbLUJ6YfgnodO
         dSJg==
X-Gm-Message-State: AOJu0Yz9VfBrcYYq96ROOc6tg2V5jgWm3zOV2zztGuZfMUvUPZaylB5J
	hTMWI2GKsWiPAPMTQFXWHoGEEm8IBGgfpskPu2PYuBZb8tNLeNdIADheNTBi
X-Google-Smtp-Source: AGHT+IEPpPT91R2JuQDCGeAvwQJVpiCLFO8WR31Nw6CMzLAwpoUSEb8jp7XkwnKiSuSYCN+JwY3CeQ==
X-Received: by 2002:a05:6808:b3b:b0:3c3:b10c:efa0 with SMTP id t27-20020a0568080b3b00b003c3b10cefa0mr318485oij.18.1712097064815;
        Tue, 02 Apr 2024 15:31:04 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a58b8e4b1csm2956204oob.7.2024.04.02.15.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 15:31:04 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 12/13] provision: Add support for provision filter tags
Date: Tue,  2 Apr 2024 17:30:37 -0500
Message-ID: <20240402223054.2819526-12-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402223054.2819526-1-denkenz@gmail.com>
References: <20240402223054.2819526-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

oFono main.conf configuration file can now contain an entry with group
'Provision' and key 'TagsFilter'.  This entry is treated as a comma
separated list of all tags that are accepted during context
auto-provisioning.  This can help to filter duplicate context entries
from the provisioning database such that context auto-provisioning is
successful without user intervention.
---
 src/provision.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/provision.c b/src/provision.c
index 22413d2ccde6..0530386f61c1 100644
--- a/src/provision.c
+++ b/src/provision.c
@@ -28,12 +28,17 @@ bool __ofono_provision_get_settings(const char *mcc,
 	int r;
 	size_t i;
 	uint32_t type;
+	_auto_(l_strv_free) char **tags_filter = NULL;
 
 	if (mcc == NULL || strlen(mcc) == 0 || mnc == NULL || strlen(mnc) == 0)
 		return false;
 
-	r = provision_db_lookup(pdb, mcc, mnc, spn, NULL,
-					&contexts, &n_contexts);
+	tags_filter = l_settings_get_string_list(__ofono_get_config(),
+							"Provision",
+							"TagsFilter", ',');
+
+	r = provision_db_lookup(pdb, mcc, mnc, spn, tags_filter,
+						&contexts, &n_contexts);
 	if (r < 0)
 		return false;
 
-- 
2.43.0

