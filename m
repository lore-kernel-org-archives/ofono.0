Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BD61AE84E
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895140; cv=none; b=sSQij0MVPQJ8Cr2d0HW8REKg5vbqetBYdc/temRXOu/SK/uVLeTJS7/AninXB+MmhWraZ7vmJPGDCjGZlJAtBtYeXuG53ENB052WZAsUDIrsBtOACkoQqTvjxV9Rvv/nO+ixmw7St7OCn+g6xoLGaH/2nDtu57pwLZrjqBHPVEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895140; c=relaxed/simple;
	bh=yCASfTUa+mVbFQpxIgvKw6xLhMDlWjmwUkHHvr0CTFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awdVCR943LS/kwNENQLYb5L6zz1SlK0swipi4ad/pWl9dgI+KGtLlv8iBoEurzWv0HbiVDR0nB+qdQLxqxXmTN+H+UcPhurdihdosbUEhGdRN4xp4P9n1fNfUVgRh9Ew25m8kEhjhYXiEQSzvAFNtZPNl4jYapZRyO1S4cIpSh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1kctCW2; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1kctCW2"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c9b94951cfso524634b6e.3
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895138; x=1719499938; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wIy4qRUI1gV6a2AuRMXprV+NjXE4khA/yj+e1Qp8qQ=;
        b=H1kctCW25YvP/EK4Z0zf6qUb8IhuAUEzC/ncSHLmbVpJRVLm3UAqGZClxhEnyyGCIj
         R8usjk+pXpn3Xc+rsc69FFIf2LB1flSGnJZ2W6MF5M/+M+lDgaMDdBBVW+P4VdUmvLeq
         lJIdaP7TnZH/VmVJNbuq4ExOyYJDgHuRqPlBwK2wI1xDSv+x38ohKzKEQt76pCfTieLT
         gsSXqAGg6PeJ8K94bo00aoPWltInxWv8QT5esqQKpGRPHX0qSMRs6sxlS+3WZcy/CPJ+
         ypXrqmZPp6f6xGyDmBHnbfT8cLFdUn9stYmPvl0d/0oPLBjKrAlbhutZ8FzUJhBwkXse
         HfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895138; x=1719499938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wIy4qRUI1gV6a2AuRMXprV+NjXE4khA/yj+e1Qp8qQ=;
        b=MNcfqWvvVeC54WxevF8syi8x5WhGFJzOHzh4rRNw8uSDCooh/4FcvDr8XsqqKIq4ae
         zL1OkKHkoe71fJQPBg7bAXVjToysW/r4kUBSGYugss2q2mJP+bxBsmycoXuMd2OZrsK+
         I49WqvoeeV101Hvcb7K79cG7O8nEMpCnJBa+GEhhzlG81ouTsnAOCMtTw3lyXxsBX4hs
         GWsHIE40sn9w+NwUmq64Yj4Jvn0QytgV++dXGiLAtqfwByCNPcuAnA//ef0InGLE4w5c
         nAUAm4UmHQSYtqU7XE9Kop25P7OnPgWKK4fC7EuT9Q0BFmUIAFxYWMf6Um5bbOJkc5Z2
         TNIg==
X-Gm-Message-State: AOJu0YymuEeY2t6nuSTD+riLYTS35lXSn3k9SE2KDIuhFkFTwWmBDOZ9
	Y2Hi3koBEe/xR+USXpkIaGPycMoGuAweDABs8IkKvVaxTSwbrD7YCKSliQ==
X-Google-Smtp-Source: AGHT+IFmEYX07HhrhzpO/agtfH/ng9ATwkLdzq8GHJkw03RxR+KGLoYmpPjb7aMYhFImX+yGkh3oQg==
X-Received: by 2002:a05:6808:15a6:b0:3d5:123b:e2db with SMTP id 5614622812f47-3d51bac5225mr5788112b6e.41.1718895138160;
        Thu, 20 Jun 2024 07:52:18 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:52:17 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 31/33] gprs: Fix memory leak
Date: Thu, 20 Jun 2024 09:51:18 -0500
Message-ID: <20240620145139.1135899-31-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620145139.1135899-1-denkenz@gmail.com>
References: <20240620145139.1135899-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported by lsan:
==1120532==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x761c0dadf359 in __interceptor_malloc /usr/src/debug/gcc/gcc/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x9ae9b9 in l_malloc ell/util.c:49
    #2 0x9f41a7 in l_uintset_new_from_range ell/uintset.c:181
    #3 0x8e486f in ofono_gprs_set_cid_range src/gprs.c:2669
    #4 0x55b8d0 in get_default_profile_number_cb drivers/qmimodem/gprs.c:399
    #5 0x52f822 in service_send_callback drivers/qmimodem/qmi.c:2311
    #6 0x51f461 in __rx_message drivers/qmimodem/qmi.c:801
    #7 0x521d22 in received_qmux_data drivers/qmimodem/qmi.c:1052
    #8 0x9da348 in io_callback ell/io.c:105
    #9 0x9d5077 in l_main_iterate ell/main.c:461
    #10 0x7811df in event_check src/main.c:182
    #11 0x761c0e1260ed  (/usr/lib/libglib-2.0.so.0+0x5b0ed) (BuildId: e717410de6953d0e1e85882d796204ca2675f1d4)
    #12 0x7ffe00000000  (<unknown module>)

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x761c0dadf359 in __interceptor_malloc /usr/src/debug/gcc/gcc/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x9ae9b9 in l_malloc ell/util.c:49
    #2 0x9f4211 in l_uintset_new_from_range ell/uintset.c:182
    #3 0x8e486f in ofono_gprs_set_cid_range src/gprs.c:2669
    #4 0x55b8d0 in get_default_profile_number_cb drivers/qmimodem/gprs.c:399
    #5 0x52f822 in service_send_callback drivers/qmimodem/qmi.c:2311
    #6 0x51f461 in __rx_message drivers/qmimodem/qmi.c:801
    #7 0x521d22 in received_qmux_data drivers/qmimodem/qmi.c:1052
    #8 0x9da348 in io_callback ell/io.c:105
    #9 0x9d5077 in l_main_iterate ell/main.c:461
    #10 0x7811df in event_check src/main.c:182
    #11 0x761c0e1260ed  (/usr/lib/libglib-2.0.so.0+0x5b0ed) (BuildId: e717410de6953d0e1e85882d796204ca2675f1d4)
    #12 0x7ffe00000000  (<unknown module>)

The cid range can be set by the driver at any time.  If the gprs atom is
removed prior to being registered, the memory is not freed.  Fix that by
moving uintset deallocation to the remove method.
---
 src/gprs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 57b823b0f1c6..97d6f382e87d 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -3014,9 +3014,6 @@ static void gprs_unregister(struct ofono_atom *atom)
 
 	free_contexts(gprs);
 
-	l_uintset_free(gprs->used_cids);
-	gprs->used_cids = NULL;
-
 	if (gprs->netreg_watch) {
 		if (gprs->status_watch) {
 			__ofono_netreg_remove_status_watch(gprs->netreg,
@@ -3055,6 +3052,9 @@ static void gprs_remove(struct ofono_atom *atom)
 	if (gprs->suspend_timeout)
 		g_source_remove(gprs->suspend_timeout);
 
+	l_uintset_free(gprs->used_cids);
+	gprs->used_cids = NULL;
+
 	l_uintset_free(gprs->used_pids);
 	gprs->used_pids = NULL;
 
-- 
2.45.0

