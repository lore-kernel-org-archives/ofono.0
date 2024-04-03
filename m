Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C033114D295
	for <ofono@lists.linux.dev>; Wed,  3 Apr 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160370; cv=none; b=UZanVgKYbgqtXCpIbhS2ZSbdi/+3V+WAPAbeY1fJXwtYx4ZDPvhNHExlIHLQau5URTJRHm4zIwxBu8YzYD3d3X0TkPxcbubdfkF5oOqB/rHsZLqRRrjnyE4CfZQqN+U1Wz+K/Bi9cloYmvT0WLnT7/Nl/nd3/rq7NuGyETVHsEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160370; c=relaxed/simple;
	bh=VIVvtDsq+G5WYkgS7BSz4Z7jw6G1tAM7WGFCd31MXL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjuMgR3JTz/aEoR2PUGGk3ZzK0+Y++IkzpGw47Zw2q6Wa2mOikrviYuMudNoZ8Bn88/VYEcCHfk/8ozcBt4EjiURUDPcKH6sB/y29cqJp7cPmHz7UUzggotaVgBqTiQ0j+2cfqg/SCLcc5rsXrxrQA0k98/FoSMFIk1cjPYWZj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/ligH7V; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/ligH7V"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e67d42422aso12676a34.0
        for <ofono@lists.linux.dev>; Wed, 03 Apr 2024 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712160367; x=1712765167; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUbKF21gV6LrGLntC6qJNUd+XWJqU7cqRFbMu1fiPwo=;
        b=X/ligH7VRI80G4GQHuUMBHsog/3Bub5QTA0uN+IVEmjrKPzLZpR4eL3srxENMUNs/6
         MH/cFDf6nY8/r6DAd5vKJEiTM4bSl81sEUZO5Yzc87dMnecqg3LXha/TugrYH/BCIyl/
         lhNSPtpnccQ9uxKioeeM40sa9puJWrAsgHg9BJ38eY6lXgLgVgkDwqhwFh9//q4q4nNA
         K8pb/4A12ENJK6SiZ6DDSnekh9FrxwJO8tppet6esb0A2U9stILCCxEOepmyxp8SsaM1
         mMAqq40qgLu86fmYvDHMTFEG5wgEJyhjInBqzyoAxqz53M37MQtOnioYs/oOfEGoNd8n
         rmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160367; x=1712765167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUbKF21gV6LrGLntC6qJNUd+XWJqU7cqRFbMu1fiPwo=;
        b=nSS07XFj0/2VMDunrxw2PkJ/bCoemN6V4rVBWDujIZ9ieD+XYoJDn2WrvfZXBU9s6Q
         EbG2AhOlolbs4AXT6Nd2EPKv8DOoIfsgRCtrX/wdkkvyRMtla/XSJODT53Q7C8AzIXJa
         Ke2qItqmI447XwsxgjepCiAcjftLJBOPcSEXG6rITG/lpLrQjG7z1Va7p/KEvRFJLoab
         yGMztiDg7/V/2/rnMa+svZ3HWcRnaubqLPClwomFB5ay6EWdP+/n93N5GnOX2gWqHXEy
         SXtZDYO8UaLpvo3JSv/IRAUSg32wNSEz+j7pzTDX0cfwLxPTLpgXHpLlwDIhAZ4s48nw
         LsnQ==
X-Gm-Message-State: AOJu0YxdSITmzrXGZQbZisiXSas1mV+q2PXtQHDgvvKBTZLvDEKBxQfk
	PSv1Z6kByfh/cWb0ncDajGlqd5AK1gTxEJcLISmPTEBT9KRTzkTQgWQN63n4
X-Google-Smtp-Source: AGHT+IGmTGUwPzVRy8EzOUTCiCCfEF1V7CKF6mAGDAt8jOtlpikybDlRF87Y8IkMfcaiy4/dp4WTUw==
X-Received: by 2002:a05:6830:6e93:b0:6e7:39ab:a96b with SMTP id ed19-20020a0568306e9300b006e739aba96bmr5047967otb.24.1712160367585;
        Wed, 03 Apr 2024 09:06:07 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id a15-20020a056830100f00b006e6b018a703sm2653635otp.79.2024.04.03.09.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:06:07 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 12/14] provision: Add support for provision filter tags
Date: Wed,  3 Apr 2024 11:05:35 -0500
Message-ID: <20240403160557.2828145-12-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403160557.2828145-1-denkenz@gmail.com>
References: <20240403160557.2828145-1-denkenz@gmail.com>
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

