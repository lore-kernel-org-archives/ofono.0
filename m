Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62794168AE2
	for <ofono@lists.linux.dev>; Wed,  1 May 2024 23:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605710; cv=none; b=Uq7LZB6MNx0zV3ntQKQjsAbb8p4wn6jxnTI9jGV+j1Y11pDDo7y83Ox9qSi/aD225YCU4kIXLdKQ1tqpnV9NYBphHNQbLhJaM/AIjRH89hHYFCBkKLg7Fq/Ar7FeV6YZ5kvrejpLSf3455Tw9snX5+mZy5QmJBOwXri+uHeQ+Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605710; c=relaxed/simple;
	bh=hsKznquxEBOZm/whxYN0T/K8hU+CPqi7HNkk6/IeSDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDGuD/F8eRBl+ljeOYHie+K9XcUtWdVKkaYiw3hW9SbLzHeY2Pne4Qrpdt7f0qCoOoFZebQlhQWrD2RugX7byNfip75kuxzRN/bmH44+TGgYyUSaUh6HnHj5cpMm58BfbeRLtFSBSUPs7zsM5HRGeuG6oUDloUlp+J67xG64Zxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpeoQ5KH; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpeoQ5KH"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6eb8ea5ac95so4300384a34.2
        for <ofono@lists.linux.dev>; Wed, 01 May 2024 16:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714605708; x=1715210508; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9YGcAocKbWGCaQsxwjkN96uQtedAjjKUnGKbgpD9ys=;
        b=VpeoQ5KHPcP7pvOtt5z1y+sCHU9oJvZe0fUwjrobNq4QqNnhSyuzjOF9yJF2VzTxNA
         kcqhKRvLaigmfk5/VAZjqXK4rO1blDjoZx5LZ3sSMKMhzIKe1LSGiAaEUxGl1BdEIKiW
         h6m/xqR504srHgQ3s6B4iYsKQt/Q0JjHERgSnAbOvfcMvrwJvdNTkVWShwex6Er0fA6G
         S5fRy8X+gnZ8vIuDSzPF9U+EJAGFYRTwlF3L9X7Zt7NttV7qoX87Aa+uGCTM4DFTrH3k
         JECj4qsyrUfcfwBBeWwkj2Uw1dZ4AHz04+SROhJDl15gOnUJ2TRqQBAzd5kg/LvXCigg
         himQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605708; x=1715210508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9YGcAocKbWGCaQsxwjkN96uQtedAjjKUnGKbgpD9ys=;
        b=usEbhvzOz4iorAUAdd8mudSHLfTqTVw/Ghh4lg5CpEaOt0ToqVIKJqf75bf7+M/ZAn
         p4Hq6M2wd7uyiBazCcyG/BadPv04swQLORFC9Rnn2UvXgG1c976zYNCXheopkx+fXJAR
         vosVmsDW7RzSXiTDKrR2nhoXdUFOlOiA6s/aIGwDtR4LsTh2S5a1XtAfso7ccktU86Wr
         ZsRRgtODp7c9emlqoeI3QNJ8BP3XGwtx0gBAJ4ANEtqeP5siVbXe6nYDifbG4Tnq1itf
         hOQhrb4SdD3bD6UopRLFcE95WeRLE5yGvzWNxjS/NQ+YbmOTuz8Oz46rKPi2VCGYoUJy
         vr1w==
X-Gm-Message-State: AOJu0YwkGAy1c1CJpMS1qzWhEoNQu9HCyiqpyLyHk1WmDxsUE1w34mrI
	jcnKVzxa/9VM5hVY5oyJEXBSrk02IOkgtNWPD21fFyEIrlOjUGs7NvG4+A==
X-Google-Smtp-Source: AGHT+IEAeCe3lcc4mzgWi+nMFsQsO24K+74nEMJGWMBYkz2Na5VFoIHN4kGYCqMoCp2K9MLOZ01KeQ==
X-Received: by 2002:a9d:65c8:0:b0:6ee:32ab:8124 with SMTP id z8-20020a9d65c8000000b006ee32ab8124mr4792047oth.25.1714605708581;
        Wed, 01 May 2024 16:21:48 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id x11-20020a056830278b00b006ee4e216d02sm1128040otu.14.2024.05.01.16.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 16:21:48 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 4/6] qmi: gprs: Register for other notifications
Date: Wed,  1 May 2024 18:21:31 -0500
Message-ID: <20240501232144.14025-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501232144.14025-1-denkenz@gmail.com>
References: <20240501232144.14025-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register for additional notifications via Indication Register command.
---
 drivers/qmimodem/gprs.c | 48 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index ebbef4475120..6bb5879199e6 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -191,6 +191,13 @@ static void event_report_notify(struct qmi_result *result, void *user_data)
 	qmi_result_print_tlvs(result);
 }
 
+static void profile_changed_notify(struct qmi_result *result, void *user_data)
+{
+	DBG("");
+
+	qmi_result_print_tlvs(result);
+}
+
 static void attach_detach_cb(struct qmi_result *result, void *user_data)
 {
 	struct cb_data *cbd = user_data;
@@ -282,7 +289,7 @@ static void qmi_attached_status(struct ofono_gprs *gprs,
 	l_free(cbd);
 }
 
-static void set_event_report_cb(struct qmi_result *result, void *user_data)
+static void indication_register_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_gprs *gprs = user_data;
 	struct gprs_data *data = ofono_gprs_get_data(gprs);
@@ -291,7 +298,7 @@ static void set_event_report_cb(struct qmi_result *result, void *user_data)
 	DBG("");
 
 	if (qmi_result_set_error(result, &error)) {
-		ofono_error("set_event_report_cb: %hd", error);
+		ofono_error("indication_register_cb: %hd", error);
 		goto error;
 	}
 
@@ -308,6 +315,41 @@ error:
 	ofono_gprs_remove(gprs);
 }
 
+static int indication_register_request(struct ofono_gprs *gprs)
+{
+	static const uint8_t PARAM_PROFILE_CHANGES = 0x19;
+
+	struct gprs_data *data = ofono_gprs_get_data(gprs);
+	struct qmi_param *param = qmi_param_new();
+
+	qmi_param_append_uint8(param, PARAM_PROFILE_CHANGES, 1);
+
+	if (qmi_service_send(data->wds, QMI_WDS_INDICATION_REGISTER,
+				param, indication_register_cb, gprs, NULL) > 0)
+		return 0;
+
+	qmi_param_free(param);
+	return -EIO;
+}
+
+static void set_event_report_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_gprs *gprs = user_data;
+	uint16_t error;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error)) {
+		ofono_error("set_event_report_cb: %hd", error);
+		goto error;
+	}
+
+	if (indication_register_request(gprs) >= 0)
+		return;
+error:
+	ofono_gprs_remove(gprs);
+}
+
 static int set_event_report_request(struct ofono_gprs *gprs)
 {
 	static const uint8_t PARAM_CHANNEL_RATE = 0x10;
@@ -423,6 +465,8 @@ static void create_wds_cb(struct qmi_service *service, void *user_data)
 	data->wds = service;
 	qmi_service_register(data->wds, QMI_WDS_EVENT_REPORT,
 				event_report_notify, gprs, NULL);
+	qmi_service_register(data->wds, QMI_WDS_PROFILE_CHANGED,
+				profile_changed_notify, gprs, NULL);
 
 	if (get_default_profile_number_request(gprs) >= 0)
 		return;
-- 
2.44.0

