Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA1B1468E0
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 22:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468927; cv=none; b=GIVpdW3hbwKcvwbt1OMnhS2RNZyD/uFIBbcOM0LSa1qetb+gcOLf9eRgl3v4l70W02iq2Qb7hs7iNYrx3vl+uPQarxDJUxmqxxGqtIg106Sm5CzZID8bp1hLs+yb9ntbYOEwyX72tkEYPZSPMtZTlLtSTbBDVGJpZrMOSD2nkxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468927; c=relaxed/simple;
	bh=OEU1xpqThKW8XFaZn/NSxip7qRGfJFeG8AMs+fzGvGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjwrF5nfdRfZXuzADXro22yaPpjiRK0HQ9iEhLZLZ8Gbxtivekr7OcvgoGGAenjUV162cVnKmZtEyhLJRA8DiCq682wINfAhtPKbACs48CfkddiC8aHzLOR6/rFcHoTiSgaYvrU0X/pY3yGNX+uWSXKrZGcVsMdEnlcsttMOKrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTy3NtV+; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTy3NtV+"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-21e2673a206so3863831fac.2
        for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 14:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708468925; x=1709073725; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GT2n1ZhFZMKX4SFCmBfRS0JOvgzdVRGbzfbOfsTlYBU=;
        b=VTy3NtV+Txx1NDZ2nRK7OdAUxM0asU0k/q1Eo8QMfkKQcE4xYIf+Z7MswLT4eb3GRJ
         8lwhaaflC2WBUYzyWB/H29A3HT/lZ6lanpVGkqb2nccC3DIdW2iidbC16Sob5jj3DsVp
         KTgh9pniwYnoZw/3e5hfBKIRMCC2oH8ZEcB52Tvue4sVu1R+vABuhZvScMNPQjUNsHxF
         WZbaCi12QQnvBquad+1pwLP9yO1D3MgZV8p8YO1vWQA1tW4g92t6KxV76TGisoG0pOxV
         D1K5C0/5Tm8VFyZPb4HMY1+pCbjLyWlBfkPR8ow6Y56jegnqPqDRLKiPEA2Wb7QLVn7e
         2uXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708468925; x=1709073725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GT2n1ZhFZMKX4SFCmBfRS0JOvgzdVRGbzfbOfsTlYBU=;
        b=iLA4lbbU1ksTAp68UoAK06AW/nQCR+8ql7s7lklTHPZdjIG7QA/Cd45amN64RO9ues
         yNIx7zSTPXg9yvu7181xVIWS/GJPQCo//hXkkKxN2Cw2xSbzgIwDIfMWzUvg9CGAb5jU
         tqagG0HjiXjLE6bqt2Bno1E6Zj7ZaOE44kem8Ewj4uNnRXizTXXpo5gIQnYTQOJliFqF
         reLIJbEVk1FLsOVBVsLw1D4db4dZdcgu4l6vwRbexry+NwbnabyzJ7xvJC0ru42RLnXv
         ApzRpWpvkW518CjKlloGzSWWVvU/dDcYNTSwsUjb/ERfW+C/n2fAefePiB0oFyqrroC+
         FMqQ==
X-Gm-Message-State: AOJu0YzeFqFc6EhSpZ3/JjM2vgXkBtb3rgdBE5z/AZ/WLKjoZhhgnY3Z
	61D4OXZsHPvG5AJrcYQ/MRFzLWvTxmwbsEY5UqM6dFsUvs6Ee+Ah8wagXGGz
X-Google-Smtp-Source: AGHT+IF5I3gTegCDWTUW+tziuaS+tbYz+Gch/GFAY8MLlCAd1n0r60kxnbk3RZrnpHDUZPlyA5enIQ==
X-Received: by 2002:a05:6870:1613:b0:21e:b667:22 with SMTP id b19-20020a056870161300b0021eb6670022mr11023351oae.7.1708468925433;
        Tue, 20 Feb 2024 14:42:05 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id nd15-20020a056871440f00b0021a1492f000sm2056403oab.38.2024.02.20.14.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:42:05 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/7] qmi: Move control_{major|minor} to qmux sublcass
Date: Tue, 20 Feb 2024 16:40:57 -0600
Message-ID: <20240220224115.1254853-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220224115.1254853-1-denkenz@gmail.com>
References: <20240220224115.1254853-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the following members to the qmux subclass:
	- control_major
	- control_minor
---
 drivers/qmimodem/qmi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 8de5170674f8..dae540251118 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -73,8 +73,6 @@ struct qmi_device {
 	uint16_t next_service_tid;
 	qmi_debug_func_t debug_func;
 	void *debug_data;
-	uint16_t control_major;
-	uint16_t control_minor;
 	char *version_str;
 	struct qmi_version *version_list;
 	uint8_t version_count;
@@ -91,6 +89,8 @@ struct qmi_device {
 
 struct qmi_device_qmux {
 	struct qmi_device super;
+	uint16_t control_major;
+	uint16_t control_minor;
 };
 
 struct qmi_service {
@@ -1205,6 +1205,8 @@ static void discover_callback(uint16_t message, uint16_t length,
 {
 	struct discover_data *data = user_data;
 	struct qmi_device *device = data->device;
+	struct qmi_device_qmux *qmux =
+		l_container_of(device, struct qmi_device_qmux, super);
 	const struct qmi_result_code *result_code;
 	const struct qmi_service_list *service_list;
 	const void *ptr;
@@ -1250,8 +1252,8 @@ static void discover_callback(uint16_t message, uint16_t length,
 					type, major, minor);
 
 		if (type == QMI_SERVICE_CONTROL) {
-			device->control_major = major;
-			device->control_minor = minor;
+			qmux->control_major = major;
+			qmux->control_minor = minor;
 			continue;
 		}
 
@@ -1274,8 +1276,8 @@ done:
 	device->version_count = count;
 
 	/* if the device support the QMI call SYNC over the CTL interface */
-	if ((device->control_major == 1 && device->control_minor >= 5) ||
-			device->control_major > 1) {
+	if ((qmux->control_major == 1 && qmux->control_minor >= 5) ||
+			qmux->control_major > 1) {
 		qmi_device_sync(data->device, data);
 		return;
 	}
-- 
2.43.0

