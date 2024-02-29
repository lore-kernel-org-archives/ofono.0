Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309D67580B
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230072; cv=none; b=Y9NiQlEgPHuMDTVbV6KXpfYOfP8Pb6fO07hMjq3Ctu0j3cqP1R2CcYjDeP59OCHZWGvhzd5SKxg/ACXtrkYppPKh6rPlevx+YGXUEtoir+all/+lHuRyg7h59IyEMPEqY7bgo2HA9v5F79if+fGQ7+EGGGjD02/powwMwuj4Jr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230072; c=relaxed/simple;
	bh=ALaFddaMybjdvoQUptL7z8fTvU8rFFNWAa8p+432H7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxKXRhTPTPkbkGiOyeoiPKsQis1pmtWwcIV3Yu2iMNvP5uA1lDyGIg0HMHjLNXhzhw0ubESVUsUNCMsARYUEbsuFeqkRAaibqx9qZv7HqCqBhHXu00QC6Os5wlAKUniwkybFFSMFa2525WdzJ6HXkycqEOMesSmQUdmFhQwir74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amWh1+pS; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amWh1+pS"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e0f43074edso768185a34.1
        for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 10:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709230070; x=1709834870; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmtEp7NOnUMWVq/LgsQkQj+PEKpnbL/3LbpIH3T9rdw=;
        b=amWh1+pSHZKA3x7MDBUImZPLJ8Zf/sA9Ef7v1O96Krs7DCPSDWVvCrxOQaUI+XE50C
         WuEAS9ymHFc/dFoIUJacmB89i+39p47k86A0i85wpHJBJTv5CmEV/81asbbQA/Lg6xTe
         Pi9BIZ9xo8R0Tc5synzxsNCydh/IZ1VZzPGqdJRD6S0YjOUDFulhWDrm5fPnJxytDGGU
         hz0lNBzB/wtai/ePFmKH2smG9tLbTg9hmz7hBdoVAgeDT1GiZGkf7dKVeJRBKogGm5fJ
         tEkBwm1Jl/yA6R+jNs8cGelAf7F+s9ivprMFLHn3bQ5mZ6ts6Z1DNJoI1p3Z+4jyixCa
         aD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230070; x=1709834870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmtEp7NOnUMWVq/LgsQkQj+PEKpnbL/3LbpIH3T9rdw=;
        b=BF1+F9Tsq4tV/isNh74GD9m/Ud0zzI3/f4v9TCaazc8CXlo/LgiVpfIfrDPdmHIJAN
         2ZRmJckfnCBPVC1F//u/+77iHAqInEPmBbCvJGOW4vheLg8UcyUe/QbN7Vk/bNIW5SE2
         5GJpqrusfF0jLf1OWT6aURBSRlKV8Lv+RPB3vXxn58szUJOvlX7u9JtFogGTQdJghyA4
         9PEG2pB9FQpDcI5NfP9a4nyfiKpmUMqHaKOkEhXFXdw1a1wQhymTD77iG5ujof/OujWV
         XV6X4Q2C6Hzo+sHRT+FKz6JhSjbAfzlfasgHqkKBwO75wLgHllIJEwETkEd9GlwQChEj
         gt4A==
X-Gm-Message-State: AOJu0YyvTfYbY2myXNt4VA6oFtUT+rKYXA+wYJWaXnrIhT+JgJsJKKOa
	yetZUeVrB+cXD7ZGjgMfmIjatFc/QjS3G4q6LXCcWfNjrF45rEs3Vy9uzvji
X-Google-Smtp-Source: AGHT+IEkR0qaNLVta2E5ibCg7WdYbHyLpD49eHdvzikWrfwPIDkd0kVPSPWtwkyZNPg+yRxur9EmPw==
X-Received: by 2002:a05:6870:9597:b0:220:8d98:fafd with SMTP id k23-20020a056870959700b002208d98fafdmr3182884oao.4.1709230070053;
        Thu, 29 Feb 2024 10:07:50 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id gz14-20020a056870280e00b0022008c33ee0sm549899oab.36.2024.02.29.10.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:07:49 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/4] smsutil: ensure the address length in bytes <= 10
Date: Thu, 29 Feb 2024 12:07:34 -0600
Message-ID: <20240229180746.1671015-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229180746.1671015-1-denkenz@gmail.com>
References: <20240229180746.1671015-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a specially formatted SMS is received, it is conceivable that the
address length might overflow the structure it is being parsed into.
Ensure that the length in bytes of the address never exceeds 10.
---
 src/smsutil.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 954f92df2c0d..e89b4567f9f4 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -643,7 +643,12 @@ gboolean sms_decode_address_field(const unsigned char *pdu, int len,
 	else
 		byte_len = (addr_len + 1) / 2;
 
-	if ((len - *offset) < byte_len)
+	/*
+	 * 23.040:
+	 * The maximum length of the full address field
+	 * (AddressLength, TypeofAddress and AddressValue) is 12 octets.
+	 */
+	if ((len - *offset) < byte_len || byte_len > 10)
 		return FALSE;
 
 	out->number_type = bit_field(addr_type, 4, 3);
-- 
2.43.0

