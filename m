Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1984A14885B
	for <ofono@lists.linux.dev>; Sun,  4 May 2025 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746386429; cv=none; b=I/8iYUX7g4zfhmH4806E/2a6T6mBtgpoPa7j6S2wTsS5soNQe48bHGFYC3b7wIS4GkoRs3wsH2zJfg7JZzcDFL5LVrN8hcxltXXJkWpk+Uu307+VcnG9Jlh9Av2a6HQWoRUXaZpJd9eQadpJNyEN+G2pJ1dWAFcEBOKQXEiOd4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746386429; c=relaxed/simple;
	bh=wS1zDMzVMi5VfDVMJbrAkn3zcmFohJezPCk5wBXZ1m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUJmSqy6NFhqD0DoLn0opKufMAopC/ywVcCThsiGkD/tV5no6gUcARKSkB3ki1UCdalhyPIdPJxhmZHzS34j/3c8d2Gka1MgOYRLZ1qR2YKjIxc6F/5Fq+AXBEiGMd/uSouP7i/A1aGjFt5cgFOp8DcYfF23OvubRUV+EAsYI/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=mqKiommB; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="mqKiommB"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=mqKiommB4BuQyZ7hdt0nB5KB9f9Zh0Kbqehpy3eeH4lT7y7eAVTcVn1E8OLzeqD+YJkfIc2tHu6rVawo0bMqoMcm+6Y0P59JmUG7lT/vxj4GAyncWgocbRFoVnkKlDWMN+wV7spEY3DqNGBV/IQxcg48uHrZIiyTcWc5tAds9gAVGMgtPRmvkqawKw15mdo36eBP+32yULrLJQWvG2rk6lZkvuW2AiQ4PHhHymlzaxwjzKFVSZXEMfep2LdrdnzfmjqMsZhFPKfazrQ0lvspXlJQwbvn8MFca24ikhEX9Bdv7/oNSF/U14DgGje/JiZ70jjuueUhkWvzGa85bAz0tg==; s=purelymail2; d=purelymail.com; v=1; bh=wS1zDMzVMi5VfDVMJbrAkn3zcmFohJezPCk5wBXZ1m0=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1694754991;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 04 May 2025 19:20:22 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v4 3/6] mbim: fetch MBIM version on init
Date: Mon,  5 May 2025 00:19:28 +0500
Message-ID: <20250504191931.7078-4-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250504191931.7078-1-thevancedgamer@mentallysanemainliners.org>
References: <20250504191931.7078-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

---
 plugins/mbim.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/mbim.c b/plugins/mbim.c
index e1d33f47..3a1942da 100644
--- a/plugins/mbim.c
+++ b/plugins/mbim.c
@@ -287,6 +287,8 @@ static int mbim_enable(struct ofono_modem *modem)
 =09=09=09=09=09mbim_device_closed, modem, NULL);
 =09mbim_device_set_debug(md->device, mbim_debug, "MBIM:", NULL);
=20
+=09mbim_device_get_version(md->device);
+
 =09return -EINPROGRESS;
 }
=20
--=20
2.49.0

