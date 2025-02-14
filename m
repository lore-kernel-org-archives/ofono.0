Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803161487FA
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 05:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739509496; cv=none; b=eZ0vfuXaasQrnJ2ZVYcXY2GtLubvw+RSvn+e7/eypDMfpM9i4YmICVIHFWJNEpy8BtWTUntOOrU2Tae+/H1XFedF4zAR1gbefzmESCP8eZOjgNdOLJSNEUb89FNnYjKpIGlggYy2RPp3U6zxFIwBAjzkxTjAP6RlyzMqRYrIpOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739509496; c=relaxed/simple;
	bh=t/O+W+HsqXu03ft95Ypi7Ty/dXu8XqtU7DHBKFW3Qms=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUiSU8hSor/uoxdi9chyuFj/e023O113aKiA7xV1a/aHWuPNfad2cfeiG2WauTI8gdLpiRT4QRlgLHX9Y9dwoBK0APbCQyegwc+tY7P1v17JA6/mLu1/kla4CtbhxHtAEWnJ6oVooiUoIAbkGFnAUIA9R/20WxUpTJ/Q31QDLCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=buokyXLO; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="buokyXLO"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 92F54164A8B
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 00:04:52 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 490FE125167
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 00:04:52 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v3 5/7] qmi: Handle request rate limit option in 'qmi_qmux_device_new'.
Date: Thu, 13 Feb 2025 21:04:46 -0800
Message-ID: <86bd06fada4034df3daab5141a45c01182d89cec.1739509438.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=ISIlikyP2ZOodTD7Qlv/1RxUMgq52+SDwWMcrVclQC8=; b=buokyXLOVTnfClybHnHbHUQwmWZruKoVYLP/RjW90xey7vGNEL8JVn3iQ+HgBpjED1Ert5Ze8Tsi5ruKEiwfjPh6UyE+SZ6nc3vjfYl6h3GkI/iRbc/ASmUG+6bm4/Wpm5jTCEqMlj3kgojR9KM627WCQ7O+Zj0Q3JaUEGV710Y9ODwq4jwU5q+hG84z9XdwZBLqLrvnegPe3FZZ3aKC9UzUSmYE0ARQSPH068T7DQkj7FSAS0d+gpCRPbkTubthDaqYbz1YF7J9Pp9WqwFrpNM6y3TqMPb7S7YzquBj4GCOfczjBegm9ShWtyuGygML5X05ePYnHK/BqgveiFs34g==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

If options are specified and QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT is
asserted, set the qmux transport minimum service request period from
the specified options.
---
 drivers/qmimodem/qmi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index f26a9816c71c..6063ed1d8634 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1611,6 +1611,16 @@ struct qmi_qmux_device *qmi_qmux_device_new(const char *device,
 
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

