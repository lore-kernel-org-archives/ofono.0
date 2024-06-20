Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E031AE87D
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895141; cv=none; b=gIzDWgEJD5ACsh9nWDccMmdMR+w/FOQ4ILpteA+9D4TbHOYt9Mz/EWzHpVUpF6rMQgecqhQgc0ftA1Dqb6fQjiF7Z5Fc2cjk6Dd0k16saZsRtdgtbUiCFDwu+55dOhj8dL6Px96KjPXD+xJpH9UZqxSxa4eOf/T729dbH+S4C5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895141; c=relaxed/simple;
	bh=cKIaJ66AL5AWhs8O/mUG2hL2EMBYlebuTzuZ866/o7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kipwsu3uo/ErtA1TWj5zYWq7fKpC6ZuuN/ijbjHYT3EMWj4DGza40Pxh7P+GnUuqoSHdph5yddGz9tZBsfOJhnKkxh5lb0jE2uAlSynAO2hrsmOv+nRiPXgEmNpo2BJjo9r7HDPYk5bXGKCN3pXV1Vk6argNJoBl59aLI/68ET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5ePTaHq; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5ePTaHq"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c9cc681ee7so405071b6e.1
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895139; x=1719499939; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inCgtKfHc5T0FMjikFwxW/MC3LMHDrydzTA6wxZFvbk=;
        b=Y5ePTaHq1geLavCZZ0lXDgEbz0m7LxT249lmuGpKODUY7f8rvC6hi1+LmA8Zr/7coN
         g72D4U/qf5Z02Y6zm8L4u6d7FrtpfLT8KLQDLMC/xNBWcDnoLDkykfwrPeoQsjC9+L+7
         ve23oSQ9KIyez/rKJDffjP3Rj3Lwnhq9RaybT5nUWc0ttaHqvAaJAnQsxBkLz3mD2l7T
         TzUqmdFq1HNYyQ0FaVkEivrEJcg7Dyd0lNQ1ms/4BBZUne6yrXfIR0Sr39zNqZxFqUcD
         ztHK7uzvC9+4Xk0VVI/kPA7D8ebsu05tPdRhdEgww//PqEtd1P/AS0e9xcNlPcAeO06I
         v8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895139; x=1719499939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inCgtKfHc5T0FMjikFwxW/MC3LMHDrydzTA6wxZFvbk=;
        b=u+CziKsXM8ains+8FoanZJwaIIrlg2Sb4q5sw/PnIYU73GMbbEvT+w3Ew3ZZUu4WKR
         BWn25pc7ZKkxGKXbSBONjKTYMLKtl+ziWHJ4cYkyiKTi6BVyiHXCn8aFQd72wRQNEB2i
         baF48/Y4qKzFjixlmxs12i58ZBiHcELF4DmO3RxuXmATvLAg5mJiImWbp9tdcJIAXyt7
         VULKJz60GCXX20chmkm4V+X2px39N9ZNqpIyDbY+nOgpx0QSPm5ejnVJFxonjqzq8dSE
         m8YBbt1N0tjCHHqIqjMM91GpsuR8DqxmNolhv2C6WqiiFJdYin0r59mnA5rg9oy75EZ/
         BWPw==
X-Gm-Message-State: AOJu0Yxwb90jBKaP88U1jzMzOVul9mmHq7dpCWVFU9hkadMd+7f+tyxU
	C/g5Wgu/mZx5v1vGZNTSLWlAj13v5GDVu3OwB/GhpgWs4ElCu9amtUB4Xg==
X-Google-Smtp-Source: AGHT+IELyrsl/SSQh7UysshFcz7fVf+YPfjnaXhDmZ7jcHN+BmuSFZ0VRVcxuqX9Wwq4HufK0U4Dtw==
X-Received: by 2002:a05:6808:1b14:b0:3d5:145e:36aa with SMTP id 5614622812f47-3d51b5d6383mr2836436b6e.8.1718895138775;
        Thu, 20 Jun 2024 07:52:18 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:52:18 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 32/33] qmi:gprs: Don't fail on unsupported INDICATION_REGISTER
Date: Thu, 20 Jun 2024 09:51:19 -0500
Message-ID: <20240620145139.1135899-32-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620145139.1135899-1-denkenz@gmail.com>
References: <20240620145139.1135899-1-denkenz@gmail.com>
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
index da7ad63c49cb..547b32059da4 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -279,8 +279,12 @@ static void indication_register_cb(struct qmi_result *result, void *user_data)
 	DBG("");
 
 	if (qmi_result_set_error(result, &error)) {
-		ofono_error("indication_register_cb: %hd", error);
-		goto error;
+		ofono_error("%s: %s(%hd)", __func__,
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

