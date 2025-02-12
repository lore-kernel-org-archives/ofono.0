Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55EE1FA14E
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 05:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339592; cv=none; b=iXUxjL1P4hFV15JlDb6IIiuv7rvGeMY7vPm4hCcrsRSSN1IVHf/uzXu9Ctxxfg2nX4ulaff6cWlm48ww9WZe8gzl/dWp9bZEQ4nQybmuHzUlmtmYunot6aSFRAe0ghQH9YPR0Ggey+0xa9zB1ZnA7YQ/j+PnnfhPLoPO27s92kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339592; c=relaxed/simple;
	bh=WuzROzYYyAqeBS6OClrmOCP0xW3hBkyebwLXxPiFZVc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doTiDOGXeIforf3pb2Uu6B5BowYsXfK6RkdQ9JDz6EL5up6GXmW0C2wGWTLxzue/HDB/BBHFK9nzpshGnh1/W7Xl2mz1Iy/vQL7rS0+BiGR+BiEIV+5ufG3YLczrUUce+5qLqfP8b3H5g4R8dM8KyJe3XCIYwljUfHIrY184nmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=hm0iF5Il; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="hm0iF5Il"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 673FF164A79
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:03 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 1EDA7125163
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:03 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 04/10] qmi: Added device options parameter to 'qmi_qmux_device_new'.
Date: Tue, 11 Feb 2025 21:52:53 -0800
Message-ID: <738c21812a71676af8f7c4024991c9f43bb6e7aa.1739339173.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=j6T9nSaTKiUczODlfjyS+z6o3s2LFyv7UEf7+2ikdC4=; b=hm0iF5Il3X5ZGolJeUyU1sN2Av7pEsoetWQUy9viLobt23B76vtK1GBYkTb9IZkT6/u54ibM0VaV55kc/q/YUthNUyEFqscobzmCEdWhLmNjLi57fniqO2NBfSDt6jusQmHzkYfbDC+knDIlAUdmBODchtsWasBgGAPqUCMTmxeP+ti+e/W/Db7H+M/B3eDn1chjXvR5AiPmN9HjUCAsm/8nfeiNYkpQ143kpui2mCoY5fWzpFyy2Prayr0jBcd2eZHWG8CbFM5siuAKo2NLNekNhwQQwEkPAf7rBpsqPEiB+xBaHeHDJ/r3ei40QINXbMF8nYKEhdeCNcbklDJQTg==
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
index 3f60e90c015a..d83dd30fb4a9 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -109,7 +109,8 @@ typedef void (*qmi_qrtr_node_lookup_done_func_t)(void *);
 
 typedef void (*qmi_service_result_func_t)(struct qmi_result *, void *);
 
-struct qmi_qmux_device *qmi_qmux_device_new(const char *device);
+struct qmi_qmux_device *qmi_qmux_device_new(const char *device,
+				const struct qmi_qmux_device_options *options);
 void qmi_qmux_device_free(struct qmi_qmux_device *qmux);
 void qmi_qmux_device_set_debug(struct qmi_qmux_device *qmux,
 				qmi_debug_func_t func, void *user_data);
-- 
2.45.0

