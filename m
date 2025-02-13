Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E66A2D613
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406841; cv=none; b=S0RaF1IXVY5kGPVW5YU1ZxaFjtuD9yDweagYbBJWtcsIWFaigH2q+mdgkINKNwJQfTUlLMhWWCTVF0/OkODWw5mzAn8efGjOiKCVz0154UkvyRm3Pe0oVsKalwE0wdXvCMIZOt8IEGGv2m7v9UE2oAUH9pRa5NTtCFhfdAwAsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406841; c=relaxed/simple;
	bh=BOjh6BbY3gmEz2aVzixjVsKqCAX013D8zE0gTMLRqds=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdNUKXqTuc3GwCXD83tpMWv+gLZ1v0NgWXO7OVYPrZNLY32RlyosPyKD123GV/45o5H8VXLYjWF5ZVRJay85qpC/2pm2B1qCRpgp9zCVrLcb3sawguzQ3n5Hwmtn46o4VhExArcHmyDzaxYVG4NSauoRx9K1LjZPv7ZhjKDPyUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=iPsZpV2n; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="iPsZpV2n"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 2505C1649C6
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 19:33:59 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id D06A6125167
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 19:33:58 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v2 3/7] qmi: Added device options parameter to 'qmi_qmux_device_new'.
Date: Wed, 12 Feb 2025 16:33:52 -0800
Message-ID: <0e9adb66276124d2bebf2f54c6138959dc8068fa.1739406657.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=BzRC/MPEuWrn1WIK740cPG2Pr1K+5r5gWLIEtdkDGqY=; b=iPsZpV2noO+InylSxQKuSr0fB0uaDyDio/OCP+mB16ngKdjPhUUf/JtbsieNnFu5JSfICzms82R5FNnAb9yN6RHfacuQoNDi0MIBSwKmS62g9p676tmY6Acgiq1s7Zfb+n1+/nlgwddbhxIwFovxOLkwg2q3CWTS6LTReSqw8ogbsKCDGfkwKccJNT3ktud0rZ7pYj8uFuM0qBNULM6Tj1X1gf7Yh+ximV6ZhfeqnSN5Ws1gJ506kYRVvKHVzPV/r8pzr1ZUypVrfx26eML7aHe642gwYi36GT6pbVQdyIvN+/ijhx+d7sWwABFaxGsyJ7/Opcp4VSgdtDo7wzbfBg==
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

