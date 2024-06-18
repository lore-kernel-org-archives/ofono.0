Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9340E1C2A8
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740959; cv=none; b=VnoeAKvWMMdrIyU9+wuLym2EAmliFSHZu52AYAx5XAo9HXpJpN/aROE7PGdWULHiq5caIEzzgJdHjK/7QR4aaiVcVkYApnxeWunjlGTtV9XgfJGa+Q7VzSge5m63oI7nFl/jNciSWv96LubrCHDRk2UAZj8bb3rZcZvliZFHJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740959; c=relaxed/simple;
	bh=SFF15oEOE/+E0tbwO5fuCPcKrHEuiMdsM/IAIgKDYR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPb0OTCgDLdQ+3vTkbcQJWzn8L/hmEKGXedjNxKJS7SOyQ4gfSraNSJm9kVgYtFoAOfmyAEPZTFqA5ZILKvoHrlex8dieUNThLE4RTCMBdd/To5QAlSDrpT5LbN7tSOIjd/tXHf9E1CNN+PmuZ7GhOnR63dM6kRZTNG12+4j5Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqLbCdBs; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqLbCdBs"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25c9af0102cso9968fac.0
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740957; x=1719345757; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kl+oU570NwiMyhYtTo8ADyrZCetA3v81aYfFwn6Tyew=;
        b=JqLbCdBsIPiVBFQaAYZnkyi2LHRDH+NMA9gghabMvdWpFkdWyIDQrENitzhYNPcRFR
         os47KEZKOuZ4B0vaALDNBpvvJd9WTVjY6z0iB7APsqMidgDzcbQW3VhIi0rOb/XE4lwd
         n+05lIhicCMNmWwvQYbEHkh9KaycXZB62WT085VPF7ZdENnI76+gWSXkYrglmsYxmdUF
         P/5VfLyivuLIzFo2WDB88iJyOvmiWS7P19sSfWAEztNPphyVaCWjfaOPBU/H4DZhmJld
         SBM/2gZHEuGPVcw6FdWTxAxf7UUgEgl1cbdO1Ns5sPiTYTlY3IBSwLBqpD8BMS0xdjY4
         yF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740957; x=1719345757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kl+oU570NwiMyhYtTo8ADyrZCetA3v81aYfFwn6Tyew=;
        b=Swn+A1lbJwmVvtxSYaSfeVg26dtpVvqyB6v3ItltRjvIeJBmZ2TqMDC7vX/WeuVSmk
         WCJp7PmvyIT9Lh7CW8O4h66TUIiC3exbVBnRznKcZd0n/cbe3FKCGXdfnez+4XHz9xcM
         zWrGAP58urwefxI4t71gCT3aWq++OcTgej/1wWjZLMw+wqwLZxG+3dE8rYUdLVjukuMs
         Bg2dNLANXHUQD7FtZRrz0yHHUTf+TW8sxomjZUecuLW2JWAU1O0HSa9YJ3ZLzKuy0CzX
         +4ARl//yG98ps8WUTDbxMcZh/hoFhXSfbvMYS0iNfMfTKfkAsAmynvuxIMs0ueX8G+yd
         mpuQ==
X-Gm-Message-State: AOJu0YyRknhOrLWIRJHoxZrpPnU6nQTb5AE04UidiS+N643NnSdzicTS
	oAQsPFwNgWTeTfXUpQCp2Sz7GjA7T3xI0i5u0xtg/kpSBtCSmcY1Ut6juQ==
X-Google-Smtp-Source: AGHT+IHJo2OEpyR9ZGxRFsdTvKNkmeKVScp/c+mI6kaod6OE9UZ3cY7PdW2dbLo51zGgx+E8fQd8kQ==
X-Received: by 2002:a05:6870:b489:b0:250:876d:2a74 with SMTP id 586e51a60fabf-25c94a0e5c5mr974151fac.30.1718740957458;
        Tue, 18 Jun 2024 13:02:37 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:37 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 06/33] gobi: Use correct attribute name in docs
Date: Tue, 18 Jun 2024 15:01:48 -0500
Message-ID: <20240618200231.1129282-6-denkenz@gmail.com>
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

The name should be NetworkInterfaceKernelDriver, not
NetworkInterfaceDriver.

Fixes: b3ff67d78830 ("gobi: ensure required properties are provided")
---
 plugins/gobi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 5402bedcc22e..d8fd90153054 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -112,7 +112,7 @@ static void gobi_debug(const char *str, void *user_data)
  * NetworkInterfaceIndex
  *   The index of the main interface given by NetworkInterface
  *
- * NetworkInterfaceDriver
+ * NetworkInterfaceKernelDriver
  *   The kernel driver that is being used by the main network device.  Certain
  *   drivers such as 'qmi_wwan' or 'qmi_wwan_q' are treated specifically.
  *
-- 
2.45.0

