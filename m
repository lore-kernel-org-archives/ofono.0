Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F782E092D
	for <ofono@lists.linux.dev>; Thu, 27 Nov 2025 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265820; cv=none; b=FlMy+Rlw8kCQwJ5aEkTHZYTw9b/mCX5hHycGMQYSX98Lh5Hi8tKxo5UFRR/5fwk0dPMW1Pet1wp603WsHtZ7w0aWP4jGwckiGIDuSrIDMdFDv36bUpWtJQkhYDfewQpHY+z8ONwoF3hxJu7HhIhxAZNEbsYvEE6LjIxAtqieCe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265820; c=relaxed/simple;
	bh=zOeyDpRjsE9KYR8gQkt9Keqevkrzv8Cu+nYu0q9rv4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+0H2OZDM8cz1FGSm7Obt+BMr/FPphjVDNeVunGBWVqxh3efIixs4Kk/m5BDUT8wmsvAuHcsFm12kYn3a7ol4soDe1Ej+vCrWcukKARMpHNngNvT4GMWr9nOMTAiTVT8JkFkXvXKWE9kkVnqZl9zKBduSsfotxj5iejPWyaJ1Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Djc1/Q8D; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Djc1/Q8D"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Djc1/Q8DcL0lboXaSLHi7LF04L09PFwQMWZS6Zvj/84BWDQhwuO8RpE8LsFJ09enWMz0k4fYV/mi7uCq82CxmryqeUQOaYvNYJw44uNMx9nEHUgjVmsLO73WGJh03Xscq+vXCn49cBxvGriwIACH+qlYA7kTBGIYCGpes1AlEJFgdjpRqtz16APaN2yJTx/ZGJGEc6BiVZ6z0h9jfQ38Jb+aTjoOgl5eMWgmhBffBfl+2IFYTe0tKkRKa97dHmNYU95wM/Qg0SGu4h+4JGaQ/2l2zs9+Uh6GJC4rcJYIbLRqgxcZsQsK6qzF40g3oS3zu8ah/ivX84aXOBD6lVSwOA==; s=purelymail2; d=purelymail.com; v=1; bh=zOeyDpRjsE9KYR8gQkt9Keqevkrzv8Cu+nYu0q9rv4Y=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 62202782;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 27 Nov 2025 17:50:15 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v5 07/10] mbim-message: Add support for parsing both UTF8/16 strings
Date: Thu, 27 Nov 2025 22:49:41 +0500
Message-ID: <20251127174946.89981-8-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127174946.89981-1-thevancedgamer@mentallysanemainliners.org>
References: <20251127174946.89981-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Signed-off-by: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
---
 drivers/mbimmodem/mbim-message.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/mbimmodem/mbim-message.c b/drivers/mbimmodem/mbim-mess=
age.c
index 65cdc73f..ecb4f689 100644
--- a/drivers/mbimmodem/mbim-message.c
+++ b/drivers/mbimmodem/mbim-message.c
@@ -139,8 +139,8 @@ static bool _iter_copy_string(struct mbim_message_iter =
*iter,
 =09=09=09=09=09uint32_t offset, uint32_t len,
 =09=09=09=09=09char **out)
 {
-=09uint16_t buf[len / 2 + 1];
-=09uint8_t *dest =3D (uint8_t *) buf;
+=09uint8_t buf[len + 1];
+=09uint8_t *dest =3D buf;
 =09uint32_t remaining =3D len;
 =09uint32_t iov_start =3D 0;
 =09uint32_t i =3D 0;
@@ -164,7 +164,7 @@ static bool _iter_copy_string(struct mbim_message_iter =
*iter,
 =09if (tocopy > remaining)
 =09=09tocopy =3D remaining;
=20
-=09memcpy(dest, iter->iov[i].iov_base + offset - iov_start, tocopy);
+=09memcpy(buf, iter->iov[i].iov_base + offset - iov_start, tocopy);
 =09remaining -=3D tocopy;
 =09dest +=3D tocopy;
 =09i +=3D 1;
@@ -180,15 +180,21 @@ static bool _iter_copy_string(struct mbim_message_ite=
r *iter,
 =09=09dest +=3D tocopy;
 =09}
=20
-=09/* Strings are in UTF16-LE, so convert to UTF16-CPU first if needed */
-=09if (L_CPU_TO_LE16(0x8000) !=3D 0x8000) {
-=09=09uint16_t *le =3D buf;
+=09dest =3D buf;
+=09if (!l_utf8_validate((const char *)dest, len, NULL)) {
+=09=09/* Strings are in UTF16-LE, so convert to UTF16-CPU first if needed =
*/
+=09=09if (L_CPU_TO_LE16(0x8000) !=3D 0x8000) {
+=09=09=09uint16_t *le =3D (uint16_t *)dest;
=20
-=09=09for (i =3D 0; i < len / 2; i++)
-=09=09=09le[i] =3D __builtin_bswap16(le[i]);
+=09=09=09for (i =3D 0; i < len / 2; i++)
+=09=09=09=09le[i] =3D __builtin_bswap16(le[i]);
+=09=09}
+
+=09=09*out =3D l_utf8_from_utf16(dest, len);
+=09} else {
+=09=09*out =3D l_strndup(dest, len);
 =09}
=20
-=09*out =3D l_utf8_from_utf16(buf, len);
 =09return true;
 }
=20
--=20
2.52.0

