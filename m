Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B0513B2B0
	for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333723; cv=none; b=mT41ohoKDavWg2qvQJXBwi4q+Lx1gYficzAGwJiwi51ksX5ETBUWWCpTpE18frr1RHhFhebUD0SLTDbnv4bOFtXgsP83cTJYtO8AL9dQcU8y+VFlnLgETOIUz1eVcY5mhHxolgtqYrDU2XSjveRspMV5NpfEDmAMpUTx7cT7phQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333723; c=relaxed/simple;
	bh=Xo2CMnnhdZCjUQ8KD72oaOqWYOQkHwkLUt1WR6/X6fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wnb6X4FFf3Fu74v0IuzvG+VPLMNEbI3oo9KQlmBpWjrcix6iWpUrPuED2wWyyYcTezoJRqJLGVL4hrhY+Bggrm1pdNga/Y+ZSPaHz5Hp4bFPjkNtnqoBFXV2eDfywC9BDlvF4zdcMEkCmb8oQQao34p3qsB3Km6RB7sdVMJTAl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqiEGlTL; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqiEGlTL"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-700cc366e0dso283545a34.2
        for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 09:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719333721; x=1719938521; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qoQMBeoAJX2jdeuccsEmvFoUIEAC93FlI9juVRlE0Zo=;
        b=AqiEGlTLKPZ84N1whJQSOmaYHcG9jsgEeKK8GqgWYdW6Gf3qCvcSbURPq/QO3OCBd8
         hv0k+8LDNvt+XshtQf2yP6esHVx0ftpM7fynO46oOPzKjrlPlzfASkaQ/OTAxoShynkB
         LV2fEWsk3D7bfOWzv+EaYzbJgkiZddzcXkQ2wD9+xNe0y0k9sfFKKCEEAhQO8H49+gXV
         UUS76ks0+2f9CtRJxpsTUOnBGmBnIN7YF18j1egBLx6lk7cAjzy5FcQkGvn75h3LiwGQ
         jseI5Ejw1/LPhYprrfpybWQDD/WDgYYh+aOpQwe4B+PD9Q8WuMPHmN8FyxDFRLx3Opoz
         4V/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333721; x=1719938521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoQMBeoAJX2jdeuccsEmvFoUIEAC93FlI9juVRlE0Zo=;
        b=KXEbRAeBd8WeLEHKG/UnMtOeMf69uoFSbZfYB+ZQp1eOZOFUjKLAgA1ct+s0eGvijC
         yjs8phmzvth6EJ9ShSgD2VKi2MG+GJvst6bReIwI6Tq7jrPcAjgvXrnUONG7CyiWz76k
         IqXDgqha/ot/USlIFje14hnLA3qQhgIW38KNHAWcJ2HKji1iiJRYLZKGJzNcFxbwmj3z
         okj3atra19ve+4PEbLqCMu2RcgpZk4E9aJX7ROwqT64Q6g9j0uMtfcfg9e7ckjyxjDgS
         OsM+8/RjeecLB+duUcQOQRqIQbaplN9fnf/fTicBpymezRHl9HiicO2qcaTumlOjWT4Z
         NLmw==
X-Gm-Message-State: AOJu0Yzm2fKVdi4LldZ0PFmRcKWdldIP21C0W+Fvy48rC5LH8KqekjSl
	WkDvrN6n9r3LXQ3wMp2KCqi/gSxEQSp1vrwv84PHI4a4eiI2Zodrgp7yxw==
X-Google-Smtp-Source: AGHT+IEmapcaLCyQaZTXkaZlYp8iR0gRr1iPwaL2mZ6idlSuDooUIUgl+EEv1Y40EXAxs5cm6iIvGg==
X-Received: by 2002:a05:6830:22e7:b0:700:a962:ad17 with SMTP id 46e09a7af769-700b1201662mr8581918a34.16.1719333721199;
        Tue, 25 Jun 2024 09:42:01 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d55dc2dcsm1884844eaf.27.2024.06.25.09.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:42:00 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 01/14] qmi: Introduce SERVICE_VERSION macro
Date: Tue, 25 Jun 2024 11:41:37 -0500
Message-ID: <20240625164158.1170937-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will make it easier to compare service major.minor versions in a
more readable manner.
---
 drivers/qmimodem/qmi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index e3a8b225140f..5f29c4384803 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -36,6 +36,9 @@
 	l_util_debug((debug)->func, (debug)->user_data, "%s:%i " fmt,	\
 			__func__, __LINE__, ## args)
 
+#define SERVICE_VERSION(major, minor)				\
+	(((major) << 16) | (minor))
+
 struct qmi_device;
 struct qmi_request;
 
@@ -1199,6 +1202,7 @@ static void qmux_discover_callback(struct qmi_request *req, uint16_t message,
 	const void *ptr;
 	uint16_t len;
 	unsigned int i;
+	uint32_t control_version = 0;
 
 	result_code = tlv_get(buffer, length, 0x02, &len);
 	if (!result_code)
@@ -1233,6 +1237,7 @@ static void qmux_discover_callback(struct qmi_request *req, uint16_t message,
 		if (type == QMI_SERVICE_CONTROL) {
 			qmux->control_major = major;
 			qmux->control_minor = minor;
+			control_version = SERVICE_VERSION(major, minor);
 			continue;
 		}
 
@@ -1257,8 +1262,7 @@ done:
 	 * invoke it to reset the state, including release all previously
 	 * allocated clients
 	 */
-	if ((qmux->control_major == 1 && qmux->control_minor >= 5) ||
-			qmux->control_major > 1) {
+	if (control_version >= SERVICE_VERSION(1, 5)) {
 		struct qmi_request *req =
 			__control_request_alloc(QMI_CTL_SYNC, NULL, 0, 0);
 
-- 
2.45.0

