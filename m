Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E760710A1F
	for <ofono@lists.linux.dev>; Fri,  2 May 2025 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212070; cv=none; b=CIf07zmaWffrrasQzcsXcosXLWhprt8bC9NaFcYcZAL0Q5EOhZnajdwxXVehL2eYXo88ubbXc4Yt+2fdn3ISJUYgvftIi7p8/SS4Ucyca6EOeO7qdqPw+00PiGJotDJC8XGJ2l2wMbl4EgTVEhy1dQ/co3OQDgP+CUYXrDmnmDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212070; c=relaxed/simple;
	bh=+LB7FVt5bdkiOXA5wQf9ZLwOmu+maBrQ0ALyk8iMd+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E5KQxpwq4JSdeCqJ7kzny/PzGDFdSFu3XUaAVuaBukOONwWCvV/aU3PFF9ynO64dt0WRnbJbNGJk+TGxk+SIsZ7SP4kOj7kWlsq+woxJz1rpGAB50SJN2JCqObUMe1UdMtIhuYlQweV+bviRnrTBDoNQC91AE2TB8luVbfA1XzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=p5azGaoJ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="p5azGaoJ"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=p5azGaoJV2B8B/FzaPTv6hN14I4qIeZW4r7ag55Rp42oN/CIO43/EHsnWbBfFNrdVgqKcK88o1R87fsauy2cxWudwJUsYAHAPGAXuLymfk8k45jKGgs5QAsd/3QuyyMk7E8Lnl8i4XgkcufMIt7AK+luNevg41BxcWuxijdMrE1CghS+hir2SJ+k/vO5ySfB1Jtqe9fr6E0y9LpshAqscxrMZjqP2nXZubtKc8/lz6F5u6AJfKCiNnvwOjhP2UAn2ziIvp/jtB6cfuVWy+3fc3/h6VkWZNIWhDx+SGtdwunNis5jRCu4bJqkKLiJneAF/SN1dXQhrP6QVjsOdyOEow==; s=purelymail2; d=purelymail.com; v=1; bh=+LB7FVt5bdkiOXA5wQf9ZLwOmu+maBrQ0ALyk8iMd+c=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -220201744;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 02 May 2025 18:54:22 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v2 0/5] mbim: Add support for MediaTek T700 5G
Date: Fri,  2 May 2025 23:53:21 +0500
Message-ID: <20250502185326.19134-1-thevancedgamer@mentallysanemainliners.org>
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

