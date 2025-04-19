Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E07D647
	for <ofono@lists.linux.dev>; Sat, 19 Apr 2025 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745068960; cv=none; b=XQGUFCi/BRSI4z+aqja23F6U6FZ5a2bNcFcMaJQoIYjSJh7xmp3TFwzYpchU0YFtJczGI9BUUPlbfjTgZxW8rFKw9ppY1OpjK83/n60blFtR+JxddFWbHReVcUeEPsL0CLVoma5xmfSYINorSDiwagqz2xwiBjRr4W0k+GeBaxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745068960; c=relaxed/simple;
	bh=gJ6pPU3kqAJpJAWVgICaYb/ZGUyI73fEQsEf9YtSdAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fteJ3CKNwBis3wWpU2m0Ys+O1NVBjq28fVx4XGhqrdkZyhRGkpNjVe5PXjIBnO1pyuCzStjR8X8yuhO7XYBW/37rcskVFh2zBo9imilmT2DAd23z+U17cGj6e0YYehxkfa3FjG3xunlyGRD+9HbOQs2lSqmA8Uv1IYggTgqJa7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=KRzwOtvo; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="KRzwOtvo"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=KRzwOtvoAvWctPNzI7O/6QW9Gqf32k1vOoaFWa6oBguzrPKP+gjb8WxFMEFcYXQ8bVIJMhv69bBczQke2DJHzzzwGW9QrWIHYJpJVe10zSGwT6ippupQD/IVYEVBzd38hAt5drKkftmMtSox0jYMaFUk1o7qKUJwUZ94UtyP/XI+rv537oZUE/It+9Xk7anwpD+Z09xjR9VO4dzNukFxqPkw0IjkbmBt2C3AEsOHQ3oLb8Fb2zLWhhmvWt8fNCmI1uDv28wnjycwwFOLQqgKyHflEzwpxxCo7sXPIYHHqRnlau4Da5ybLR/rYpt7ZOCMj/MCYWRGaocZkGYV/D4/aw==; s=purelymail3; d=purelymail.com; v=1; bh=gJ6pPU3kqAJpJAWVgICaYb/ZGUyI73fEQsEf9YtSdAE=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1433134003;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 19 Apr 2025 13:22:36 +0000 (UTC)
From: Muhammad <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v1 4/4] plugins/udevng: Add support for the MediaTek T700 5G modem * Found in the Lenovo ThinkPad X1 Yoga Gen 8 as the Fibocom FM350-GL   modem * Works perfectly with ofono now
Date: Sat, 19 Apr 2025 18:22:15 +0500
Message-ID: <20250419132215.28887-5-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250419132215.28887-1-thevancedgamer@mentallysanemainliners.org>
References: <20250419132215.28887-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Signed-off-by: Muhammad <thevancedgamer@mentallysanemainliners.org>
---
 plugins/udevng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 1ba1a3a9..6a698ab3 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -2279,6 +2279,7 @@ static const struct {
 =09const char *pid;
 } pci_driver_list[] =3D {
 =09{ "xmm7xxx",=09"imc_ipc",=09"0x8086",=09"0x7560"},
+=09{ "mbim",       "mtk_t7xx",     "0x14c3", =09"0x4d75"},
 =09{ }
 };
=20
--=20
2.49.0

