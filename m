Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196FB1591E8
	for <ofono@lists.linux.dev>; Mon,  6 May 2024 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027997; cv=none; b=lFMcEeoXWF0D09xGzKrg6Q8LkwD4NkzzQBj1eE3bqlLfB8FpboCF85uEEk9SdDumOxrwlmf8g6wUKScU+AgFr7ogPZF+p8N8M4udsLgP6u0+iTw7WroItHYtye9oq+JmTZuBwkyC8KLqmNoV2rYYe2JMdd/SqEgsoAsLU4MpcrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027997; c=relaxed/simple;
	bh=mWSCYtO2kXP1iew/GPMYRO3MMHdMvoVoDzDEgPSQcHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOX4dQtY4YJZsZbcjJ2GfW/XtfywHg7Oa4UxTRQOo4Ykjqn5wJ/yvo9/GvKcW3ux+C9/TzDyL9R7orJJI7TzeRqeMaMFyJU6bJ5YJgyBAMuqKG57G6S0a7EGqlzGnV7cjDDWkbjQUMJxZXqtXtZ5gYW9eO1pQtjNKoqfng1ynpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJDCsfGQ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJDCsfGQ"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f05b8fc6c1so850683a34.0
        for <ofono@lists.linux.dev>; Mon, 06 May 2024 13:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715027995; x=1715632795; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e+6WUjHPVlhw/U9dfcyIm8mVKlaCvLZeH63jCeDW7Z4=;
        b=NJDCsfGQLvKCQcOl4ynJtSkXZN9X2DUIvGNWYMLbpisSf+GW8sweofOmcBFT3ffrfE
         Wk0Hfu0BABgvvFcbiUXL5Zw6WZzfH7h3/4X8ZQt5REr0bQWjIJkKzk0YmQN9ukmWAtaY
         5GdG1yIt4bIb4OfahqysUqMv/lab6cES/bvMop2rZlpt4skyi0rn6VEFoBRbAZLJVRXw
         J5pk8NDLVJhScE2v1xaGioux5jk0mlJXmlgbE8R5FOCgTSck/50xlQrdIxDorA2S96LE
         Sz0e6+tUTItpmCjQsMTVLeJvr/dx4z7xW+seFfA35pNa4389XADNivJ1mTtteFVbFsC4
         HOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715027995; x=1715632795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+6WUjHPVlhw/U9dfcyIm8mVKlaCvLZeH63jCeDW7Z4=;
        b=VdPZ6Mt4BHwcUbXeL5mCZ68CPvul27DkHwckq8m6Aci0VR4Cj1vg1ib9UIovveMw2e
         4FTI/yLYNxEpAEYCROcy3tKquLEyqnNZAUpVy9Gnyxd7KNkYcM4dKhDajQitK6IbU9GP
         wjGSh4W3i4Mmsd0hNNfcjRtl4sy+jFd0i7YG/vopwdJvmfrWsX1HNhFhsyyXqFpl7Dq9
         8vpXFwbMNfavo6SnGc9xx9LMBzxdNTqDHFqiCc97E7ZsvrdS/3jXjNYx/pjfpDUAf9Kg
         +4YMZnClhr0asLsSgTpJKz9NU+J5gu0bDlj3JiFTt++E8UWkRoiP2Ra/Z08ljEfpVDaS
         7/xg==
X-Gm-Message-State: AOJu0YzFwJsEMdn0Ln1W9Zawn4JMH6Y5elo7VJVMPohkmKUexqHhVgJ3
	fBUDL6ud27erUmLqHo5Xw4jDxEk5A+OgWswWVmWU+6wp4PmaoFDYd/rURg==
X-Google-Smtp-Source: AGHT+IG6hXN9Yq++1pUtm8QOHd0vMxk6ifQkNzVr2Lb4DOGLR1Q6qHJIyXZtlxSb3ulZX/rT2FoZ+Q==
X-Received: by 2002:a05:6870:d8cb:b0:23e:5cd0:faae with SMTP id of11-20020a056870d8cb00b0023e5cd0faaemr12871623oac.34.1715027994766;
        Mon, 06 May 2024 13:39:54 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id gk12-20020a0568703c0c00b0023bcaacf426sm2107715oab.9.2024.05.06.13.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 13:39:54 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/8] qmi: wds: Fix up enum naming
Date: Mon,  6 May 2024 15:39:23 -0500
Message-ID: <20240506203952.55806-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: e075175baff2 ("qmi: wds: add utility to parse Data System Status tlv")
---
 drivers/qmimodem/wds.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index 94f1c028bd81..218587c3e437 100644
--- a/drivers/qmimodem/wds.h
+++ b/drivers/qmimodem/wds.h
@@ -68,8 +68,8 @@ enum qmi_wds_profile_family {
 	QMI_WDS_PROFILE_FAMILY_TETHERED =	0x01,
 };
 
-enum qmi_wds_3gpp_rat {
-	QMI_WDS_3GPP_RAT_WCDMA			= 0x01,
+enum qmi_wds_rat_3gpp {
+	QMI_WDS_RAT_3GPP_WCDMA			= 0x01,
 	QMI_WDS_RAT_3GPP_GPRS			= 0x02,
 	QMI_WDS_RAT_3GPP_HSDPA			= 0x04,
 	QMI_WDS_RAT_3GPP_HSUPA			= 0x08,
-- 
2.45.0

