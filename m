Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9902F2E
	for <ofono@lists.linux.dev>; Fri,  2 May 2025 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212653; cv=none; b=R+a2Kvq8F9PIMUFS6DdlGePNhUB3r/06oEv7yPe12I9um92/XQS6mqcPiOFkvv4rlyejlDwp1xA4rqN9/gMUUn7uHyObSGC+2+VKKrweTz3iZiU2kZPZHG/ur2Nux67eq0bB9jTsSWuQjtqL5+oq7n/MeUtPaco2kicTr+bFD8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212653; c=relaxed/simple;
	bh=OhPCswwXGP8AsJ/2PPE+6nR58C6tr2P2e3gk2sBwaCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KljtYHW00NdY5BbDGrqSb0t6pYGuwnIwWFrpsMrkZ1RhatU/5loIrgg3JDyUoRbGjS8oKeun2Wf2bMUgkL4dHbL58bFQM4lKMpR6Qy1UJBK8th5JMZdV1TAKqU1j3jN/WcCk9TgwvQfJTt5owA0X1LnErb48uukGU2qWRfdqD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=v/DxmPrf; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="v/DxmPrf"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=v/DxmPrfoy1U3x9S0Ad7dCPoaJoy9nZIDoR3+ku1rpQe7fMTQ9EDYfLQ8lmksPC6PDLg+3WnLIhHNAqC4IF0xQbQMCNvAh9yQaCabmvamYkpEo9Ntpg2ddsAiyZMU4NpNNLtmmHHu8ZECEnPDFbjjjJrLasLRkXP3FqAvLGAczgUYIbO6XfNqcIHyszV40pj3KPvkwL9a68LiK36r4WeauXhp7jMIToUu1MSasnJ3HaBWffKY2p4bIpXJUiYFM52K7jxVkIpeSeBb91BPpuTE/B7J912USDpZhDGsZwngAKtq/Hpx/iAXNEvhKTSWqW1ZxCni0o7qyua00UP/qjo9Q==; s=purelymail2; d=purelymail.com; v=1; bh=OhPCswwXGP8AsJ/2PPE+6nR58C6tr2P2e3gk2sBwaCc=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1492705212;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 02 May 2025 19:03:46 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v3 0/5] mbim: Add support for MediaTek T700 5G
Date: Sat,  3 May 2025 00:03:13 +0500
Message-ID: <20250502190318.41366-1-thevancedgamer@mentallysanemainliners.org>
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

The previous patch series was flawed, so I resent the patches.

Muhammad (5):
  plugins/udevng: Add support for PCIe MBIM modems * Parses through the
    sysfs tree and detects MBIM control nodes, net and   AT nodes
  mbimmodem: add support for MBIM extensions * With MBIMEx 3.0,
    arguments for activating GPRS changed. Update as   needed.
  mbim: fetch MBIM version on init
  plugins/udevng: Add support for the MediaTek T700 5G modem * Found in
    the Lenovo ThinkPad X1 Yoga Gen 8 as the Fibocom FM350-GL   modem *
    Works perfectly with ofono now
  mbimmodem: sim: add support for querying IMSI with MBIMEx 3

 drivers/mbimmodem/gprs-context.c | 59 ++++++++++++++++++++++++--------
 drivers/mbimmodem/mbim.c         | 55 +++++++++++++++++++++++++++++
 drivers/mbimmodem/mbim.h         |  7 ++++
 drivers/mbimmodem/sim.c          | 30 ++++++++++++----
 plugins/mbim.c                   |  2 ++
 plugins/udevng.c                 | 57 ++++++++++++++++++++++++++++++
 6 files changed, 190 insertions(+), 20 deletions(-)

--=20
2.49.0

