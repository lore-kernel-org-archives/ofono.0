Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36684237702
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822523; cv=none; b=llK0HmckXa7wAnH2yTiYpghzfBRBiGTHDEyYuscPPyqMQulf/poyoexpGi8I4lxscDXAyOEsJkO82cmnZEzAewc8iBtQiEi/3uA6IqgT9/sZ+9P3mnWOX8pF0mFegw7piDeklM6eGg5/TogJ34BvoJuDaZ0ensyjL+Gj0SfXUm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822523; c=relaxed/simple;
	bh=FIddyMiqDQ4SXLU7mGYwdnroR7JS4TpHpl436gYzOpw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyrinn2wFiUG5iWIoRU/CpFrO30+5g8T9FM0xb/mDru6ua1wqQfojnDSt/cUVE6JsdOWkAp4u68HYzvQ54vMAwXO+R+zBzMj2i6Enn8OebLvVPi7j3DTrsqncYlUi8wVimV5C7m4mUB9CShsGq6gqzBrI1hhZUiAzuyjJ4R6nAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=XnU5Plcu; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="XnU5Plcu"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id D7CD5164A9C
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 15:01:53 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 8DE54126369
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 15:01:53 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v5 5/7] qmi: Handle request rate limit option in 'qmi_qmux_device_new'.
Date: Mon, 17 Feb 2025 12:01:48 -0800
Message-ID: <93d99436ed7edca6e4e2086d287446d308a3225f.1739822462.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=Q5rPOnnhU6QgeYqmwcfFQJMGFc+T1dSX3km0wC4zHEE=; b=XnU5PlcuXg9U9BayhktQpyemvbY3eKXO8nT1949E4Zx9N9PPxJ3MljF1SZnEAv5srwM9ZP5en4otRMU6xbRMO7a/TZpacJMN2U023qk1hJJnoBnBydFtQ34FxLKo2RKTW97AhMwhphpdSYJuKCDXWNoUQC5HnPb8lbzaR9gBxAnshkk24Wec5DIj1TKkeaK/BNFnQI6rlQ724F+r8Zii5oY69pCqKUXr8VVT+YZuYMIB0c8NaPxSpeFE7Qdf9cA4rxmq/brdbG2zZxRo6bU/HfMpX/yOvOGTSzPK+wRwRJe+4Ov9AnxHOR5yORij+Xl2X1mSoobDuGO1OcZ4cDnZ3Q==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

If options are specified and QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT is
asserted, set the qmux transport minimum service request period from
the specified options.
---
 drivers/qmimodem/qmi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index a9ea88d31c36..438b98fbc7a0 100644
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

