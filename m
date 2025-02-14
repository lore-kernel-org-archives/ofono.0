Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C8D2690C2
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553766; cv=none; b=hd6kXAXLJOrbJ3YQSzWPDGiTP5TF6lnwmr5qzQOQa4sooqlDqkkMjorpXc3iM9mTCeyYEGMUSi1w+IfFqrVFA9C+C7m3wMON2vI2cYXwV6fr8XgYO9jzxKOqnivzwfd0fBNp92FkGGo151epG0gxr31AcH/vYisA/9pKtBryYJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553766; c=relaxed/simple;
	bh=Zv4RA/sY6txtwuaBhWqF/sIrPbIIQMK3UhHs9h1Vs0M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgienNw4VjHAvM2ZqJGbuE0sMRMA0TiRf7dErl1JK+BKlEX34ee/LGCHuUUk9EYAWX8Djmjfr9T/Ylg1OTB9PLTpNLOgy+iRtEa3UEe6s/IiWBJqLNtkPA/nXAhAJeYsUe6GU+BciPVKY0HZa4PtTYtHlJ/A1W4CmAfUIN2Qhxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=duWZndmF; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="duWZndmF"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 40889164A83
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 12:22:43 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id E63BF124F0D
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 12:22:42 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v4 1/7] qmi: Added enumeration for device quirk flags.
Date: Fri, 14 Feb 2025 09:22:35 -0800
Message-ID: <59c8f32bc48808da9223a192cfa180a04c711402.1739553712.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1739553712.git.gerickson@nuovations.com>
References: <cover.1739553712.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=5RkJRnoVHnJwZCzxHGA2QOPk/DensYYgENGrNo82m/E=; b=duWZndmFsvqfFTJW/5enaW2C74hsdDDUFbQNMBsBT/B6E+tlXONkwo4G+GUkDU8jc2FsRuPs9mkbivgVxI1bQfKZCZ4taxq+adiQz3KnHz4SFP6zUltbE+b9WkjQUjQYY1lEV3YE15mtLQZacsF4dwVwQuJY9P7Bgi8Y9AKJhx45yXrla++Oi/zF5rjOt8cmdAm42KUoa7nfzmu5b+Gnbrpbmsd/QlFVoJMSYodHLDjXTWweiNpM1jBPGWIfcE8WDp17xP01sAD3tFTt7R4jP5ORxchDuLLbdIjKswEWfo30HhHAieXVMXvvFvB13/WkPSILXrRW8tNPjjmn5HJddw==
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

