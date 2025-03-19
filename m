Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B66020E704
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412625; cv=none; b=D1KotpzssWztthLlDjfYgpDiWLBkSuIWpEZTbFiJqVPALd2MJn4ch1yHsvJj/DH8q8YI6DVZ3gAbrKwa2u1shBeyNHdH2bZSTrs726dQxbOJhWB1IJHibYjPYhG3pn7MKhBAZMSOblL6u2CFUaUywLYM3UMS43C7tbhC3t9AhL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412625; c=relaxed/simple;
	bh=M5Yt+XgkEhwDsBif7PeTj7L8IDaWFyPdeokkm14HJmE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFHGEOZPWHv/PwlpGaa8+psi92VaxJulS8GMZXdVPIRI1CthYwa3hEgFYOERGZ/AA6lzVuFcen9+gYKpg2wD/lpT9NDTzaggTFEsb3Ufl70DSSBDndHnYvQ2q80GUPHNy37ITyqzlkhWErdC2klQgQ6P+GwHxCfLfwRhHTUkFbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=NxHe8Laz; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="NxHe8Laz"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id C4851164A9A
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 15:22:36 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 7C8AA1262BA
	for <ofono@lists.linux.dev>; Wed, 19 Mar 2025 15:22:36 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH v6 2/7] qmi: Added structure for device options.
Date: Wed, 19 Mar 2025 12:22:29 -0700
Message-ID: <c9277d0d9b73576a232e3df4be9e4ced7bc06244.1742411889.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=fHma6eg08g0rSRzjb2Szp8dq8ebKa/ez0Aq5JPdNAGU=; b=NxHe8LazRyG8cdHDgHgN95FGUAo2ZeDTBSCIjLzv+kL/6dv1/vOGNfdNG+swExIx0D1ahX/qEme0rHIjrOSdaOqSAXPgpkguPho6jj+dIXajY4CBHgPlupqR5dthaiNuEotsAc7QuUVSnXxBnkXMNIaVgiVgH1DIAfOp+pdhXYvOJLhHlvljeXR/1vYzYJVF/zeboN1zH7ALabnMlugsSKd0oqBZOVhjz5m33ysEmayeEBCofLkR7R6jG5dmaOljBtbM+j1ql8THqHXE+2jIykHGs2WpLXmsDA7G2LJgPDBaTNpm4oTc5f8baOZGDi10xtlYcGz9r3KzISVXgIILrQ==
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

