Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941671F8AC8
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339593; cv=none; b=JtdAjBxlYwx/XFwyxjY8VxoisPiREE7jvxYbyM/gmoSHXfd3Uy2gI9Jg/+jaD+8j1GNLQPWP+eqPVLIEOGCtdFRywaB9oXU+ay6WFMIxnZ9DY9Gpfh4x4MWMkcUUO/RiZcgD1WRpz/fwu/LSX9mpN8zBZYy8LXa69NrWsLzVfSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339593; c=relaxed/simple;
	bh=fyZCkFG4f1nU6lEgnK9RgsoZLw/aktjcDMRCKgx2ET8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuH/Zuzi8u+PM/Mjj8We6gcCzRsGpTw1BypWsw4WLoYJjWETXGOba1HgmB5H7FMmOFlHi/dKdpHWBSJBMb2+TOsoolQAI9pZaJ1u4yT8scwC6fFk5C0DEU07QFV2q3PtyTLIL1MTia/GX02yahFq5l2D8G9CcX/6bcH0t4ULTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=LocDutJo; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="LocDutJo"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 493C2164A8B
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:05 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id F3944125163
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:04 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 08/10] qmi: Implement QMI service request rate limiting in 'can_write_data'.
Date: Tue, 11 Feb 2025 21:52:57 -0800
Message-ID: <1cf82d1527078e71d7a64b4f8caa7c5adad680c7.1739339173.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=PETC866+3XLMGNb/TAHK8lpsdi7BngDuP9iQ7VmoBqc=; b=LocDutJoCwavTXWwi+CR0nsEOcixG/Yc09nks9ftuKfVtkWZYg8TW+DWn5Ow1i5XJZC/MXTya+Io3P5gjUNoTtX9OuG8kkByYR0yDqK9aU3AdXc1Zz+sjECRKrAV7veTsvvNlvE9fnnhYLNj0b+Z5ePuwe8Dy6uD4hT6855ltZZQBsxgC4r4QA4eRV5ia//9pdPSUEAMHiLqwZSLVbLdAoAE6xvh30viKHnY1gHD2mA31a4ZZ/t5KrTcafb2tYyQKBVHjin84NZIpA6DiV4DWVM/XHqCY1oSS5IV5dFx6NGakhzWa816RLjrbE+8YqyTV13l+/XygzwljF2tEHY+XQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Determine if we need to rate-limit QMI services requests to a
transport-specific minimum request period. If so, return true so that
the queue can be retried again later.
---
 drivers/qmimodem/qmi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 00086578da10..591129c252e3 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -665,8 +665,23 @@ static bool can_write_data(struct l_io *io, void *user_data)
 {
 	struct qmi_transport *transport = user_data;
 	struct qmi_request *req;
+	const uint64_t now = l_time_now();
+	uint64_t delta = 0;
 	int r;
 
+	/*
+	 * Determine if we need to rate-limit commands to a
+	 * transport-specific minimum request period. If so,
+	 * return true so that the queue can be retried again
+	 * later.
+	 */
+	if (transport->last_req_sent_time_us != 0) {
+		delta = l_time_diff(now, transport->last_req_sent_time_us);
+
+		if (delta < transport->min_req_period_us)
+			return true;
+	}
+
 	req = l_queue_pop_head(transport->req_queue);
 	if (!req)
 		return false;
@@ -677,6 +692,8 @@ static bool can_write_data(struct l_io *io, void *user_data)
 		return false;
 	}
 
+	transport->last_req_sent_time_us = now;
+
 	if (l_queue_length(transport->req_queue) > 0)
 		return true;
 
-- 
2.45.0

