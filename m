Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50DF16EB4E
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740980; cv=none; b=QtGC1zCPsBRi1/XHMEHhvL61B+9Zg7Jgm5LyQn/OPrEogWcb8pAJMLaPKvf0jTRNJ9kRbgR+tuh3giWU0rmFz3lHaJUb71gH3XeG+dFb1e1URmpTAodGHZSS/DR1GF20yEPxCzHc9qyTnfenw4DC+5ifWfur/Hlg7vkrmZW05qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740980; c=relaxed/simple;
	bh=PHRFImjLI9jAlflntOrvaWQbxtJQhUwxaPki5M0DYgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnU4shtnGueNQBWLVRZ3YUhw5FRkQkqok3asuD1cniR+6Ah/fc21UziZYAMBQKY7rvXDb9TSFLuKhoc57KscGibTgSMCR5LmxvZlLrecFnd2pbDJnFgVFKWohXwwKpsWQHkHD45j/1hhsxUbKCKnd/khVo/iMnvZd1zqOrkWrfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCUX3VC7; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCUX3VC7"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2547e1c7bbeso3080990fac.2
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740978; x=1719345778; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0aurGGIaUBvp/K0HPX3fLYIhmruLRueL24gkxt4kTA=;
        b=VCUX3VC78tw2pyeBAiJ4nxMicIQPZ//ktl9rNvKndZ8VebIZT97+yAUDn3zTqFH0B/
         rL1jwR4Dd1EHoaUQvWrtoiCeOjsM1GPPV2JT5i+/mYMyCX3Ew1IFgKlT/KUuXROA9iXw
         +V2FER1q4siGX3dsCrMY5LA+9vGHILtmQVT6wWX8Ne3uXmFj2/QTPvflGxnrMVqOU/Df
         mL1jF0XDDR4HPfPjDEH1tdNKyBbPQjskgUjD1tHS8/1ditFR/A3/YJCgY5E5hR6QX88D
         +15uBJmeV/o0T/LmfNwBNsbjIGveXYMBShZCcpOJquhDYQ6C4wfiA1Trtjl+BDMUre2l
         Q6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740978; x=1719345778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0aurGGIaUBvp/K0HPX3fLYIhmruLRueL24gkxt4kTA=;
        b=DvxoXnwkvl/a9UJeU32bMXz67BTcRrIMapW4/pIkU+9rdSq0TlWAlwP17wdyTidAqp
         TiHj/Hfr1mM5urSUxzjDgi6aY4irArVXz0PEYDOKtGAHECZIO+g6DfXxsDnGaGLioeHq
         XiqDCQKO1fXfuLmynCHVp5VzhVzQ7d+Usv+KgDlXz0+w97Ng3FUfl3w295s6KpkyiLDT
         eAhDBEp4jqVE1YtyWkl3IOGKwpFUD57DlOE4awOslFRaWtkU79J6A5ga5gf9TKnncuUP
         q0twz7Vdx8nWyluP2kh4dwi3FzhKLMVnZb1+ew8XTvTSTaboGdTsR/zmqwjjy6NAemw8
         dYyA==
X-Gm-Message-State: AOJu0YySUU/BpGiRZzOVEyHn9Znrb1WSu5Pu6camz+90G0+v7QEoXk+9
	I3lcjKW53nJBy/ip07djW/bKzh1mBMsOSQAbOKBZKa5dzaUCAb7W9TgIrg==
X-Google-Smtp-Source: AGHT+IERBhETjElw98muddGtAMw6vTzKtZpFAKUh4Nc/tLF5oAgMB9kGsZaijxCkgLP8by7+KO9Rrw==
X-Received: by 2002:a05:6871:5c9:b0:254:6e4e:23d7 with SMTP id 586e51a60fabf-25c94d722a6mr926966fac.50.1718740977731;
        Tue, 18 Jun 2024 13:02:57 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:57 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 32/33] qmi:gprs: Don't fail on unsupported INDICATION_REGISTER
Date: Tue, 18 Jun 2024 15:02:14 -0500
Message-ID: <20240618200231.1129282-32-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240618200231.1129282-1-denkenz@gmail.com>
References: <20240618200231.1129282-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some modems (like Sierra MC7710) seemingly do not support
INDICATION_REGISTER request on WDS.  Do not fail gprs atom registration
if so.  Only indications of interest are currently used only for
informational output to syslog.

ofonod[1120532]: drivers/qmimodem/gprs.c:set_event_report_cb()
ofonod[1120532]: drivers/qmimodem/lte.c:modify_profile_cb()
ofonod[1120532]: drivers/qmimodem/gprs.c:indication_register_cb()
ofonod[1120532]: indication_register_cb: 71
ofonod[1120532]: src/gprs.c:gprs_remove() atom: 0x504000022a90
ofonod[1120532]: drivers/qmimodem/gprs.c:qmi_gprs_remove()
---
 drivers/qmimodem/gprs.c | 8 ++++++--
 drivers/qmimodem/qmi.h  | 4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index da7ad63c49cb..51aa722a89c1 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -279,8 +279,12 @@ static void indication_register_cb(struct qmi_result *result, void *user_data)
 	DBG("");
 
 	if (qmi_result_set_error(result, &error)) {
-		ofono_error("indication_register_cb: %hd", error);
-		goto error;
+		ofono_error("indication_register_cb: %s(%hd)",
+				qmi_result_get_error(result), error);
+
+		/* Some modems do not support indications, ignore */
+		if (error != QMI_ERROR_INVALID_QMI_COMMAND)
+			goto error;
 	}
 
 	/*
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 966f99f114fe..db20280f9aa3 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -50,6 +50,10 @@ enum qmi_data_endpoint_type {
 	QMI_DATA_ENDPOINT_TYPE_BAM_DMUX  = 0x05,
 };
 
+enum qmi_error {
+	QMI_ERROR_INVALID_QMI_COMMAND				= 71,
+};
+
 typedef void (*qmi_destroy_func_t)(void *user_data);
 
 struct qmi_service;
-- 
2.45.0

