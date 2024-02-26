Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2214604CC
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961705; cv=none; b=IvM8RbhX0Eijgaz/78ZGvCXR3D7g/2f+DizQXdRWw7JfDNAHoXMxn8y36LWSc4/ykDAco6WH6uhzzzk3tDTA97Kb1cY63+6dovtO1wrR02ea19dRMM4IaHAYv0q8FFLMjFI1vHYb4qvaVQlYdhfvHMRpfycuxdMr0ZauwOA63Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961705; c=relaxed/simple;
	bh=D+Q5nJzhNKzTJ7AlNe4KyVckn7E3TAUMS9LtrxYEiiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIftGGlv2+JWuiVTsNDE0K8z+KIi65ngWUEpNQtvfcai3GHnwZMroEjz19JTsSQ3hmvMr+p55bw+kuRwmqWT447ZJQevMdrmyRPBVtL53Cl1k4i37zCg8KMYJh26D14LHIEy1ypiw9G2s2efLcLZjWtF3WP+8XqV6unR47sbcU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFlZmTau; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFlZmTau"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-21e8a740439so1061241fac.1
        for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 07:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708961703; x=1709566503; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6aMKdSt4hlpMvvzbH/1eqnngZDBGFEB284Ogg6dR3I=;
        b=EFlZmTauvKP97sU64itkRDjdCFU8SK7zZxHnSMgYwZl6iC0cwNeDhW9mgw0Ot7uTKz
         wyJhcra3KluopGk9+Ei2aWcXhhKtxqyBndMCN6qbHTFsrxzSfOOf1ne7lk944mvBmfcv
         6LWR3krwDiGhPvaptiKIJkzYddIG8TIjEFAVoDlyQ8gtghnskA7DRjuQD7Qpp7uKX9z5
         4E5UTgaJlGQ9OQSqHNH7GkaMzfG34ExsFlq5TLUbUZsTIubNZkOEqsJXP08V47Wg1+UZ
         07Y6nKqgOIntaPZixkwPoE4ah+Aid4mJ8gjM3Q7toqy8HVGFS3eEyKZ53fvg2zgMT6yv
         A2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961703; x=1709566503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6aMKdSt4hlpMvvzbH/1eqnngZDBGFEB284Ogg6dR3I=;
        b=ceaEIBd6sk7ebE4LCzP/7la/tjkQZoVoXFuYEf4Ru7qT1R5/SBfuhmT+Cd9bdh7Nn0
         O4ok+gmRl+gjzxngllTJ4woZ8fVGCBsRvHpwhmTOSLUVPYiuEzT65d1UIIYIztoCjC4e
         j3snopB0lhcDaw3LR0qk/8RreP/tu5j8l4qiA0BkBriyIEgLwMJN+X0uyRkKbmvv3hyh
         UDy2PqcNT9wTG6fdgXv1fKzOJ5Lk8IDQgnDTq0FOceqz1IjF/l1w1WhbMVWGWmz/JduT
         jRcMHwZdcnRW4+0P6E7BHNsJ5C5PUrPmWuBF+nG/KZ0aCeutoxBtvB3fMlkSN0pF10X/
         xVaQ==
X-Gm-Message-State: AOJu0Yx9bfBs/3ZUeK2jiTwEpyeRMhzJdilliW7hy71ptQ4xwpVIrnBr
	snj6ZYkfPn3sjAJ5KW7dKM0quzN2QlHzYeFPL97b1dUDtnMinag5S20oZ7gV
X-Google-Smtp-Source: AGHT+IHx9aLUb3nkOVVOsznbHJpqxF/53eJVaROIhlqUBuCbRr49sSSVaflwg9iG9V4m6FWgNdFQcQ==
X-Received: by 2002:a05:6870:1711:b0:21e:c9eb:e19f with SMTP id h17-20020a056870171100b0021ec9ebe19fmr3266912oae.19.1708961702798;
        Mon, 26 Feb 2024 07:35:02 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eg14-20020a056870988e00b002201144306csm567048oab.53.2024.02.26.07.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:35:02 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/8] qmi: Ensure tid is initialized
Date: Mon, 26 Feb 2024 09:34:21 -0600
Message-ID: <20240226153459.1463304-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226153459.1463304-1-denkenz@gmail.com>
References: <20240226153459.1463304-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the qmi_request structure is allocated, the tid member is never
initialized properly.  This is usually okay since the request is
submitted afterwards, but it is still better to initialize this member
properly.
---
 drivers/qmimodem/qmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 652f19fb6cd0..be6f6f7bd601 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -202,6 +202,7 @@ static struct qmi_request *__request_alloc(uint8_t service,
 
 	msglen = hdrlen + QMI_MESSAGE_HDR_SIZE + length;
 	req = l_malloc(sizeof(struct qmi_request) + msglen);
+	req->tid = 0;
 	req->len = msglen;
 	req->client = client;
 
-- 
2.43.0

