Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3908710A1F
	for <ofono@lists.linux.dev>; Fri,  2 May 2025 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212080; cv=none; b=ZadiS34a4Fll/x+gCdPrnRQLxrzGfQHwR/C5kFhDx0gQ1qh8bXEcHTr8Fv+oN+yS51BcttoR75FtCadtI7Wpxkup+CRTkISWaEqiyz9BDwPSQ8RvkNBnMGD40W/Qhxy70ZG0VELhkduAgh++U1tjx3bKUjcGPYSihCy5S0yCb8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212080; c=relaxed/simple;
	bh=wS1zDMzVMi5VfDVMJbrAkn3zcmFohJezPCk5wBXZ1m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUrd6EMK9Zc4MiDpUvnttpIgsshC5qkct3xAb2/HICL/hLroMWc90OhxA1tehdxoTN/KXc21CxM+GkcU6iTejMyoBimI7B7WU9HwojRb41gIDD7t7oztwYQ3MXf3/xkitytOh0HAre6GkNV4bo7r7kGPbuJncSzY3qBUfgzrA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=jMAHsnps; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="jMAHsnps"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=jMAHsnpsCXG7Uc3ypXVRuGvwa2S/jUF1hkkO3GweDpT/V11GMdTrCrB7aqFFXDk+jkItxjJORzcWiekx/S3VL0ybTz0V57KM5LtaRgS8NqGTFzntUgGqglup+ivZaUYzRP3gn6NZu7ww35PAjQYAXbX8EO8f6mK0Sdz5bI2A4vwEAlj4FHxWJk+KZamPupO1jSBZRkq9zgTjPQl69SO218nxvjXXF5E5y+BCEUKEV9dWx9vsV7uWL437f1G7gbpkMN84rh/DgSC6Zf/273Mpj8DKh1E4Wkjo/wsAt7+TM4rpItbZY3guM1tappjMOMnbc5qQyjX5P7pdDTWPzkp6wA==; s=purelymail2; d=purelymail.com; v=1; bh=wS1zDMzVMi5VfDVMJbrAkn3zcmFohJezPCk5wBXZ1m0=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -220201744;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 02 May 2025 18:54:35 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v2 3/5] mbim: fetch MBIM version on init
Date: Fri,  2 May 2025 23:53:24 +0500
Message-ID: <20250502185326.19134-4-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502185326.19134-1-thevancedgamer@mentallysanemainliners.org>
References: <20250502185326.19134-1-thevancedgamer@mentallysanemainliners.org>
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

