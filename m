Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234B2FA0F6
	for <ofono@lists.linux.dev>; Fri, 12 Dec 2025 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573399; cv=none; b=NOK8Xubb9NTs9zpWwG3p1G0JKLjfs1ZNhLRacZmYbNdqJr8LZhBR2/gz5/eR1ZuJDuPM+utjgly19bROxCQE5IubIFbEHdaggyp0yctI6MJAUReNLuqQi13schScXA8hol7YuKIpMnqGVsX5O0xtMYuuhr5c4RXcwpWQKgl2VQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573399; c=relaxed/simple;
	bh=ywGfWUdOfuyc7fpBOzNZp7QEiBP7MfThNPGA+OilSiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XiXVWUb8GUo9lCm7kVm92rjJ3AiSBauAqS3KwGrctV0XASn7EumK4DRZgtxWZWMxQ+Mb6PYAdFKtVM+3FZVBSUsjQhnxm+O+fcpRh95AKrvsoYz/tpYP7Cc3P0i4ulABLIaYmWizXYMHwCWiglFkFTmFmyqRq0XVPAa9lDS6f9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=kkDlqmeM; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="kkDlqmeM"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=kkDlqmeMng4PGzduBG3vFSo7F2zI9Hnx6yK7uPvsTI6YI9eiI28loNh+nBYBazP84IDzTbUCDJmtdifm+OLz3Xb5OqvHdUwj7nItU5TGvHkUldB5/ufj/F+hGucVyQ7uNDrX8zp2Jxfsaon8N5u4Gv+C27SBLH1dYmnNsWFYrgCWL6i+0spAchcdq3fw4ABd77hBYG24gh3N8cUWuGfW8HDnVZGxtWLXKXxNOQq6xdBiyU2scnoAVUlY3oJB0DUHav7OrgMci+vGd8ZYnkVG/4cFWUbEkY4Mcyn+IHpDRhadQLGM6PUZ6UKK/JCRFxCsp7XxESwJSJbf9b68OIKxNQ==; s=purelymail1; d=purelymail.com; v=1; bh=ywGfWUdOfuyc7fpBOzNZp7QEiBP7MfThNPGA+OilSiY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 511728581;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 12 Dec 2025 21:03:15 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v8 4/8] plugins/udevng: Add support for the MediaTek T700 5G modem
Date: Sat, 13 Dec 2025 02:02:45 +0500
Message-ID: <20251212210249.95597-5-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212210249.95597-1-thevancedgamer@mentallysanemainliners.org>
References: <20251212210249.95597-1-thevancedgamer@mentallysanemainliners.org>
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
index 97d64466..ba2da550 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -2370,6 +2370,7 @@ static const struct {
 =09const char *pid;
 } pci_driver_list[] =3D {
 =09{ "xmm7xxx",=09"imc_ipc",=09"0x8086",=09"0x7560"},
+=09{ "mbim",=09=09"mtk_t7xx",=09"0x14c3",=09"0x4d75"},
 =09{ }
 };
=20
--=20
2.52.0

