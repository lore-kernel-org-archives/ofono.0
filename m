Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C96152E02
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 05:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739509494; cv=none; b=Muc1b5PMv+WwQmAZb1Zvp9KnHhAcC+3ijSyNaHEZO7VKkyTLv8nti2Vvii0E65D90C5MbHxH4BNjCmr/dVGyWVWr+9XBeBavvBwytyXhSQc1kNtfmV0LoGuzfEFOYm6JsN1gxQXLDOfsuH49Mxu4ns43iTzn9pAeRZeEsZv1pn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739509494; c=relaxed/simple;
	bh=PyYbFE0YeT1OUiReqcfILe2xmfo+Nlx4QEM22HFNUsc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/d9m6ezp2uEwBVNtIvOzETtOAwtzX6kCW1P4GwfxKRMENviq8rHRh/KRzP1d+OQVgLWIbC1abFsHsxzWO0xbYYIsgOlGud1879kGB8X7M5AuD/BaL7NDD9FSDIvmGeCyCYrfG6YhIm820MobGYhnLGFUUoi2RCN1UqJ1ArfLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=RoHeSceX; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="RoHeSceX"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 24359164A83
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 00:04:52 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id CD2B3125167
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 00:04:51 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v3 4/7] qmi: Implement QMI service request rate limiting in 'can_write_data'.
Date: Thu, 13 Feb 2025 21:04:45 -0800
Message-ID: <31c04f926af6ddfe0e244c2d6b0999ee9442659a.1739509438.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=scoC26SEZPw9somyZlxltMd0AUfRHn+aP9H34pSobqQ=; b=RoHeSceX94dUiC/LVTyzMY1SXCHAoTwCJpLp21RTVHxRmZLJpmgZzAdYBf5RKW+hUEM2wgABBWl8ihvfIB8gTGV+vd6E71CUkdA9vP4nAUyAcsE0uBTwIkowOozlbIL5qlV6o4tHOXve+YvxAPpKui7ptP83ks+F5RrbPjBrRPrrJt+x54rLBHGvthPqn3G1oJb3b8TGRr96WfKODejCXxFuOr9H1O4pwBQc5i9ohnEmRwCIQ6PrrCCgN/O9jlqHLe05CznfSFZHBw/6zw7TY/t3tsK0Hq6SzsoYFxvIWReYdqVMbQYveETjdqjvVljNwK7jPEBLDHLz2GoHBuqPqQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Determine if we need to rate-limit QMI services requests to a
transport-specific minimum request period. If so, return true so that
the queue can be retried again later.

Adds the following data members to 'qmi_transport':

  * Minimum request period
    - The minimum period, in microseconds, for back-to-back QMI
      service requests.

  * Last request time
    - Time, in microseconds, when the last QMI service request was
      sent.

to support the implementation.
---
 drivers/qmimodem/qmi.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index bbe6440abe0f..f26a9816c71c 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -92,6 +92,18 @@ struct qmi_transport {
 	const struct qmi_transport_ops *ops;
 	struct debug_data debug;
 	bool writer_active : 1;
+
+	/**
+	 *  If specified via qmi_qmux_device_options, the minimum period
+	 *  for back-to-back QMI service requests.
+	 */
+	unsigned int min_req_period_us;
+
+	/**
+	 *  The time, in microseconds, when the last QMI service request
+	 *  was sent.
+	 */
+	uint64_t last_req_sent_time_us;
 };
 
 struct qmi_qmux_device {
@@ -653,8 +665,25 @@ static bool can_write_data(struct l_io *io, void *user_data)
 {
 	struct qmi_transport *transport = user_data;
 	struct qmi_request *req;
+	const bool throttle_enabled = transport->min_req_period_us > 0;
+	uint64_t now = 0;
+	uint64_t delta;
 	int r;
 
+	/*
+	 * Determine if we need to rate-limit commands to a
+	 * transport-specific minimum request period. If so,
+	 * return true so that the queue can be retried again
+	 * later.
+	 */
+	if (throttle_enabled && transport->last_req_sent_time_us != 0) {
+		now = l_time_now();
+		delta = l_time_diff(now, transport->last_req_sent_time_us);
+
+		if (delta < transport->min_req_period_us)
+			return true;
+	}
+
 	req = l_queue_pop_head(transport->req_queue);
 	if (!req)
 		return false;
@@ -665,6 +694,9 @@ static bool can_write_data(struct l_io *io, void *user_data)
 		return false;
 	}
 
+	if (throttle_enabled)
+		transport->last_req_sent_time_us = now;
+
 	if (l_queue_length(transport->req_queue) > 0)
 		return true;
 
-- 
2.45.0

