Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F90237702
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822520; cv=none; b=qh+mF78InOy+0r+RPLhj/91xvQDLtAWWnH1i/SlF/QBK9aQ54TS33J9M1QMvWw7luXqTaDelCIVR6o3e5bSOqIvMUnzEBZ+El1CP5+Q3eWtElJfcXIpmJNedrNilNSCo2NeUw40DPul/u2Cj4H/t4YpELa5UbqSRG270iIVFqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822520; c=relaxed/simple;
	bh=Zv4RA/sY6txtwuaBhWqF/sIrPbIIQMK3UhHs9h1Vs0M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIESpYHHDOf7j2cKdZRpNmJhGALn2gZ/rjrq1iXC+zw8RvjAyySo0CItWMxaZU2ePpsESH0Ksy/v8X4FJ0eOtUHigsyjG9e7LF5ykvtCLIpV+GFCzfe727hDt/88GbNam2UHKywEA6G/g/BgRnVPX3FxJSekH6R4tnMvfRf/3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=nmkOC0sf; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="nmkOC0sf"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 12A2A164A95
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 15:01:52 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id BC2461262BA
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 15:01:51 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v5 1/7] qmi: Added enumeration for device quirk flags.
Date: Mon, 17 Feb 2025 12:01:44 -0800
Message-ID: <59c8f32bc48808da9223a192cfa180a04c711402.1739822462.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1739822462.git.gerickson@nuovations.com>
References: <cover.1739822462.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=5RkJRnoVHnJwZCzxHGA2QOPk/DensYYgENGrNo82m/E=; b=nmkOC0sfKAB8StEk5bRqksc9LDZpw5sj8SRRVvEJR8blULaHbRjpORQ/imMmeedHGoCLcmY0e9P4L7RmyfG26OI2LQ2mpf/GP46vTfEyd9LMNUeKYMak6r1terFgtJu5hiLdugC/6FFPGxqJ5YS/MlmMeNvAakR6m51QGtkWJgDt2x6I92TlU+QGRfd+OCYmU4G+RQk4jzNlejk6OMbRmsUSXIPfBY1SVwnWrVlHxnktnLk7d/y6QcFSXjCVJup36z29FLPx9vfYrSi9TBzcyUEW86WE8qfpn7zgZ6Y1ufVciTeX2RmerRHlxZ/z55gR6G3jOkoRuB9mSATWndGsGw==
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

