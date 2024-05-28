Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3D39FFB
	for <ofono@lists.linux.dev>; Tue, 28 May 2024 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922438; cv=none; b=XFTdsrrkR8IvtDBPXsxYOMoICH0vngAzrQgUWpAcD2NGb2AHO7bczwaGKNj5JvO2iu4wf8FN3yH/x8NkHqvr/1king5ZMfBzNfKxuwJKh8I4AxOM5pzOd7QFDWwOHBaXhiNrK+VcUCFQ4ZxqSct5pOExw7479y8qWKrHvMtHvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922438; c=relaxed/simple;
	bh=uFUNaE/7jKQ0MEhKGWB3w3xNjYX8m4m8QbzvQu4tuQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ugHwJ25bD+MjWUciRseAXfZkzVhM5J+0LMI6JXGbJGKrc+4wz4ye8JY35x7mEI/aphKa8yJWTd4h4P7WiPg6+inUo/wmAirDB2F/GftHyDs+286nNEAIzPNVNNLate+iANBU1wtJMcKAApZ3IJ2w6ctz2vfzHRTX+IbLiL1LmN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkaElT3i; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkaElT3i"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24cb75c126aso569836fac.3
        for <ofono@lists.linux.dev>; Tue, 28 May 2024 11:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716922436; x=1717527236; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPaldu6RYcFbFSFsAGtZhs7LqeMETBGiP3boYTS5b3Q=;
        b=RkaElT3ine+MWQAjmfpUb59msrvRM+aZT2yxxwXfj3ShHy8l7B8ju9iRtq1/pYDwHg
         YXkgW4ilYOU5WvzZPRtiP0gvD9sQ9n9Puq/+84noVO5rhIuSBBMAhEA3oEEpnmcDFlCz
         lpVOBcLkOZV8LrWAyeY42VAAs4P0CqTn/4nabNLdp3t00ogdOydT975MBFGnwXXHD0Re
         26i+r/NHIC8BZ5TlsImsckw+suq6GpahaHq5qh1pLVCqNW1uKY3ECG8bdwh/t9njqAnz
         IhwK51tiWFgkbsuboxMUz5odWSpdSL7j8zbZOuW9dgmrOKeYPiT5aIC6SXn/Esb/pTKk
         0J/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716922436; x=1717527236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPaldu6RYcFbFSFsAGtZhs7LqeMETBGiP3boYTS5b3Q=;
        b=AEiHwwpMJOy04Tr6reOzHNbxDdCMpKqRSJh84+Ewcc1ropPr9qURom4MwZdHkmfuBK
         kMLQEaCZIkMW7uikWmzyYtijiGKh9nGd8Sh9OSfSa9dHxtQx3WQskXVYKlfSFf/WhspN
         8SVmZ43PZoqi7GtNNwK90cJMn/WSiC4MgzMGSTqqh/FDQjdrj2j8arPwadkiA8pmtEBi
         vm2NiCpGn8EFfFYd3Xb54z/Gj8epnzoQqNAgeGD/GtcDMK4WNg+pyF2Pf1ywLr3PFb/O
         HSTVCkWmwVKgOB6fj7iONCMHrJNJ7PyGJQhR4up6OV1OXKijI04vrp5eFx3KYnGeJfeI
         LTdA==
X-Gm-Message-State: AOJu0Yw4I8jbDfryzagPuA1dA5AwXD5qbP5b8fBjIGzuugyf6W1/aX6H
	dmA9ZlND6ICqmFjkwvBPztHQCLtkaKS8/W2Q3WmPHkzQZ+r9XJvQa8LGTA==
X-Google-Smtp-Source: AGHT+IHKDhCtgiHalq4SYLdgSUtTHMnZMX4d6Dus4ZYRQvzccvHfE9Bputpu0b0brFglNuPzwsSJ1g==
X-Received: by 2002:a05:6870:c697:b0:24c:535d:9b2d with SMTP id 586e51a60fabf-24ca11ad4dcmr17817714fac.32.1716922436506;
        Tue, 28 May 2024 11:53:56 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-24fd7c50c37sm1933625fac.18.2024.05.28.11.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 11:53:56 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/2] build: link dundee with ell
Date: Tue, 28 May 2024 13:53:35 -0500
Message-ID: <20240528185354.224680-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 44fb7b1baef0..e60f4f2d2bee 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -991,7 +991,7 @@ dundee_common_sources = $(gatchat_sources) \
 			dundee/dbus.c dundee/manager.c dundee/device.c
 
 dundee_dundee_LDADD = $(builtin_libadd) gdbus/libgdbus-internal.la \
-			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
+			$(ell_ldadd) @GLIB_LIBS@ @DBUS_LIBS@ -ldl
 
 if DATAFILES
 dist_dbusconf_DATA += dundee/dundee.conf
-- 
2.45.0

