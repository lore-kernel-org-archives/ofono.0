Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76D226E6FD
	for <ofono@lists.linux.dev>; Fri, 12 Dec 2025 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573398; cv=none; b=I2EpSrqTGeR4MljXh/P315HisfuSgI5nfAsjvI1RQeXO4GBA6083IV9UgtVvS80SVE1HcKIPsx2AG2h7xBtH9MASY/jWF/G3ktBSCiYCrtG2Igm3ago9sljeqNkVT4wdj8+MXq2bDVvM4Rm2axeuoDSoUE46DeYeN8njQ/dg7mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573398; c=relaxed/simple;
	bh=8guzIHNmcmJqBM3Ej/FbJ4TBlUqlbc/WYVTR+8LqtQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tsXQrZZfCVL9SEKOktdic/UojOPmftLJAyloDXSrGlHAVVBKsoayNZzJ8o+nr5MdA0BD0aYMFhd3D6M7+NdmnqSA+Vgt5GHm4DTV8ySf8bqYqV5byb5qYaz1e7zg/D21auPSTT4FLwPYL9lapdDh/GWQTsePC+Bn0cemmXXKSxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=MOGSn7f0; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="MOGSn7f0"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=MOGSn7f0az/iCy6z3K5zBx2kftoKZpFXj/+DlKdU5e5deegLEeK1iutrS/HOeehw6gfDNoueQp+/kst4oaQwArjLsPpaxdy4tBqCxVGhnc+WYSefOEk8y94mWKYLAFMWVDtCwnK59l6MFW/ZN0ZnbDH4gbXMT7Ske9hb365R42MBWlbVMUi0YrtX7qAmxAnSjnnQ4TkBczMXYIJVl5MFYM+CF+bt+eK0XbBTCdSmJUyNTRNNi8RmV1W3OoGxUTTShWkVCDkNXWTFTskfW8aDGB/ecUUqQin6T5mQC5JKibZrOP8BY7Rn3V3jdDgAAlBxZ1U9w7aiTrLscP6Ix3zsRQ==; s=purelymail1; d=purelymail.com; v=1; bh=8guzIHNmcmJqBM3Ej/FbJ4TBlUqlbc/WYVTR+8LqtQs=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 511728581;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 12 Dec 2025 21:03:02 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v8 0/8] mbim: Add support for MediaTek T700 5G
Date: Sat, 13 Dec 2025 02:02:41 +0500
Message-ID: <20251212210249.95597-1-thevancedgamer@mentallysanemainliners.org>
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

Changes from v7:
- Applied changes from Andres Salomon
- Improved the SIM path resolution
- Unified the core logic between mbim_register_{auto,manual}
- Fixed some leaking variables in the MBIM code
- Removed a pointless patch
- Improved comments for the code responsible for resolving the PCI MBIM mod=
em

Muhammad Asif (8):
  sim: add ofono_sim_get_modem method
  plugins/udevng: Add support for PCIe MBIM modems
  mbimmodem: add support for MBIM extensions
  plugins/udevng: Add support for the MediaTek T700 5G modem
  mbim-message: Add support for parsing both UTF8/16 strings
  mbim: Add support for nested fixed arrays in arrays/structs
  mbim: Add support for SIM I/O operations
  mbim/network-registration: add support for manual registration

 drivers/mbimmodem/gprs-context.c         |  64 ++++--
 drivers/mbimmodem/gprs.c                 |   2 +-
 drivers/mbimmodem/mbim-message.c         |  51 +++--
 drivers/mbimmodem/mbim.c                 |  18 ++
 drivers/mbimmodem/mbim.h                 |  37 ++++
 drivers/mbimmodem/network-registration.c | 108 +++++++++-
 drivers/mbimmodem/sim.c                  | 248 ++++++++++++++++++++++-
 drivers/mbimmodem/sms.c                  |   5 +-
 drivers/mbimmodem/util.c                 |  50 +++++
 drivers/mbimmodem/util.h                 |   2 +
 include/sim.h                            |   2 +
 plugins/mbim.c                           |  36 ++++
 plugins/udevng.c                         | 112 +++++++++-
 src/sim.c                                |   5 +
 14 files changed, 692 insertions(+), 48 deletions(-)

--=20
2.52.0

