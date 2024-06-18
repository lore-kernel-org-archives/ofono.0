Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465E15E5C2
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740965; cv=none; b=Ipqy+gcs1wIM2E24By6rMDzWffEytXxICtRJoAarmMePW+n8gxkLdw9MNck4eFiQd5YkvlAhblvseTLmAjLrBO3K2ld/VTal9WN66/eFIn9ergBlrUu6ziiC0DlLISJT45MHCmUunyvl4oPQSQ+kvQVbYiccPKuzrIYfmpExGcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740965; c=relaxed/simple;
	bh=PUqciVf6SyF29ynkB5ohCCJxvD+yzNgmrz+ZPf4RSbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fw0CqgcL11BxT9w5ZbLqCoHurrCpY80XaUHJ/lzIOUOPalI1Yebt46nZ3qyutWdYsoEvbdRKVdA1v1fGiOk8ypC5/8tRSkf+fsRADlLorlXLFvTYidKbnEbmKBWTolpSfpz7nE9yN+A30eSFJHrFFWmKB+erwzbQ6QK060rbDn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuyezpTO; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuyezpTO"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25982aa59efso384595fac.3
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740963; x=1719345763; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anqT9mrgm63Yh56RVd+qcXTDOPv5O3/l9gYFo2LaGVE=;
        b=AuyezpTOOHd/ho+/tI3NRcQzGkQsBfGq21c/iSFvpeYcjFuX4VPwwdiegVNd+BZvOA
         V9PzN35sCgLDzKyh29UUlp18BW+4zwCIy+OoEb5hz/T6BMO2P7u3hDn97Ovpnw4Uh+Rg
         HvzF4AbWprJIRakbpJoqbyz4DiG0CRRHB+qOTPX/EvxE6w9/8D059GHO0d8PE4kdB8lq
         A5plWNkfjm4Qo0aK9ywftTJTbzgU8lTRibBXM4MAlOc7Uakq3F7NBEq3Js29gIg/UZf2
         t2yR7TUptsRa71JQbXxkeCDGT2mUtrPW9xnAA/ZnNcPDx2vJKlZiw58dKc88NmyBhpR8
         q4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740963; x=1719345763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anqT9mrgm63Yh56RVd+qcXTDOPv5O3/l9gYFo2LaGVE=;
        b=I5pxAQaGAFGagquq57x7NOnku5GNGW1rZ79PobEJzUIMP7WrhEj16DQVQSCxTfx6Ih
         iQgKIEee2d6XGl93YyAuG8ROmYuwX9RVL5HhCiXstc3xwwu6phL80yq9ZKZUh0LN/fJZ
         tyjqyBJi9+1rF5yc2/KO0sQEJiZLPZwDDRqsa81FqP1XzfMxkY+YDwpDeZHwqq8Nyt22
         0gsQWGq2LPt9qj50JIkSOM84cbbvKouoNpqv0vwX2UNkE//lXongWhwkgox/Uk/Iaofu
         hNUja0/G9HFr6Jnjjya/OalrszwtQSVZ5LzvYNhYpvxkljPvK1X45wo1d0O/bLAajvyd
         rIhw==
X-Gm-Message-State: AOJu0YyPj1yI/bV5rUbWdv129wUvCJR0IYmtaekxBkNZ8wf2dz2lqXMf
	qbEPf0Fxr4T16IHb+LV/M4Q2vMKnJIegPul8MfDPDRP+4si4bWXX3YOh6A==
X-Google-Smtp-Source: AGHT+IELhTyF8vOkGHukTFUGjqRcqPvA6kfghFvWHwdRrKROHt8121o69P4qtLfMbJrqODoMI8vqRw==
X-Received: by 2002:a05:6870:1608:b0:254:b781:2f71 with SMTP id 586e51a60fabf-25c94d7349cmr904056fac.57.1718740960768;
        Tue, 18 Jun 2024 13:02:40 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:40 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 11/33] qmi: Rename qmi_device_new_qrtr to qmi_qrtr_node_new
Date: Tue, 18 Jun 2024 15:01:53 -0500
Message-ID: <20240618200231.1129282-11-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240618200231.1129282-1-denkenz@gmail.com>
References: <20240618200231.1129282-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This better reflects the terminology used on the QRTR bus.  A 'node'
parameter is introduced.  It is currently unused, but in the future will
be used to specify which node is being addressed by the created object.
---
 drivers/qmimodem/qmi.c   | 2 +-
 drivers/qmimodem/qmi.h   | 2 +-
 plugins/qrtrqmi.c        | 2 +-
 unit/test-qmimodem-qmi.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index c3b1f7fef64f..a845e3809090 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2310,7 +2310,7 @@ static const struct qmi_device_ops qrtr_ops = {
 	.destroy = qmi_device_qrtr_destroy,
 };
 
-struct qmi_device *qmi_device_new_qrtr(void)
+struct qmi_device *qmi_qrtr_node_new(uint32_t node)
 {
 	struct qmi_device_qrtr *qrtr;
 	int fd;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 604e4e7e8659..10202fba6128 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -88,8 +88,8 @@ bool qmi_device_set_expected_data_format(struct qmi_device *device,
 			enum qmi_device_expected_data_format format);
 
 struct qmi_device *qmi_device_new_qmux(const char *device);
-struct qmi_device *qmi_device_new_qrtr(void);
 
+struct qmi_device *qmi_qrtr_node_new(uint32_t node);
 struct qmi_service *qmi_qrtr_node_get_service(struct qmi_device *device,
 						uint32_t type);
 
diff --git a/plugins/qrtrqmi.c b/plugins/qrtrqmi.c
index f75742f98508..adf6625e2824 100644
--- a/plugins/qrtrqmi.c
+++ b/plugins/qrtrqmi.c
@@ -208,7 +208,7 @@ static int qrtrqmi_enable(struct ofono_modem *modem)
 
 	DBG("%p", modem);
 
-	data->node = qmi_device_new_qrtr();
+	data->node = qmi_qrtr_node_new(0);
 	if (!data->node)
 		return -EIO;
 
diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index 07560aadcc49..0fedd9803bb5 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -153,7 +153,7 @@ static struct test_info *test_setup(void)
 
 	info = l_new(struct test_info, 1);
 	setup_test_qrtr_services(info);
-	info->node = qmi_device_new_qrtr();
+	info->node = qmi_qrtr_node_new(0);
 	assert(info->node);
 
 	/* Enable ofono logging */
-- 
2.45.0

