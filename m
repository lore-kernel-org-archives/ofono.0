Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAFB22127B
	for <ofono@lists.linux.dev>; Fri, 26 Dec 2025 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766758462; cv=none; b=HX31pegsJBerIuDOlSYjj3dvxqlFUFuTvUAmM2yfsRWw+JSe8zBoMSwuCJSxO489IErPIGOp30w7UDJMAhsoc9X3sfaoLHmUctQuuFpmKz4sal/fhMcY3kTapCmo0bxMI4zbTxWNCov2GM2DhSwJyaKjkyFy1sh9V2cOP8YxJqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766758462; c=relaxed/simple;
	bh=pXyLswQZxYXtnjayXUdBO4+GvNqwNS2VTn0Q/JFxUFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdyAW/W9e8LOJ4ixIzl5S+j6xwpLQPK6XKTRqEvRbmM4+9dkPZvtrLihrGVCoeGrCzy7gk/PazUJbi1mef2I/ivYzEcsI1+UhfpHcv1Q19wvsAeeICeRP/5PxfqkBYpYGDpAB7rAl3xw2GCkizxUFTwLR5aaPO9xzylBr8Za4CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=eiKs8BZV; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="eiKs8BZV"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=eiKs8BZV82bdyx2lpmqB2qj2IMwP0QqFXD39LdXkm6/iT696XCMsl8UrT5JwLGv0Vh1IlK0T2/YpKsf57d/JqP3lle6eeZ8UfGjcX+DzW0ZoZPlLuSN8kAVCO/2qGi7rcNbgvuidGwcHiw8+tTJMxmjBGnPvK+F2fwnf3ncYo4QIxF0VuDqsDMfNEeUYkdeogx7rJJ/voWsj0ujt9lFqPYwx1aUnWIANTeDzMWxbDyYHFsBYk0vRmSZYS0v3OB9RXUuMtsI+Ss6AuPb0yS/OMFofN5W/JJ8U5PgaAwcbWyq+a/+5qSFaJ6R0t73BJPYj7rNW8f3JWqujSAm+b79T/g==; s=purelymail3; d=purelymail.com; v=1; bh=pXyLswQZxYXtnjayXUdBO4+GvNqwNS2VTn0Q/JFxUFY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2072196880;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 26 Dec 2025 14:14:17 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v9 05/10] plugins/udevng: Add support for the MediaTek T700 5G modem
Date: Fri, 26 Dec 2025 19:13:05 +0500
Message-ID: <20251226141310.41856-6-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251226141310.41856-1-thevancedgamer@mentallysanemainliners.org>
References: <20251226141310.41856-1-thevancedgamer@mentallysanemainliners.org>
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
index 1ce02525..460ebb82 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -2371,6 +2371,7 @@ static const struct {
 =09const char *pid;
 } pci_driver_list[] =3D {
 =09{ "xmm7xxx",=09"imc_ipc",=09"0x8086",=09"0x7560"},
+=09{ "mbim",=09=09"mtk_t7xx",=09"0x14c3",=09"0x4d75"},
 =09{ }
 };
=20
--=20
2.52.0

