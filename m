Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0C41FAC40
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339593; cv=none; b=LUOY5HhJonyHxBShmR4dp/PSQZGBZGe65v5Z74PijF7Baq0aDf/VWZ60i7glZCcWrjJxiMPha4YrpwITMexlZ1x+1aHuBbUNvHd0yF7KecXMjoMrMMFEMcVRw/+TGuALsB7j1FILeTUDVITHQ0eZn/gLvWGwmw3PMQB8DBQsyC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339593; c=relaxed/simple;
	bh=afGYCSwnSCqSpupa2p/8SXOZEbLErGjEn70mFKQixaI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsJAH1Iev03eXDcPSfGJ/oZGXVYK/Hrv/TYE7+nzVOlSYE6euklQe/ILWn9taGnn07XnKZC7q2uad0YoztHiecJMlQ5Of1woL7JMxSlbGpb7swJn4fpg6k8RUfDovuW0l3v6802e+L3H6gmJvhw6osQc2XY/30UGxFJCuKdfagQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=IN9ZNX1l; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="IN9ZNX1l"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 61681164A7F
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:04 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 0DCF7125163
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:03 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 06/10] qmi: Added last request time data member to 'qmi_transport'.
Date: Tue, 11 Feb 2025 21:52:55 -0800
Message-ID: <1851578df4de1be24f0ea782801ccfcdd7f77bcb.1739339173.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=JYMmFLtLS8ZzkHDpOXinNqcxyFYluDRk1fHhP5q7HbQ=; b=IN9ZNX1lI8pBjBXPOaxntPO6kdAvsib04rvbLDn7F5eHjiX6Yd31aXxgcgcwv0/iYScEW5Ng+/l1L99oTcyw7fN54stCxWxMTh0PYc3QUN9aENHPco4IFKbj301OBlyFygz9SNdBRhlJqsMQ3JCoGbq//kIt+4Ey//k4A140knAVpQEn5ld5h3aeKId8zLAdCHZS1tsEGLd/DvpKeqK9/AXSrBayGYkLeQoAkXlibmjZp4M9nWkkAON3aDFHOL3/ISxmMOJp5MEAJ+4yXpC9wDEwMSceyTJSXm7r7vXoIqNiXwNrxyIRqJtHq0aXhWHurzQseSnHNrzr3Uxt7wTO2w==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

The time, in microseconds, when the last QMI service request was sent.
---
 drivers/qmimodem/qmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index b16fee252db6..2623e0312db4 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -98,6 +98,12 @@ struct qmi_transport {
 	 *  for back-to-back QMI service requests.
 	 */
 	unsigned int min_req_period_us;
+
+	/**
+	 *  The time, in microseconds, when the last QMI service request
+	 *  was sent.
+	 */
+	uint64_t last_req_sent_time_us;
 };
 
 struct qmi_qmux_device {
-- 
2.45.0

