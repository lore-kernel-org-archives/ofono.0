Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEF01F9F51
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 05:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339590; cv=none; b=aogmeBbTl/jD1mNTBU8ApctjcP4JqaTX1cee7Gu3CzbjpLZNEowtOHMSQAqDHjwAD3/sa6thyHn/GdV29RLDrsldEOzuu56xt2tQcU2avkJBjgM34J8ffiNmiNq17xjBLDCKYm52AoM+R9HfFYLp2KYZ1kV7MR+dTubhcu8sUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339590; c=relaxed/simple;
	bh=u6VQRuMXhX2s9rnzNeWfBrLTm+3c+Oc9XfSRphzRLWA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9tJfiAREF4yMbe4hkWKbC7GbfhP+2pBAN7vpiVEySjf9a9tOBw8oij53VAgQlXuE93Q0HhhIEySBvJ/tvZI8idT9QSVyhxzZ2Z2isbje8bZ2g9sembmuXawNTjlBueYAaSoI8XQDHko5o/pfFclcUNRHNPhKugR4nSqHEdRKwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=c58ISw12; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="c58ISw12"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 0E234164A14
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:02 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id AF5D212516C
	for <ofono@lists.linux.dev>; Wed, 12 Feb 2025 00:53:01 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 01/10] qmi: Added minimum service request period property string.
Date: Tue, 11 Feb 2025 21:52:50 -0800
Message-ID: <78fcde63abae5551db9893dbfbaca842e4d38b32.1739339173.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=KQYoQBfiDau+hwNmz3g0IDpLbjlC5/QqmFqMW3qWKiA=; b=c58ISw12AT2J33orvf/RcNewd9LF16NGgRSTxA6cYxn6omdLtsWjZnN+4WwM3n5lGGO2sB1JQlOCV3LXkZlcogKvZg4bEEjYgfXB0RQ3Vjy5oTckZPOZ3tiPAQb3X8/B/+kWPj5vSxWEz3TaRrWuFgbGjhYGFF0BYrT7Ue99q1PUEg0jW2IsOJ2VJVxlBMi2RhvB+1cX2TB07zCWWkGvtb5HyuKySy0/RbQ2FFUMtgFvAhz7sViJS2kuiHgVtxKQ64EIzdJll8Ir/pCN4XRhFpM9z+U15eBCCnhFpktTtZSTbgvEniOG+xfVbzGq7Pf+uhRYhAJfTbwDItiB4veZVQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

This may be used by ofono_modem_{g,s}et_integer to get or set the QMI
minimum service request period, in microseconds, modem property.
---
 drivers/qmimodem/qmi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 69698ee049c6..0c786ed065a3 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -43,6 +43,8 @@
 #define QMI_SERVICE_RMS		225	/* Remote management service */
 #define QMI_SERVICE_OMA		226	/* OMA device management service */
 
+#define QMI_PROP_MIN_REQ_PERIOD_US "QMIMinReqPeriodUs"
+
 enum qmi_data_endpoint_type {
 	QMI_DATA_ENDPOINT_TYPE_UNKNOWN   = 0x00,
 	QMI_DATA_ENDPOINT_TYPE_HSIC      = 0x01,
-- 
2.45.0

