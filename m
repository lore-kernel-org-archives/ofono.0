Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF69535A8
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122165; cv=none; b=Wzv5s7zp7MLIPpKawCbbYYz8NCGX/deEupNRqWMDp7XTuKq1FRITfZH/jG5HggCvSVuX71owdro2pLHczRj0WnAQpTBHSv4RC1qJby7O/ZGSG3ErTTKaRAdntGQF3aG8Q3aUlduuPsp7l1bAXkcoLq9aOFdJuKDa23Ue1V3reQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122165; c=relaxed/simple;
	bh=mBiLrFdYNYBz0XbHChKsUD1e65jj5aBvVSyWXY4nl48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0I1ToVaT63w+tXTicsFbexqKDmS6/6OUds/R8Zn22TjIpyvtue/Cw6D6Fksv5B23L1zEwHpGyILB8FcsJx8v5vjHT208wLqFmw5SjWpbpuF7zI0hbH6QjrHK2bxD7lkc5pBNl3RoJuEPWkzNJueOI4yXLczx5FD1YuM5iXxqok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9CUolE3; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9CUolE3"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e6738f7535so1392601a34.2
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711122163; x=1711726963; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2vBrJVLFqka9GoaqiUx2639LIKDpdupWHga3nbQOHo=;
        b=I9CUolE3eRTbgF3Yn6VJhq/vXFjsTut+NLuKerg70uzxUyBhexFtK9sP6YixhpqFal
         QQI+qSj5HalmJCnf14ZGVkYD9ay1KOpcKFjI7yp5MaTt4UTj43HczQpF/wryVSfK/OOE
         EtkCBc3CHXx9VWHMuW4B8hx8+wyNpIjLMrbyOIZ/9zTqhHrt6TX3FJWtcWjWLQh6eNH0
         Xq6CFZQGWxeiKou1uJ3RSdidxLjdf5/5QRBJpsUY1J/eWm6JPIHXbaIq3FbQLQGheRQF
         E4B/6A8lSRdPXujr4upffgJwtnC6Wk0K3whZts8UvgOU/T5pWTEktNp6txHZWMabXaV4
         cwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122163; x=1711726963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2vBrJVLFqka9GoaqiUx2639LIKDpdupWHga3nbQOHo=;
        b=Ua3fXF2wmuTCz8lxqoqPK3lovuygm998rh3KHprMMhuaNgBD54VsNbARgkRJlKjqWq
         4tEwLEYDjABWkggU1p6xEhtgcLilEIE/M4XcRIaH8HHZFtcrx+79VF8zf4V6PFUZGvAW
         yGdeAstP2l40ApUhJFN+HZN3+RxELkXF098957HNMRsuEAXYmKfZv+dobrQFDfoqzTab
         6wFyJG4C3OVLnCNyOMkZThL7WkNo5ToCqVrzkStsKpSMgG+BkDdawjdgNA/lq9gzmYPJ
         t+ThFiwJz6l9aPAn513dYxJjOSnnziRITznQb3o0rLXeaYXZp52ELRpmIYCL+opFRzoI
         unmg==
X-Gm-Message-State: AOJu0Yy0PMkOpdtZkhGnRElXly2t1rWhoJeWgmkLcuDM7GmLBSwdDVBE
	ZUe0/nPtXcZf1+PQEx+Gjt7q1ggW/zeju6d5Euw183DDefqYMLiAu/gwqT9l
X-Google-Smtp-Source: AGHT+IE7ELbmcYRp8CVTbMa7FY29yJE3K1Dek9TK4E2gwdnxrbe963rniIJ8fHY3e/ZeY7/Fi1NsZw==
X-Received: by 2002:a05:6830:117:b0:6e6:6ea1:9820 with SMTP id i23-20020a056830011700b006e66ea19820mr5620otp.14.1711122162895;
        Fri, 22 Mar 2024 08:42:42 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id u12-20020a9d4d8c000000b006e6763530e1sm386538otk.61.2024.03.22.08.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:42:42 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 09/11] ublox: Set modem lte capable
Date: Fri, 22 Mar 2024 10:42:22 -0500
Message-ID: <20240322154234.2720542-9-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322154234.2720542-1-denkenz@gmail.com>
References: <20240322154234.2720542-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 plugins/ublox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index c5661ab6b1ad..c2fab0e7184e 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -91,6 +91,7 @@ static int ublox_probe(struct ofono_modem *modem)
 		return -ENOMEM;
 
 	ofono_modem_set_data(modem, data);
+	ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
 
 	return 0;
 }
-- 
2.43.0

