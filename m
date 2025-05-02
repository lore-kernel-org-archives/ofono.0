Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299231E0DE4
	for <ofono@lists.linux.dev>; Fri,  2 May 2025 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212082; cv=none; b=WJ4OlalnRyk0TTbcGI9oNJGt3E/AiRfyhMRrjtc/1syVdGzPAviuSxjiGFSNwm3e8MFaTA/WekywPO0KwN6dNtUULyphgOWYPuWst30kjqrDYb1wD+6diNmYSjXh7jCBzoRYvs5xGGfMfQDAC2X4xsCuW7CkpciV+4jqKakRCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212082; c=relaxed/simple;
	bh=SkHJdhACHeqcF3dOQFy39Gnss8JA+173EHyWyKDlN44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXNc6FKNMjUGh/iqsRvHsTMpmtTvqXjqs5B+0uTsrWCY3uweBAg6vl0HoCv4lxL1yZXdsvPw3VXsjNIFzDpFs57QC7+llVqCk/Gg/zbgKQOWAb2Ddsuv3FvV/s9Bjl3B/S49IFlQkW5VLjE1v+euFgRBRAQkhWq9i0K5eZnl9Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=b4NgZ4gW; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="b4NgZ4gW"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=b4NgZ4gW7p6ZxvcDwzDAADUJtgD462K3YwTFl+Yq/Tsozz7Sc44nj4XArfrJAu/pwCZ6zzJOd6peRjNrqw5GqvNBQqJGL/pD2y9zgla4kkmHgjS2aWhQ7mNKIVb1FtvHn8Je58xppW2ICPihZLBssaVEcYbXd75TFa5VcPiDZG7UlGZR4dmTOVXRb8xx6j2R0rasA286Kx+QoRY4zzj2+SgdXwycWRLPk2J14MAmFBtvlF3HB0Zsfc1QN/moyaW6laX+8UOOCHYbACIAuIp8+7T8y7ONZ3Cf6Ww+coJKXczddrnajrzMKR1Jtrc3SlKdqbreosf+0gneDNCrW2rEYA==; s=purelymail2; d=purelymail.com; v=1; bh=SkHJdhACHeqcF3dOQFy39Gnss8JA+173EHyWyKDlN44=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -220201744;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 02 May 2025 18:54:38 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v2 4/5] plugins/udevng: Add support for the MediaTek T700 5G * Found in the Lenovo ThinkPad X1 Yoga Gen 8 as the Fibocom FM350-GL * Works perfectly with ofono now
Date: Fri,  2 May 2025 23:53:25 +0500
Message-ID: <20250502185326.19134-5-thevancedgamer@mentallysanemainliners.org>
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
 plugins/udevng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index f8aace59..874362cd 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -2282,6 +2282,7 @@ static const struct {
 =09const char *pid;
 } pci_driver_list[] =3D {
 =09{ "xmm7xxx",=09"imc_ipc",=09"0x8086",=09"0x7560"},
+=09{ "mbim",=09=09"mtk_t7xx",=09"0x14c3",=09"0x4d75"},
 =09{ }
 };
=20
--=20
2.49.0

