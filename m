Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A322F23770A
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822523; cv=none; b=WrE7StI5V6EfLlesivv19Ni9M9bnjOuUhb54KiNfT1LlBM7e8ZB85j/np7wLn/rMX1CUP7PiISriaAU01Svq2aRQP5SC8PxmNWtOu80SJbNvmw/9lxFF8MpPnGPv9vtNT5BTQttwfvgdBrpeiPln74exMBbdSxnayLF9HQLC2TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822523; c=relaxed/simple;
	bh=/zRBuxHb1YZadUGBY2Vcl0+bBcgHqG51e5rh5Q3mXrI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zdaf4XJXQT7W1DSi7LfuPssF/sGxlzk7DomrY14rHStw2B5evzUfkKzjjp6oUT9GnjvksctsV2LHIwc2B7nROkr1JBsQyy6K/DnR8qPrKmEEOHpNwsdVk7+tRKsMOs0ohWmCA9OlRP2jbkGe9ziVb8nJLRlVSQA0DMuIlm3UV1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=daFywkiz; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="daFywkiz"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id BD59E164AA2
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 15:01:54 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 747F2124F32
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 15:01:54 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v5 7/7] gobi: Pass QMI qmux device options to 'qmi_qmux_device_new'.
Date: Mon, 17 Feb 2025 12:01:50 -0800
Message-ID: <dfc6715ddef2e26ba62bd2ed5326b295ca044d9e.1739822462.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=Vxp+G+wWuhPQL8Dt96ps2vexl5kKWAzJ+wzPwtwjdmc=; b=daFywkizlMEW3WT2AfPR1Zv28jSSAXApH84Ux+PaRpYY2agySgIghpCMtTPi3tvaG5O5LphE19uVPftYlhT7AgebKC0WLupk1jnK6N+i4ZWNnK9RVCP6Evulk+pa4PJQdOa42AYc6lK+YlEdNm5WtTlcyULEVOQ2AkycWMOHQdjZv1SkN2pfUVtmOZIgNHGfz/pQxIvmhgOhQvQJdGE7a/bqQAZIHo3Vn4h4VDQGaoL8SpzBazSkWzML4ZseR9wKz4wMD0ljfoRILaZW8il7HVuozxQSXiRhW2Ekus9+Ztfw9ANoP7HHR5vZ+3oAeTsZ/wZnsSJQTa9pJLTLxDuCxA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

If the QMI minimum service request period property is set on the modem
object, then set the appropriate QMI QMUX device option quirk and
value.
---
 plugins/gobi.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 027aa91d6ade..dfc7402e36aa 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -842,9 +842,19 @@ error:
 	__shutdown_device(modem);
 }
 
+/*
+ * Enable the modem. The following modem properties are optionally set:
+ *
+ * RequestThrottleTimeUs
+ *   The minimum period, in microseconds, in which back-to-back *
+ *   modem service requests may be sent.
+ *
+ */
 static int gobi_enable(struct ofono_modem *modem)
 {
 	struct gobi_data *data = ofono_modem_get_data(modem);
+	struct qmi_qmux_device_options options = { QMI_QMUX_DEVICE_QUIRK_NONE, 0 };
+	int min_req_period_us;
 	const char *device;
 
 	DBG("%p", modem);
@@ -853,7 +863,17 @@ static int gobi_enable(struct ofono_modem *modem)
 	if (!device)
 		return -EINVAL;
 
-	data->device = qmi_qmux_device_new(device);
+	/*
+	 * If the QMI minimum service request period property is set, then
+	 * set the appropriate QMI QMUX device quirk and value.
+	 */
+	min_req_period_us = ofono_modem_get_integer(modem, "RequestThrottleTimeUs");
+	if (min_req_period_us > 0) {
+		options.quirks |= QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT;
+		options.min_req_period_us = min_req_period_us;
+	}
+
+	data->device = qmi_qmux_device_new(device, &options);
 	if (!data->device)
 		return -EIO;
 
-- 
2.45.0

