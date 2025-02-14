Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0D0268FDE
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553768; cv=none; b=eIsQReIJv6xysFDlwozveF1teds6nlmy63s0VMiMGQkvWGo3jUITArbpmEjVcdlcWnS+X7FXWGk+HHz1wt3sJTKS4c3zO+/0e1ykqZSOn9UsSHzjX+91zNmT9o/4OEFHXdRUHhMAGz4n36l763zxsZqASLlOS9YfrGVPAffbWMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553768; c=relaxed/simple;
	bh=/zRBuxHb1YZadUGBY2Vcl0+bBcgHqG51e5rh5Q3mXrI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxpSoCgUimtO9rvtE2Oul6LMBm1Twog9CQn2Ilc/kQKt5KgKwhPgB9bCjuqFheW7EMIarT3sSw5D4rgRByzkynUdC3CHVuwRiiPhUH4rpCEMkgRdYy8tCmXfZ+Mluk4mXCQ9cJ7gLVHgWc4ir20MPStQp246oBJuUvT6UUbTkOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=PRq3hej+; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="PRq3hej+"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id E85FF164A92
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 12:22:45 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id A055E124F0D
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 12:22:45 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v4 7/7] gobi: Pass QMI qmux device options to 'qmi_qmux_device_new'.
Date: Fri, 14 Feb 2025 09:22:41 -0800
Message-ID: <a0f47342d943112f1f9bff13a0b28f63680acee5.1739553712.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=Vxp+G+wWuhPQL8Dt96ps2vexl5kKWAzJ+wzPwtwjdmc=; b=PRq3hej+1tVeHKxcO9ONfBEa1DN4caHLfV9QTLD6ZEmwwni8XC8MsNqCdA7mgeLXgTAMtDpoLORtsorJE3jBSWf7PgWsy8Fbq5XY48keYmKaNal7m4JXbhkblAWVD89/dw1HVKFcSUyfhCnhozd6Pkgy0uPofyRxjKy87MVWKFwaWD6A27iG/JFF0LWUOwprmPSTikk+u1tH9GJaDWDKyzVyxHAWQJAry8lGqe7MTJo/6utFmHkjwPYh3vSrVdmzs43U9IXbumWkgS3hqCwElOZsNaNb1YDN9cX/1TuFjY/4qE5HswPIM18hJfAMCuubKqglj1itLzvxxgaGIH+JnA==
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

