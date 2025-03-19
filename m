Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BFA20C49E
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412166; cv=none; b=pPyjb8aPSZYo4JMu/kkGcebk0Ul07ELF8U4VeJM/K9Nt9yBGP7UKJEx9isMY+6EfF8Ib+bHvjvF29ulgtICt3vkewOy45pN4+93BIcSuMkvLiyPfu51biJUauf4+WqY3s987OyZ99X8oKG7lAbpwK0TP4uqa6UVhKjL8Zwasv+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412166; c=relaxed/simple;
	bh=4r8w3BB1akA9ViycLhH6r9nNTeF+K4NnxLI7QZhqfeU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptU73rQ2wbqjyeXHwXUlVfGHH/weaVZiUg9jQWJrJ4siT/dT2K8nyowZ+a7vRx3KO3OwP7BU5Jxttu99UsaAcuYMAm52h8HxiffTtsY7otr8QKbjYr7Spjw0lFfYger02VhExRkqUIZVVbrgVIhv7v+C3SyeGz4hWCrBSUu3jyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=kYi9/T6O; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="kYi9/T6O"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 971D3164AA7
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 15:22:38 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 4BB20124FD0
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 15:22:38 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v6 6/7] udevng: Set the QMI minimum service request period for Quectel BG96 modems.
Date: Wed, 19 Mar 2025 12:22:33 -0700
Message-ID: <0845d591dde762644f32e36ecdd6c6e98d3e336a.1742411889.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=HY5EY2ISZixz3Mr7Wq0vZ6BjK6Xua0OSEwuqX7gyeJ8=; b=kYi9/T6OXRCcsaUY32n56k3O4SfQEp4w4spDqaTbJAOgd+wljgASeIMfrGVCOmByaTR9gRMWCQ/ygY1oejpttFWMiR+RbbnIqMxKA6uE1bg9aCQ4eQhYiwjXI2wVbZRyE+gVsWewQ66nXsFrbs3sr7HmR9QrniSOKvw7tb9ShjO0l5FPvpwsF+Zs9WPAbnmECBhey+ARCabGjG/Vt9KUoR0np0MydLy9w0rW1MG9LYB8QfPOlXejpMpaG1dS150hqYA7XI7eVf+0cEYdGFEXVntSak19PNr+drYl3RFyPS+Bh2IPMHMOMH3AKp16BbzY3ltgib0xiue6+YONXm4WMQ==
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

