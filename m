Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B60320C49E
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412624; cv=none; b=rLWx6gu1v6SMTS77H4pE6UFDooKknQ+PGxuPWwcONSbbbHU2LnquaomXIgg1zPvqR6BrG4wVunlnMy5+y1kQEQJOBZWgYJO6zKrNzqn6ohnEtdi+adRiapIkO7ds3P2qIy3HsKyNVayZBbt2nPdZFiZFvPaFvFViA/56GNwHroc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412624; c=relaxed/simple;
	bh=BOjh6BbY3gmEz2aVzixjVsKqCAX013D8zE0gTMLRqds=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUNF0BZEyg79fUZToGwO9rw5tGrUhi3rX6A3x4I/TUrnRxLNzGhMuImzPDCWhwMtW5Vjn3S1KyoA0nWl7anZrMk5cuxE2pruRx49WV8aveJn0yCrtQnDZhqvJwq6uWUK94GINlk/X9FjcnXe6RjB2JeL3pIaPdYxNmVKVo45kX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=GQHwGfBS; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="GQHwGfBS"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 3FD0A164AA0
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 15:22:37 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id E776712635B
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 15:22:36 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v6 3/7] qmi: Added device options parameter to 'qmi_qmux_device_new'.
Date: Wed, 19 Mar 2025 12:22:30 -0700
Message-ID: <c91173c6116b14dc0a57c28dfb8362f8f8088c68.1742411889.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=BzRC/MPEuWrn1WIK740cPG2Pr1K+5r5gWLIEtdkDGqY=; b=GQHwGfBS3RvCfrO46cFYJGeI8dkrKSIUt+k0eKM8iztSKIVsF9jHadwPPGCVU2z8wnp6jb70s8Znw03TxSq29acVpjdXoboKrDKtI1W7SziwNbU9e6+SWd7+meF+h0PS6ssvwDPTVrBm8GJJIdyuekknj4gxEwxj8lYMfbxStDl8WtDgeY6/AnfunwE4KMqZJQW3mS4FTWwCyW14FoMkJcgiLFc667SkEmEifG/Q30wVUHnW4FgvJU80v8Fb6TzqZmqwvB2VMQEI2uwOrsok/5TqBjN3glM+m2XhFBkFu+dlHZSr3FByU+5XtWfUhZUdTAEi2OQto23LTOUisUA0iA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

An optional pointer to immutable device options that may alter the
default behavior of the QMI driver for the instantiated device.
---
 drivers/qmimodem/qmi.c | 3 ++-
 drivers/qmimodem/qmi.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 10dbdaac8bf6..bbe6440abe0f 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1567,7 +1567,8 @@ static const struct qmi_transport_ops qmux_ops = {
 	.write = qmi_qmux_device_write,
 };
 
-struct qmi_qmux_device *qmi_qmux_device_new(const char *device)
+struct qmi_qmux_device *qmi_qmux_device_new(const char *device,
+	const struct qmi_qmux_device_options *options)
 {
 	struct qmi_qmux_device *qmux;
 	int fd;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 4ba27847176f..09b551d74823 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -107,7 +107,8 @@ typedef void (*qmi_qrtr_node_lookup_done_func_t)(void *);
 
 typedef void (*qmi_service_result_func_t)(struct qmi_result *, void *);
 
-struct qmi_qmux_device *qmi_qmux_device_new(const char *device);
+struct qmi_qmux_device *qmi_qmux_device_new(const char *device,
+				const struct qmi_qmux_device_options *options);
 void qmi_qmux_device_free(struct qmi_qmux_device *qmux);
 void qmi_qmux_device_set_debug(struct qmi_qmux_device *qmux,
 				qmi_debug_func_t func, void *user_data);
-- 
2.45.0

