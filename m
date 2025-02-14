Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB32B2686B3
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553766; cv=none; b=sgrf4JMl12RCd/oIdKet4oU4yqhSLLOsBGux+6znM+P3/sqIro4XY6zybr14XZ3BEUATANe+Krm7iMhv/AoAarsHz5xKOBibPKbBLfzt7wWHQhTYUdnefS5fYY6kLtf20g24awt5naTTA43KfSOr/8JexUavQBFS5AI1UDz3jcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553766; c=relaxed/simple;
	bh=M5Yt+XgkEhwDsBif7PeTj7L8IDaWFyPdeokkm14HJmE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TR6mBW3Sh1hB3mkF0gmoI/aTG4zT1xR2JxuzJuLrEANkdPLAqAeqpvpajh9yqVfbNJTYgU0VNt8mJjBRMrCynCm7RzQsBhheOZjQiwoyrKjjtGaX352gScehlFANyYoRl5L+V9Jsz+16MfJ2J3VDpb0xAKu14uBo4RrLzHecgGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=QUl2ZlO1; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="QUl2ZlO1"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id AFA4A164A8B
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 12:22:43 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 653A0124F0D
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 12:22:43 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v4 2/7] qmi: Added structure for device options.
Date: Fri, 14 Feb 2025 09:22:36 -0800
Message-ID: <520a4879b3157a715299d4874c4091a170d84638.1739553712.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=fHma6eg08g0rSRzjb2Szp8dq8ebKa/ez0Aq5JPdNAGU=; b=QUl2ZlO1ewhzEYoN6jGgTGemsMkAmHdJ+KS6xZFQd5brgvSSGGPX0gHT+978FG0t3UAi+E9+UcsRphmn/mwzhZF4spr1baJ+XVVjUCQcUNoSczC1is4pp5tN/hyAu0My/nhpJBfnjRyDfN2kD1LvwWOtV7fWbXCMCfy4NCwvGOkuqRDgPvaaVq3IBS/2AA/cATgvG0nypgAhdPrMvcOIekTG04CPs+9i9unlzEnRIGXz+Q8X2oSmHqwVyU9dgz09/KHdIAnPqzZtjr1OkpscfkWs2kcpj0h5bLlGp2nMmxY3By4xC9EYob6UelhOEM/yx4HV5Z3CDLjaGqkP8lxanQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Defines options that may alter the default behavior of the QMI driver
for a specific, instantiated device.
---
 drivers/qmimodem/qmi.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index e74ff3feaeec..4ba27847176f 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -74,6 +74,25 @@ enum qmi_qmux_device_quirk {
 	QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT = 0x01
 };
 
+/**
+ *	Defines options that may alter the default behavior of the QMI
+ *	driver for a specific, instantiated device.
+ */
+struct qmi_qmux_device_options {
+	/**
+	 *	Device-specific "quirk".
+	 */
+	enum qmi_qmux_device_quirk quirks;
+
+	/**
+	 *	If quirks has #QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT set, this
+	 *	is the minimum period, in microseconds, in which back-to-back
+	 *	QMI service requests may be sent to avoid triggering a
+	 *	firmware lock up and hang.
+	 */
+	unsigned int min_req_period_us;
+};
+
 typedef void (*qmi_destroy_func_t)(void *user_data);
 
 struct qmi_service;
-- 
2.45.0

