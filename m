Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8DF2686B3
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553770; cv=none; b=fMa62uMgas2cmiSk9sFwv+qpe+rVRsQjxKPlQlCtN1YHcSses5x55vYBnlgeUalZsohEtc6orj88552ITZo+rgdpkr6HHDkDWhB39f4mbR0aogrYqIat1pRGjjEkS+Cop9r1Y3dyp/94nFtJ4jm0Y+vhLWZsMg0xKBGW3eiXvuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553770; c=relaxed/simple;
	bh=6ZOCUwTNZTyfyFNvdruZ4bNsiD0meoa93gVPTJuiIy4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCuGcQltCxGmoHcrkAyAVs3broogyGfhI07jSfK/zpSjM6hSNyVYooapEXTkM6svfCuMJ08j1/Q+MoQHnt5autClVSnnfIs8C0/1oz5RTQHeJ9YCVMwfI0NJNJgjGB9Mfy84wQjaU3yxUYwX/H6pmKhOZKXRLzNEc4tiKd8brPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Uq4rHN3a; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Uq4rHN3a"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 0E9A6164A90
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 12:22:45 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id BAAC3124F0D
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 12:22:44 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v4 5/7] qmi: Handle request rate limit option in 'qmi_qmux_device_new'.
Date: Fri, 14 Feb 2025 09:22:39 -0800
Message-ID: <2e5a4d1a9a6bf9aa8651367f3e2da92bb86a5407.1739553712.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=EAKTIc2jXJq4PegzPeVRjAHo1DNrrRyLjOE3VGG1yQQ=; b=Uq4rHN3amFcbIMoXlSyqBdY8R103SsYHi3NNdUm3N8MXrq7CK01Bv0hfrhASzwATnAkp72XoumWh/ySI3ZQqlBse7Sar45FR3jWrEFExpdpIiDtJmCV4OJop90RP8eg1tJsozBX1CaRCNJyM1DqJHp0fJMH9WOdQ/nfnwRaHE1vPsXLO2NAx1PQflWOV918jYrEW20nQFJ+BtiXMu/1BkmSG0BBPlFpzqB2JvPhmuIfUEgf3XWXpsgY8JI0VYtacYun7Hfei5tDfHTc5ZqXnCRgqcmQFpn2ryOjVOe3/I9432NR050EQ1MnyJ3SNk2zY93AaByhYI7CuNWcEYwkRkg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

If options are specified and QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT is
asserted, set the qmux transport minimum service request period from
the specified options.
---
 drivers/qmimodem/qmi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 7b20dc3f85dd..b50076b08a0c 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1614,6 +1614,16 @@ struct qmi_qmux_device *qmi_qmux_device_new(const char *device,
 
 	qmux = l_new(struct qmi_qmux_device, 1);
 
+	if (options != NULL) {
+		if ((options->quirks & QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT)
+			== QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT) {
+			qmux->transport.min_req_period_us = options->min_req_period_us;
+
+			ofono_info("QMI minimum service request period %u us",
+				qmux->transport.min_req_period_us);
+		}
+	}
+
 	if (qmi_transport_open(&qmux->transport, fd, &qmux_ops) < 0) {
 		close(fd);
 		l_free(qmux);
-- 
2.45.0

