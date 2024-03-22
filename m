Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD253481B3
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122166; cv=none; b=jGDmGlj+5cRGj/OgbaEnC6olm7g5OgaFlL3GXTORXW6Ayd2DjaWMY82Cm0sG9AnUWEAGP2+x6WLj8tgHoh+1Q2XIEROtCXsThAgDMgKPVTfUv+IMfTrIpZlh5C244iZfW7PHuZf9LATmL94kCSk3pcHGtE6BCTsjLj76ZPj+SsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122166; c=relaxed/simple;
	bh=A+yMIvSImCfLwpDFqcE+k8goyjDKsN873ZWb4qI1YnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXfojd1RoyiZYHU7ZE0Ss3Ppmmq0VRtpQmICNpz8z3XR+UDIYg/PsNoOEJYnImol+LO+GSZ78nQi0Vby5sH5ov2FRRVxJKjUMbd8+wV5Wp9GNcLgEX/KAx6CYnnm8AkqdQYp7Zh+hxWYbmjQWcouo2XfO4m1qc+QBFUXMs/0CdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjaoI3d9; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjaoI3d9"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e519d73850so1414665a34.2
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 08:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711122163; x=1711726963; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j0wn23XXDaf1iyM+ZHhbWPkDlv/JUY0HjF7OwJctII=;
        b=ZjaoI3d9no+vfUrqfl2cyD+U5RnbcudC55peJ6kn4wTO9n8j8tkUPv7vMoDJbQJPGM
         Vh+UclDt+jRpn2JEvLUQGR1Y/ITNHtSPWvvhB7RwLgKyGuEXAZU9aOrlcUDosnOM+OP8
         ABtSmz3VUOuY0XEVyi/uA2jQO8e8ujAdKi9aT3/GCiAT7zfNmpkKjEqQkTX4UPKObnj8
         F5yB3IKJ92A6GedgoSBWPpdMLtrF/lMS8LysGE0UV6A95wAn2ixf6eXNn3u4+q9HvdHy
         Vab59+yrL4nNTwPTV6jcvF7Z8gGYQ9kmUcnHW5yk9rvzOrMknxlokeVIEnIBC3pJLxIm
         k6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122163; x=1711726963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0j0wn23XXDaf1iyM+ZHhbWPkDlv/JUY0HjF7OwJctII=;
        b=rDVL4EEoZMyEmLdhNILb1uibjj1bM8vubp4iXF1DfRZi2tcluczwiQjiw3JQ8tEdd3
         fzdUJNSH0JSmkW2SsZDjDnWr0fme50h4X4evNevcPk6GAPvgqtBp9pNl8dIZMeUFafZ3
         2xqIRnZkV4tohfb13q03ER60LdPMqQIFq2k2bsGAsqiW+hGEMYlWZe1LwUtwutdaPfNU
         ioZ2rdGMkED6ABWbR4uqtTJARHObdb0Q7CzhCIfV6cuTp7HjUSDKvui401FpJR/q8Mbb
         +zaEoiSN+aLBCBuLZCkIjCgv6bQk4jrd8QBKAehRYTxgRIDQ1ccmfazAmQ1sLmwBSBHa
         3Egw==
X-Gm-Message-State: AOJu0YzCsgn25IyhyvR/ANwlgo+iRRg/6U84KDS17NZmP+nFkWj0UPOu
	/56a6XIVefokImbz44hBAh2n7G8w7a7qorNl6zIe8HRaElrDofVRU00lqzfO
X-Google-Smtp-Source: AGHT+IH1iaryRdHNPJBghqMw3+RI/upGUlXyY6ajNon+yQ1YkF2AcbVdQeg/M2KsZ1SMvIqw7MP3QQ==
X-Received: by 2002:a05:6830:10c8:b0:6e6:99da:8944 with SMTP id z8-20020a05683010c800b006e699da8944mr2689640oto.26.1711122163480;
        Fri, 22 Mar 2024 08:42:43 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id u12-20020a9d4d8c000000b006e6763530e1sm386538otk.61.2024.03.22.08.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:42:43 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 10/11] gobi: Set modem lte capable
Date: Fri, 22 Mar 2024 10:42:23 -0500
Message-ID: <20240322154234.2720542-10-denkenz@gmail.com>
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

