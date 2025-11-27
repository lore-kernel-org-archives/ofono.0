Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83601E4AB
	for <ofono@lists.linux.dev>; Thu, 27 Nov 2025 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265813; cv=none; b=CPl536l2IPTAZRVSGORnktafWuqpYA7iRSoylFeNhoPcySqURYTjiPRNGcDUYr5aFUUUgrfFUJX7M5K7BEPgpgmv8PJsoRK0JrhceD3Wl8Js+f40MFa5dY8Qlklb/2C7jswn3k/O9pR/nnXJSH8pnTyXANG9TRT6Px3WO9ppD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265813; c=relaxed/simple;
	bh=bwkFWGaDpq/JDKLlsjzDsvCz0nA7wzPCnHWxoWtKtmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ainLD/regD/OEpfCDqHPYwcMrbzftG6o1WRAl40JeIkqGu0CHRDlqDZ9x4HiZ9tQrF2qwCj3eXFzCF7efbXuipkO23XwFc5hBf4kdjTw0qGRdy2+7y2XF93DpeADbFKbP8HFkzORTHxkNLJdUKruPdMz0cQSlHkGRCbOBv7loXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=bZJGagwa; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="bZJGagwa"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=bZJGagwad0HMYxIIB0kFYhZe4SxAcEwYBa31BStu71gVwnuSybWF/jX82FIanDNH/cr92z1+QHHqZmlWRmDKY0unyk2ZY431ea5ezYcrADCpLEDv47n1auspB4aSZLdFeF8mzp55lT7sbCCEodYtIVRdrrw5p2Hn7IeB1v/7vKa4EnySz0SEY+sgGoRUz+MhltcxmEYZJ6QFj5uCBBnricT4YLb7fPH/fBe84Lv3tPe3JjVyfxRc53EH1dJdw3klfxc/CCuxg4qdmJsvteI+mAxOn9LMtdisHxfPpz7q7KrsCddl8PVBBOTq9wPbGdbxG2Z6YigwOK7L6dvxRkHE6Q==; s=purelymail2; d=purelymail.com; v=1; bh=bwkFWGaDpq/JDKLlsjzDsvCz0nA7wzPCnHWxoWtKtmQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 62202782;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 27 Nov 2025 17:50:09 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v5 04/10] plugins/udevng: Add support for the MediaTek T700 5G modem * Found in the Lenovo ThinkPad X1 Yoga Gen 8 as the Fibocom FM350-GL   modem * Works perfectly with ofono now
Date: Thu, 27 Nov 2025 22:49:38 +0500
Message-ID: <20251127174946.89981-5-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127174946.89981-1-thevancedgamer@mentallysanemainliners.org>
References: <20251127174946.89981-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

---
 plugins/udevng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index bae0be76..5199d6ab 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -2317,6 +2317,7 @@ static const struct {
 =09const char *pid;
 } pci_driver_list[] =3D {
 =09{ "xmm7xxx",=09"imc_ipc",=09"0x8086",=09"0x7560"},
+=09{ "mbim",=09=09"mtk_t7xx",=09"0x14c3",=09"0x4d75"},
 =09{ }
 };
=20
--=20
2.52.0

