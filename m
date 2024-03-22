Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8970A47A48
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116594; cv=none; b=m/38W1jcHhW6mVqmaqpybfb6+T7GMsyKG5LS9byOqaV4Qj1QQLXQfW7aSjD0azdtKqZHr/PQJgSmrxTiONWNq3TPhnOhhYeSMy8wTl4TOFoXLJukcZHA0CE32ZEf8GDKnwYW5l88o8pz9vLTJtQER34Rnr442Lq4yOcFdzpnxT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116594; c=relaxed/simple;
	bh=W6uvZisSYNEQjcVezRx7ALmV51KyF8XmVqESwNLMd34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPEEz7MBBPyUrtGszCtWaVVH35IldHw6mh5gXVmY/2laXcvkaQYJ/tyLGiYEXd7r5np7FVy7/PE4tKJ3kMY2+cMLgqQKmpRe2FfSrr0HZJaiE98FaLH7tKARvq5ekxey+Vi7tM0APNbrIOrZM89bGUmsSXhJZi2yut9QklXFkWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xx0TqUuB; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xx0TqUuB"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a4a14c52fcso1072372eaf.1
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 07:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711116591; x=1711721391; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOhvItY3Y0qLd518mZq72HRT5QF9xoAQYfLZ9ScWJTE=;
        b=Xx0TqUuB4QBMmIGToQoOV7IZLu4uH/JOu+rolR7inbF4+84O9WpH1UW7H5R0Jj0+Dc
         mCAQyRs8CIMJ6VLO/RIo8gO+n3MMS0Fy4z+iVTj61VDi0ADI4Fq1mKx8pCBsHEITYDYw
         Y7AZRVbe4L+v/IhZmsFmqV17454e9d9AlhH8Lw1UDHsmeoyg8aruoM0N5dAbS2K3PQID
         qqf6Xcq4OR2DYDuy6ZXTtMs+ZdudvZjZSBunQ6wz2eMM4a1b00JVrPU7bKtyU4os68sG
         g1yY7QqS8IaPZ5egMT3jHiku4qm/uYq66TdHkSXgbfLCMce+tORkhWjoPXHbdeUeWoQr
         +iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116591; x=1711721391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOhvItY3Y0qLd518mZq72HRT5QF9xoAQYfLZ9ScWJTE=;
        b=EAYiBb7d/OpJyTKvoRjRKqnUlLRI/zxIcje4JzARnlybBdehkciwURegkDsDffFizd
         E7qi+heDm812JkOpdf1vOrN81qIE8Dhcsv/lSOOTElISdQekR3ke7U/bYOgafFjOyaPf
         QrHF4OctVLYjPIXJrnb8K0NY30C5FCTbb5Pmx+AWCnugbN+qIOgggdAxP8L09099QsCE
         syQEwiJ+eyPJ7vk/6OlEzoRx4PW+UbzpVECOzG8kRbmLqEMqx6r1si73FLXRPPo1xO0A
         dbFy/LcNoVK/1Vwh65qkEE6rUTRqu27WIAfvC1BWnRaHyuE8yO9lU8JJfdn3ESiHMt7R
         JU1w==
X-Gm-Message-State: AOJu0YxL8oEgI0QmdS30eAgexaXPq2Inmrg62Cb4KMTv8qz5hT4Hm+so
	UD8ggq2ZhrNrNNMciZSDOGjvFGcvilXgC2iLNs1GiqwdF4muhJyQGKxr1a1G
X-Google-Smtp-Source: AGHT+IH+BZCq9qcufz5LpXKH4nR9EXWYoJpkyXmSCqV3iI1we34/cmorXmvN2nt/hHNC2etRsOEmQA==
X-Received: by 2002:a05:6820:210:b0:5a5:21df:7ef1 with SMTP id bw16-20020a056820021000b005a521df7ef1mr1332273oob.6.1711116590060;
        Fri, 22 Mar 2024 07:09:50 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id cs2-20020a056820258200b005a1f748f3edsm303673oob.30.2024.03.22.07.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:09:49 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 08/11] xmm7xxx: Set modem as lte capable
Date: Fri, 22 Mar 2024 09:09:09 -0500
Message-ID: <20240322140942.2703042-8-denkenz@gmail.com>
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
 plugins/xmm7xxx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 871c964c03b8..a02f1f5aa027 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -1682,6 +1682,7 @@ static int xmm7xxx_probe(struct ofono_modem *modem)
 		return -ENOMEM;
 
 	ofono_modem_set_data(modem, data);
+	ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
 
 	return 0;
 }
-- 
2.43.0

