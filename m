Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9438C3054DE
	for <ofono@lists.linux.dev>; Fri, 28 Nov 2025 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764350302; cv=none; b=bNzAylM/Gzt6oLuS2thsh9rrolOA9w50RUGoQFEYKLh/7J3N+R8ClQ1qxdbjcl6EG2BIxmkSJAcMJAfQyXCEhQK4Z6Gl91yGeX879korJvXeXflT5fjwsbs/5xrly/MNhUzfSOjgLsoPuiBeTRLfLzi+E2qjdX6fen2b2ZFGjrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764350302; c=relaxed/simple;
	bh=P5t34/HrCQ6Xi1T2kQetyIVkM37ffdt9crom5NcxTL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vCgtRg2ixHPrGwI6xRsfHFB/XN7JZU25MoiMxV8HbdIvLjpwXAIihutU3CUYkz9eFsmj+JZq2LdgwE48CkWRzc/MGUV3gxfFEjw+xxvLwODUU2hU07APdjiF/J+cav5zEXO0slE0CA47rO86uSrRp3Qcpz6gyBq7jb7mfhVUw2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=TcySVr0Y; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="TcySVr0Y"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=TcySVr0Y+IZP8t/GOf51BvXJMTp3IoqlorpxXSmEWG0Dy/mln+RGoNl3lZIJZUH9LgVuK6cKIx1lBBdpMGKgmpWV4fvk+BFBOdI9cQTL3fAxlBhmE2ZktxHPfX0ozZIK1IcG89dXhLKbW34HA95NXoii4H9m3MYbPh/y1MSlz7D/2Vx4NrRlpJIwyAaSEVaR+l6Hec0jZAgYqIpiqvdAFmAMdXKnge5MFRzL8s+KxPdORIjzNZBt+5Om53IYYInCLtfDLoKYWGD0vaC13Stq2g10Ybp+tSgyUS8mrLsCTY9/kn4Rw/RDf96F5uaexttAD//dMY7Hub43pWJqVBSQMw==; s=purelymail2; d=purelymail.com; v=1; bh=P5t34/HrCQ6Xi1T2kQetyIVkM37ffdt9crom5NcxTL4=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2023556145;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 28 Nov 2025 17:18:17 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v6 0/9] mbim: Add support for MediaTek T700 5G
Date: Fri, 28 Nov 2025 22:17:38 +0500
Message-ID: <20251128171747.32679-1-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
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

Changes from v5:
- Fixed the ugly commit messages (truly sorry about that!)
- Fixed patch corruption (git decided it wasn't having it)
- Migrated from existing code using DIR* to GIO
- Improved MBIMEx naming and functions

Muhammad Asif (9):
  sim: add ofono_sim_get_modem method
  plugins/udevng: Add support for PCIe MBIM modems
  mbimmodem: add support for MBIM extensions
  plugins/udevng: Add support for the MediaTek T700 5G modem
  mbimmodem: sim: add support for querying IMSI with MBIMEx 3
  mbimmodem: sim: add support for querying ICCID
  mbim-message: Add support for parsing both UTF8/16 strings
  mbim: Add support for nested fixed arrays in arrays/structs
  mbim/network-registration: add support for manual registration

 drivers/mbimmodem/gprs-context.c         |  64 ++++--
 drivers/mbimmodem/gprs.c                 |   2 +-
 drivers/mbimmodem/mbim-message.c         |  51 +++--
 drivers/mbimmodem/mbim.c                 |  18 ++
 drivers/mbimmodem/mbim.h                 |  37 ++++
 drivers/mbimmodem/mbimmodem.h            |   1 +
 drivers/mbimmodem/network-registration.c | 103 +++++++++-
 drivers/mbimmodem/sim.c                  | 248 ++++++++++++++++++++++-
 drivers/mbimmodem/sms.c                  |   5 +-
 drivers/mbimmodem/util.c                 |  56 +++++
 drivers/mbimmodem/util.h                 |   3 +
 include/sim.h                            |   2 +
 plugins/mbim.c                           |  39 ++++
 plugins/udevng.c                         |  78 ++++++-
 src/sim.c                                |   5 +
 15 files changed, 670 insertions(+), 42 deletions(-)

--=20
2.52.0

