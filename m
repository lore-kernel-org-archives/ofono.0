Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE6D481B3
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122164; cv=none; b=TDYi8LdiprGMnRB0vHuYKGuYZHYdhEpi7I95vDIXVE1UDGQflWEl53d7RDGD4jr1vAQsvL8FoKOr2iCBH1agODQifJuqBGnRpirMTqaO8BO6fWocizRb/f3OmVKvTsKIJLV7ae6+oubyJ0u/AAK1uM2JQEjJCs9igqYvHuhCRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122164; c=relaxed/simple;
	bh=53kY7wdjRLDgkkh3NeBR1gqnow7I8TCjdrXhcEgaRP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/CNNXTbAj2OZ/K9L/feBgKEtLbU5EVMODyLaAtlpLqMKCj5QvsUfhnJGDnbnUvqRz2mtKQXt1f6Ob5fuEovBMcQq+fftuc+YKj0N8Ol+PLfeiC+pR9tVWAsWDUJNXMgxRPZmOutiF2OO2SQO2T2VLNEvD0qTerfOa3K0ZMPkVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m53gWNy0; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m53gWNy0"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ddca59e336so1196346a34.0
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711122161; x=1711726961; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aH5XvMBIRwrrwpxXvpflVrN0+YlJj02C1YSdGvWXRU8=;
        b=m53gWNy0XpFwu9Y+SMA4na+xaeILKG6QgmrgzT9R7wSUssMzkbbSOjR4QfZpds2BGV
         Ml0gpJnq2OID81w0kw1JdHDw7BUu21CQXYP9XrE1/8tIUqMcLpXmmk6ZoMECHs+Yg4ej
         M7PCoCYM3vVV7oUumcGMKmtXBoASQBT20hhlzOX0OMcenzRV6V9DeJT0KOt1VjmbXhFX
         ddYzKxCbDAifkbYEY2gXsjkZ53FwH95CUpz7weKDeDotJj5r+XbfU/XZNYrChVOAzwFE
         K+HtEihqECLiBfVUJfZUJZGEp8Tr+N4bSjfyQrPQIiRzHMnhPEhm2EQivEIzacYxN2uC
         3aHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122161; x=1711726961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aH5XvMBIRwrrwpxXvpflVrN0+YlJj02C1YSdGvWXRU8=;
        b=AYjTdMa14KpWQimBOcpH6Hmsgko0GwyvAtELHH1xTMoSDK8NwWICTHF/J4zB3+B21h
         S3hxYOYpS5dISA5JHhVC/PnlWwfM77L4HQG/+5kET8ECytDmGXLuLhFtc37awZM1hAxS
         kROTxCUuUuWC6y9Lf8lhOnjYCVyhlHHn+I4VK/WuKdAUkmy7ZmezfOwees9XCdusEkC9
         J9GosUzwnErpOVTQ3WHRWmap9wETmLiy+LzokZDAJGL8dqBB1FhzhIWfgFchrkjA/Ubn
         2S2UiCjyQ9M+l0sZ+X0JiyOiIAtX/eTRKoup8O98dOqHQYKNMuq2EBQNKmjc9xFscppw
         KyYg==
X-Gm-Message-State: AOJu0YySZLS2xGDRFEKRL1m5g2ReO2pGgHgD/c5Q2vL0Gxa2e+pm5vT2
	VTiEuG1UYiXCMclt9HLe6+9qUSWMmZr4d+IzTpNfqzuDO2NNHCwvwzLfUT3z
X-Google-Smtp-Source: AGHT+IGeQFc2kJFK2uCDR9mPRwjsMVdA1Sa7ilqn23EtURuDQ72xP52wkEELxk/2HkB1pyXWt9pqug==
X-Received: by 2002:a05:6830:4785:b0:6e6:b121:90ee with SMTP id df5-20020a056830478500b006e6b12190eemr988701otb.13.1711122160808;
        Fri, 22 Mar 2024 08:42:40 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id u12-20020a9d4d8c000000b006e6763530e1sm386538otk.61.2024.03.22.08.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:42:40 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 06/11] phonesim: Set modem lte capable
Date: Fri, 22 Mar 2024 10:42:19 -0500
Message-ID: <20240322154234.2720542-6-denkenz@gmail.com>
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

