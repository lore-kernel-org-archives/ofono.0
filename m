Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24368C07
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391190; cv=none; b=JJLfUaYYXatLe00BVBmhRgR5OoLcJAjR50DstLT94+Y0HwIG4Nz+HWSidYg6UxhihKn93QODe4iFk6eWctRcDRkkG6rmdFm9Csfud91GdIWivTLx9daDztfDymUUgKSX1biX9ArphuP/Z+dE+996msOsqWQLNlM1jEGCis+JftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391190; c=relaxed/simple;
	bh=/bJIVDzUX2e5StEymqjn7ZCFKph0WNy6h/8JY7C7LB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlnAoj6EGBL/F9ANEDSqO9lJdMLcbb5hByo/aKR8nhOtguiEGA/ZYfoJfOKk+9mIWwwd/yh6DAKid8n8T+F/Zh2pnsckHi82wjXi8J8V4bLybnq9a0o0lxFC4cwifXqwE3824uXP9LILmks9BSOZ7LYE5/hjPhy6hgHxuitWXHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9n8+hT9; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9n8+hT9"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-254a2d8485eso1132102fac.0
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391188; x=1718995988; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eh4nL2Xqu/H5NtYMM7qVpf7I932OuBKzjLpQY+cEmLY=;
        b=e9n8+hT9nQvdrLnpGHuxAKH9Arb2P8mXaEORHVAIKdA+mniusQqVXoABuuUHpjouLW
         IYd76aLv4aM8U6/FXMCz2P2bLm8xa8XazJtZKY83ONV1MIWMg672NQ47ZhaltDfaWrMh
         /n2ie0YULVMTTknJBErtl7hPEMA51/5rtKviJeqEKNLQizN81O1is6Wq5qSXtAzouymr
         AktcQpUKqtAGVPheLlHM5uyVkJE1i7sHspMJsM7pTpks9NmxNlUynM8CaR+GmaRPwu0n
         ws+/3iHjIrzPvFpcvwXAa7yf3g8WY6tc7QI6vC2WplFK7X+DZWoJ6PtVo/crbUkt9E3W
         JAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391188; x=1718995988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eh4nL2Xqu/H5NtYMM7qVpf7I932OuBKzjLpQY+cEmLY=;
        b=uYKwH6rIqIgP10R2R4+gAxVLwIkLfGPfMP2XIMUKJO2Frup0GyQQC4GGX7MTMsUJ2Q
         VvqOVQuAaA2JbPzta1UPgAA1v4VRzDA7yC7p1fMW+YsYnfmjJTZ26295agIo4KHR19x0
         YSb3iRy5Y/r/RtzYMXWtws3zipozYHAafaCOvwATNtgTUXiUiz9YWCsQs3c2i8unW6Fj
         gBSj4jvjEnzNH55bqZwpiNZDrY2Xu1/U6nvvvEmQqq5oq7OL4kf0L0DFtlDkUmlVlmOq
         jxBfemn5oryh/vNQsd4BU22Z5e9wKutjaWbkK3n3s6vJKD7dEa2LqdJLsWfWFXCrnGkC
         iUdw==
X-Gm-Message-State: AOJu0Yxqp+7KcpxEhMVutBz6Avv7D4u+yzyuZbAXQGb0+kLImQzxS1Ho
	agen0i1ubvio4cbgsnwYV/sQgkQh9g+xz7FIy/BDh0UcM8IntF7PohOVQA==
X-Google-Smtp-Source: AGHT+IHD1bB6nLIykTakQpfHg4qj5ut6/EwmcQj1QQYgq7Lrdgxae75+Xita4QYp/AuTX8ZzkTbP0w==
X-Received: by 2002:a05:6871:3a06:b0:258:365d:b964 with SMTP id 586e51a60fabf-2584287edf4mr3854899fac.11.1718391187693;
        Fri, 14 Jun 2024 11:53:07 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:07 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 06/27] udevng: Use new qrtrqmi driver for MHI and SoC modems
Date: Fri, 14 Jun 2024 13:52:18 -0500
Message-ID: <20240614185300.1086701-6-denkenz@gmail.com>
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

The new qrtrqmi driver only supports QRTR based devices, so drop the use
of DeviceProtocol modem attribute.
---
 plugins/udevng.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 0b3b9686166b..5ef0bc253562 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -278,8 +278,7 @@ static int setup_qmi_qrtr(struct modem_info *modem,
 		return -ENOTSUP;
 	}
 
-	ofono_modem_set_driver(modem->modem, "gobi");
-	ofono_modem_set_string(modem->modem, "DeviceProtocol", "qrtr");
+	ofono_modem_set_driver(modem->modem, "qrtrqmi");
 
 	return setup_qmi_netdev(modem, net);
 }
@@ -309,7 +308,7 @@ static gboolean setup_gobi_qrtr_premux(struct modem_info *modem,
 	return TRUE;
 }
 
-static gboolean setup_gobi_qrtr(struct modem_info *modem)
+static gboolean setup_qrtrsoc(struct modem_info *modem)
 {
 	const struct device_info *ipa_info = NULL;
 	int premux_count = 0;
@@ -1798,7 +1797,7 @@ static struct {
 	{ "wavecom",	setup_wavecom		},
 	{ "tc65",	setup_tc65		},
 	{ "ehs6",	setup_ehs6		},
-	{ "gobiqrtr",	setup_gobi_qrtr		},
+	{ "qrtrsoc",	setup_qrtrsoc		},
 	{ "mhi",	setup_mhi		},
 	{ }
 };
@@ -2487,7 +2486,7 @@ static void check_net_device(struct udev_device *device)
 
 	/* Collect all rmnet devices with this iflink under a common path. */
 	sprintf(path, "/embedded/qrtr/%s", iflink);
-	add_device(path, NULL, "gobiqrtr", NULL, NULL, MODEM_TYPE_EMBEDDED,
+	add_device(path, NULL, "qrtrsoc", NULL, NULL, MODEM_TYPE_EMBEDDED,
 							device, "qrtr");
 }
 
-- 
2.45.0

