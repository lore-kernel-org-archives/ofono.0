Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EA91A0B06
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391191; cv=none; b=MYgFqwJwkPivpbvSXW0/wZN8b/VkmVNfWl9HgDie1NxpNq9W5JEszYS4GokKXO4+10JTEe9sV8LqofTrxAz+Lw2g13lwSaUG4XQMBgWliBsKKYdTYM5jOmEXuMfcl5HA8s2Wvugb7Arcgz5+oKHzip8Kk4MW4Y343gi4pm0bSgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391191; c=relaxed/simple;
	bh=Y1PdZud7erIXoShijODcPVTJniAFQD+o57VgIzmdn1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qofefEi0KmJY18uiiiAg+a4kxvL0LcT+pXbI1jiZaufopi2hDGIUOVvDycEMNP4bNKd43vH2AJB/y0wVw2yTRByfhz02xOiLtOg0dpVvA8Pn3UQXzxkvWO66NPhHg1OnJeoFF/Rm5blqvR6n8f5KGHbEtvNPNqf12/j/zQAiroQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gftwm8Kl; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gftwm8Kl"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5bafe063f35so1490108eaf.0
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391189; x=1718995989; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMJ76HT01RXhDJay/m4oOJX4o+vlJaUvm7hJAa6MQ2I=;
        b=Gftwm8Kld/VFc6grK5evWR0RQINsPhzFWnbXxGr/V/jybfBEHDTWLCL5rnjF4i1/tl
         VvTEsH3ndYrcZjnqjgGashnZZXF88bucwbexlkEru0dsD3p62GlH8pR60fVrA/XdC391
         jnlGwYC6ek3Z2RK5VFLjRh7Kz06zudlNC2KsQI9BjoB0+uJNHUozhoUuof8TU1D0/fRr
         icyn9xlpbPcaYJCSSSUqE3yRHrLx1HuVEDptRhnghtiMKOF5+1gSHeInRHApDfoLV6cg
         z4ryx0kHBkpWFUJKyvLpIn/deihQTedYmwDbrG3gMkktj2/znifcOX70gk71YB5xQhuD
         8njA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391189; x=1718995989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMJ76HT01RXhDJay/m4oOJX4o+vlJaUvm7hJAa6MQ2I=;
        b=wCZ5kBZDAQDfYWmIPFSxf11rudmiX7UJsVgANGo1BeJOt7b4BoStuCvS55/4jx8Ux4
         bXTGC9ZHH7kNH6usJbubVDt1aQBPqBy7YvmADhQ1qq7eBqnh6uZhOIQNh9Jr4kxQRgT+
         zQsIW2kL87yHpsEnAAExR6WT4HIZ3zk4x0UMIlkm1pU71kfejDotkvbpvuSbPXBuEFQk
         0P5/nLiogX8Gp/aal0vtulUM/Z+tFaJ0Z19lsKRzgOzpjWxJSCnjaTRAa69+ElFhWsXj
         A4cz4rvqEUw4ogKHVwbexDn0l2HmaTsrIIbTf9NNGWZ0fAmj0P4bJ+VU/oBKmzW/onwR
         E53A==
X-Gm-Message-State: AOJu0YxtL7nVlmC39ha1WTa/sMNenjhjSvT4fHlDD1np5YrOM09dq7Su
	nJy1I84HInG7ha7hr8WpREpTjHQ7sP5FHDQMDQSLPADqn9Ya7g7WqVwyig==
X-Google-Smtp-Source: AGHT+IFTfoigqcPyGynZC1K7DscIars2g6PBg+hlNsGgFPVcSKE2OZsSahsdohlWCh7wvhGu4ApnOQ==
X-Received: by 2002:a05:6870:c084:b0:254:a2c2:d3bf with SMTP id 586e51a60fabf-25841169f9dmr1980170fac.28.1718391189144;
        Fri, 14 Jun 2024 11:53:09 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:08 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 08/27] udevng: Do not set DeviceProtocol
Date: Fri, 14 Jun 2024 13:52:20 -0500
Message-ID: <20240614185300.1086701-8-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614185300.1086701-1-denkenz@gmail.com>
References: <20240614185300.1086701-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This attribute is no longer used by the gobi driver.
---
 plugins/udevng.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 5ef0bc253562..864f9c12b9c2 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -252,7 +252,6 @@ static int setup_qmi_qmux(struct modem_info *modem,
 
 	ofono_modem_set_driver(modem->modem, "gobi");
 	ofono_modem_set_string(modem->modem, "Device", qmi->devnode);
-	ofono_modem_set_string(modem->modem, "DeviceProtocol", "qmux");
 	ofono_modem_set_string(modem->modem, "InterfaceNumber", net->number);
 
 	ofono_modem_set_string(modem->modem, "Bus", "usb");
-- 
2.45.0

