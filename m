Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6B820F070
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412624; cv=none; b=VdzyydaiwwMq3KowQeGK4kn55/vSB5LC6xlaFyTTOB+3cW/9eRHfYkFFOhXBUNx8FgVkGoS+Z+VoJo6i8CX7bjYHcLAyQ6UtTMsGZN8u4Kvo03CoQL2296Fze8kje3XkbLg7EsNX4ljlLy+Q4WS7VoKI1ZCj5DAwVw6pdZ6QfWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412624; c=relaxed/simple;
	bh=Zv4RA/sY6txtwuaBhWqF/sIrPbIIQMK3UhHs9h1Vs0M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBpoRSJANvsTDHuFg6s/MXIcisJRJ7LENU46YcyjXVYBTxeUDqwkT++m5tRcxqebuEZrfguEgaoKokgRZimbZux0VPlOs6eWaGrCXznxWg1DaIfZ7X6sNEzjUVukCKhFqX5Q2m0qZ24V8qMCqNiLJ3UXSs/gIA2bziHj9/weW48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=tLGerych; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="tLGerych"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 59AA0164A99
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 15:22:36 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 096151262B6
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 15:22:35 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v6 1/7] qmi: Added enumeration for device quirk flags.
Date: Wed, 19 Mar 2025 12:22:28 -0700
Message-ID: <75813bdb479c8abf6206be99b7c45a7cd73e73fd.1742411889.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1742411889.git.gerickson@nuovations.com>
References: <cover.1742411889.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=5RkJRnoVHnJwZCzxHGA2QOPk/DensYYgENGrNo82m/E=; b=tLGerychACP1K/I8342dy1uZF+a49g0pkk7Gf8D5+3nnHCGB2jQ0v4HPBFsKuxS2rj1b7+jOnbZ1Ozjpf3qocZDTfDkeYZ1rrbmhEJi8z2xC7mZc9ZsWlVvwmG4hbnEupr4jH7bgYl0/LUhkZrU5WYz1yICg55Two3xalzYiO9B2Dg/c9REA0ffKj8elx9zrDbCxrA/W6gQhMCF2T8Gpf4PMun3wlIU5wxBkjxtJPtrIqrM8z+Ars/CFgH/9MXvwWA16P0tndJ3/lJJwMgD3u1gi3lzpb8+2kSscNW3hEB48mnVQ7j0vGrjgPmcJKtxXkMx80A0e9XY+Z/iLwcR/lw==
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

