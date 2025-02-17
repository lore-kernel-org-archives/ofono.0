Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B996323770B
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822522; cv=none; b=aoIf3LsLKWwec9pTJVrC/qJX6ZeIlfCNz8MHWNAtdOrECe4ikurFxvOSOYw8JQMQLHp09Iii+ATSmmi3GObQ/HCxBqrXowikTafHDTMRvkIUCKXouOppLy1bkiLiNldeIA5a8p/8zShqFPCe2tpIwJc1j/1N5GZHPDFd9SAwP/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822522; c=relaxed/simple;
	bh=BqGtxcEQ7ZOW68ToWAY0Q3/t6f0yzXBoRM2y8+3Ys/M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWst/8CktBQln6EDgAOI3ofS45WP3eV5/QD+owhYVzdSVd5PKp9wutFM+e0jP6V52ycrpyPm2pyOtoS7qnw9q3o+PosPt7CJwGJgVEnF0XWqgfCFegDHh8LCsOKEAjJpRj/kb8yDXrY0Ry6/WIhBge2rSFuUN2j8Hs10DVwFcWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=pOTI/1aA; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="pOTI/1aA"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 6A528164A9A
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 15:01:53 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 1F4DE126369
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 15:01:53 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v5 4/7] qmi: Implement QMI service request rate limiting in 'can_write_data'.
Date: Mon, 17 Feb 2025 12:01:47 -0800
Message-ID: <06f2aab8af4cfd8b660bb9b1c65897618ef0ad74.1739822462.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=19LVONsaqyrtgc0hdnY+CnoAHTfcEdl5YYgArp7rH6s=; b=pOTI/1aAGE+stSfhC6Rm4Yac9LUQYR/vp/otb7t1dn1NGYMhqPgBoNcG6nNdl6yEiDboD2sqDOY2dAARWT8PWBnPCWd2PAMYjaLzX5Y4pItapSA82tOawU9YbXCffdpVvrwHpQ7VVaXRB2gRo82ED5KeTyXIxel9aXNWGBFre46cwWafm0bf5x+oNuoxAL19WwWis77BQ3fC0d5779qPpOlTwfVlH7qrbKCYP2xWhJTeFhjX8SfloSMXKj3rMTAg5lZWKQ7HhEv0BrSvcVkgJ5WKHPHlg3kfZjqEzcO27wTIopg0g/CYJQr8J7MupCunisxIE3qWzQuqoVCLfMY1RQ==
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
index bbe6440abe0f..a9ea88d31c36 100644
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
+_Pragma("GCC diagnostic ignored \"-Wconditional-uninitialized\"")
+	if (throttle_enabled)
+		transport->last_req_sent_time_us = now;
+_Pragma("GCC diagnostic pop")
+
 	if (l_queue_length(transport->req_queue) > 0)
 		return true;
 
-- 
2.45.0

