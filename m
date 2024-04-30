Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4835E176FBE
	for <ofono@lists.linux.dev>; Tue, 30 Apr 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498703; cv=none; b=m4jiBimJD22qwma/Ga/QUfukey7Lo5aKVD1AoQ+1m8dwKlYbfshKtSeLjLfZi19KHXXGli8rOiDkAlbJh58w0YAgIkTyWgTDrhCN/9qyTgqazHF55T2F81y5lAafZrGQuFEGEjAcAq3lIu0FA3VTRjZiBtI2rrPtk28abPM6LqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498703; c=relaxed/simple;
	bh=k4aKWe8oMKT6O3ycUTM1RHrR27Tm1KLFvLSmfAIHBUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G6XKJs+JxGZfUnJUHrS/+Kb8YKXuZgQfBqSBbsND/KqhcZM/afF1Ug5EyIL1qaptT8DZjQn+7Hj8ZpTqPgMVCJ4mibA3RYi39VxXrbL7Y8SC7Xfekd3ArpLf8+0LRsZoHrP3URn2nhRa0lohY+cDpbq3jR5MjxP1POq+L8hLEbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HM1dNXGn; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM1dNXGn"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6eb55324879so1776545a34.1
        for <ofono@lists.linux.dev>; Tue, 30 Apr 2024 10:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714498701; x=1715103501; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HCrQVspZMl8vW5TeQ2cuo/1BLm828yffwZWQojp3JR8=;
        b=HM1dNXGnG7P1IX+huO66HWYwSmYqyTjGT5eOyGPIqlhAzGssJiKJHEiToCOk8eNltR
         WtM/qcfH9wkuq+8akYKCdkDGPir52+3udbzhokbX6TyC+H4rJC5CryMDlQBOorxBkoGs
         IQ2Mnw1IjSClgIuwF2/hJw8hhWwxiIGAZyqb1UawCDQoPeLxQgjFcWDgACD4nNATjOCF
         5IrkppgqDjHbXsoOE7v6JJY1ZRgXjXBVlX48kH4XYFpOomnwJPUh/z+rioSr5my/0A0s
         R1EoH0dZBKGw1YpD8E3lyaRQCZTtsCKh8XYYSK+vsAZfTKNB8D/OAOnN2l8dWTvc0JWE
         oisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498701; x=1715103501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCrQVspZMl8vW5TeQ2cuo/1BLm828yffwZWQojp3JR8=;
        b=VUNpMBsmlgzNY6z5td6kOaPPthNaPFEMO2dbt3WENh1KTxsMWjTTePdG+EFByC1SI4
         heWd/YN5zcld5kUK0SC05TywVWh4JwwYX+DLJvWCGZsehl4NXdaZGvG8Xwz4PcgtBiiz
         n5jIUn39YTk3cWbwqYKlWHNr4BaUDP5xUqbRaTuIqR4eFEEPEEEoYof8SGkNF3FqENr8
         y842yxdFfeJJ4FplhU0JhJYlge00v+wAkMJS0S1lf0RhExexfJfpPQZfw65VXQa/ATMm
         dcb4oMM4UWjpzAJvFnuvfMdGohqLelZszRr/b9ifqTvKwNOD870Be5HaDvPZ8JDYdjO8
         hMlw==
X-Gm-Message-State: AOJu0YwzGrHi9UtebHgJHASZIZQH4YtHNjFMMvbSjYy45mpYOJ3ROp1G
	as4haekBkuXdQ3wM1CKJhfZB4dRPnC3ME4GnJhFDb2Weoz12ovXimgxcgQ==
X-Google-Smtp-Source: AGHT+IHWa6hq11loe38/wlMRYVVtsrCPSZZXdPKljqeoVmcC2pytnGbjW4bYyQgsgZYS9EO/THQJ/g==
X-Received: by 2002:a05:6830:105a:b0:6ee:738:e3b6 with SMTP id b26-20020a056830105a00b006ee0738e3b6mr156035otp.9.1714498701081;
        Tue, 30 Apr 2024 10:38:21 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id dy25-20020a056830211900b006ef91c025d3sm77440otb.33.2024.04.30.10.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 10:38:20 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/2] gobi: Use LOW_POWER instead of PERSIST_LOW_POWER
Date: Tue, 30 Apr 2024 12:37:34 -0500
Message-ID: <20240430173817.3044-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PERSIST_LOW_POWER setting is supposed to tell the device that it should
not enter online state at the next bootup.  Unfortunately, no USB
devices tested seem to honor this setting.

Telit devices in particular will turn off the SIM and become unusable
until set back into online mode.  Use low-power instead of persistent
low power state instead.  AlwaysOnline support is now no longer needed.
---
 plugins/gobi.c   | 4 ++--
 plugins/udevng.c | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 550ce78733f5..39c1ab81fa56 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -226,7 +226,7 @@ static void get_oper_mode_cb(struct qmi_result *result, void *user_data)
 	switch (data->oper_mode) {
 	case QMI_DMS_OPER_MODE_ONLINE:
 		param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
-					QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
+					QMI_DMS_OPER_MODE_LOW_POWER);
 		if (!param) {
 			shutdown_device(modem);
 			return;
@@ -480,7 +480,7 @@ static int gobi_disable(struct ofono_modem *modem)
 		goto out;
 
 	param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
-					QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
+					QMI_DMS_OPER_MODE_LOW_POWER);
 	if (!param)
 		return -ENOMEM;
 
diff --git a/plugins/udevng.c b/plugins/udevng.c
index b9d115f16b7d..243dcd6e91ec 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -850,7 +850,6 @@ static gboolean setup_telitqmi(struct modem_info *modem)
 		return FALSE;
 
 	ofono_modem_set_boolean(modem->modem, "ForceSimLegacy", TRUE);
-	ofono_modem_set_boolean(modem->modem, "AlwaysOnline", TRUE);
 
 	return TRUE;
 }
-- 
2.44.0

