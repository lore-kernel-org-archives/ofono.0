Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD91A01C8
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391193; cv=none; b=m5hy81JRKY33UqYpf1ExFDZMLTSlLx+vipKVNvJMnzqExt1iH8TEpuKZHK995Ge4HZnx+qSfN8uGSOfRWV/OAhWBaRSf9Eb838ujgW46oBIpnmQFBcTv4XBOj9NAE181JJ8wLXs2LGfnZ3JJAHHZ7DlgVmLr/NCEW9zg01wzpt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391193; c=relaxed/simple;
	bh=CnaUHbd+gHYm6psoDf5u7ar4m1Serw4kpQI5Z7uweg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bchqa4nFGHPRg8cNd61axEDCuH6GhoESFJ2BGJRCTF6ghNTqFUAGdpMWgvjh+U0nYT5EOtqsmedxlIyyURRzhVe7DhW8YgdV+3szNxcFJt+Fvg0XmXq8FWZKZ6Rg9gfWivlgKGJHagLOgZrBewQiJJh2NGxqh1RXOqb+jqXcnA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2GsPQHy; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2GsPQHy"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25837a78858so974513fac.2
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391190; x=1718995990; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLpspu/j8y9gKGIWMaeZiP8O4CXBeT4ATAY1Sfxgiok=;
        b=P2GsPQHy2oIF4qMHJ35r+Z3Iak8yn497kCW028wpANTHCuf01ULGXRXi/QaKpoe6eM
         6lvKG4eCYZaN6YxiVPLBuXOSXhSD4UFPonXkhmj5avKfSL8TnSlLetNzxZNaPvsv+dUg
         ljbKpqm4yopd6XAFJHF+bOp2xBvH4g4RXK/ZU7qpAa9O1pdsKOHwZ2JCjpDjzUlfm5cn
         /q+TpfKtM1fqTR90Dh54AE54irxIwNX/2GFG1RY3RGaNw5B9UrCZmWqMKMWtx/dOWHp7
         yjczYq6bP0Tom5pJa+kwWLjOQB3oizN4+tDjAIcEsgmJuREpBjqD44RJKIQuHQbSaElo
         vUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391190; x=1718995990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLpspu/j8y9gKGIWMaeZiP8O4CXBeT4ATAY1Sfxgiok=;
        b=FVjIH6Y8hGtfEMk91GMGy5g1rdkQrme4tVaTqu57GTMwGlbCjvBO/jAaZ7yLiXlk/a
         GlxEwzc09QWr0QyInNoZhQjygRiAajdjLoT05nwr+r6QqVE0Sqo4vcCO7NLKwPT+yZbF
         lIdXh2x1kEi1RLUWGmc31KDjJbXacfpLjOodtD6SPRjoEZ6W7+EL50VqLm44QUbQ3WKQ
         UhCgQRSvLKspBvEm49ib0ZCMwvd3SG7w8ut/wHzRnXQCdAVlhoUXSG0sA726mP/sXNd+
         0erIgcsmIm4aQQ5P+nP5eV+kfmAh13m+urOrfEaWSkaOnkp1htitJZk8gah3nfRa5xvC
         cyKQ==
X-Gm-Message-State: AOJu0YzQuv26vvpmCCcgWvsykExVvKFmsI3bOHiZS3swlCz4pyxGg05w
	NA/x7abHy4MnHNQPdFtbEXzZprVD1S98ZPCgsJdZQO5ExBMkmZTnR2b3HA==
X-Google-Smtp-Source: AGHT+IG4DH+p81Wo4xh/91HuU6lrIzVsqu/KUyy/9E2r6cVeVrQWMNYSPAWf0Ut49ReOFpF+gadUmg==
X-Received: by 2002:a05:6870:5e4b:b0:254:b455:2bf6 with SMTP id 586e51a60fabf-25842b83883mr3578164fac.53.1718391190562;
        Fri, 14 Jun 2024 11:53:10 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:10 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 10/27] qmi: Rename qmi_device_new_qrtr to qmi_qrtr_node_new
Date: Fri, 14 Jun 2024 13:52:22 -0500
Message-ID: <20240614185300.1086701-10-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614185300.1086701-1-denkenz@gmail.com>
References: <20240614185300.1086701-1-denkenz@gmail.com>
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
index 9ea87ba67c9d..1c503c2d6cde 100644
--- a/plugins/qrtrqmi.c
+++ b/plugins/qrtrqmi.c
@@ -206,7 +206,7 @@ static int qrtrqmi_enable(struct ofono_modem *modem)
 
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

