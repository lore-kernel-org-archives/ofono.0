Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FFA38FAD
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406843; cv=none; b=Tgc3P/ydr1vvKvfgrIn74J7TC/x9DrawTWpR5UAyQEwehWQARQgrMVcfy7wY25yKaYIY3pgV56+7CJeEXvJQUJitKObsq66ns1udZ670pkjPOho7G/drEGqz+GjJieLg/ehP64724Q7uPf7pGhxTqS1eKqonUr0rJHubNdz1XuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406843; c=relaxed/simple;
	bh=4r8w3BB1akA9ViycLhH6r9nNTeF+K4NnxLI7QZhqfeU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHDlNy92ZmXPUHj5HjGXWyTNMtYpRaTPvWWlF9sERY/nmIEv+QXsfF36Y6ypXEMGakyBi37EmuwquyDjBMLRljWUTslj0khk1xPz8pKMnN1R+aCoHiNygN+sQWLI6+HQDjrwZadx15t/At58wFYm0bTnrz5AMOJbOeeQJZyDsx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=AROofcK/; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="AROofcK/"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 78BF5164A4D
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 19:34:00 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 2FE4E125167
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 19:34:00 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v2 6/7] udevng: Set the QMI minimum service request period for Quectel BG96 modems.
Date: Wed, 12 Feb 2025 16:33:55 -0800
Message-ID: <66c3c2270abebb17d7083969519abf8dc59a2b16.1739406657.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=HY5EY2ISZixz3Mr7Wq0vZ6BjK6Xua0OSEwuqX7gyeJ8=; b=AROofcK/nWxt3J36DAzFz0YZm3T1f13+04uMkDSDwuo11yKiJcW28n7UGLI5MpZFQWe+6w2TzzNRhoCkK59X7oB2SxsE0AjJFaAuZ0sAdjVKEhH/cPz2YnRvwECP991jY7DHyFy2RvjGXc7emuf8aXPDjg7swj72DLwNti7WTc3djWdJnuZV9SYNdtPXaOBBtTagtbY2n+IBRTlK8JWlZdIUx65gawgRkyxyS/P/JfDf7B85aEa4uTiTRLIBAeaGbgPmxP51JL2fDhZfU2ZdsbpSNz79xKMxUy3B2upA2ZgaMkxTdr9vPbbucAR2cJLSSoozCJb4+WznDM+0WiS8LA==
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

