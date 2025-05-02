Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB16A1EB5E6
	for <ofono@lists.linux.dev>; Fri,  2 May 2025 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212653; cv=none; b=Qe2wLFWz59pamcnMGOSs9+hVuYGWWXyOQ/XEbNl2bwq1RJ7ezpxvNWHmaGORB+IYjHkfkiYBQWCGLeN1HEkLFDFTGKk+SfRPGv7Fpmv+J3OyrMldXE/GIHQFvqJ7lSe6UArsT1JQV/oye5ii0vdWqG86pTZQ4b9TuoUqvtdn18E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212653; c=relaxed/simple;
	bh=S+eRGdce9fu/Y6GrzCa+V+i4Tyvs005CcTNnHTEOc+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LopZKRND/E+QC/yvLMHxfm/VfSTXGNJVG3WZbt8WZcy9FVK+VGJtbhXKLKwIeUkxJtV6oZPJlt8SW3vIvQqkbG9rXl2CHQ399bnHx8MjxbgOV4rToL/UfhQRWj6ABBcpy8u/Z+wMquR/9gqQCc5aLMVt4zw8ODVW+L32qbkXC/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=IBElEEJc; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="IBElEEJc"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=IBElEEJc/2xy4d4K6IZTAhu/JXrHKjPMzglsmIyyNGWzxcYhqqc521Svkwi6eSYV3nn0T7JcWwwSRHeWAFSOnyRTMfg7FhdUShp8KpqGgfRxKvSZqSlkPiuXQtGtW34mRg+NUUaYNjyI/AL6jWW2FOKR/0PrBDHQqsQOCO9xTlv3qABOuKhE4hS4yR37AoK3rmiNOMUxdGXtmUZS/2dhrQV7caKL4c7RbSdweMaXPslfF2ZfthGSFibGWyiCnYk9GUlwi4PfOQKsd8K4Rq0cdsHKOMRffULpBtxmK9poHsVAGTVeF2ZmBTK6bI5iwPOU33w5foZMzydsOyzkiTE6/w==; s=purelymail2; d=purelymail.com; v=1; bh=S+eRGdce9fu/Y6GrzCa+V+i4Tyvs005CcTNnHTEOc+E=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1492705212;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 02 May 2025 19:03:57 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v3 4/5] plugins/udevng: Add support for the MediaTek T700 5G Found in the Lenovo ThinkPad X1 Yoga Gen 8 as the Fibocom FM350-GL   Works perfectly with ofono now
Date: Sat,  3 May 2025 00:03:17 +0500
Message-ID: <20250502190318.41366-5-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502190318.41366-1-thevancedgamer@mentallysanemainliners.org>
References: <20250502190318.41366-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

From: Muhammad <thevancedgamer@mentallysanemainliners.org>

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

