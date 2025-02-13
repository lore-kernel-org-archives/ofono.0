Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BED1DFDE
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406841; cv=none; b=hY5xXsOCVqqYa6i6QHnSRl4vD0pLJTijLfmyGm+EYR3XoiaN5hcQadF2+gAq6MKl8UsDoztpJWIc7V42iiR/VEgfp1AXPsOtnVk0j4NpVbs+L5pyF/Lzc3pRBoXaIe2Nk2PKZrLCKEcT8Sf9hgbqT5UpQyi6J9zo2dyHKgXwJJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406841; c=relaxed/simple;
	bh=Zv4RA/sY6txtwuaBhWqF/sIrPbIIQMK3UhHs9h1Vs0M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmvYzGfPt0nOSDH0/STGc0Ul1vD9M9QwWO5/dYTCCkKHcuKlg4STBirNb8FZqoZ+64ELruVtqice+Jd+gkZZEU9vjLlWrOxAx5BFQTDaSEIYuIFW7sXFv1JVztOhdMuK39UWUvNdt64WCMqs/tDLJ9J3LCqeRs6ZybqJE3JaRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=ai8hXpXT; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="ai8hXpXT"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 4090B164922
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 19:33:58 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id EB9A4125167
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 19:33:57 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v2 1/7] qmi: Added enumeration for device quirk flags.
Date: Wed, 12 Feb 2025 16:33:50 -0800
Message-ID: <59c8f32bc48808da9223a192cfa180a04c711402.1739406657.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1739406657.git.gerickson@nuovations.com>
References: <cover.1739406657.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=5RkJRnoVHnJwZCzxHGA2QOPk/DensYYgENGrNo82m/E=; b=ai8hXpXTQ4ahBMjn/D4jJeG4WSG2ZyRliTbF9WNccrvuDFB4xo8EYE3paCjZqKCY2e2/bGs3R07BkI2Viz6ggtBzxgSP+6+4H6KbVX9py/VrOprvGsMrZgePW6jdYk/O4x/5TlLW4oVJ0YdOvXhFnc7gHlKXq1hoeowXmMx2N2XIGJlWnfc6RofM0GmwLt0Fzdc7fQNcR8JIk7PQJzf8fqi2cAArrkihhuf2bn0fjvPPqfZhacGlTeKmGxzld5qetl8vRZ9I2hWI/8DJYUGvW86wf1VLOiL63zGRmil0QZGft2C24bt6wKwjJE4W2OeSd6+3sFIAO8DnQaVpkT6zHQ==
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

