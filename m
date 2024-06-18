Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6516DED1
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740979; cv=none; b=e1PMibJEdDsM2G+Pr6L0xjTDVT4vMRtV9tgxsi8g4SEUWbuIzPK/YbqtG07CGw5bp9Y4WIjrokHWutLSi4dm6fIVnXoVvOdLr7CjlmYw5aLdD64xDjM7XaWRzwF4CckAjcjpOhrixORwqSGkgE1Juy4ET0zkdfSJMF59+/5sSO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740979; c=relaxed/simple;
	bh=yCASfTUa+mVbFQpxIgvKw6xLhMDlWjmwUkHHvr0CTFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsI1vmmGNACF46Tt5DKxM0nzdS/2tOHzuaF2+6KsrYBwCoW9+0ZWixCBHw/e+2uWbjoM2SJWPCZzPOjhFF431XYKs1cdY3u1LULk26Yi6H1y1D4yKbFOP7WYwMZthCOtLmCZ/tR1h5imNn2a0KkqlX+yqdvNC/7aQdlkN6LWNGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sc7O6FYu; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc7O6FYu"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-254a7fe21aeso92453fac.0
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740977; x=1719345777; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wIy4qRUI1gV6a2AuRMXprV+NjXE4khA/yj+e1Qp8qQ=;
        b=Sc7O6FYuCnj9QdcbWVQeNwoiTrMXDbMRwR/RhoQ6lfDPXbjYQldRP8vyyaNqULPoAx
         3evgrKKMbpMeIR3aK7t0ZRNA2isD7Y34jVA8uqk77dpV8GFhi0FIt1xaVuG0pjUvq4mN
         SmSgJstlPBQbLKsccsChWCjQ3Mqpj4Lzx2V2H39lP46w8tZWZRD6TVtmKp3/FjjFd+H7
         iOM8qZ2cPojqm5OVpzMCDXf4HBCnPu4BYAb+gqx4Gptqg4Xcre89xCEFjLmjel15JJ2Z
         vPtWQ5pnGGWVzHJpTqcI7AQXONGe9mVXFOxoqk7bLp0tgg6jSDjQ9oQD8J7oKIiOdKeh
         FH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740977; x=1719345777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wIy4qRUI1gV6a2AuRMXprV+NjXE4khA/yj+e1Qp8qQ=;
        b=WjfbynY41q57m5eueeYx1HajZjjWrTSvvAfoGL809RxLdmmVEUDaO02C9DedKpPzge
         WeXzD3hYfUnMPvz8XLwAbDKesdcQY6YtH7ofKL8siCWjAH+U9hY3DRYqLJVu7fZVtkKA
         v5DdATtMTcf6zxmPMfY67+NeBo2jwpWAe6YlGtEoZ7dige+Eolz/4aYJzUiiOcBJ6VPc
         yrADb4Kusd85uzDJ5N5bOsiAk4IEsqISzHvpia0BYIKuB8yipMuPa+pi2tEOBtghdZcm
         rbccyV4j0kBYUeiVWdaZ7Ubb62BHWS7tqFsBEmQkyZP0SExjuFBs/f9uLNhrl6SpmfZk
         OTQg==
X-Gm-Message-State: AOJu0YwcUfZCIeb26xE5C9qpXH27JLxuBM+OxV8Z3qQGIVmGjFUYMwwg
	zYkbsD7C5RVce2vjU8JvnuR9Sosje9VWQKxov2J/KVYopRevAWv367vwAg==
X-Google-Smtp-Source: AGHT+IFGXEmrGTigwVEaFla9iEq5iGAdZRVidCKNrtejqSJcoqEkGDFzEke0QBCHUDJ3Gpl9Q+XQLA==
X-Received: by 2002:a05:6870:f14e:b0:259:7767:3767 with SMTP id 586e51a60fabf-259776737edmr1378362fac.8.1718740977161;
        Tue, 18 Jun 2024 13:02:57 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:56 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 31/33] gprs: Fix memory leak
Date: Tue, 18 Jun 2024 15:02:13 -0500
Message-ID: <20240618200231.1129282-31-denkenz@gmail.com>
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

