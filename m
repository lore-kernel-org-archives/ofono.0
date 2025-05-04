Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D1414885B
	for <ofono@lists.linux.dev>; Sun,  4 May 2025 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746386426; cv=none; b=nM7LrxvMdR/DYukFxt9uy77gmr3bx9Q0uVtNHRteja5g2lWRNDzRl14CxbdMixYjk7DZTNSc0DVEO0i/i+pgcY5LC0sb4leFivA37esGsZxLLN3ZB6PQFhwojUqWn9X4FEa3SPr3Udpr750GyJdROjYQri1vwpbVZJq0fP0KVY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746386426; c=relaxed/simple;
	bh=DFtoEZp13DyowSkCY9gYBD29QuwSqoK8KIKdaOPoUyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mj0/TBVJJ5fPmPxqdwVC6gnHHELFwdprBW6vsok67FO+1ZZEoSywVUnX6BxJb4liIFIx7wkhDFlsxlULpb9avQ3Ple6A4dKFJgJDFN2VmG38uGYXcqaMvZukszZXdN3ObRuIb9sSzGZN9amqI/x9s95/ZRUxsZCl7B1Qjbun17U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=gbwIsDF0; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="gbwIsDF0"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=gbwIsDF0XfoCHKqfRQ6HgvdLPhfkf6dGyog3eAcicS2vIVFFn7Mvm5OUFh6J2xKRi+FGAMB6BEfcUumbm5yLFE9M89UwHzmKPjMz4a6AbJ0qS9YZAAETF6aJHSBkHn8uXZJnZcpFLPC9hqioiSgSiFMsefcJ5zHq6p1M9pdA9Ldx/Ho0ckDsGoQx/fn/tGfHNWq3w2chphds+GnSj45ONRWPJjIG32NXfyd25X7NJ8t3NcjGFIMhReEW4yVAtzryMumKz4XpuzBgvu88NWDLRterKmkg0ZKG01WSF+RZBZ1kE7ziVIOyDQqddk3i+MGmk91shITA4ZwX2YgLbQyI5Q==; s=purelymail2; d=purelymail.com; v=1; bh=DFtoEZp13DyowSkCY9gYBD29QuwSqoK8KIKdaOPoUyM=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1694754991;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 04 May 2025 19:20:15 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v4 0/6] mbim: Add support for MediaTek T700 5G
Date: Mon,  5 May 2025 00:19:25 +0500
Message-ID: <20250504191931.7078-1-thevancedgamer@mentallysanemainliners.org>
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

Muhammad Asif (6):
  plugins/udevng: Add support for PCIe MBIM modems * Parses through the
    sysfs tree and detects MBIM control nodes, net and   AT nodes
  mbimmodem: add support for MBIM extensions * With MBIMEx 3.0,
    arguments for activating GPRS changed. Update as   needed.
  mbim: fetch MBIM version on init
  plugins/udevng: Add support for the MediaTek T700 5G modem * Found in
    the Lenovo ThinkPad X1 Yoga Gen 8 as the Fibocom FM350-GL   modem *
    Works perfectly with ofono now
  mbimmodem: sim: add support for querying IMSI with MBIMEx 3 This
    commit adds the ability to query IMSI with newer modems that use the
    MBIMEx 3 protocol.
  mbimmodem: sim: add support for querying ICCID This implements the
    required functions to query file info and read file info from the
    modem. Currently the other file IDs haven't been implemented, but
    they will be tackled later.

 drivers/mbimmodem/gprs-context.c | 59 +++++++++++++++++++------
 drivers/mbimmodem/mbim.c         | 55 +++++++++++++++++++++++
 drivers/mbimmodem/mbim.h         |  7 +++
 drivers/mbimmodem/sim.c          | 75 +++++++++++++++++++++++++++++---
 plugins/mbim.c                   |  2 +
 plugins/udevng.c                 | 57 ++++++++++++++++++++++++
 6 files changed, 235 insertions(+), 20 deletions(-)

--=20
2.49.0

