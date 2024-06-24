Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A970B1A00EF
	for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257601; cv=none; b=V34iNhnBnlems7ZZJifKXDRvtPCn7n66MjCcTXrvUxtEpzIijE8LbtGLrxfw89VF1Lpio96UyM0x+WXDfVrjHiHtX5qIGf68GMHv1rxKuUcfarkqLuClG2ORNdOWI+/mvdsPGpCewXHi3FFQQht3UnKlurPMEtHENu6mdwuv65g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257601; c=relaxed/simple;
	bh=Xo2CMnnhdZCjUQ8KD72oaOqWYOQkHwkLUt1WR6/X6fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BhtHihZvRXtnuWh24mDQCGg0fYI10TGwbVJaj0YrBIpNeqKpfxzH8C6//u9O4Dh1g0Nr8FIbBAmwKGOGUe5pCKk6LjINRjH2dtU73hpiYhUsfAPpnSev3isL9PyZ8KHwNLV+P2b+x2NU8ATN+L58g16iJ/2JJcn/FaExf2mO2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3NcuYdy; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3NcuYdy"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5bfb24e338bso1880338eaf.0
        for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 12:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719257598; x=1719862398; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qoQMBeoAJX2jdeuccsEmvFoUIEAC93FlI9juVRlE0Zo=;
        b=c3NcuYdy1uQhbjB3o6in1D58+1o27CxlH7FtM+7QoeT/s5nnHrg33CRNq05zHSd7SB
         hM+iQbuRWookHZSbTfSz6CUpkL51XdlexfFCf/mhqBnmQ3bW4Zgto26vaUQypnGX6sVX
         oFf/p/HlaZm56ym5YqEj7LsBQA/40SBaPkN7/OOKXmbOfY8RRvv3PpaHMbZ2Bmu0Wi6L
         e1oLmWKVaj4MHFiN3MHsSVTmyqctD5dORrthC9qZqvSvguVLer0HVRKUSupNDD0qIUVD
         4ZSDhkjWD4BvA9lxe3IzQL1UiLrppSztqUX2Sc04gGR8VsFC5fLVL6n9H+R+Y4P43sef
         Fm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719257598; x=1719862398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoQMBeoAJX2jdeuccsEmvFoUIEAC93FlI9juVRlE0Zo=;
        b=Wx0M5NJ9IuSgCHxmZimFype7tLeF/4Lfdw2F74dYbFJS6paSoAdpOav8TE8I7JOpsc
         nKsWFrjhMU9iVHw3pHL3GZsTFms+u4vQeaYruvJCjipE2tVmqpx7h2Pnbamh605jDESr
         AerLeJ5Zm42aWgK47kF/R4Oqz3c+Z5UgG3sK2q946AjYLrujDb3aiLZP25k4paqJ/3Ri
         wcMltD9kP6M6Ji2EVyTmPkq0a4g5Q8sS/5AbiBzp36tR/hfto5Fc3MoIY8Yz3hFsxf3T
         DHV3UwkLHu5F52cFlC799aymZtxYpKPYppqeqPPldnaYQ465BPVcNbWtZRjYByPrmPZL
         MPGg==
X-Gm-Message-State: AOJu0YwwEkouXFDBoRjRyg8kO5sBC/W7VYDkcq/tW3sRLXqeDsV9VT8g
	NpjBlCzX1BcZQwIO0ja5erwXlU8FGiSTOs6cQY4JqCUSWnMGvjXlvvFhFA==
X-Google-Smtp-Source: AGHT+IGmDQaOJVnJX6/5DGWFGABYKTXkp4KSa5is6qrUomtMA1mjEs75Vny7h7ND9+ZCoWzfbGtIHQ==
X-Received: by 2002:a05:6870:d1c3:b0:25c:adef:2348 with SMTP id 586e51a60fabf-25cf8a3839amr2565576fac.12.1719257598299;
        Mon, 24 Jun 2024 12:33:18 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d54c2d44sm1480831eaf.8.2024.06.24.12.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:33:17 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 01/13] qmi: Introduce SERVICE_VERSION macro
Date: Mon, 24 Jun 2024 14:32:44 -0500
Message-ID: <20240624193315.1164943-1-denkenz@gmail.com>
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

