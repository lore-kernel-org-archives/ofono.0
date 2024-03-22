Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E8746525
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116591; cv=none; b=g7g5VxCzSvlFeQ+gjmpB0wuR3Rxix/K4rYZaTrd+bZVvnBoEv8O2hmwg5iHGhycvGG+f5oXp3/x7QjIphGLxF9VlXF4eclhd3wGEL4opY69+9Qz6yTmzs236E8JWFm3RoksJNuk4j0pzn5Y1gePyguDvhCBbYd1TVNeukjxUgGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116591; c=relaxed/simple;
	bh=53kY7wdjRLDgkkh3NeBR1gqnow7I8TCjdrXhcEgaRP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+SjXBN8tmucam119jwLKJgjJywxnQmhQmrJDmwYfW4ScPYoCYuSC2Q8YkaIuRNsXRQRizN+mRBCRUP1mm0VqSeJGGyOKWHzNA/iqV5+jM3OjXax8z+2Z5wdBj2U3IHd/ZAO5Z2VoF6QEDMxLVlEIP3HNPT0/LeV+eO0JhfYPCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb62tW0Q; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb62tW0Q"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a496fde460so1018789eaf.1
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 07:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711116588; x=1711721388; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aH5XvMBIRwrrwpxXvpflVrN0+YlJj02C1YSdGvWXRU8=;
        b=Bb62tW0QLIKTldxrvdYHeOmPNneL9CggvZbIiCZAokSEYxDByDCU4+HPomRw69/0Wi
         mRR6HLkNpLJSc8pDGoBt1/qKYU9UD7n2vYV2McjTu4lPDXKTgQ9OKe85K38aLnVkdjHf
         isr1s0CrUtJ/6cP2/AWc5rjJ+stQTNggVl3EjMvVmPSwN6LuAoR/wPqhm4pzTTgMg+Bi
         sr/hJlH6N2eni921KV/qAOCdfgiK5Yf6/agpPkH+EUTkmMQ0Ar/hcT5CsygFG5Uc3FhD
         29kP2H4Gc87vclwu88HtCjVsRiY4mpD5dbnox+gYSsUP72EcpW56Z4Md3oPboyKMRLJZ
         XW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116588; x=1711721388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aH5XvMBIRwrrwpxXvpflVrN0+YlJj02C1YSdGvWXRU8=;
        b=f6259bgzNMU/4b8ZoPypqb0Rz6xlPncWNxkqlmikt9wT272hFTVz+dcP4q5Xot+KLR
         7RvExnK1C7ZzZ7GUTC/CZtEZFzgDh59asjcKCj+Sa17OhH1OwoGJ4D6EnVXuhZ6qxi0M
         6ee34Sa6QiVl6fPuEkPy4rjWtc+8a/LTbfDUcABV3qjKilSZFtu7001KojO+qTZtiWJw
         ZWdg4uDNdOuy939xSs9A8DDRPW+Oy255DI2xd+8kjxo9nwAicDnYP5Dq7X9gawPANup8
         0hwoBvWkhwZF53iEpAlR9eFz195TRKL/We7T9sjsU/7ivxf8S/3xbexYgQAxS6fhTbvK
         +tJA==
X-Gm-Message-State: AOJu0YzU2CMqq9aDwU8h5CJNT8csHY0/7TfGITLcm76D+lCxhvW3DEJm
	ujgGFRk+Qq9nHyY5AT3U/ZYu9cPdmedpM71M5nPaZPG24OYl9ADuoOckDtwh
X-Google-Smtp-Source: AGHT+IEnK5vgiQ1d+VKFHg4IVWdxrzwnURvEjaWz2I1YdCADjN6uAy0JeRdWpLWNYl9Rb1lgehvJAA==
X-Received: by 2002:a05:6820:308a:b0:5a4:f5b6:4eca with SMTP id eu10-20020a056820308a00b005a4f5b64ecamr2608504oob.7.1711116588695;
        Fri, 22 Mar 2024 07:09:48 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id cs2-20020a056820258200b005a1f748f3edsm303673oob.30.2024.03.22.07.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:09:48 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 06/11] phonesim: Set modem lte capable
Date: Fri, 22 Mar 2024 09:09:07 -0500
Message-ID: <20240322140942.2703042-6-denkenz@gmail.com>
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
 plugins/phonesim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 29a983611d75..ac83e88fa3d4 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -447,6 +447,7 @@ static int phonesim_probe(struct ofono_modem *modem)
 		return -ENOMEM;
 
 	ofono_modem_set_data(modem, data);
+	ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
 
 	return 0;
 }
-- 
2.43.0

