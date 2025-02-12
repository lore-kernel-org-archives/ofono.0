Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55941F9F60
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 05:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339591; cv=none; b=M1o5exdz6BuKaeFazWinBHX+1/zSZmY1PlK48p0mhC1q4Q+5h1ckpdiTc3KqNzQ+3DmpjdXA2kdxqz3kQPvC9CFRHQ4eQ66I+/IQluV3hORJEIHY+8ph+sB/BBO1dInsPQeK4yZJLLNv7sFWHyCkjJ5ng7EUJjs2s/BTVU/hm5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339591; c=relaxed/simple;
	bh=kUD+fPdF9p0zjFVTzkZz2THFiIbHfbLGtUUUkLEmdjU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwIcgT3CI7Y3gOe56T5f3iZCHmkNFd5cQWQsFNtvz+j4kevFLKO0cy1SxM8aJSY7Ua8FNCz6WFqQSW5haQU5bOycE2zGjoWRsFl9V59WFEfUa7PiE4XjEqhdD3Snerflzb4JNADENs8F8u2qmPRgqcKPrENlw2QO3AJmiM8cUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=MNBkZLgF; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="MNBkZLgF"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id EEDCE164A77
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:02 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id A588C125163
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:02 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 03/10] qmi: Added structure for device options.
Date: Tue, 11 Feb 2025 21:52:52 -0800
Message-ID: <92dd49e261569657414c1e43825cbe8928ace900.1739339173.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=aQeMayNyuBinOnp1xaSB3V7V8/8H6Fgfktp/m7Jqftg=; b=MNBkZLgFIjsEOskuj+XS5J6cEW7p3pM62bpt1GfgleKu2tL0nnhw+C5Pc7anZtjqua4zj7Pwl1Mj9XV1jhiIDGnMbAReX0OGbfbM+wfFnawFVupjoV2RXwVR5T2vlLp/DJBGf7nm7W4WyIuHd6os12o3ZKmRgpru1LAPF/cXvyS8nL1/a4RMJPizGD5uWet+feURjQecCyVDsLdA7IT4PLboTN11aqCB/fcZC6t/FJlcXdr/whQyC0ZZci1ua+eLOcsVfI94hs/2U5jtkT1f+Qon9wc7sYoemAeVCAeH0KCRbD0RCUkHwrafQe34rKWwu+56Cf75fb12cquH5KSUbQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Defines options that may alter the default behavior of the QMI driver
for a specific, instantiated device.
---
 drivers/qmimodem/qmi.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 913035897ea4..3f60e90c015a 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -76,6 +76,25 @@ enum qmi_qmux_device_quirk {
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

