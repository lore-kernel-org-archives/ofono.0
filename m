Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7273328F0
	for <ofono@lists.linux.dev>; Fri, 28 Nov 2025 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764351432; cv=none; b=Kl/ZjSNCUHvoOdt7DrQLsEPGwJjIAfHau4pA1OVJWDUeglQD75YeyxR4lpav0zMtIv0iPC0YmBlUfAWJ5pXw/aROEHHnYJIQWyz2MKxtwrPGU+uJLcjYAZaPj+Iovk2fEhA6VpX3IXbglf08NDBRjQCWOA01nY0MzjX+ayq1rC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764351432; c=relaxed/simple;
	bh=0ndxKB3RPTpF/7jAGOz3EpdNkgXCPrr2Ya+VGP34nT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PUZ4xYRFddZJenRzM7ROSxcfY9FG/uXHJtHrsyFhpTk2vj+mdmUmF2x0WX+jJz1ExxT1wp0jU7A9+xoqz73wj2ZVN7/eUBJresOAzweOjfD/zBF6gQIpsEEsnn25nkzcsQXKCmGt3mcTLhvGe/p5kLeyoqvRD2SrM2mJzleT3cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=t17KlbNV; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="t17KlbNV"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=t17KlbNVljX8ZUOHJTCEhN1RCRUDaMopzM682PcSaQa29pKJTZkJiGMSoX7gnG14/vhPA7x3dt2N2dGjZmaCdp0hBthXGcV+eJUomhfvqcONtr1jgR+A4pA+rX3jPBmeB0yfZdass7R2aeH8OUKsfSpsnzTiv/IEWLCu5poXpYiRQGAQx5DcHJLRSQ6XuXABBp/mxyecKNDZmRAhOcEKinPMX+92VTuk85QiYQGpn9iCh4YNXZ3sHKN8dsQ6S9Iv8rXUeprZp+SfpEpdUJifVe9vFc/n77kANS2y5+yFZFnVDegSFdHqU9mlC/zi8wY35DcB62FVM5BXPxfLIshjBg==; s=purelymail2; d=purelymail.com; v=1; bh=0ndxKB3RPTpF/7jAGOz3EpdNkgXCPrr2Ya+VGP34nT4=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1079628981;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 28 Nov 2025 17:37:07 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v7 00/10] mbim: Add support for MediaTek T700 5G
Date: Fri, 28 Nov 2025 22:36:46 +0500
Message-ID: <20251128173656.55692-1-thevancedgamer@mentallysanemainliners.org>
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

Changes from v6:
- Split out a patch that got accidentally included in another
  (I am really _really_ sorry about this, seems like nighttime is not
   a good time for sending patches)

Muhammad Asif (10):
  sim: add ofono_sim_get_modem method
  plugins/udevng: Add support for PCIe MBIM modems
  mbimmodem: add support for MBIM extensions
  plugins/udevng: Add support for the MediaTek T700 5G modem
  mbimmodem: sim: add support for querying IMSI with MBIMEx 3
  mbimmodem: sim: add support for querying ICCID
  mbim-message: Add support for parsing both UTF8/16 strings
  mbim: Add support for nested fixed arrays in arrays/structs
  mbim: Add support for SIM I/O operations
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

