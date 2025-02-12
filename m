Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E551FAC53
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339593; cv=none; b=eprdMPLZnSpHXu+KxqHrnIuTBZhMCIvplGbIb9xOiebLKbr3WBQGP3jrMikEh13WKauaXHXngf7mMBzmopYKsEWH4wVw6TbDD63v77t3y0+MT9TULz6AucPl8gty3huyQRx6WK6Etw3o0oNc4GHi+dSX2bSPt5HiwYtaTFwSmCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339593; c=relaxed/simple;
	bh=pevQY1piwnhjz2JISkGtHu1nTb4TPhEeUvxAw/J1T9s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTm9gLl0BLW32F78y0cKidsgkRjowcmV3wwJhEJB4uCbKoMXofpqXkq1mIkzPSKnlXhFNAvkj0cJ1B4TzdOqxOACB112F1ipoOGNfHIOfBo3Bddf9BSCJP6ALaKLwez/gfrvBY7TvSDdI0lUQXOjVRmp9clHpisV4ewebN+YZKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=TjY+BFFN; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="TjY+BFFN"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id CF8ED164A83
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:04 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 86504125163
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:04 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 07/10] qmi: Handle request rate limit option in 'qmi_qmux_device_new'.
Date: Tue, 11 Feb 2025 21:52:56 -0800
Message-ID: <f82251abdf3d444cf7857b2fd5f87437384e1629.1739339173.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=DlsHrY7a947iONCE98ivJfnxMlJFpPEEzSBIyPYwo0Q=; b=TjY+BFFNEzv1XOysb3xR0mW0c9lgQeP+KcQFnQTTigBJdvyn6EtUGaSciRQqZiJujZi5X+8pD3t99oxaDkEgcX9OWf6Wpo5Xt3VLohbp0NSA+MH7USoTXBVQJTarcso4PMNtEb082cMF8gcS9KxQn163OFDsXJ/KWNvueSKc1c3Vyjo3/rTQXKGHwlE5Spw+/iMRsffXYh29vFd0t2apbdN2vk1Uz87Spl8tXrNKgsl7csu9qYPMjpx42W8zFhmwdN3N/1NbGVmzUmpbGKRqvbFQgJPtU/8YAEvboL8oGf/0DGIpcKrpwTFtH7IxeUks0DsHTjFsARU6hYVneaB/yA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

If options are specified and QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT is
asserted, set the qmux transport minimum service request period from
the specified options.
---
 drivers/qmimodem/qmi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 2623e0312db4..00086578da10 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1591,6 +1591,16 @@ struct qmi_qmux_device *qmi_qmux_device_new(const char *device,
 
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

