Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7F62690CA
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553767; cv=none; b=bGZZQnVB2yK/Yxi6ZT4WMXlsIv4Zg6vWEcM+OFxJNXqBk7UCcNNAxl/OZ+/0lvY6YYhjTO4iew6iBoWDVnYmsqysO82hWFFCeb2iDKvW4bV9vqPlJORc1oSijjIAUKwkJYuGzK/G3NKgKADm7ThNyH7QpWsgsuFwG1AG7NXuLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553767; c=relaxed/simple;
	bh=BOjh6BbY3gmEz2aVzixjVsKqCAX013D8zE0gTMLRqds=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgNyyAnSIosdADQF7k+Z89P/9btKpY7CYpMiY9zjNq3AeUEkX18DC8xnZZsv91u/rqTeVrNdY7/eGM30d2/KuPawc4iWquQNII2kWw/MijwP4hTUV2WrXHFwU9j2+/udyoWh5NQLLnsNCSwcI2Czj0NZffhG8GdVVUOsiQqPxpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=DKR/btta; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="DKR/btta"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 27DAA164A8D
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 12:22:44 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id D3504124F0D
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 12:22:43 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v4 3/7] qmi: Added device options parameter to 'qmi_qmux_device_new'.
Date: Fri, 14 Feb 2025 09:22:37 -0800
Message-ID: <0e9adb66276124d2bebf2f54c6138959dc8068fa.1739553712.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=BzRC/MPEuWrn1WIK740cPG2Pr1K+5r5gWLIEtdkDGqY=; b=DKR/bttadtEYOdNOXssUNmzAuIvQNRXrwVarl83LpJfWMBcwpQ4zJmYI9VIIjzFviZzLHk8vxbNg/mf63y5bgq1RbjqDtk31bJvy/8Gsm87vQJNhj5S26LKl0mg4DDuqnX6gPHZsR7lH+w7CB4PC0jlewy+6CZCu22uX5drESeXnlRxx0w5iNZKt/lwbf238xbSdVHaCSMAneOcl18D5xK1aaRjHjDyX1ADHPYDYdtF7v2dj2n0lwfEupM+Bz8ZCNfGyI2IQt4Zno0AxpPO4iKMKTBA0h0xaOTVJwzf57TIziAH11+15bOPEc4FZyqEwz3eBUGmF3+khFqs+oW3y2g==
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

