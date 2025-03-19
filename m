Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B821DF258
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412167; cv=none; b=nK/bCZbOThSQZSyYoMOMJybYqUR2THj9NsLNf3Mo7iUTopKFpYHqAFOWKBQDUyPlHJvaHKX8SyT8K/ilWMCHAgszz070CPj0DxnlRQdhRwYbcWJ52C6NLlO67YV4dg265s+63j4bSSIst4U0bjzKGngD2PBPL+yn6gasDbifIxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412167; c=relaxed/simple;
	bh=/zRBuxHb1YZadUGBY2Vcl0+bBcgHqG51e5rh5Q3mXrI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPZSbfs5CfR3mGFZn6iKSe5Y7OfK3kzmd8MhDLY8mounhKBfG6RJtHJX+T1mdEo3AbMT52OuCBov+ox3LGQON6TpKcyh9k9irgREvDPyy4J0F62rJoeNzBKOGouF6v07F0wtm8sk4PPDC2kiTrkoIWFyrpg/yQJqDVc8hcp9c4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=pHXnc6vo; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="pHXnc6vo"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 103CC164AA9
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 15:22:39 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id B9F0F124C24
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 15:22:38 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v6 7/7] gobi: Pass QMI qmux device options to 'qmi_qmux_device_new'.
Date: Wed, 19 Mar 2025 12:22:34 -0700
Message-ID: <c5f03c791a3a9aa06dcbb36a4aedd9ba92270079.1742411889.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=Vxp+G+wWuhPQL8Dt96ps2vexl5kKWAzJ+wzPwtwjdmc=; b=pHXnc6voaqbd34UjKR887xHbWo8kawn5F7Uy1kXyjL1S9yGVxAa8v9pSpkragZ5LgCNpbh9+qrG2bNurQD9BpnWYbdPZo7Ipz+gS2aXffXBcPJOKPfYBXQ//4okNl3Rj2tQ+D9UsF+5/TC6PkRHRKC+/zB9dV32pG8AvXdEA5KlfY1AyhjN3vYF4MQ6HKC78bnAEgbEpLdynwERw/ZRs9JCQYKa07mDTHYAucpqtyWEd7YTIhx3xQmzS28WLi8y3UX7BlTO72UsCi/HgrTjUXwUmM1V19hu02cAVEMHLzIUjoabIBPGzWKDYLfpxzjXye4KW07sb4VJjDkMYAU+X1g==
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

