Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE8B271834
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 05:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339592; cv=none; b=n+y7avWyQj9wHJb491/nHZ+1rIuhoIdf5KhkI6zO6XC+XSuGT8Rt12iaktz4CnabpVHKCiQ5ePLobaZu7RRfZw6ILv1lBakrd4vqJuGt2/M3IViRqodWcKmqYUaZeNNozS7oEuBZYuOJCQrmzIxcHqQzUp4ZwtSgqOmIZu/uCB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339592; c=relaxed/simple;
	bh=PltWv2wVFYHvatT7lhVsIRu1pYZ+yglFhIA+Kn4obus=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmXUjNzXRoFPAWwabS2pwiOfvPo5ms87nDBe3VzI0siYouyMyhwhJyg1HzJX+m8+M3pT5FJgfJ1QPog+q24M8WnrKYgx0kOwE0tsSleZ3rpBHgvHtFVChFyl010K/6ar6Nm7UaUpnS8xKKtP+90h410LKmWDokjJdVyliwhCzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=WIXzRZd+; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="WIXzRZd+"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 81753164A75
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:02 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 31DE1125163
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:02 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 02/10] qmi: Added enumeration for device quirk flags.
Date: Tue, 11 Feb 2025 21:52:51 -0800
Message-ID: <7667a457a8852adb853648c03f3e1c05dd61c9cf.1739339173.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1739339173.git.gerickson@nuovations.com>
References: <cover.1739339173.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=e8NYA3ktvGinLVqkiML1o/tcKl93DcaTI0fujudhneo=; b=WIXzRZd+deJlcpa3Ime5Oaa7UIGRoNVA5O/cFLgg+jysHMRz1CGTIds30I37Q4J7pDX8otyJUZpo0yAreuNc9pxH1wCcLSrM7Ow++1ticdKxmBp37cWJ5Y5gQbbFYERKnOSTVKz+BbE0quuvCpJ2Rp01ANX0LdahK8tNw+AdBL6aDFExRDf2FO7RvLpXHAVGmvomCxpXODeADZFRsdUtzczy13IBqWyAtmKsJ1NWX8HLPdEb+B0Plf+l6VJjKfHlYdCL0AgPA6BvlGQKaLuGUxZI1I3A/V8VatekjgekvDAmSi/6++s+ol/xcvYtM8CUFg2Jow+F9Bj0NwUp6yWP0Q==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Defines device-specific "quirks" that may alter the default behavior
of the QMI driver for a specific, instantiated device.
---
 drivers/qmimodem/qmi.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 0c786ed065a3..913035897ea4 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -58,6 +58,24 @@ enum qmi_error {
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

