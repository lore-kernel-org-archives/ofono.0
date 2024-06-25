Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937CA17334B
	for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333730; cv=none; b=dmIZRYZSLULny3P7PtSAz23Dc+Tz4lfr2Q32I0XWhfn0IfM5DHooW/cRT8eF7SvcfBOzIUQiCXbz+kgA7EB5lyS5EhH1IjodtoO2HlJSj+snusTn1F+pWRKYxR7OH8KV1/UotoNw8qurBjc5GRGi9n+9OC/+lhpaqdin4O/na1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333730; c=relaxed/simple;
	bh=N1uKVcD0uw4noIf+jmTYaK+rEmryhD2zpY7EGzkwxNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/lxmaKQpVLc0YCUbL+7PyujI8x7gCv4alWOTiEeo6K3G96shUIoLXEBjqNiNRhBnMIl9dcWFak7I1LUXKUzBdqVYRqKm4SNyxdUI8yks2kGuFB4bLV80LnTxWPYEVN7XSiwWyQkT/70WqBrmCmaeYD1VVzcsJhf5UDaMr5zx9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7gcwhhX; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7gcwhhX"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f96445cfaeso3184791a34.2
        for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 09:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719333728; x=1719938528; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeT9+Ikd9VFzsN+KD509wRzZWwFtwP5snd+Dz/9Sh+8=;
        b=B7gcwhhX0qNmlFE4D3MPCs7pCZtAglNVBsMzeJFZ3W/45JOFcKVoApityXVqI8vDXA
         0Z+9yulMtDWlqQ/GV0bQvAhI1uSo2lJh80p4318QFkJ24RyHuoSwXxTM5KUD/E99f/Ze
         DlTwdTILDYLgksf9kqLoukojUXoZDayIGtX6m1gIfWZNJpRnOiyGmM7QWcrS9Jl/cqln
         UiSBWQP7d0b1nn5SaOa17H4xFIF1oqDuiVix5Y69FzOJRv0WenkI2V3JVnQg/IxM4AZ+
         LpdOOu5aTYcJlYnUZCxBZ44JtgQOhg1f4iVhjnVJb25caNeIyXnVj602OSFkJnFoGUVK
         5s5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333728; x=1719938528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeT9+Ikd9VFzsN+KD509wRzZWwFtwP5snd+Dz/9Sh+8=;
        b=cB0FEDv+dH9XiigdSLQAhg6WjneRXH5DMkT+U3W+YmaKcIM3Dq6XX9MxS3XwI+Wze7
         JwQ7Z2Gi6Kova1zRrNVEvtBWqi2HHeeHOaHUzow1c76CNMl7Ei0jrZeiOb5rxjrgOLE1
         6aGT0iUPkDyD2gSV6emhK9tvmOaj5hFFLJY69sIOx59W3SkNs1VlBLPPm5Zo6naQ8SBL
         DMX+uOwQDT5gdswZB6HSfVg4C/bqZqIPMW0erzG8ZuE6lFVed1PjAXYKHPhSoaSsc9wU
         WEDtX7YkmY8DBQW4qSe3gFVc4917ldkI9/ot/XVgNF91yo7YH/c3zIecTQxvt+TA+Rfh
         HnFw==
X-Gm-Message-State: AOJu0Yz335hF/8s0H7DPb0BNu10g6xQt9wVbUHMBxKNHzeiavcbSc/bB
	dEx9MHeoOuCWwXGgzpbEt24nF4c9bSfFjZjs0KPE8arKhRbRhhCEt/yIDQ==
X-Google-Smtp-Source: AGHT+IFsvQ5ZAtD9Rt7vbX+qkDbyWJ8/0Wri9b9cGBtABVl5ZDX+n5DM5maiDUJ1VCPkxFeAkO9wXg==
X-Received: by 2002:a05:6830:1da6:b0:6f9:6518:27d9 with SMTP id 46e09a7af769-700b11c2d15mr8754645a34.3.1719333728546;
        Tue, 25 Jun 2024 09:42:08 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d55dc2dcsm1884844eaf.27.2024.06.25.09.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:42:08 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 08/14] gobi: Enable io debugging only if OFONO_QMI_IO_DEBUG is set
Date: Tue, 25 Jun 2024 11:41:44 -0500
Message-ID: <20240625164158.1170937-8-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240625164158.1170937-1-denkenz@gmail.com>
References: <20240625164158.1170937-1-denkenz@gmail.com>
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

