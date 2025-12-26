Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37692AF1D
	for <ofono@lists.linux.dev>; Fri, 26 Dec 2025 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766758459; cv=none; b=NjR8OW9VlNZEFcDYveYx7guh4luosuKYHew0RAP58Gak1xuFiYiwyermcvx+SbDAY2v5QKa6N3h2ayzZJGkvoav16YsPcrXXoZHr+FAMwrcw93l5DVGS0hJOY8CQfIZfB6fQhKueYibkM2xjQPI1ihJlO4URUv/rS3hZeQxM90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766758459; c=relaxed/simple;
	bh=qUwwiCTEdNzup1TDudoPh+ZmdaSXEjTSpD+TwkKrgf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=snjW6iixEA2gnnlRkjEliOtFEQAD0FjKsIDYMmjpGIPCssDRn4ONaFb2XMLgoYVxEveNUuC8vBdJ43ZmMrG0Vk1jzGfwg6egeQJbjWlYQjybFKpP5NzJL8Z+jlO06YwHtT2KLOqxHZo7qL8NuWsueF9hfjUBgM7hDiXvjadlqGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=eP6GFERd; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="eP6GFERd"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=eP6GFERdrnxz8LqqVqlHLqDlaTInk2TghbPEt1OD+LquXK4KRshe9d20KD1x/0lPPvUNdCUMLTyq48Z0x/z0QwFGG2MyrD1MhjclPmRR3Nu3t2UavgBG3y/2IcUp7e/lL4Mhzea57HX5wSuDy6j54I7Adah7lfiOkA2+PgbY8kGo+eai0EF7g/fgkJaet36WmDqycshIBDIUMHmkdlQYVqZRXNf8CFQzS9HA2g1LoTj5BHmquQsDwsMdz5of9vQ6H563x7A/m26Qw0W8Gt+i0sfRJN96Au+8y15M9hDd7K+to1aoArd1VqMPXcpQjEDb4FjpvAUNuOOVGL3wMSn3Iw==; s=purelymail3; d=purelymail.com; v=1; bh=qUwwiCTEdNzup1TDudoPh+ZmdaSXEjTSpD+TwkKrgf0=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2072196880;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 26 Dec 2025 14:14:04 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v9 00/10] mbim: Add support for MediaTek T700 5G
Date: Fri, 26 Dec 2025 19:13:00 +0500
Message-ID: <20251226141310.41856-1-thevancedgamer@mentallysanemainliners.org>
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

Changes from v8:
- Added a new radio-settings driver
- Added support for TLVs
- Fixed ofono segfault when removing/inserting SIM
- Fixed memory leaks in MBIM driver
- Applied changes from Andres Salomon

Muhammad Asif (10):
  sim: add ofono_sim_get_modem method
  plugins/udevng: Add support for PCIe MBIM modems
  mbimmodem: add support for appending TLVs in messages
  mbimmodem: add support for MBIM extensions
  plugins/udevng: Add support for the MediaTek T700 5G modem
  mbim-message: Add support for parsing both UTF8/16 strings
  mbim: Add support for nested fixed arrays in arrays/structs
  mbim: Add support for SIM I/O operations
  mbim/network-registration: add support for manual registration
  mbim: introduce a new radio-settings driver

 Makefile.am                              |   3 +-
 drivers/mbimmodem/gprs-context.c         |  67 ++++--
 drivers/mbimmodem/gprs.c                 |   2 +-
 drivers/mbimmodem/mbim-message.c         |  95 ++++++--
 drivers/mbimmodem/mbim-message.h         |   5 +
 drivers/mbimmodem/mbim-private.h         |   7 +
 drivers/mbimmodem/mbim.c                 |  18 ++
 drivers/mbimmodem/mbim.h                 |  37 +++
 drivers/mbimmodem/mbimmodem.h            |   1 +
 drivers/mbimmodem/network-registration.c | 116 +++++++++-
 drivers/mbimmodem/radio-settings.c       | 198 ++++++++++++++++
 drivers/mbimmodem/sim.c                  | 283 ++++++++++++++++++++++-
 drivers/mbimmodem/sms.c                  |   5 +-
 drivers/mbimmodem/util.c                 |  46 ++++
 drivers/mbimmodem/util.h                 |   2 +
 include/sim.h                            |   2 +
 plugins/mbim.c                           |  39 ++++
 plugins/udevng.c                         | 119 +++++++++-
 src/sim.c                                |   5 +
 19 files changed, 994 insertions(+), 56 deletions(-)
 create mode 100644 drivers/mbimmodem/radio-settings.c

--=20
2.52.0

