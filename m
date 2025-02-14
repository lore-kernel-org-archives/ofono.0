Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251C414658D
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 05:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739509494; cv=none; b=EqJAE0Wbdz/lGOdgzr2DMPbHiibETnPPxeoSMgZsQTI853RNhArJVtcBMq0stwH1zrJ1Ud8mlINskupjCTv1IYBS7ydRRmvi/dpC25m7xmFhn7bj0Z1EmRLrmWucAQ43oxaWwlkKqrpRZG4ZI7Z1Aq4gYEgGAQyJsfCgpy/osAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739509494; c=relaxed/simple;
	bh=M5Yt+XgkEhwDsBif7PeTj7L8IDaWFyPdeokkm14HJmE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcffQTGdN41sbJlhVh1LRk47MuYPMczT5Lq5ztCadt+z34klFYDwISSDMcH1LBgbUfKLjYob+F9pdb+5+/jihmWqu9GzFnhSxmCGsDmFK2G2utQa4npiZrshQ4EvGq1SP/gCiaW2Lim3fbqbK8lv+gHS++kiGE6nG/cJ0dsDwvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=N3P0hNqS; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="N3P0hNqS"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 3BA28164A79
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 00:04:51 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id E6280125167
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 00:04:50 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v3 2/7] qmi: Added structure for device options.
Date: Thu, 13 Feb 2025 21:04:43 -0800
Message-ID: <520a4879b3157a715299d4874c4091a170d84638.1739509438.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=fHma6eg08g0rSRzjb2Szp8dq8ebKa/ez0Aq5JPdNAGU=; b=N3P0hNqSZG8uhftwHdULHTuA9/+2BcRQV92NhxuUNDd4O8tcnSrzEE0J9gCWqGhyUICpwSkB1AijWBPE4B68VweP9u1gJIQZS/poYA8Td6SLMx7WFuP5ggyCyPs+m05ghMtKHapfo2Jp2JYgYIFuntVsp8WCf2u6yeOI3Mp3Hn2Fi7NosyqKAJnftnAsQfME5mkHwiLM4uYV4ud6Q0ghnUCE1HSN4ZE5YeMcptiE21ssHN4S/nN/wXx6ys6dWYGznEBCl5fSIWIGd31k8rQtql+3gaOEy7ClLwZb5DfJiJlvs6P6Vh+NLE6fsO571A1WyymaFLQWlHnXB38CVin90Q==
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

