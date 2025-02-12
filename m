Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0D91F9F51
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339593; cv=none; b=MeoDQJBvJluEXhntz7R7cUZnEYhDwaLXvETkuErSJU7q/mNHwxNyw/nxev2jN1myPohSxTQeCkymGsY4S7rWodxN5Sqpemf2PbdpN2ixuoaDT8cFMAsj0mDkPU7lWh7NoT9gNIo7KplGFU/PIHSdFlZazwwL3oo0uflmBwOAQPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339593; c=relaxed/simple;
	bh=UOMM+NLVivf3s4h2IB7qNzMjQpTv4mzFK1+/KXThKMc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S51DrQQWTD1CESFkaNU1+evOds3TQ8FcaugDOEq43awFsqRLEqaC0lXcVnCOxtJvHHBo0LFJlCY212zYKfopktpKqfGGFu7+J5Qx33IOYCOaH7w8LwmRdz/4uVsvv+Foax3MP/4osu4hqplJjlU0BriOPG5ey3weult210stN+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=eUIuiaDQ; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="eUIuiaDQ"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id DD502164A7B
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:03 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 8B3CC125163
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:03 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 05/10] qmi: Added minimum request period data member to 'qmi_transport'.
Date: Tue, 11 Feb 2025 21:52:54 -0800
Message-ID: <a8e769d2245622fc81b046906d145002e4066829.1739339173.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=s3+1aa9GGwVgyPtDRMJdLX6gkZodw5+K1K+b1GhnjLE=; b=eUIuiaDQy+C0awEBcrer6M1lXunAD8iuSIEyeEdSh9q7zFdvIw/DMtXGcvc5TH3g3g2xEOuiBY6i0s/70WKrkE7LwmCBz/WI2kkWYMW6u//DA0laYq24dbgzAeL37deV+C5fJ5WCV+00DRqw76/c8IPFyj63aC6RiC8NbzSUcN7HyL9bs1MIR3oNzNU6AdiVyL9dET6NvgiPg6eihQ28v7yCjlZzgXFTtujmzWhRmCnOd2IdiF7MRo7qKnAL8kkwMD8RaxbMBQc5HTzcJiQji6wgp+luTow+TtKyq+Vfql5iYsMsv0FAYu14j9P8o1GGc2lkZt/+Q7sxr49V+J/9yg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

If specified via qmi_qmux_device_options, the minimum period, in
microseconds, for back-to-back QMI service requests.
---
 drivers/qmimodem/qmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index bbe6440abe0f..b16fee252db6 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -92,6 +92,12 @@ struct qmi_transport {
 	const struct qmi_transport_ops *ops;
 	struct debug_data debug;
 	bool writer_active : 1;
+
+	/**
+	 *  If specified via qmi_qmux_device_options, the minimum period
+	 *  for back-to-back QMI service requests.
+	 */
+	unsigned int min_req_period_us;
 };
 
 struct qmi_qmux_device {
-- 
2.45.0

