Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366E7238D52
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822523; cv=none; b=Zxs1nooUSLfLj4sk7V3E0ob3dDasyEX8pIegpqnV3iWqjuWteFDu7lhE+2HZFO4+UjEK40si3AbHwop6iETdHhfNodybAvUcYj4LkEDZib0MBmj/6LBWvtFvA6BlH3L49uHgQYQfsW6SItVq5WEnsSxOMG9rQyeQeChpbEh6DVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822523; c=relaxed/simple;
	bh=4r8w3BB1akA9ViycLhH6r9nNTeF+K4NnxLI7QZhqfeU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVcGbJb78/IgOrds5jUg3iABsoEjCcuZJU9NWeduQ8C6eg0ZI76Wx86qKRuQps0QuIHkxFrwsFNnEswpe/jMWFkzG7gfl4As4sXJXC+Dbi3QfmBJc7+cKjQDNXaDXZuWz9abPfA267VbSQy/QT472EZ7cqZEfXdIKlgPnFPgoDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=BtMc8DMy; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="BtMc8DMy"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 50E18164AA0
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 15:01:54 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 07E85126369
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 15:01:53 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v5 6/7] udevng: Set the QMI minimum service request period for Quectel BG96 modems.
Date: Mon, 17 Feb 2025 12:01:49 -0800
Message-ID: <9f30423960cf36ce579e20c36c3570cc5e2f64d4.1739822462.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=HY5EY2ISZixz3Mr7Wq0vZ6BjK6Xua0OSEwuqX7gyeJ8=; b=BtMc8DMy0bDwwDCUCM0df9OjP6gZtdn0SlA85cxDAmrMYSpcqzyLv6u8t6VKSz5UYAf/CnFjsIvdyYwG1b5vl+R8c8PHTMgh85uYxptZK2lfdXsNxkyRuLDofZ/fcF5I8GpqQtaVk43H5tzvjNdvoFEZ4GF49njkztmcrt//4rC5tA1J2Jln8XLTIn/zdVQQlrDjF9rWXvzo/0YfxYX672btAeOIdQmpx/JBupdCwR+kJTedrju321ebXi1WOZB26tXJnM17RBSOgfeKsqNl0NiDjjs93/s26OfCNbk0OVj6719A0YI+SI3jN15Rtd5PcRbL8tLodO4bR4O9sCRVHw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

The Quectel Wireless Solutions Co., Ltd. (2c7c) BG96 CAT-M1/NB-IoT
modem (0296) has a firmware issue where it can lock up and hang (not
responding to subsequent commands) due to high QMI service request
arrival rates. If the vendor and model match those, then rate limit
QMI service requests to no more than one every 2,000 us.
---
 plugins/udevng.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 64875a47752b..b8df66de5c71 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1118,6 +1118,20 @@ static gboolean setup_quectelqmi(struct modem_info *modem)
 
 	DBG("%s", modem->syspath);
 
+	/*
+	 * The Quectel Wireless Solutions Co., Ltd. (2c7c) BG96
+	 * CAT-M1/NB-IoT modem (0296) has a firmware issue where it can
+	 * lock up and hang (not responding to subsequent commands) due to
+	 * high QMI service request arrival rates. If the vendor and model
+	 * match those, then rate limit QMI service requests to no more
+	 * than one every 2,000 us.
+	 */
+	if (l_streq0(modem->vendor, "2c7c")) {
+		if (l_streq0(modem->model, "0296"))
+			ofono_modem_set_integer(modem->modem,
+				"RequestThrottleTimeUs", 2000);
+	}
+
 	for (list = modem->devices; list; list = g_slist_next(list)) {
 		const struct device_info *info = list->data;
 		const char *subsystem =
-- 
2.45.0

