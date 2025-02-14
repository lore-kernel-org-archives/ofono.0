Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30CD2686A5
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553767; cv=none; b=hC2n3Q7cElLDxaeJd+xS2kIVAbKoicXu4ZBoBWiEybBdJRJeOBEE95AKuXRxb4sGWO7CaWhObxmg2XaDHkkg9zNGQ0qNKQaIswNP7mQl+PsAB+Ov+HEOr6Yipw2mDO3hk1kVOPuyXU4KYPodqPNTcnAImMLOV3Ar2nYo8mZegSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553767; c=relaxed/simple;
	bh=0bCcH2HXW6KvEsx6HAW6GXOmybWW6YKSc7TQAJqMID0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mskKgri6mbMZpPBDwRU4aB2WsEWj9LPAE0LLdoujWV3/VuxvMJu8SlqHXSEIqwVVagIb9NC9JO0U2QVAQDVYR1PnHSJBCKJK8YvayjdF1nx2y9pgqz7loScLvVFXujtVwGjYYh39WBxw9iQymBXMHAb26pN96DROrnLhzlDV2d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=XGbdzF7H; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="XGbdzF7H"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 96777164A8F
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 12:22:44 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 4BBED124F0D
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 12:22:44 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v4 4/7] qmi: Implement QMI service request rate limiting in 'can_write_data'.
Date: Fri, 14 Feb 2025 09:22:38 -0800
Message-ID: <35556cf3af8ce161ab6e178bdf4615ee94407bc6.1739553712.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1739553712.git.gerickson@nuovations.com>
References: <cover.1739553712.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=lFYvsI57/a7zeWOBW/LqDkoahzsvZXnr3vFbMIr6TJU=; b=XGbdzF7HuNXeMa/6Y1xY069obZOOP4VbHDGdlm6znoWPN5hK/Mu1NL6VpAFg3sYNe6M+zj5ZR+k60C5rGC7YaaZQvJMbxraFwQYtOwXoNX0Xkq9zb6+rmkRGFYFItY8KhMwIbY2B104KOrdxR1leCMtmw0jy8JDjEIenYnUraUBoxfF2Fw6wItkBb/HOAnwkldrRhixnkmjsWv/DpHPw0K1TUyN7qFdistqfIMAvAcSkGcXMx/DZirr6ZOrNoM99UF9PE0BTjmu8yMJcytb5C4g4qgTh1a3XKgfonlZCYtBSn6AVBtAHFO4/1b3cDOdtCoY4PgaLb1aZ7ycF5DMOPw==
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
 drivers/qmimodem/qmi.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index bbe6440abe0f..7b20dc3f85dd 100644
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
@@ -665,6 +697,9 @@ static bool can_write_data(struct l_io *io, void *user_data)
 		return false;
 	}
 
+	if (throttle_enabled)
+		transport->last_req_sent_time_us = now;
+
 	if (l_queue_length(transport->req_queue) > 0)
 		return true;
 
-- 
2.45.0

