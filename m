Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A6B4779E
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116593; cv=none; b=dZcM8GFazCorKUGMuf+QQR6dqVmeIaVgfAt8gOXWy1PLibhqBm/GZ3BbHhXTzcqO1wTXRKf9ByC6je/6vKKQKPZ+6G2jtfc5dGIjQSaZBpgcZgM3rVEG6amoQ3tAXkzvRLAVYcdUOA7CY1IJbYIymz80YQyKGeg0i2NBz8dqmGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116593; c=relaxed/simple;
	bh=A+yMIvSImCfLwpDFqcE+k8goyjDKsN873ZWb4qI1YnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZaWU8lA5xu1XAgh53JKdpMXBWLew+X0KZEIm2sA0SQ78mHQwZi16cPpfg6GzoSpB7E0XIsGu7zy/3SvLdDGZO1NfT3rQws4hZHX9Z0PVsC3mgw0SUOxhIZGrPnkIC7atZlsSHLyNGQ8fUFFHte8Nbna00V1N1CcM4LBsvyFvlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVzuPj1a; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVzuPj1a"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a1fa3cf5eeso814387eaf.3
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 07:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711116591; x=1711721391; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j0wn23XXDaf1iyM+ZHhbWPkDlv/JUY0HjF7OwJctII=;
        b=QVzuPj1ao6vjtboESFMiYq83qx+8/wv/w+nUlVh/cI44T8eerhiGfLn5tKEjHZNAiu
         W6X+7AqlZdCDDtyhyvbJH4ifAYRTRAAwehuCONpVbJFH6w4TpGt2WND11PO93zcIVVxi
         735S38DxtOo3uQPsH3SEyPOpFhTZwanBBxk2oNfWtI4naSzXdX/UKdxHCGSq6Ni6hsEU
         DxEbmuTlSgPL00e9c9k9oaWb4485p5jOC7cXce67HX5uxrSzXn10TUGdMmb5Gld6/1sY
         7yzxsddnUgvh4DZqtgZeGkJtOhfm0ZPNaksdH9RgVP9696qqthnNh+keU7soGIRBU1qX
         L46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116591; x=1711721391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0j0wn23XXDaf1iyM+ZHhbWPkDlv/JUY0HjF7OwJctII=;
        b=lxDwbIL2onC1Rzd0dVCQo69w0CPJbnBMITaFJTCYlfLXbTibCUXHqa/BVTgokrHnUh
         kDULHQq77+A2nGcSq2nhkEFP9qm1CgWUAhLFeVz/c5tua9ZUqPj5jFHHGdaITzQEmE4A
         kwpXar+Q56iB5nt/Wr1GjcUm2cBRvsOTH4ySI0qP+Q5Y4KP3AsHUy+2UKh5nM87wVHD4
         x9Fd7X2evnwceP4GuDWotieVfEJtVawmmRDLzQ67DYWDmV62ozL4ynqZ7DojOoJ3DjHr
         5Hfph10yoGQgYCemMxlZsK9/VYDIh7tj0ljk6YuOTj/5ezutWrpjJtAJm0JxwgYcOnND
         cjVg==
X-Gm-Message-State: AOJu0Yymjtp1cVfnbkyuMR+7HjEicvwEj4iAHmboFd5055ortUSre/XS
	g5i1Bz/bddXIcm7J6Dm/R/AEn5oljT5WlvXdaNe55akMjmMVn6Fp/tvM0H+E
X-Google-Smtp-Source: AGHT+IFkmdeCpomwr3Hcemytq4pW0m05tUBcNhuIxnPO4JXouVdHCu5PPU4SuXmYkRkWXUi8ssY64A==
X-Received: by 2002:a4a:edc7:0:b0:5a5:27f5:38cb with SMTP id m7-20020a4aedc7000000b005a527f538cbmr701777ooh.4.1711116591504;
        Fri, 22 Mar 2024 07:09:51 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id cs2-20020a056820258200b005a1f748f3edsm303673oob.30.2024.03.22.07.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:09:51 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 10/11] gobi: Set modem lte capable
Date: Fri, 22 Mar 2024 09:09:11 -0500
Message-ID: <20240322140942.2703042-10-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322140942.2703042-1-denkenz@gmail.com>
References: <20240322140942.2703042-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 plugins/gobi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 8d3b7ef4cdfc..7a07b080d895 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -117,6 +117,7 @@ static int gobi_probe(struct ofono_modem *modem)
 	DBG("net: %s (%d)", data->main_net_name, data->main_net_ifindex);
 
 	ofono_modem_set_data(modem, data);
+	ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
 
 	return 0;
 }
-- 
2.43.0

