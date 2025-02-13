Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6908C2E40E
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406842; cv=none; b=ndWbNtTpE5GrhcPKfRrmmkwUXfIGTbCmxHzBqNkcNhJMy/TWmmRg9Lf4EtNwjQrXrCTrJv9AhRYxmWxoU4T91ab/SYHVxKIu4kRu7fdNloNMMjkcynZMxH4GaMVFs618WWe8+3JKfmp9scUdR9/Svn68ReN7JUElhooiG8OlJUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406842; c=relaxed/simple;
	bh=scdN6rz+5Lc4Dsgc+rEScFi/JxNPO9iwoKN9xeN44Zg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsCcxOpuUp9pQv104ZWHXITf5pJXy6iBgs5+Iug3i8QkhGl/20YCPeBe5VXLTrJ3kiGXFyH3IrU+HrJOupv6vesvGTI12gWncftdR9TY7Q92uJTYVC2gS/1sDd1i1uVgXE31BpFV7Pd/d/ldFzWrUSLvK3heiGrmibuaxu/l1Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=jwfAOweY; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="jwfAOweY"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 930C01649D5
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 19:33:59 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 49FA4125167
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 19:33:59 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v2 4/7] qmi: Implement QMI service request rate limiting in 'can_write_data'.
Date: Wed, 12 Feb 2025 16:33:53 -0800
Message-ID: <d2b56b2248111502169c4639329ad8f2fa5715dd.1739406657.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=wBZ4+HlxopPH02YQcuqfpZdJs7NwflyDJrcCjmdfH8w=; b=jwfAOweYktA+H/UmrRbyBlLl9+eoIDmozToldMwVoC3aDoOuaEaGmfqyCpa7fsUm1jjlpF0bj5E08zqsBjeVfIdr45RuX1h2CNQLo2WB2t+oQRbPFuJQqs2djMG93ezbEel314zl7Q5e60zhY+DLUA4ddsby3lUgT10dEFYCtT1H3gyyBRj0vrYtUIPw++cutPlyg32Q9CVAKCTLcSBuvk4JwnRe3zb+IcPjZa8pSYkYD3+yU6eifiS3UiShlKQ8384dioISVH9MCFzsQ6NC/pQgokP7OmxpLKiWwdsAIn45HprzmJmsxSv/9aiQlYqbiVtKTjAidBoOYlnfqx5xtA==
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
index bbe6440abe0f..ace83044138a 100644
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
+	uint64_t now;
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

