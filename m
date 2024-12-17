Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D92D1531E1
	for <ofono@lists.linux.dev>; Tue, 17 Dec 2024 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427949; cv=none; b=m+w7YbBd8uJ9E2VpdE1B32tz+uI49zaXO2duzj8U/W9z9P7hQhGVS+jUiJtsHHg3N2kAtly2LIWvMQVK91+VA4I52BIUUl8TVwZdysAZM8wAwZ0Qjba/Sq0QOpDq+muzoCcQUjzizxkRAhYMrAUE1pdp9Ad22CaAD5Pr0XYLUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427949; c=relaxed/simple;
	bh=sUjNE2HMyoX4vb1YpfYId71c4OT4L/kFHF/x3yQZY8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvgsqZ+bOtRoBJQSFznY0XiuUwtaUA2KtkUMW/tsRmpR3fqNYpIY6gBIwh4H39OSNqunrRewmAsISpE6nnzZ7Sl4Fnm/zG6eCNHqTAMBKkfb9bdzXOXm/lpbGNlpmkGEqpL8c4XT7n6bFsVAskE0P64a2WGOY5fOLIfrUYAtXVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3bI4p6C; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3bI4p6C"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa662795ca3so1172539566b.1
        for <ofono@lists.linux.dev>; Tue, 17 Dec 2024 01:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734427946; x=1735032746; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NevN2wwzyAP5C+vyw3UFiYN66h6ehOD991ZX3ZcigO4=;
        b=X3bI4p6Cso0v6gspc0AmkAC1uVRUnAnQD1bWJbuFS2QU+lIuVswUxNFCrw050zL8/8
         0tMdW1rhAIpp6ExFqgK7GR/F6TcdilrINvAkryRnMWHs59Cnu+IojbaEkvTEy0GmzpGD
         Vzh0OrrZkgaM3CfHJ9b8MV5A8oeh4jUNB1AaE/s/ovmAVvW7HrSEp7kCPS39gTgiWv6v
         d2oIC6OmsBTPleqP8m+1914cd+DC8pruFSioxgHDrPRfy+EqcwbhRSTHZhQdQuWEvlOt
         FvxJ+JnJ/ihUwEQL3GrrXtDsL6rIEDV6+Huzn+CUBxH2v4CK8xqn2+0SpRW2z0GivyxH
         s1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734427946; x=1735032746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NevN2wwzyAP5C+vyw3UFiYN66h6ehOD991ZX3ZcigO4=;
        b=quc5ATvKKU3eSPe018+sa1DNHq4Bmq+UQ/l95wb2y4SQlJJUiYj8T3DV8Z+3zi+EzZ
         KuJbcfo4GWBicvL2Vbt2PlfRmejTMD+hTo3xvcJ5wBOv3fuu63S3XNx/O+o79HroMer8
         Q9gFBYEYWAzyBnpkZIjsDHbmpv/qSgPYwacbl9iUGozeqWAwtf1ssC8xoDkG8DlDe9DV
         DEUOC8zXhXX1ncQIY353eVu2Goq/GshWKgQWC+P+B8P8gjUSh+jS7+D8GCc+w0IqrliS
         hwJzaGyGRVtPa91vQh4oibmHl6YRAPb149SybzG1tx5W+iAKIcySznG3641hShmaJylu
         m85Q==
X-Gm-Message-State: AOJu0YyyZVTIQMiayBPV1ON0hDDRglv8LpofhhUvHCaCM2pO755WFCL6
	wAV758r5cZGYuMoIwd7AfP0vuw+XI967nQQ+659MVDdbSxBjxnBbUA7Vt9O7
X-Gm-Gg: ASbGncufGigA7oHzzifaSdKNdX/3YgI92h01/XdxU9GUjS43dAe52a2rFIIM44Y68ub
	7C2AoKV04At0e/3ch3DigTg4Dyn+VPqgprz+17g0fNitDwQ0PzcE92ynAHCXkFoNf4yTooipCDP
	uCFJn5+Xsgl5BXhMdZGEs/yvlrwKKex6k4+BlW+jul+QQR1jypKU3pwnIoSmNpvWB+R3vcZWWu6
	hq/iCsXojYKoRyHSMpfLcSS6/qKJ4IejyYMWVO/wn6JJXhpg/YWcTEc
X-Google-Smtp-Source: AGHT+IEeYOZJ8Uc85kS0okwWzWCu35hp4cptyce5lcRsIceSzmOACQH47n05x4CrnyLKgFr2LTrOJw==
X-Received: by 2002:a17:907:d8b:b0:aa6:1afe:b0a5 with SMTP id a640c23a62f3a-aabdc834bf0mr206825066b.2.1734427946299;
        Tue, 17 Dec 2024 01:32:26 -0800 (PST)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963598b7sm425536566b.101.2024.12.17.01.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 01:32:25 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH v2 2/3] atmodem: sms: ensure buffer is initialized before use
Date: Tue, 17 Dec 2024 11:31:28 +0200
Message-ID: <20241217093207.20636-2-absicsz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241217093207.20636-1-absicsz@gmail.com>
References: <20241217093207.20636-1-absicsz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: CVE-2024-7540
Fixes: CVE-2024-7541
Fixes: CVE-2024-7542
---
 drivers/atmodem/sms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index d994856b..0668c631 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -399,7 +399,7 @@ static void at_cmt_notify(GAtResult *result, gpointer user_data)
 	struct sms_data *data = ofono_sms_get_data(sms);
 	GAtResultIter iter;
 	const char *hexpdu;
-	unsigned char pdu[176];
+	unsigned char pdu[176] = {0};
 	long pdu_len;
 	int tpdu_len;
 
@@ -466,7 +466,7 @@ static void at_cmgr_notify(GAtResult *result, gpointer user_data)
 	struct sms_data *data = ofono_sms_get_data(sms);
 	GAtResultIter iter;
 	const char *hexpdu;
-	unsigned char pdu[176];
+	unsigned char pdu[176] = {0};
 	long pdu_len;
 	int tpdu_len;
 
@@ -648,7 +648,7 @@ static void at_cmgl_notify(GAtResult *result, gpointer user_data)
 	struct sms_data *data = ofono_sms_get_data(sms);
 	GAtResultIter iter;
 	const char *hexpdu;
-	unsigned char pdu[176];
+	unsigned char pdu[176] = {0};
 	long pdu_len;
 	int tpdu_len;
 	int index;
-- 
2.45.2

