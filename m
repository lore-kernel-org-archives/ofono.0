Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E6513C918
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 05:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739509493; cv=none; b=hKY32dr3c25Pbxx4s9qdkauEJ4EkTH1B0Fyk/o/dr7AF9uf0gx5K83NCoaxWIYNo45Lq78xliQjZlJX7sz4yYEzFsB3acAfhvzZqA7/wIc+f4Rth/TAgMogTHHc2OwTNtiAdAASmLqNmCDDeaVlr+U0BmkgB4O8Cov9s7/ZJD4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739509493; c=relaxed/simple;
	bh=Zv4RA/sY6txtwuaBhWqF/sIrPbIIQMK3UhHs9h1Vs0M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvrRNs0rvNf6PG2IVZ41ymp2H5QLylzwbhFgAldVQHTkB89gKYQ6Mb0negZlg6N+OZCOFa/hrVqGRLpOWTnX5GglCpC4P7iGkm9h3jx2A53218oaU+mSlYV3d/rIYKnClmuX+iHuw9PZMU2vu4IviWXDlF7U2jU2l19dFV15Tc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=MfcK1Baj; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="MfcK1Baj"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id C258B164A75
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 00:04:50 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 7902A125167
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 00:04:50 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v3 1/7] qmi: Added enumeration for device quirk flags.
Date: Thu, 13 Feb 2025 21:04:42 -0800
Message-ID: <59c8f32bc48808da9223a192cfa180a04c711402.1739509438.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1739509438.git.gerickson@nuovations.com>
References: <cover.1739509438.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=5RkJRnoVHnJwZCzxHGA2QOPk/DensYYgENGrNo82m/E=; b=MfcK1BajhPWVEmG5BMiqE8FT+v6LNmxPFTHX8YZX1Cov6OCM79XPapHjVQ0K2rqC4sRwgiFp34gHJ6PvJeNlwqth4vSN9ShCcf4tgYmiPjo8+qY8fscNImvV3RxTqdz9IgT1U3ALDQYMKPS/Bv8cqpH1hBJ/kQO4pz5tK6jtFX2Tnzm5wKQwI9+yJf8CzSjxNDymvYX4KnTYqKPnE+oqyC6RAKJPcFGzBNp7kA7mDJGmN3Jsed2yVQYKCO/uCSR+qV2iFt38GmJ0ARo4FrS46F918F6vVDfhf8cVqY9dfC5WLF3E+diNrxqIusJys6jgU5+fDIEHhzp9QRDvhPNQew==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Defines device-specific "quirks" that may alter the default behavior
of the QMI driver for a specific, instantiated device.
---
 drivers/qmimodem/qmi.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 69698ee049c6..e74ff3feaeec 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -56,6 +56,24 @@ enum qmi_error {
 	QMI_ERROR_INVALID_QMI_COMMAND				= 71,
 };
 
+/**
+ *	This defines device-specific "quirks" that may alter the default
+ *	behavior of the QMI driver for a specific, instantiated device.
+ */
+enum qmi_qmux_device_quirk {
+	/**
+	 *	The device has no "quirks".
+	 */
+	QMI_QMUX_DEVICE_QUIRK_NONE			= 0x00,
+
+	/**
+	 *	The device has a "quirk" where it can lock up and hang (not
+	 *	responding to subsequent commands) due to high QMI service
+	 *	request arrival rates.
+	 */
+	QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT = 0x01
+};
+
 typedef void (*qmi_destroy_func_t)(void *user_data);
 
 struct qmi_service;
-- 
2.45.0

