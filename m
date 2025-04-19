Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6FC4501A
	for <ofono@lists.linux.dev>; Sat, 19 Apr 2025 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745068959; cv=none; b=YTNEqfUqUdp+hmffpGXc5h//zpW0lLbHRRb4AeM8yOIjQQNtoYZ+g5PChkvoMNTDGCc5xYtqJNSGOoJhFCMWwGUGxHZvo5CEyBTDHwjRkDelwZffTmT+V6Q9OwW5oWP7EFqd2JQaoeQWZXQHDcROpFWSky3Udiga7BNlDnjdC54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745068959; c=relaxed/simple;
	bh=H3cfOqqYm2qwfgYcBk+kOpRIW/Y8vC3pjsp++Z0RVNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FMe88tOuQbDz6dTwW8epYhrJb/2/4YtuuFLWfEjwehkkNpeldbQt/m2FpjOirsvyB2O4O7dhpdwPhUsvu/8X7JGeaePf/vzB1oC7wx7M15l6zvXeIobhQifhQC/8sleKLFkfc7us4BixbsXhfG6Y98dBVsGydsKSrfF2nDX5ASY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=ME1FYYgn; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="ME1FYYgn"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=ME1FYYgnMbrtcx2P8aRtTP1vj1i/zsaVgKlk/Jd8nbgUDNG4WynsNqj54MfgCZTwnxy2r3HPX+LqrtC5Fk+i5WhbShGUct+i2jUQtfb42a58IAtQTqAyONpCZs8mQmVNpSqYZdbwjZ6c76ViRJk7oNdI8dPOCwW3CVy3JhE72PRIGetnkFdxz9A/ZOOMS9sGL6IaLCTk9rR+7BQBj0Zk7U2Q0L8yJ/CTvFUmTzf0j7FpFi+bX/QXKa0KNUvosioSxmwH31IkNmZvETFzeqqSTT7uGcYgBtEeAb2UwlOU2NsWrkXP76em33xLeTI8nGYK1YLYogTWGO8UIbs3y4FNpg==; s=purelymail3; d=purelymail.com; v=1; bh=H3cfOqqYm2qwfgYcBk+kOpRIW/Y8vC3pjsp++Z0RVNE=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1433134003;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 19 Apr 2025 13:22:21 +0000 (UTC)
From: Muhammad <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v1 0/4] mbim: Add support for MediaTek T700 modem
Date: Sat, 19 Apr 2025 18:22:11 +0500
Message-ID: <20250419132215.28887-1-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

This modem is a PCIe MBIM modem, found in a lot of modern laptops,
like the Lenovo ThinkPad X1. Unfortunately, oFono does not support
PCIe MBIM modems out of the box, so this patch adds support for them,
as well as MBIM extensions which are needed for newer modems.

Muhammad (4):
  plugins/udevng: Add support for PCIe MBIM modems * Parses through the
    sysfs tree and detects MBIM control nodes, net and   AT nodes
  mbimmodem: add support for MBIM extensions * With MBIMEx 3.0,
    arguments for activating GPRS changed. Update as   needed.
  mbim: fetch MBIM version on init
  plugins/udevng: Add support for the MediaTek T700 5G modem * Found in
    the Lenovo ThinkPad X1 Yoga Gen 8 as the Fibocom FM350-GL   modem *
    Works perfectly with ofono now

 drivers/mbimmodem/gprs-context.c | 59 ++++++++++++++++++++++++--------
 drivers/mbimmodem/mbim.c         | 53 ++++++++++++++++++++++++++++
 drivers/mbimmodem/mbim.h         |  6 ++++
 plugins/mbim.c                   |  2 ++
 plugins/udevng.c                 | 54 +++++++++++++++++++++++++++++
 5 files changed, 160 insertions(+), 14 deletions(-)

--=20
2.49.0

