Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B71B211707
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412624; cv=none; b=dcGLf18bkH0KEIOCx+dMHlRfm60GV0METFjSVylz0mXQ1LRgl36kwzSb5SCR1IXDQlBMdZL2TUlZeLDYBndNmvGnR9hW7JySi8LRgrg6y8xo/FB7IKboqzVuVgCPo8bSnf+tHAdxzBOTS2tz7UyXSbWpxTk6SCfxqJz6/lScbrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412624; c=relaxed/simple;
	bh=MSorLqobb9OQwVoC74blqqM3HX30zMCYyhfYvQK+C2s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9PoS9+KnI1dXtXp0FDuWA6wUEuQog5JPp7cE7zS17QXmDswx5/IM8eMhLXpj/JTpY5stGhhCsqhdWnkDeXHhjFCNUen1CrCT7pdzk+O04w62rjCfK3ScNlVZNSN8Ghlq8FzgzlTySzxnlqnAqQS/2jN32wVy9nMB/asXzkwI7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=qinEzhD3; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="qinEzhD3"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id B0B3A164AA2
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 15:22:37 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 62372126374
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 15:22:37 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v6 4/7] qmi: Implement QMI service request rate limiting in 'can_write_data'.
Date: Wed, 19 Mar 2025 12:22:31 -0700
Message-ID: <ff3f37eb09769e57b2c5abf6d7bc217b99370d10.1742411889.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=gTner/89Vv1FmtWUBekDe8cuJ1Y7ghgt7kQLUgESQjw=; b=qinEzhD3mLciAKN00LSlF/Efccv4NwbQv7hZLStl0/iGwwmJi5RDLwRodYym8Clr+3vm7Xzux1Ts7IVTnzwx9q03ZwEbGe3mhK7VPHMYw2uTCSBeKApbm3PiUAiwSdhafADzNCPOF0dISgudTv11TaJu+10jb8MLCrZBJLHImpBFZC07e1NXR2HfJTIpOkM6WML4VvOXeLsAxP/nJpm0zDoqqAHyp9JBpcJT4AzuG0kkeBlgbjyOYr/QW/8eyyhOv9K5E9HKABWetK2kRDWHIpL4hTTTRuez6NZ0cllPU0rD/nlbI4G6AK97kGq580hwj/B+pviNOwwTcjWItYKg0w==
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
 drivers/qmimodem/qmi.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index bbe6440abe0f..33063483692e 100644
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
@@ -653,8 +665,28 @@ static bool can_write_data(struct l_io *io, void *user_data)
 {
 	struct qmi_transport *transport = user_data;
 	struct qmi_request *req;
+	const bool throttle_enabled = transport->min_req_period_us > 0;
+	uint64_t now;
 	int r;
 
+	/*
+	 * Determine if we need to rate-limit commands to a
+	 * transport-specific minimum request period. If so,
+	 * return true so that the queue can be retried again
+	 * later.
+	 */
+	if (throttle_enabled) {
+		now = l_time_now();
+
+		if (transport->last_req_sent_time_us != 0) {
+			const uint64_t delta = l_time_diff(now,
+				transport->last_req_sent_time_us);
+
+			if (delta < transport->min_req_period_us)
+				return true;
+		}
+	}
+
 	req = l_queue_pop_head(transport->req_queue);
 	if (!req)
 		return false;
@@ -665,6 +697,12 @@ static bool can_write_data(struct l_io *io, void *user_data)
 		return false;
 	}
 
+_Pragma("GCC diagnostic push")
+_Pragma("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
+	if (throttle_enabled)
+		transport->last_req_sent_time_us = now;
+_Pragma("GCC diagnostic pop")
+
 	if (l_queue_length(transport->req_queue) > 0)
 		return true;
 
-- 
2.45.0

