Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739622765F5
	for <ofono@lists.linux.dev>; Thu, 27 Nov 2025 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265813; cv=none; b=pWRQeDcQ8PmXf0lGnisrniZxLqRixUQnL1tfTRZHNGDD+63x6+2rPMDf0P9yU/+XrinD235vkgTmggG2R+9FRtaM1na2ZAitoDTaJ9tc/rJvEqLPNUsYJvSlL3YW28/dmIsqd8v3mExgKFpcX8cQpQIVCodTrkhiAjrp+0j1wW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265813; c=relaxed/simple;
	bh=bLpFnq/wbUlK5/KWBbW/oMH409tNY4NfTpplQVpQOUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d/Y5Q6PUXJmeLHszYT2lOsUKJW2/MgMW8+c/REnZHBFgFgmfXdh5U38aEaIeqIAnQGk2bxEFmygg9kvr453AraC5w/7G+MR5XXELTJ6EARm/7h760jMH0h6Y+7zRkJp764Xq6wJ21jEe0EShfnUfpjAYinFlw5i4EeVSRwA4ob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=J3U3WPK6; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="J3U3WPK6"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=J3U3WPK6x/KrOLUIYpZkiE6P3STHHKRSxb5wB4AZkpKNM7c5yNRyYAWEqH5yU2YaQlFF6XaA17e1G3sjkJMPAG9oQpiAegMCNm3dZTtaRW2za5sdmpUQUEQygaKDj7v0jOg0Cxo1Ge0wGxy2ykjk892SOqTJfXRB3FbuRnSLJeTs+jAFElMiDEF6WkGwYzjiWN8NqYAu9MHJL1++x3MUaMvK5G7ZYzQ/eRr8cT/w0C1v/O50nQbOovse6mJ9sUmRFs5xcTh1C8k5YrpTaswAg2wX9CfOFPT1YQBG159UTUgh3CqgZtWh8IJ3jjAObyEJCUAWVtBcNpqlymdxO/5Y+Q==; s=purelymail2; d=purelymail.com; v=1; bh=bLpFnq/wbUlK5/KWBbW/oMH409tNY4NfTpplQVpQOUs=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 62202782;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 27 Nov 2025 17:49:54 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v5 00/10] mbim: Add support for MediaTek T700 5G
Date: Thu, 27 Nov 2025 22:49:34 +0500
Message-ID: <20251127174946.89981-1-thevancedgamer@mentallysanemainliners.org>
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

Muhammad Asif (10):
  sim: add ofono_sim_get_modem method Align with the other ofono
    structures for fetching ofono_modem from atoms
  plugins/udevng: Add support for PCIe MBIM modems * Parses through the
    sysfs tree and detects MBIM control nodes, net and   AT nodes
  mbimmodem: add support for MBIM extensions * With MBIMEx 3.0,
    arguments for activating GPRS changed. Update as   needed.
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
  mbim-message: Add support for parsing both UTF8/16 strings
  mbim: Add support for nested fixed arrays in arrays/structs In some
    arrays, a nested array can be a fixed array coupled with an OL-pair,
    which breaks the existing assumptions of arrays and structs, leading
    to wrong data being parsed. Or the parent array can have no OL-pair
    in this condition.
  mbimmodem: add support for SIM I/O operations
  mbim/network-registration: add support for manual registration

 drivers/mbimmodem/gprs-context.c         |  64 ++++--
 drivers/mbimmodem/gprs.c                 |   2 +-
 drivers/mbimmodem/mbim-message.c         |  53 +++--
 drivers/mbimmodem/mbim.c                 |  18 ++
 drivers/mbimmodem/mbim.h                 |  37 ++++
 drivers/mbimmodem/mbimmodem.h            |   2 +-
 drivers/mbimmodem/network-registration.c | 103 +++++++++-
 drivers/mbimmodem/sim.c                  | 248 ++++++++++++++++++++++-
 drivers/mbimmodem/sms.c                  |   5 +-
 drivers/mbimmodem/util.c                 |  56 +++++
 drivers/mbimmodem/util.h                 |   2 +
 include/sim.h                            |   2 +
 plugins/mbim.c                           |  40 ++++
 plugins/udevng.c                         |  57 ++++++
 src/sim.c                                |   5 +
 15 files changed, 652 insertions(+), 42 deletions(-)

--=20
2.52.0

