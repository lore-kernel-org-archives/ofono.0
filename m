Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B401C07D5
	for <ofono@lists.linux.dev>; Tue, 19 Nov 2024 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036722; cv=none; b=S2zNgF/QMatIqpU5So7lYbKlf/IVf8vym763MMK/Pc5uylXnZ4MgNXqDC7UIajKN/B87pScu9gPnYL4HpzZU5Kmc9sYlqqyY9rt2n0RBivoqWPV4bVUVHmwbinP7Q8N5odIFDz6luaLd8EsKaO/nM/TZE9XHBlCNX5tGh7yXhSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036722; c=relaxed/simple;
	bh=tlLXCONCtA4Xbvf4m1JxOMVuNvoRnkSQF9tYzySvHVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qa4b3JNm4Q6iljUeI8EWJo/LXXN/szhnnzZqEape5E1PJO/IQnyc2ZJaOo2o4E2+Z5Sy5UUuV3cwaHqvYgH0JGsHSQwk2N0dJTAzqcc/KHpMVcu7zDJ7qbp53S5XKK2DRMgbcvfgX7fuG95L0lrLRhIM0TY+3Y6mH/EkjYsCY64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIkylmk+; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIkylmk+"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e5fee32e76so1173976b6e.1
        for <ofono@lists.linux.dev>; Tue, 19 Nov 2024 09:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732036720; x=1732641520; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLrgs/4EtUqg+fIuM3RBjKZkkgnr0rtb+7yMiXJNplI=;
        b=XIkylmk+krRMmm0uUVfQRk9lcBjbzxr0auWediIFKen8pzKwmqX7/uqXLu+HRYVJDz
         mGbCBOIxMzmTmLrNGMgAbthouYi4lzr+bLpGQE84mZ1GAupwnTuAAa98eEWM+owZCxsL
         r7l6NNlSuYsij/TUyqAXZk2yUgp3KPlV89cJD5+ku7eIi6SE4rK1AktYK3aYtC1Cb4jq
         ctIUFpKEQ6pVrYvr/R8+dAA8W+/TYsMW0i/wcp/UfUdRHD2tZy1tok+AAG8eyifLCS1n
         Wt32kHU6+kzSSvFDu9e27x1YI7yXU8099UYhpLcBYUoT/K8Wlr5ZU83nR47q1XlCtNTV
         zPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036720; x=1732641520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLrgs/4EtUqg+fIuM3RBjKZkkgnr0rtb+7yMiXJNplI=;
        b=tvrzUI1yz7TrZC+celkLu32U/ywkgArk6a7nREdGyJI43SEYemcnI/5tUIYP/kzE6N
         S56BdaPrhB+vM0n7tWHWxoRos9sMf9AxDYKF9y3ichxqTGpvun50wvWFVHW5zrCDsOQ2
         /9fUDm58T7Ef3UR703tEbiHPZ38d3SYEd/bb7hk0YKEYNPPUvuVo8OAHzy519kPhEa8i
         1cegaooJRbLvmR4/Klrr8X0mgnZrUdP4a1ZCPR0swsAHSyH2jy1Olwwiyzjr4SEimvMp
         Esl55JAVSQ/4LGeZ6VJg6ZIEP00BbjT9ieFj8nCkPzhDqh/RurYnRYbmmK33ty/Gj6vk
         3tpQ==
X-Gm-Message-State: AOJu0YwkquyvtjADAfDXCGOFDc5S7Oke8yLM2v58hl4Tg8LPyk5nFrjK
	cTIt+Q2rmL4fRllb2+BCAz5kn2VG7chL+iDDvg5YpAZYdysCpHq3WeIGxw==
X-Google-Smtp-Source: AGHT+IFmVtoDG1oIKfFGy+HeqWzfOifNHWgZtJNKr/RtxWzLr9S1l2KvsroJP2+hUNEzucAeIlAclA==
X-Received: by 2002:aca:2b03:0:b0:3e7:63ce:1d6f with SMTP id 5614622812f47-3e7bc851773mr13888630b6e.34.1732036720173;
        Tue, 19 Nov 2024 09:18:40 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eeabd7feaesm3664016eaf.39.2024.11.19.09.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:18:39 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 6/8] rmnet: Implement rmnet_del_interfaces
Date: Tue, 19 Nov 2024 11:18:17 -0600
Message-ID: <20241119171832.1119-6-denkenz@gmail.com>
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

Add implementation for rmnet_del_interfaces.  This method will remove
the interfaces based on the passed in struct rmnet_ifinfo array.
---
 src/rmnet.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/rmnet.c b/src/rmnet.c
index 4309f8e61ccc..adbe605effdb 100644
--- a/src/rmnet.c
+++ b/src/rmnet.c
@@ -149,7 +149,18 @@ int rmnet_get_interfaces(uint32_t parent_ifindex, unsigned int n_interfaces,
 int rmnet_del_interfaces(unsigned int n_interfaces,
 					const struct rmnet_ifinfo *interfaces)
 {
-	return -ENOTSUP;
+	struct rmnet_request *req;
+
+	if (!n_interfaces || n_interfaces > MAX_MUX_IDS)
+		return -EINVAL;
+
+	req = __rmnet_del_request_new(n_interfaces, interfaces);
+	l_queue_push_tail(request_q, req);
+
+	if (l_queue_length(request_q) == 1 && !dump_id)
+		rmnet_start_next_request();
+
+	return 0;
 }
 
 int rmnet_cancel(int id)
-- 
2.47.0

