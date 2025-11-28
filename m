Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A140632ED2A
	for <ofono@lists.linux.dev>; Fri, 28 Nov 2025 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764350310; cv=none; b=Pe0WF9Nx1LSOkjvfhBN77irh1jiAKvOZM7maiqvTbMG0J1ExHx3XcmaMqoOPoimv8QQPF8p3CBtt/pIRhoPDunpUnOfD80fJz2YMXR9eZNQKr645zjTgAff9v6qs/EecjLYDpo8pldVP1DYog0avshdu2J6/IVlNKHdgYTQ8d0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764350310; c=relaxed/simple;
	bh=vaen1m3zCpCJ+VeXgYY7J6CtUCRImhT/bS8DvLhpiTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYJw6RePerzD3YOm4peZSovUxqr11pfHCk2f0whrSu2OweqGsvB5yu6hqBp4P6sYepM4cw3vCNoCwgltRHFxlSVKJRIEy3KIYW0toF3L+5e0Ue6AO4lMOlmuL/mnGaA2iWHaydeel2CxOWMXTcS30unA2utRFGTNwqYFZ6BxNxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=w9FCP4hp; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="w9FCP4hp"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=w9FCP4hp2NqCtmswQ/ymaYiM54g3UCP7sIzJmjD7lRmUq+3UhFaK9JTjou1H+PaKp+X90cTEaiNf8rPpWAcudLEioubG7sxe+8+oSsb8GzHlQxck9CxqrNcFww7E1qlDYnMKJOXFcxEIGwMm9YjaCUq0Uyy5do0/wCZjZlAk+/WFszxmmKWvB0kAvW4KrxlComtsloC8Z8iO5lfIhQc0K0Q/ZQAODROitjb5De6U34KGsHH53xyEyhobVDmhQT0i1JCg8Q0XeeyQmSqSz9luuIbhiR3v6HgPtVrq1Ucyfu5AReNGJ6Ka36nG8xZPu9cmQaZFl8BWnQkqUYmuuyAhdQ==; s=purelymail2; d=purelymail.com; v=1; bh=vaen1m3zCpCJ+VeXgYY7J6CtUCRImhT/bS8DvLhpiTY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2023556145;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 28 Nov 2025 17:18:23 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v6 4/9] plugins/udevng: Add support for the MediaTek T700 5G modem
Date: Fri, 28 Nov 2025 22:17:42 +0500
Message-ID: <20251128171747.32679-5-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128171747.32679-1-thevancedgamer@mentallysanemainliners.org>
References: <20251128171747.32679-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

* Found in the Lenovo ThinkPad X1 Yoga Gen 8 as the Fibocom FM350-GL
  modem
* Works perfectly with ofono now
---
 plugins/udevng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index e779524c..27c9d110 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -2336,6 +2336,7 @@ static const struct {
 =09const char *pid;
 } pci_driver_list[] =3D {
 =09{ "xmm7xxx",=09"imc_ipc",=09"0x8086",=09"0x7560"},
+=09{ "mbim",=09=09"mtk_t7xx",=09"0x14c3",=09"0x4d75"},
 =09{ }
 };
=20
--=20
2.52.0

