Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9472690C2
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553768; cv=none; b=H4cHqDvC3jNTfsKUCoGkGDrqi5czZQrKVQIwtYEvhMjHevnrAvWWa1uYxh/Ya/FcTrGbnE3hTLXrPao8kLKXeU3Vn16+5Izw711nKWmFnKAeNks1mmoYEPP5AWxYC01GrFTtinWKBFJCokDKoY/0sjuwyOt7MzVydmu5GrdEGls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553768; c=relaxed/simple;
	bh=4r8w3BB1akA9ViycLhH6r9nNTeF+K4NnxLI7QZhqfeU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFXxTejTDvA/hJUo+aTlvEWDr3VuDG8nLiqmeq/KNMSUdvxU3TSJa41E3hK64kG5u8m8sEZlq2+brYcJDunWcQCEnZF+D+YEmHP8jJYHLI2UiT5kSbMHoenyYI1gKDI+c+dJiOiNtzy1AXCOO962XAEOWX3gl4XPnmNekUOTsSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=AMIA/W/U; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="AMIA/W/U"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 7CB80164A91
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 12:22:45 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 33426124F0D
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 12:22:45 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v4 6/7] udevng: Set the QMI minimum service request period for Quectel BG96 modems.
Date: Fri, 14 Feb 2025 09:22:40 -0800
Message-ID: <6a4c7884769af30a032cca23388c0a044833d836.1739553712.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=HY5EY2ISZixz3Mr7Wq0vZ6BjK6Xua0OSEwuqX7gyeJ8=; b=AMIA/W/UmVxc87yWOxAbvOYpaAnPPloKnJB31hrnoHOCvwtCRf/bCULrSbwfA/sBbZyw2VwSZZzpGG6NG6g+IJj3ihuxE5aYpR+38u1iDeVBmQwgGEBbifQ9eG/cyjS5t7ev3HpQtyU2tIyq7DRHnSZyI6NIFPRNR0QRlhRNGAr0s3gC6O2J9LfC3fUnxgq0gunDL4NDMLcTTy4LpUURNtiwmVTbQm7UCTskgm/DdAF9MBxMRFysmwnr/rj1ph1eq6ETnGHO6Lki+ta7xXZg6eN8ltvcBwS8LatwQ+NyON7lapK3Xj7ZsXcdgcjqYV5YWogQER/JiS6vznkZMdIVkQ==
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

