Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC297237713
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822521; cv=none; b=amNFFCqy0rJdVX27tOoWbnZ9e5oSqPaWwdv36SDbSbw/qxcfwdnmgx9i0NFi8AjdhHYBwYLSX3aKxUjiNxeZkBVsMdo1OZ3aCqqUYXWbBfFAWHkFJo+n3R0f8je5jyoiODUTaHEAI92Gzq7Vsu2/D+U11PbWNGe9/lgY3Ifuwlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822521; c=relaxed/simple;
	bh=BOjh6BbY3gmEz2aVzixjVsKqCAX013D8zE0gTMLRqds=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6fAB0m5++KrPVNsnNFMx2XKuvjfRT/lPU6CMzUWJHeXVfSXtpSH/ZWfrdTA6reL5nc+8Ht5qcwtJaSpcY/FhhW6C5nzw5uyPqDlaTxrOcnXkgXPYS/RxGYQOXlzRfsvLoN7F95MPFVD/4kb4/GQdlBZtQsEtoePrpAcL7zYFyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=dxD+Deye; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="dxD+Deye"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id EE009164A99
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 15:01:52 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id A5215126369
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 15:01:52 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v5 3/7] qmi: Added device options parameter to 'qmi_qmux_device_new'.
Date: Mon, 17 Feb 2025 12:01:46 -0800
Message-ID: <0e9adb66276124d2bebf2f54c6138959dc8068fa.1739822462.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=BzRC/MPEuWrn1WIK740cPG2Pr1K+5r5gWLIEtdkDGqY=; b=dxD+DeyeOlruvaAFW5g8kM/wmbzSQ0TJwgv0JOSM0ctqccaGgLtI8oR7kGmo0v5m5PwqmSaseRmZKjbeFEb9TI+D7e+lWlvHMewbyPt1tU3m9d8W3A4OHywPZLG6ib+HTPMN6mJ2U+kBIppf9otRjxNn/IsQ47LRsEYHRTh3uSD0SVENwujo1N92Xm57daL+zbdIXVjRu86vSyMJmUOHvjRmZPWtVGZGSaZL43+9u18krOBPtF/ITKgL+SWGF1Pue2K4mxTCIT14a8Sq6x+ZS3HFQsdZZFXMRSgBsweZcnNxNHlhsZkYm89dEAcYKWDp37ec7xrLZ7EClN+wb4yzzg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

An optional pointer to immutable device options that may alter the
default behavior of the QMI driver for the instantiated device.
---
 drivers/qmimodem/qmi.c | 3 ++-
 drivers/qmimodem/qmi.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 10dbdaac8bf6..bbe6440abe0f 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1567,7 +1567,8 @@ static const struct qmi_transport_ops qmux_ops = {
 	.write = qmi_qmux_device_write,
 };
 
-struct qmi_qmux_device *qmi_qmux_device_new(const char *device)
+struct qmi_qmux_device *qmi_qmux_device_new(const char *device,
+	const struct qmi_qmux_device_options *options)
 {
 	struct qmi_qmux_device *qmux;
 	int fd;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 4ba27847176f..09b551d74823 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -107,7 +107,8 @@ typedef void (*qmi_qrtr_node_lookup_done_func_t)(void *);
 
 typedef void (*qmi_service_result_func_t)(struct qmi_result *, void *);
 
-struct qmi_qmux_device *qmi_qmux_device_new(const char *device);
+struct qmi_qmux_device *qmi_qmux_device_new(const char *device,
+				const struct qmi_qmux_device_options *options);
 void qmi_qmux_device_free(struct qmi_qmux_device *qmux);
 void qmi_qmux_device_set_debug(struct qmi_qmux_device *qmux,
 				qmi_debug_func_t func, void *user_data);
-- 
2.45.0

