Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D64716DC1B
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740965; cv=none; b=ANK0GpdcO1ViASER+0qgHAOQO0wl1AB/u1Z5ou5jXNf2rRCYHqPixYQ7oZ89JeT2cwsD5QArB0gNNm4HNXR/W6yGbGE1+xilx8gmNYm3uUNw6ARSZb0uldtvk+RSU8cJRTc7fb2iPW/OrJ+PubxiX18RY0yHw+GufjkfCM+DV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740965; c=relaxed/simple;
	bh=ckvNClCkY8uqwNMkaBkcQ/Dv+40u6hUo0a6BgUt+mCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6heomTgBlYWAqnG2Ex8Cl6ezbr6r4aFd4Aj236lwjuuz/O0qkMRajCzelTOXSjx3XKZVW9kMQJkkOWjuNwJAw/0d+wVWZKNYadPmuF5Q8kngAzWYuDcz+xmKFCa0L+1xwlMnZDcdOntahrcAeLoq6T9C/WUGdVRVMo8TvU198M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/OS2Q6o; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/OS2Q6o"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2598f517a33so378221fac.1
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740963; x=1719345763; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0LW8jWwDVbJfyz4Pq2lQKVb+OW0QTh8Ef+fpjZXzDw=;
        b=I/OS2Q6o91QjGP0iAMyBtvmfDbvv4AZgj7qjtTN3+1RvEFkAraoU6S1Ebl3RSQZx9m
         Fz5CFhMyELOOEWjkKVc0EQGGehvTtas+c3RKjIAiVelDcbq7lFutohx2F5y/HedD0jQW
         nDDO8W5haIC2ARaxm91QfHzPAB3bBfK2g6Lw0nYdlTLQLdU6UdiTXdzLkMuU1/TBZ8e/
         +/ORS3l8gBT3vMg2uAqXkt6uTRaDvOFDnGOfmaVCj62RWWhhQA/5tvqixdoR0hlh+uCt
         L3Dm+6x060mE5vYjsxYIDruKSVYKIVcdpQMQEu9T31D6zUPA81XdWcqHQaWEpAbnR7lo
         ZDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740963; x=1719345763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0LW8jWwDVbJfyz4Pq2lQKVb+OW0QTh8Ef+fpjZXzDw=;
        b=QDakuEB3FdTnPfmE8XMU9Lk+vkVQvnloltkNwYroKCVoizqOkWdhJtz5850lQ3NYBp
         O3rG0Sqo65idlcDl4onadkR2QlbWUcIedh6l4cfWzU3plW97EQpk6+jewSL9h7axTEO9
         SEitHAP2p4P2+TfrbJ7/KclhNKiutjQPhtH/JO9rIlEONj9fjdTGg4/un98HatdN4xwd
         lj3Fa5+m7IgSA8mgMiSXLHUoc30PfRP2tx5CMQ1MFvCvPPs0odMoltbGJabgt9YqjM4h
         JM1xfx5MEoGl1wKmPI03IpR7lUtEXuLsEb/Q6joKz3is5iGbvznMA5zcqrorKt13mURr
         GhAg==
X-Gm-Message-State: AOJu0YyL/lMZicWZ8DZ+VpVwXskO6m2uPP6YAxSHE30KBlfe9AnYwX7G
	4lvDTKWDx1IyCxuTx3VUahm3SuJa2oCp18UZEQWUBt4PEcyWRDOEIpoieg==
X-Google-Smtp-Source: AGHT+IEZ2NX00qxuM7rUAYGf+FVDQqvScxNTd0+EPh1sJ6vx7w0+q7R5mpduusxPqok1YRSWV6h5Yg==
X-Received: by 2002:a05:6870:a11e:b0:254:a3b9:9756 with SMTP id 586e51a60fabf-25c94a212e1mr925387fac.32.1718740963399;
        Tue, 18 Jun 2024 13:02:43 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:43 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 12/33] qmi: Rename qmi_device_new_qmux to qmi_qmux_device_new
Date: Tue, 18 Jun 2024 15:01:54 -0500
Message-ID: <20240618200231.1129282-12-denkenz@gmail.com>
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

---
 drivers/qmimodem/qmi.c | 2 +-
 drivers/qmimodem/qmi.h | 3 +--
 plugins/gobi.c         | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index a845e3809090..9fdc209edf7c 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1991,7 +1991,7 @@ static const struct qmi_device_ops qmux_ops = {
 	.destroy = qmi_device_qmux_destroy,
 };
 
-struct qmi_device *qmi_device_new_qmux(const char *device)
+struct qmi_device *qmi_qmux_device_new(const char *device)
 {
 	struct qmi_device_qmux *qmux;
 	int fd;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 10202fba6128..966d4f354d6e 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -68,6 +68,7 @@ typedef void (*qmi_discover_func_t)(void *user_data);
 
 typedef void (*qmi_service_result_func_t)(struct qmi_result *, void *);
 
+struct qmi_device *qmi_qmux_device_new(const char *device);
 void qmi_device_free(struct qmi_device *device);
 
 void qmi_device_set_debug(struct qmi_device *device,
@@ -87,8 +88,6 @@ enum qmi_device_expected_data_format qmi_device_get_expected_data_format(
 bool qmi_device_set_expected_data_format(struct qmi_device *device,
 			enum qmi_device_expected_data_format format);
 
-struct qmi_device *qmi_device_new_qmux(const char *device);
-
 struct qmi_device *qmi_qrtr_node_new(uint32_t node);
 struct qmi_service *qmi_qrtr_node_get_service(struct qmi_device *device,
 						uint32_t type);
diff --git a/plugins/gobi.c b/plugins/gobi.c
index d1da5fbc366b..5463a46edecb 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -501,7 +501,7 @@ static int gobi_enable(struct ofono_modem *modem)
 	if (!device)
 		return -EINVAL;
 
-	data->device = qmi_device_new_qmux(device);
+	data->device = qmi_qmux_device_new(device);
 	if (!data->device)
 		return -EIO;
 
-- 
2.45.0

