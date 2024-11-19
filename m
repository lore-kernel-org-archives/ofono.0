Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A1153598
	for <ofono@lists.linux.dev>; Tue, 19 Nov 2024 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036721; cv=none; b=VmYELUqySriMZt2n0c20a9/AzNKgW+OrnHDIBeJOXwROorDP6gN1yExb551Om7n3wEHbX9K9Mruj2bhJfNNCYpKkcfu658nU2Blzlv/aiSB3QxK1uyN2c94OKKfRPtfMUMkr3kLrf4qDivBRphgcIxxczlWxOAEpZpFmBuiA0GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036721; c=relaxed/simple;
	bh=zap4gEhh3pHftT4lAgiaK7lcfE6I3TfbT7rHvr+E0mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdVGaBT9dWLurEXsJG6HwVnEOlIOTRVhgf9IAZsugvJRMwfS7Ac5wk/7IFUBxDAw+/Xen+WBVim4dH2ddxTIuUGnhY+fkCECjad9o5t5//gue3oG7Hi5To2kJcKIrWn1ICstrq3Fe0XPkjfHXzT87V8V8x151y52f0uDnENPAuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQOCpEBm; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQOCpEBm"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2968322f5feso1129509fac.0
        for <ofono@lists.linux.dev>; Tue, 19 Nov 2024 09:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732036718; x=1732641518; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLjL2Vq7WRnQajfwKZlproHWYslJYQ4LqE5SYyHey78=;
        b=VQOCpEBm1z/+U8qCBvvn5a0PG5cCz6cGJKTixbkfd5Z0KsUHNlcDXeYz442A9rOd5N
         EymHtTSWsEXDKnqHJjpp/iWL1iuPpAPnWJCf4Z0sqDdEbX5cCmwtHnNPGXDPn/wgWkX3
         fB0Dxcq1Q87BGlWyERAZ/EtzY3/E2OgAhuHgUzfz96GJTPHBZUFIOMbRkr1gQxwLhWEa
         sUjg+rPMp8j8rndCjFu7xHiGMx9Ke/2JfEAhbcn59XomTPxDM4Xjg3QgayGmAlRrCfXk
         +3P6Dv6SK8V2hNRZEAmp/W20UHQE2RnnecEJlgs3BfDV2/5u0WQ78ZJ13P3klVQYQ/ST
         uoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036718; x=1732641518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLjL2Vq7WRnQajfwKZlproHWYslJYQ4LqE5SYyHey78=;
        b=vgmDXSnIAQKC+kl+sy5fPxohpLZQlbGd1iSqchsyyeurJ96zh/ATdJnoSghAyYV0Wd
         5Qbdbg1XwnpDEox3jbWF/0wftJxH+zaS5kdZJb7SqJqbx3hrb4ZRrznJKwSFQSbRAY4s
         BohujVAg2HPbTZeEmSVB5/7KPpZP7FSMldfbh0OWPQ72sbPiWEYIBPzFDPUYK1F9GmN1
         F5JYLqNd2wtDxk/EGkdCrJw0+ECVhd8J/cZzfQyo/ZR3ZjZpPNpvQwqU+tio4tcLm4Qf
         4kcgAg5iTC0lq6Bpu5rZ80XTYB0JwhOOXXhrVn6tHn5PxHy5i61t/dVXN44xn1yliCgH
         Sf5w==
X-Gm-Message-State: AOJu0YxWpziQX5MIMswf4mOvU8lgFVsZo3Fa82oveCHrxEKhkXQkpsyC
	FoOw9Xf25ur8ZyL7WR3VcdpRaFX/FkHwfUrIv09Yl47UWUSUJug8mfvY2Q==
X-Google-Smtp-Source: AGHT+IGrNIZ8aIVMNemGT811n2y3m+oS83d/kKus9liC24p+OiEu9YrScX15mg/oq+9DK7yHX85HZQ==
X-Received: by 2002:a05:6870:b19:b0:296:ae1d:a760 with SMTP id 586e51a60fabf-296ae1e9167mr4640035fac.6.1732036718028;
        Tue, 19 Nov 2024 09:18:38 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eeabd7feaesm3664016eaf.39.2024.11.19.09.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:18:37 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 4/8] rmnet: Track used mux ids
Date: Tue, 19 Nov 2024 11:18:15 -0600
Message-ID: <20241119171832.1119-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119171832.1119-1-denkenz@gmail.com>
References: <20241119171832.1119-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track used mux identifiers.  This uintset can later be used to allocate
unused mux identifiers.
---
 src/rmnet.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/rmnet.c b/src/rmnet.c
index 5f40fcabcfb7..350f0bf844a2 100644
--- a/src/rmnet.c
+++ b/src/rmnet.c
@@ -28,6 +28,7 @@
 static struct l_netlink *rtnl;
 static uint32_t dump_id;
 static uint32_t link_notify_id;
+static struct l_uintset *mux_ids;
 
 int rmnet_get_interfaces(uint32_t parent_ifindex, unsigned int n_interfaces,
 				rmnet_new_interfaces_func_t cb,
@@ -169,6 +170,7 @@ static void rmnet_link_dump_cb(int error,
 
 	DBG("Existing rmnet link: %s(%u) mux_id: %u",
 			info.ifname, info.ifindex, info.mux_id);
+	l_uintset_put(mux_ids, info.mux_id);
 }
 
 static int rmnet_link_dump(void)
@@ -207,6 +209,11 @@ static void rmnet_link_notification(uint16_t type, const void *data,
 	if (rmnet_parse_link(data, len, ifname, &ifindex, &mux_id) < 0)
 		return;
 
+	if (type == RTM_NEWLINK)
+		l_uintset_put(mux_ids, mux_id);
+	else
+		l_uintset_take(mux_ids, mux_id);
+
 	DBG("link_notification: %s(%u) with mux_id: %u",
 			ifname, ifindex, mux_id);
 }
@@ -227,6 +234,7 @@ static int rmnet_init(void)
 
 	link_notify_id = l_netlink_register(rtnl, RTNLGRP_LINK,
 					rmnet_link_notification, NULL, NULL);
+	mux_ids = l_uintset_new_from_range(1, MAX_MUX_IDS);
 
 	return 0;
 dump_failed:
@@ -236,6 +244,7 @@ dump_failed:
 
 static void rmnet_exit(void)
 {
+	l_uintset_free(mux_ids);
 	l_netlink_unregister(rtnl, link_notify_id);
 	l_netlink_destroy(rtnl);
 }
-- 
2.47.0

