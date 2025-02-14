Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8036315748F
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 05:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739509496; cv=none; b=DyMFqUQmaDuePCWnob2QGE6gGIcW+NyKLXj6I9oblHPUE4AMrWqdnWXttpp9PK+JXjBEKPVfTHvSI3YSe6khC5ii/f8VWmIrh6Y82EaeIvY47d1JKQHd5urZ5EHC+95FnAmQyzeq9yR4ibVsEVwV7DRtg3qb/szpyCld2Ci3gJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739509496; c=relaxed/simple;
	bh=4r8w3BB1akA9ViycLhH6r9nNTeF+K4NnxLI7QZhqfeU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmtzaXDtJfLCtpzotSrPhYqwROnLJLUllEV4cp6Ex0LYwC7yhWi4k1FT9RWq3syGCyvQ3wxDHHIeTfvYsgubCM9cK8Vu+0hBYy0d4IBuT7/hdTkw7e8rlwxkgj4zVmg9yss1PK7uneyim1IwOsArRavu4ifJXHhhZ1kiN172pvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=A8ABgXBS; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="A8ABgXBS"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 0BA2D164A8D
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 00:04:53 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id B6C43125167
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 00:04:52 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v3 6/7] udevng: Set the QMI minimum service request period for Quectel BG96 modems.
Date: Thu, 13 Feb 2025 21:04:47 -0800
Message-ID: <dfe06ed169c42a0ca6117bd09140f97a090f164d.1739509438.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=HY5EY2ISZixz3Mr7Wq0vZ6BjK6Xua0OSEwuqX7gyeJ8=; b=A8ABgXBSgZClldSFoCYm9l5ziiN8hDAVNMRksLyvyMlHQeKQpP0vtVgHDu7CjpvSL2JBYKEI32AwNvPWoSicRCzD04Uj7Vwc49p/u4lJZj34gC248+JU3PrSEtdaU2ZxlaotQGjde7I2LeJZd+k8Cwxodf424Zb2Who1JSjz4ttOGQpw9+TPVd0Ykmsv2v4T243m34JfrStNT7YA+ybNlxXTEyFqYHDiJxcEvQXlSjqfk2NV5W9r9cMa8C2aSCrBLdj+fCuF0eB0P0Cc3eEYsul9sXCx8zPRpbxwRVHZlPD1/jv6oqH4jIIt1I69w3NrXG9n4O0XgOFd9CnAAqXVAw==
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

