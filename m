Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F6681741
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532669; cv=none; b=h7wCHqSdbqbkBIDD20nSPvYDsas1SLNGfFyuAzJinzUZPUsdxkbZrLJbB3XyV57V8J5SokGpzB+UwVuHAWfvoS/Aj7L8Uxr7ikYirG/JEZLTHcNO26WsCbdlAtyh5bBsNELAFlPWyh+iQ4ZBQ3oIBxb+QTMi6VKf1NIxjbF5uvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532669; c=relaxed/simple;
	bh=i7tvfcKFmnVh78d8KtLw3QfEElFRS6FPwMN02y3MjuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJ952RPsRhVReTLndYx9IJ8EtFjAG1Y3zHZ5DTfdV4hNcESG5jdF0qUzvC7QN3NDNgWjwXc/OMIY+WKX5LtNPg6KuY7lw7aIozVh9Wyh1xtZD9vJt+CrOTzre5ZS5kVruURMqrS1vw9wXaTSGSJFU197OEzbwhDa1YKek+JxObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6YboZzG; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6YboZzG"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59fd69bab3bso1064587eaf.2
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 08:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708532666; x=1709137466; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUxnPqn+84Zt1123ccdhiKW5ymXzGKm/tisgzCQrOLY=;
        b=Q6YboZzGjdJgOCl7GJfUeM51h03G8q43v9kMGYcrDMLJF174Ozz2p3r53sXnxLnRiU
         3j8suZUK+dSzeEpd3tTK+Hzdpq6/IpxwYqhDBoHETAvJ/dJ2WkP2KvkxBH7MgqSrS+oA
         EN0oGWBFxwfXSVmuba4HT4fiwPMpLFqKy4O69EG0ZkC6FgWFOUXyLkC6er2JOx46Kn14
         lrlRkFjELjew8WdqT5RqgHrUvdMM+Po9Tx0e/nRCtwFkEAWS4op2DZUJTsVfVeQ5pEIx
         SqG4ZRZ9auR9iDZIvud0MvOf398Vaf2GVMUX1WVN25gFx9zEjvZhhmkiKidmARgYQ+0c
         aQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708532666; x=1709137466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUxnPqn+84Zt1123ccdhiKW5ymXzGKm/tisgzCQrOLY=;
        b=JK2kUUSMfUpU0Q7tptwA5oH2AfQ70xZGRVuwAVBlF/OtwioSmUNIb2mvHEAdzCFDDd
         0wMPBGNRGYsjK8Tcvjf+IhD6GkMy56KGD/LlonGU8sVU1/ImvCRJ8olhFOBH3GQYJFVw
         cLlEWY5aTKnPApK9S2Zjyj537ZSW5rZlCAIdDCEvHGyfu5Q0uQRqwAaDEn+ETrbcSMeC
         IXn0Q7pjNHGDM7PwzPDd1CjrjAD+M9r3pQnOidVJlzu9LN4ECNXM6e9zVzBERfAY/nhf
         6EzM2aTZuSp/g5xGJ9NMcKdJ1OWNDsQIf7ii1hUtCRy/EVSt0GhsG6CmflG0WzcfsG6H
         jDgg==
X-Gm-Message-State: AOJu0YzztPsciA2ak9SkZFNCXpxqAJWyr6eB/mhWV5me3By8CK8WomL7
	PVsGHJOLA1tViW0XTFpgbWiavCOwrFxCx0/zh+X+7e6SNOgw1aXsEBEUarG/
X-Google-Smtp-Source: AGHT+IGH//ey2u+AO701tYtJXfQw2bVLBIRDH2tB+MHZrvcBVKX5Ul3I9qgKrcBPSkhfWwDCv2Fi/w==
X-Received: by 2002:a4a:dfac:0:b0:59f:e26f:fb1a with SMTP id k12-20020a4adfac000000b0059fe26ffb1amr8446002ook.3.1708532666554;
        Wed, 21 Feb 2024 08:24:26 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j25-20020a4a92d9000000b00594ee4b4339sm1905405ooh.28.2024.02.21.08.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 08:24:26 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 7/7] gobi: Fail if device could not be created
Date: Wed, 21 Feb 2024 10:23:20 -0600
Message-ID: <20240221162335.1258315-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221162335.1258315-1-denkenz@gmail.com>
References: <20240221162335.1258315-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If for some reason the qmux device creation fails, indicate failure
early and do not rely on the 5 second modem powered timeout.
---
 plugins/gobi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index e22b8146cf93..4134c62d398e 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -431,6 +431,8 @@ static int gobi_enable(struct ofono_modem *modem)
 		return -EINVAL;
 
 	data->device = qmi_device_new_qmux(device);
+	if (!data->device)
+		return -EIO;
 
 	if (getenv("OFONO_QMI_DEBUG"))
 		qmi_device_set_debug(data->device, gobi_debug, "QMI: ");
-- 
2.43.0

