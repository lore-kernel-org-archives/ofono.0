Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6478460
	for <ofono@lists.linux.dev>; Mon, 12 Feb 2024 20:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770156; cv=none; b=mDExMDx9JfNFhUj596f4I6Nvy16YbznuQpoWSrOvCUkTIZ85LWAHP0SF1kaWS4crdn7lPNambr8K3tUMw330VokC06m0U8Epgec+itK41gNer9ZC6neV5xp8/IppKtthEtxquDA/U1eqFSk0kL1OmZxENr0o5/t2k8+nXR2nNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770156; c=relaxed/simple;
	bh=0JRhZnmqSbggDrg/0VmBwNAQvQVkHHNO6tJcOph6njE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XTVdk0dMxGhXpcnxLF0BCe1zNGHNgArpCKQEx77T4LiTtrrH80HFEhk15E6JRCMFsT0g0IRboJwuerEWOyapfz3Pf58yjECV7MAewqul5nNTgk2HKBUO7FO9aos/F2zuoLT4ViCPy1ksJQoke6l7SOm9pqoPJXHU4LmqLyFYTms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7FmMckI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7FmMckI"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55fe4534e9bso4707664a12.0
        for <ofono@lists.linux.dev>; Mon, 12 Feb 2024 12:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707770153; x=1708374953; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVkJndaf32pG8qtdr1hq7iwlSZtOtQ2Km4wn0SvURMA=;
        b=I7FmMckIdQslKHGkr1GxBzx7l6D0dUGLYNpaqT/q5gZY1ZyE/xr86OaMUVXGthq75z
         WlF19AlVNdqIxl4n4OwtMJqNCQ5vQ5krlTucxrCFVronyOBOgYrSLvPFgyuJQBaPS/nY
         gVVRfxhuD9NOZ68ydhvkxIVA2+jLr8t+tieO+zeizfMiQFrgQChm8G+27UtDwYpBv34X
         SmeZ8GxjW6GFySexi2sRDg3rBgZPVxQhfhxk5HCNpvP5iT1J5dPMlJi3FJMbJDgGr42F
         SmAmzrqDG7Ag3MVxI+XUdkvp8JzOcD14A3nh0DDqK7/D4iUrygkKvw3iRMVwmxDwP1mX
         q0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707770153; x=1708374953;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVkJndaf32pG8qtdr1hq7iwlSZtOtQ2Km4wn0SvURMA=;
        b=pI9H79hmiOh6s3XvYsw5GMEterJXDArj4g89jqoUkeK8r0VagQqlsyfw6wmMmHxUHy
         TXKV/DABTB6TyWFkgeSi4RwKrQGSDVYh5Szi2mY9ys5FzmXWRURygHe7lhFdDxHiUnL0
         9pfAAzvDjfVZg/mlC1XOWT+4LdZDtoKU1f/h6k0C7qd3VsVvZHIcR1XH2fAJM1ejudDA
         w/5w5Ej4Xu7cHqPxtwuqdyca4lgUvP0HJQFe0mD+mm1cLjHYjlu8F9yTFPMYgAXW8+lP
         oDFhz2/TuQQckdXUaKlxPCtj1mhJWbYw5bjUO6BdFQew9Ae4cw9t7+DCQuww2dXw3JRM
         rCvw==
X-Gm-Message-State: AOJu0YyEBjbZOIfdsmIStF2kLn+pFnSI0p978lJ8B3bNEAr3Y7F93+vl
	GgZFT0jRYYZ1gr+dGsb91VA+nXCfWyHnC4/yqlJ8GlHhhInma3UgqkUmKS4R
X-Google-Smtp-Source: AGHT+IE7UfPCwNDSL+ocAJGvO9/QwVZut/G4+fSXnJjQfKbGC1SNXeMfWIe3Fm7XEOIhfg1i3+K3iA==
X-Received: by 2002:a17:906:d8db:b0:a36:c353:952e with SMTP id re27-20020a170906d8db00b00a36c353952emr4588723ejb.41.1707770152563;
        Mon, 12 Feb 2024 12:35:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5ia9wB/tzswVZUMJNIFuMpVwW4vxBtn1/ouvSkNX0SQbDknhermMa/jXSWOqGhiCS7nxV5wj5yezH31++CVW1Yyvh+cQu72IsrB/qUYo4VQlSQK4XbvZBkeMxM6yp
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id k13-20020a170906a38d00b00a3cb2295aefsm538971ejz.205.2024.02.12.12.35.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2024 12:35:52 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] common: Drop GLib use from gprs_proto_to_string
Date: Mon, 12 Feb 2024 22:35:40 +0200
Message-Id: <1707770140-20746-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

there is one more g_str_equal usage(), fix that

Fixes 6f63dbbb ("common: Drop GLib use from gprs_auth_proto_to_string")
---
 src/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common.c b/src/common.c
index abb151b6..859f1467 100644
--- a/src/common.c
+++ b/src/common.c
@@ -756,7 +756,7 @@ bool gprs_proto_from_string(const char *str, enum ofono_gprs_proto *proto)
 	} else if (l_streq0(str, "ipv6")) {
 		*proto = OFONO_GPRS_PROTO_IPV6;
 		return true;
-	} else if (g_str_equal(str, "dual")) {
+	} else if (l_streq0(str, "dual")) {
 		*proto = OFONO_GPRS_PROTO_IPV4V6;
 		return true;
 	}
-- 
2.30.2

