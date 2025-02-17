Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F1D237701
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822520; cv=none; b=A6r6ryccZdBMl8xJq66iQxldsp93Rel4r6++iJkVswhx6uA0Pv+tgxEfHq9NwrMoZIQD8CBGqIw/GeV76savzK+mC7s1LlyQjOGr0pqX7m7wJtUQQTm9tjNkeMrk8r6XUhZJQZ8Md/jorb9H8DvJ9QXj23vZjCSkyQmP+MoZuk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822520; c=relaxed/simple;
	bh=M5Yt+XgkEhwDsBif7PeTj7L8IDaWFyPdeokkm14HJmE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYwSPOWcneWbtS/Kgyle4OiLP9B17DZkBbQSN2+xl+Y2hk1Vjfkoef1kHuiMuoycgMwKAoKr6Hace4newEPkHgMDsD8Qp88sF3tM06XK4FGqlm3Q85qf0YUKrJfZnpJTp2js1gQefhuG6HI1egWsvWZHNo3hhIoiCFbo7/4FH4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Dgy0C3p4; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Dgy0C3p4"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 815A6164A98
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 15:01:52 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 361E3124FC9
	for <ofono@lists.linux.dev>; Mon, 17 Feb 2025 15:01:52 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v5 2/7] qmi: Added structure for device options.
Date: Mon, 17 Feb 2025 12:01:45 -0800
Message-ID: <520a4879b3157a715299d4874c4091a170d84638.1739822462.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=fHma6eg08g0rSRzjb2Szp8dq8ebKa/ez0Aq5JPdNAGU=; b=Dgy0C3p4MEvT2uyp+wBvphlAS8XOD+zReO7IpCbCemLFXiPx/xqkBEq6ghWkqweugHksfFGX+VqogQWRj/uB8wcs5u2qX3Npo8BMqucGxSWskCdEzZTugEic3m5VqLAtlphkxrvChaO1nIFowLaofnF+46jRJkoXWPMde5SGGfi9s1xNJ0b6rQLh4pJQyMN1qdrFRZr0X/hM91uInUJzQ9YyJeqVmhU2g/JkA3mrlDEiVmRVmSF6NJ4ZAsCKb7cQfFyFGSZUcjGM6U9FDkcdOmoE4er+izRQzBmXseo8eYrUPxz/+aXKQqtmwLbIK/+YmR7rzt6GYtOchZK+9qCbAQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Defines options that may alter the default behavior of the QMI driver
for a specific, instantiated device.
---
 drivers/qmimodem/qmi.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index e74ff3feaeec..4ba27847176f 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -74,6 +74,25 @@ enum qmi_qmux_device_quirk {
 	QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT = 0x01
 };
 
+/**
+ *	Defines options that may alter the default behavior of the QMI
+ *	driver for a specific, instantiated device.
+ */
+struct qmi_qmux_device_options {
+	/**
+	 *	Device-specific "quirk".
+	 */
+	enum qmi_qmux_device_quirk quirks;
+
+	/**
+	 *	If quirks has #QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT set, this
+	 *	is the minimum period, in microseconds, in which back-to-back
+	 *	QMI service requests may be sent to avoid triggering a
+	 *	firmware lock up and hang.
+	 */
+	unsigned int min_req_period_us;
+};
+
 typedef void (*qmi_destroy_func_t)(void *user_data);
 
 struct qmi_service;
-- 
2.45.0

