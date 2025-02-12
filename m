Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D11FA14E
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 05:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339594; cv=none; b=SlFkZ4A0rkONAssnc9aiAIRepJHF4lEyQv4hHLSkX+CSakwDD7oi8IgUtO+/2B/CUQZ+weKsnFseyAD4nfflZwjG7Z9gLpegb5PmuUKMKmyU0gLZjLdG6m6RM2ueQtsM4XZqVH6XmmCOW4NM06sfDbuElVuiuHqFfm2GBpq6dxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339594; c=relaxed/simple;
	bh=GlSqEFme2OWGz04dS8mrQ1b0efrNkYt6ZeHzKrymFnA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PonrIVzX50cFhBvTmCteOsxvPt1KFxWbrcdMK/sJwW8P3pTHzlXfqE/eUb1AjewtBJnbnUH6AqKdYIXREk6Jb98AEswJ7xP0b5I7ZQ+XP0bPhWoXhlmDI2omQ86R8JHvFjD8fGB4bDdKzfcleWmAvai/fwgRVFOYe9cCcV3oZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Bvs36C3b; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Bvs36C3b"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 32866164A8F
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:06 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id DC3E0125163
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:05 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 10/10] gobi: Pass QMI qmux device options to 'qmi_qmux_device_new'.
Date: Tue, 11 Feb 2025 21:52:59 -0800
Message-ID: <c3452d04ed6dca8d652ff5cbf0eadd53bf0a3ea6.1739339173.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=vmkC3HLMphE9hjA+eID8Mt4/Y6u44cXldfvMpO82QsM=; b=Bvs36C3bKkzVNfpIX6ewrycu1NDTQMG6Fv2B69OPb2hL9LkCpolL1mB3a+PaFVStsaZ3eN2JhLMdSEeqzgpxVA0W5eTs36JzRn+XtiQFqxVk7od0XytdsAsn0772VlmDJrv896ighHwjKtHAokFRgSwulOuUPylqbBmqerjm7wBPiEYNznL5i9PSHPb+VDZUxW/MpeEMTrG6x8LqGKuAh3upXINCrPQq1PHmcx1aVBhGCes1/Y4GFpMRJE+LhOdXuzel+4LYmhhLV16XCXj15Kxw14axEP4tFAEZ3HOSYzlxLWXKeNySfR7GxI4MVoPdOf3OuHIYf6kOdtkFQY+sgA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

If the QMI minimum service request period property is set on the modem
object, then set the appropriate QMI QMUX device option quirk and
value.
---
 plugins/gobi.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 027aa91d6ade..9ec15deb6fa9 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -845,6 +845,8 @@ error:
 static int gobi_enable(struct ofono_modem *modem)
 {
 	struct gobi_data *data = ofono_modem_get_data(modem);
+	struct qmi_qmux_device_options options = { QMI_QMUX_DEVICE_QUIRK_NONE, 0 };
+	int min_req_period_us;
 	const char *device;
 
 	DBG("%p", modem);
@@ -853,7 +855,17 @@ static int gobi_enable(struct ofono_modem *modem)
 	if (!device)
 		return -EINVAL;
 
-	data->device = qmi_qmux_device_new(device);
+	/*
+	 * If the QMI minimum service request period property is set, then
+	 * set the appropriate QMI QMUX device quirk and value.
+	 */
+	min_req_period_us = ofono_modem_get_integer(modem, QMI_PROP_MIN_REQ_PERIOD_US);
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

