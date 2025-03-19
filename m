Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C56211704
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412165; cv=none; b=aeLwceQoZSojsj4+j5HfbcPV4YKfEjMo5URpJ7Srw2LeBKt54iFfigy45cIcsI66vYZxMOqYMK/TS7NEMlIqLDbuLQHq1W4n+V8Mj0+E6M8FNtZ5PF8SphQBSE/o667V6gSKPbmUgXK9nqRcjHwuctVF5jaABm/5X1LLYvVIGWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412165; c=relaxed/simple;
	bh=Gla3QDfQpwYfBE0H1upc/z8z+HBxqpDE+5Uis8dotlA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Agq7QFyvKvqIINqTRbZP50SddEAy2V9QsP/ZUBmjsw0QDkMHaSZpfXQkpTBYk3KyQ0fPe9nM6wm+98rn6vklXjBTvnk6t78EV7XZqyL85dDet8+RyK/HcF3Vnb9IoOYVRWvdn3SkYLxTv61w+Kq3zIpTdsewPEiLXpew4XNTG/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=QlSB62A5; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="QlSB62A5"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 28FE5164AA4
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 15:22:38 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id D35BF126374
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 15:22:37 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v6 5/7] qmi: Handle request rate limit option in 'qmi_qmux_device_new'.
Date: Wed, 19 Mar 2025 12:22:32 -0700
Message-ID: <71d090b67ed601fafd157064f9350b6786491fe1.1742411889.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=Ehm/m6dCTq2BpLAzOl6CoCiPO5KjzL0sCZtU08LEFC0=; b=QlSB62A5lW6r52Ulk8m7j9M1wYKkex0hj4cUGGSbS0HmmetP8pdDdDbxlmoDRJ3Mrd9jcl2e21l7nw782ISfrdaMIWQ/yThLuEomrX5QBlrss5FBT5gkbaX62w51BqLbLOzjsC2y95xQW5gMneY1TQ/XqYPo+8tpExsvTaWCD0WkyrTKFTW7hnrTxzWjufuYgwUbZvd5m5OhqZW1mk493laMNujclRX8kv6CEmHccs6ULjHTlK+VOoRoYy8QochQa5ycrvlq3vc79aGCbSclaTz73awHMKA6NgC26JW5EmNBtY/A8V8Om8vEOaIT9E8ThkptTPG4t8JCh+RzAcX8ew==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

If options are specified and QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT is
asserted, set the qmux transport minimum service request period from
the specified options.
---
 drivers/qmimodem/qmi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 33063483692e..9f3db6bd4d84 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1617,6 +1617,16 @@ struct qmi_qmux_device *qmi_qmux_device_new(const char *device,
 
 	qmux = l_new(struct qmi_qmux_device, 1);
 
+	if (options != NULL) {
+		if ((options->quirks & QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT)
+			== QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT) {
+			qmux->transport.min_req_period_us = options->min_req_period_us;
+
+			ofono_info("QMI minimum service request period %u us",
+				qmux->transport.min_req_period_us);
+		}
+	}
+
 	if (qmi_transport_open(&qmux->transport, fd, &qmux_ops) < 0) {
 		close(fd);
 		l_free(qmux);
-- 
2.45.0

