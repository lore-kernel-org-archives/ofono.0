Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D991DFDE
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406843; cv=none; b=f+wKMbdYmtbguU6vyFtgfoCkLpPSWOhMkhLMLajcnPZn0sEKHjjfhO/gqbNF2IteDtyJUCvNWdxX1vVhSNiI7PwOadqrFL+O366DmWtCrOZ2CEC6nuMKikPYvepwsbiSFtX54tUJS1dhUP0ztfWBT+RCMYKclc8D8E140xmzk98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406843; c=relaxed/simple;
	bh=TH4AL8AgMt6mDYouRQecEvgrdJ81ruHb/vWZsr6RJ6M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tW1ui85BxncZ708sP8saWlDHRJdveERSC3XhGgr74Ura+IuEkO8HiCasCzDo51tNWMDuM7HMVjGmQFOwZrLeduuwUp0QDWfo2jmL4u5j9RFSad1z+tzlmQDhIbgk/Zwa+iZzD8dt6a7wANoIxDjzy6URlE7DnqFW5UwH+nSISgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=OuFMLdpw; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="OuFMLdpw"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 0C34B164A45
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 19:34:00 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id B8472125167
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 19:33:59 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v2 5/7] qmi: Handle request rate limit option in 'qmi_qmux_device_new'.
Date: Wed, 12 Feb 2025 16:33:54 -0800
Message-ID: <f61c068ed19e5013dc4ae9f6ecf00d4a002e95ac.1739406657.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=KBOLCGS18RHm1XFV+RoryPkVTLAukDTN/MPB8Dm2Z1c=; b=OuFMLdpwXz8DASt4QA2C8dtc4lN/wFcj09ZfK0ZwCSNexqpSohH9m++y/DpL/iBaNbYJJta9kjefJl+d6UAcNNHy2JFeseK73pGmkZmFXQSKIsxlvNfXUqzx4UgchZoy82dTdhanWeOmETm2UuL2HKtIaH2D80Y9T2s/2rCxb2GctRmwwVWYzbFfnRfubTxD9KneByZJtin0Bf6hnjkgvGFxkZO77HNpFjbW5XPH5j071LktUePsBW7LRvPf/ChVlNCfd4n5TBnakz4Nua4pssT/UNrzw4H3SyuT5ycn/IF82lzqEkuA8gcQbPz8R/yKl8uUAPSYpab9qE71M47vtg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

If options are specified and QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT is
asserted, set the qmux transport minimum service request period from
the specified options.
---
 drivers/qmimodem/qmi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index ace83044138a..f544894ad4d5 100644
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

