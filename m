Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F31423D7FB
	for <ofono@lists.linux.dev>; Fri, 28 Nov 2025 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764351439; cv=none; b=ILgv7lIGtB2L2ip7BFpJxxGZMMMuj39IrCszX7LkBvQ3MjtI4pwATLjsdBDLfwslxq4auRhW9ABXVhb/2PKXQ3iy+/bPYlSLEOGx0DKlER4Y2RNw78szuWnUIA8GxpWGpsD5WnSCZ93V2Z8l3NRfoI2UGliuoActUPo2cUurK08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764351439; c=relaxed/simple;
	bh=vaen1m3zCpCJ+VeXgYY7J6CtUCRImhT/bS8DvLhpiTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hq2fyYJ1w3J+FvD2T60r5J4l2ynXCiYiZQCkTh8CuZoSieX9BIMBvkBwnr/p9oSTtbowIl1PuNUMNJg3gH1lSt0jCI/av0msY42x0klfInkGYHRQNzNsTG8Mr02A1ognXceYt2SKSipSoLgImknkteCyCSsBE+UoRuYEzGgkFMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=cqdUmafp; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="cqdUmafp"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=cqdUmafpASwry9zujGTBCFCOhHmuI26l2oBVXXbHHgMgHXvm3QIQnb5qEklst4htG99/fdrBBneJQjU75p8IDMALVTMyCF9ilDC7mnqh/Botv8BemNdjHUA4LgvrK3meLyqXc828Nu4qdY4SreiL0z2XrRB728vl9JWg+OiU51OX71zqrxW+Xq+Hd353Fp8ZmKA7WIhaSLPpr97F5eFsUznAv8HjP1aNwiii1DsP5AhirZfUX291BVIAdJfeW1nq6EuxMCsc4TlWxIUtbWdvybNREbyNJZIerlepHztI765d+ykTsO3YIkGc8kRz1EL8Z5SOGlJRriQf2uboD1xE1Q==; s=purelymail2; d=purelymail.com; v=1; bh=vaen1m3zCpCJ+VeXgYY7J6CtUCRImhT/bS8DvLhpiTY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1079628981;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 28 Nov 2025 17:37:15 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v7 04/10] plugins/udevng: Add support for the MediaTek T700 5G modem
Date: Fri, 28 Nov 2025 22:36:50 +0500
Message-ID: <20251128173656.55692-5-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128173656.55692-1-thevancedgamer@mentallysanemainliners.org>
References: <20251128173656.55692-1-thevancedgamer@mentallysanemainliners.org>
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

