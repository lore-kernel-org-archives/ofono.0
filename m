Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7679B282F1
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406841; cv=none; b=Dvpq3jP7/35YtkWEtNIc7UTMbn2gAtoEzcy8QQTP1HEd636a8jbxqear2hwsnYg/upaAWgX+qgd2a+P4j7Jw6yo8CSumTKtO3i8v1Wdm/CK+3NGQdnjxJ3U2aVzYO3VxSgHJamnJvJiSrUD36YWnIvpiMN7ABtDo48S2GJOmeHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406841; c=relaxed/simple;
	bh=M5Yt+XgkEhwDsBif7PeTj7L8IDaWFyPdeokkm14HJmE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahxYflEuErQeJ3gL9J2BkI9cphEKTykxrJsCLNv/7OtgAf9a8rXe7UwGjE0fBeWQtnTZzwdDsA2Gw3WLVnAcG/7z8E1WIqcihMqcHN7HboY0qz0QqqPFokwuo0dQGsOooNysv5W6vbWPCSf2jOOfuIFuw+6e0Gt9ZLAmuwPcmcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Wgnq3dTH; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Wgnq3dTH"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id AC83A1649B8
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 19:33:58 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 642F8125167
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 19:33:58 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v2 2/7] qmi: Added structure for device options.
Date: Wed, 12 Feb 2025 16:33:51 -0800
Message-ID: <520a4879b3157a715299d4874c4091a170d84638.1739406657.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=fHma6eg08g0rSRzjb2Szp8dq8ebKa/ez0Aq5JPdNAGU=; b=Wgnq3dTHcE4mIWphjdXF4rdpVnYE1Dm1yXWhUVX0t7IUQ/SeyayTY6+3II19dr4MkFaBaAAiW/dlOEo7FMg9cobkfnEMrVrw7MAlCmKCTW3EsX1J+Etu6HU35qF7otdd8FZdm/TiIvy9v/nVpNZiZZDmLAtpueC1PakgC71AjJot7htQ7i5BR/oTF/xuP78jNn6Rmpz0jhZmpfxCkKFlYl/6zxRXCLF0R89uhSuMluJpTIHTeUlQz5tdQwRFI8LzyzEryJiqOeV614t89nfeBFumqbFvUTnjmtR50V04/S1QHk4SRMCv9H5da2AFFfqzJsu3EMhsAl8LiB99dbl+bg==
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

