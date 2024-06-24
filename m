Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C547D1A01A1
	for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257606; cv=none; b=j9M+tjAtZPJ7kJL4P5oUU2TOUeBI+3zs5vvnyBhY2iILA4K9KGSYQscYw0SJmmcPJJNA2UfPlL4UWhCyjtT/DX/ekPWFlyPnTMOndzoscIeNrmAQKZLF7F4zP1JsClN0tcWMTnUkuwCk9wBXsTyiLi5YqyZ4jdLFPkjkNQFHJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257606; c=relaxed/simple;
	bh=N1uKVcD0uw4noIf+jmTYaK+rEmryhD2zpY7EGzkwxNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fx+StzP8vaboBi+iEGfhzM7jF+FT2rasyLgwu2gI4F0xhpM9Zvl+vX7UImBKWtP59RJBqm/Dv6tGeg45D7mzQmiPAwU0Kxflr4Y694NJ6KKpJqT2Z8vbfNA2B7RbXPE2Q56qgmx0fOVNM3cCIFC7LHq9RF9SKWqsz/5UaiaD2mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pvlef8tE; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pvlef8tE"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b970e90ab8so2708624eaf.3
        for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 12:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719257604; x=1719862404; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeT9+Ikd9VFzsN+KD509wRzZWwFtwP5snd+Dz/9Sh+8=;
        b=Pvlef8tEXfG4mAToPQOvIQnGOUNVuFcE0qWkwU+RUC2DEoNMHuhz/32++HhZxJ99OY
         +9C/bAwXy1q2HqGeiA+nHQmHewH+56t5TDxaxkzvrpZ7AvHfslPQvCkn8XSoa38vfp4H
         C/sOqUMcxN8XPFYnQQCX8DXEG+MOMTXjHeVkK5Z24rAvGdiMWen7pkFtOhWRiooek7tB
         OBKdm7UZC7iO3eDzYa8aTwOd1YhLApoWMXAAfNioBuBpDyEAHKstm1TSVBU0953e6z7d
         oQ6d8HXihEqdWwplpDQ900PW+LT0iJZKqphq/faPs8j0rwq/sC6iHUGdHmidS/6uYmrY
         xyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719257604; x=1719862404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeT9+Ikd9VFzsN+KD509wRzZWwFtwP5snd+Dz/9Sh+8=;
        b=Tp5f6tzAxxS3S+WjcRGLTKD2fOPuRliSZ2PZleazfQjiahh2WJ+5VzYPLq90HDj2F3
         XV1gPPhptmAMlg9vajMpiWdOiNflBxbEDscNs6cSUyjDxTja4CktRwtIulnQZdOVqrjT
         JIPPU+Dw9k+dc2Bhcn5Da4arQRoy4T8QDrUH5LLrql2KxCI0toyummdcw8We7m4V7zcw
         b1NtFX80JRJg+tXxuiIvw2F0+VAaRWF2HLeF9eE3Dq3cpPctGskn8DSEaSr1IoWOpYgo
         1YdmPU4f/a+HWy0yBWGK3/rzuwcLyTdjtVAH3cpr/bQCiKdTf2ZsBcqh0W/6A/1oH/De
         ZErQ==
X-Gm-Message-State: AOJu0YwhRu3vFAQx+7LHYR2rX2R/w0hApszPn02Ch9kkCVgDoX0qjuZN
	aE+WLKO0k8I+Yrd5Me5WhaLsISNp0Hdce3c23Jsl7KZy40FbyaNvFhx5KA==
X-Google-Smtp-Source: AGHT+IHkTBKbaN/f67GVDWnQW1nNqNxvIce6VoD1CXkEZvCaGZbvVy017tbQywv8K4cK2cjbHYDpVw==
X-Received: by 2002:a4a:8405:0:b0:5ba:e1aa:9346 with SMTP id 006d021491bc7-5c1eed10c0fmr5726037eaf.4.1719257603696;
        Mon, 24 Jun 2024 12:33:23 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d54c2d44sm1480831eaf.8.2024.06.24.12.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:33:23 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 08/13] gobi: Enable io debugging only if OFONO_QMI_IO_DEBUG is set
Date: Mon, 24 Jun 2024 14:32:51 -0500
Message-ID: <20240624193315.1164943-8-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240624193315.1164943-1-denkenz@gmail.com>
References: <20240624193315.1164943-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QMUX/QMI protocol details are now mostly stable to the point that
hexdumping what is being sent / received over the wire is just noise.
qmi_qmux_device now supports setting separate debug handlers for the
underlying object and the low-level IO.  If OFONO_QMI_DEBUG environment
variable is set, enable debugging for core QMUX/QMI implementation but
disable low-level IO debugging.  If IO debugging is desired, use the
OFONO_QMI_IO_DEBUG environment variable.
---
 plugins/gobi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index e25807753e20..88e4c7fc4887 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -89,7 +89,14 @@ static void gobi_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
 
-	ofono_info("%s%s", prefix, str);
+	ofono_debug("%s%s", prefix, str);
+}
+
+static void gobi_io_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	ofono_debug("%s%s", prefix, str);
 }
 
 /*
@@ -543,7 +550,11 @@ static int gobi_enable(struct ofono_modem *modem)
 		return -EIO;
 
 	if (getenv("OFONO_QMI_DEBUG"))
-		qmi_qmux_device_set_debug(data->device, gobi_debug, "QMI: ");
+		qmi_qmux_device_set_debug(data->device, gobi_debug, "");
+
+	if (getenv("OFONO_QMI_IO_DEBUG"))
+		qmi_qmux_device_set_io_debug(data->device,
+						gobi_io_debug, "QMI: ");
 
 	r = qmi_qmux_device_discover(data->device, discover_cb, modem, NULL);
 	if (!r)
-- 
2.45.0

