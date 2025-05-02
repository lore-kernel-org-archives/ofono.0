Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BD21EB5EB
	for <ofono@lists.linux.dev>; Fri,  2 May 2025 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212653; cv=none; b=UUWM7luQkJh2bfB/F5n6DH7X+KPifKdI/fx7L0tJ0Bw2jDnze/mb8iohsz9hbO+ABlz+wEEiibXTTFTxv7Xg/XflvEvIR1j8E1HT1NQUR4cf07AB3WEEJ7qby4ahMgauyb9fY+uLUTGAU2i0RUwgfZs79S4ymnpVwGhvBVH+ylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212653; c=relaxed/simple;
	bh=qR8cdBjlSYGlmVT8/LAwSvSTconfyu4pGSEiww6GnGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXnGLEbDY775rlU3g6tPl+pB4UepgPnzfMsPDdCPFFjBWjeNQD/VUpSZs7MMIPcnjhuEIsgsQvgO2FDl35bhZN2wZ6M5W326FIw/mrvMpK3uh9CphbkQ8Wp1WVqENI/jVRPhgzPd4gXzqf8gfTqGVO5eTxaz2mmdc/ZAcc+3dl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=tKxoad9U; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="tKxoad9U"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=tKxoad9UA3LtHPX5dDlVfVaRLaDnRp3ckvpLKcpLbM8TZmx23Ug5NlWTchwN44m85k7gezoB2298XRILkjQwvyp5h3Kbe3OmlrtFhbs2KtWnT9oez3B9eKTXHwMU5Y1Da9Ukpnacd84sRBwN0Ss+1ONoHLUsjN4Efa9J43WRA28x0173fhrY/j1+tAzFab/7sZRfbsne6dzlZ53c32WqMwNLWaVYy3hKtAUU7BIRFYYnDli68SG30VuAXcLWQD/Kl2dfPnb8hl3gxlW7broH8byXx4+jRBCyDSbTV3VLBtvtBYT2c+31SPt5Sm2/9qKP/EfZ2Xt+IXOD508q0tBktA==; s=purelymail2; d=purelymail.com; v=1; bh=qR8cdBjlSYGlmVT8/LAwSvSTconfyu4pGSEiww6GnGo=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1492705212;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 02 May 2025 19:03:55 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v3 3/5] mbim: fetch MBIM version on init
Date: Sat,  3 May 2025 00:03:16 +0500
Message-ID: <20250502190318.41366-4-thevancedgamer@mentallysanemainliners.org>
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
 plugins/mbim.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/mbim.c b/plugins/mbim.c
index e1d33f47..3a1942da 100644
--- a/plugins/mbim.c
+++ b/plugins/mbim.c
@@ -287,6 +287,8 @@ static int mbim_enable(struct ofono_modem *modem)
 =09=09=09=09=09mbim_device_closed, modem, NULL);
 =09mbim_device_set_debug(md->device, mbim_debug, "MBIM:", NULL);
=20
+=09mbim_device_get_version(md->device);
+
 =09return -EINPROGRESS;
 }
=20
--=20
2.49.0

