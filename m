Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334AD17BED0
	for <ofono@lists.linux.dev>; Sun,  4 May 2025 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746386432; cv=none; b=YU9Cs2fNAuOa7UHdHI05qszJIOX/utWnBrJ4e1XSHSYQ8IBsX9C8zQhSZdd2GZxBpZYaUTMtXQxm598Ijt8+1OQ7tSTASrt9CiPoKQDZ2/APAiYUIJY6Z8RQMyvgqHVLgnwLC/OgDOUitBN51grcj2CtBIlIL/IougEBvZlcNpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746386432; c=relaxed/simple;
	bh=jBJMOsgpVo0E4rXxHL8GmqqFB33w8vh1wyxcGuPHTYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHB8fRrrsX4elqGrnEXfckRSMS1yr1YMU911TNiuuELdo5RFX0kSo18yebXgEadkEypCtiwYJ50d/Tw9PCU+4lwwo79ejkwxuCOEkgi1Tct13815+9dZugDNkLrC8Vt1TNLT/nCXVdnfP6r/7GnkFtfZmYXzi9p0PmszIXSazck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=wuLNqr9A; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="wuLNqr9A"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=wuLNqr9AfDaKhMeb4LM3GZzHU20PCu7jhvM11Y9lD+oCFo57zXLGhh+F5945aLr/rMaxOvLGj6xG9iOMbHs9LxtoSq7QJ/4pNA/ZPLEGSRfXlXCD2JkSUf9FGzo0NSXzkv+S51nuiYEgl5T0q0tAy7TJluZEtmSwMMzjFNuDOei2l6rQMEc+0QUTCuKFlEGewuBxbaCpncI6FbEQUjFqk22hT+Z+6WLmCCShqWsyOzv/++QJP3wwF/UC6azHDYsBFcs2Ws/AJwoAsS18WbblNATswEfEACgYwdes/mvFdB2l9bg780GV3SRDwyWxg9gr/EEMhumIgXcMSwqiyAKGCg==; s=purelymail2; d=purelymail.com; v=1; bh=jBJMOsgpVo0E4rXxHL8GmqqFB33w8vh1wyxcGuPHTYM=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1694754991;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 04 May 2025 19:20:24 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v4 4/6] plugins/udevng: Add support for the MediaTek T700 5G modem * Found in the Lenovo ThinkPad X1 Yoga Gen 8 as the Fibocom FM350-GL   modem * Works perfectly with ofono now
Date: Mon,  5 May 2025 00:19:29 +0500
Message-ID: <20250504191931.7078-5-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250504191931.7078-1-thevancedgamer@mentallysanemainliners.org>
References: <20250504191931.7078-1-thevancedgamer@mentallysanemainliners.org>
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
index 09c916db..5ca745c2 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -2282,6 +2282,7 @@ static const struct {
 =09const char *pid;
 } pci_driver_list[] =3D {
 =09{ "xmm7xxx",=09"imc_ipc",=09"0x8086",=09"0x7560"},
+=09{ "mbim",=09=09"mtk_t7xx",=09"0x14c3",=09"0x4d75"},
 =09{ }
 };
=20
--=20
2.49.0

