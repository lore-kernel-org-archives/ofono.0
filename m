Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C47D1FAC56
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 05:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339594; cv=none; b=e+PP4hMe0siy2Iimgr5fu/WOMCxL09MeVnmROzGazwhKPBtj2NYlrHmE1cqr1CzUSaNcagRQ6qMqBB2186n4UdLeqzMWVNa2gr1YSkPyfZ5/yNNHqlgd9QkPxu2V1saDHcCUtgb0V/ukWOedqjLdyc/7orxA9OFsrJW8q3ioAJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339594; c=relaxed/simple;
	bh=3NGnUp6eV05AuYFfqwujFqWN0Odnh2Ro4mn0Sbtg44s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7EPkSOn1V93IQCjDj2RIopmpgb1C7r6RHH+9NTczfte9hDgEqLkWakbZ6DH3Z+ECniiNTSyEmcFZPkNAjcBvOygFcvfJnHL1nmJGfDV6vzHRR9ndIsG/A5hkEPuVZBEGUlT2d7ngp/2+wF83BtigPDdeH3dAn6Hpi/lKb2VU5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=osxQLPoT; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="osxQLPoT"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id B8685164A8D
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:05 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 6D709125163
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:05 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 09/10] udevng: Set the QMI minimum service request period for Quectel BG96 modems.
Date: Tue, 11 Feb 2025 21:52:58 -0800
Message-ID: <5f9277b84477f13890620d4dbda3804881142946.1739339173.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=sHgjLuJJevFTyR5wZiR6zXCBJTwkQchOBUFflurhIMI=; b=osxQLPoTzscAIWV59nQlmMIjWabnta9Uht1TwTLNd8x4YCgy7ru+7LvKdQDe28eymFG6ryIiutft5byy4vfaMX/k9P9XlANs8/6cFzfNKOdV2EaYuzR+FfMpMLAPK7ZFoDUNEBz0QRqwKDtV8ShgehavqHssF6SFI7H0Msv8HFAQLsxBrdCCTWGOKXV+fUnUP7KTgJIQJu7kxwQexETmG2ktAqSLAb8A7w3GyeAkluyh9btxkvFxu51wtUV3FJq5I4zCrhVqOYUR9xzvicEu4fBcwkxjICPfRWUjRM/KO4h7XRr+a7kp02ZHlT/cJDiUa9SC+aU90VNc/olUI4u9HQ==
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
index 64875a47752b..e7cf494a70ff 100644
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
+	if (g_strcmp0(modem->vendor, "2c7c") == 0) {
+		if (g_strcmp0(modem->model, "0296") == 0) {
+			ofono_modem_set_integer(modem->modem, "QMIMinReqPeriodUs", 2000);
+		}
+	}
+
 	for (list = modem->devices; list; list = g_slist_next(list)) {
 		const struct device_info *info = list->data;
 		const char *subsystem =
-- 
2.45.0

