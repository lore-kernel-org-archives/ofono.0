Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561231FCFFC
	for <ofono@lists.linux.dev>; Fri, 26 Dec 2025 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766758458; cv=none; b=aZYa6/6eBfLrASKWTfOsWcDZgnCEJEbRYq8DsLOXBL6neitIxXKYwsO7zxX6kh5GndbqkkM3wkO7mf+WSkv7Xc4K4UTMiinPliiLrCPbKWYicb6lQVmVrzGxgpHBAYMcgh+F5qHhReG6BDaTUVjHJHx2PR4mUR1tg8OcNfRH3vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766758458; c=relaxed/simple;
	bh=Gtr6+PRLEd3zlv8GkYE6m13LpAvZdYV7P3x++6EQjWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMtsTJ9YPFV4ksP3velDpmrFYXbx6eXAwxxmZCaipo/XyGdcD+I1NeFOLt1+mklV/UdE92nqhbu5UMRjjwBI7iwPzpVbssfL1CU/xjEAp0RT6vMRLVPRdnJwF8SrX61UGo38xGMz0CEQTTb4/3RTBVr0rqLaNHjcE1RIkFHJTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=hV8PntUr; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="hV8PntUr"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=hV8PntUrCD24WF3e+Jzktis8/AaZe+c5X48ZZcuyTExVGjTlFdd7kQwahURv9tzlNf42wuLnYX0nQQogvL4pNabEx7ELyHKaitAIuDgDX3hLmERaTDQlMtXZQHLz0snBqTmRPGggnCU9A7qhRMZEU6ckTTqHUep+qLfkYnj7NICez4oY6Qj6iwi9LukFxvZP1p4pz6jI+tjxVvS+82rViilqrCChbRsOsns2m3rRpNRlrsuJ9wNxKk1uL8gZ1cluI0JLmD1IkBcMAuzQESeEtSPwNeeOPih8E/QVa2g4KZqHCktJtNsKyNQs0Q+sxB83Uq+KWB0X1UH5s2qVfDC3+Q==; s=purelymail3; d=purelymail.com; v=1; bh=Gtr6+PRLEd3zlv8GkYE6m13LpAvZdYV7P3x++6EQjWc=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2072196880;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 26 Dec 2025 14:14:13 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v9 03/10] mbimmodem: add support for appending TLVs in messages
Date: Fri, 26 Dec 2025 19:13:03 +0500
Message-ID: <20251226141310.41856-4-thevancedgamer@mentallysanemainliners.org>
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

So far only UTF16 strings in TLVs are supported, and no support for
reading them (not needed yet)
---
 drivers/mbimmodem/mbim-message.c | 44 ++++++++++++++++++++++++++++++++
 drivers/mbimmodem/mbim-message.h |  5 ++++
 drivers/mbimmodem/mbim-private.h |  7 +++++
 3 files changed, 56 insertions(+)

diff --git a/drivers/mbimmodem/mbim-message.c b/drivers/mbimmodem/mbim-mess=
age.c
index 65cdc73f..413abe5c 100644
--- a/drivers/mbimmodem/mbim-message.c
+++ b/drivers/mbimmodem/mbim-message.c
@@ -1669,6 +1669,50 @@ static bool append_arguments(struct mbim_message *me=
ssage,
 =09=09=09}
=20
 =09=09=09break;
+=09=09case 'T':
+=09=09{
+=09=09=09/* TLV value */
+=09=09=09struct mbim_tlv_header header =3D {0};
+=09=09=09uint16_t tlv_type =3D (uint16_t) va_arg(args, int);
+
+=09=09=09if (tlv_type =3D=3D MBIM_TLV_TYPE_INVALID)
+=09=09=09=09break;
+
+=09=09=09header.type =3D L_CPU_TO_LE16(tlv_type);
+
+=09=09=09switch (tlv_type) {
+=09=09=09case MBIM_TLV_TYPE_WCHAR_STR: {
+=09=09=09=09size_t utf16_len =3D 0;
+
+=09=09=09=09str =3D va_arg(args, const char *);
+=09=09=09=09L_AUTO_FREE_VAR(void *, val) =3D l_utf8_to_utf16(str, &utf16_l=
en);
+
+=09=09=09=09if (utf16_len % 4)
+=09=09=09=09=09header.padding_len =3D 4 - (utf16_len % 4);
+
+=09=09=09=09header.data_length =3D L_CPU_TO_LE32(utf16_len);
+
+=09=09=09=09if (!mbim_message_builder_append_bytes(builder,
+=09=09=09=09=09=09sizeof(header), (uint8_t *)&header))
+=09=09=09=09=09goto error;
+
+=09=09=09=09if (val)
+=09=09=09=09=09if (!mbim_message_builder_append_bytes(builder,
+=09=09=09=09=09=09=09utf16_len, val))
+=09=09=09=09=09=09goto error;
+=09=09=09}
+=09=09=09}
+
+=09=09=09if (header.padding_len) {
+=09=09=09=09struct container *cont =3D &builder->stack[builder->index];
+=09=09=09=09size_t start =3D GROW_SBUF(cont, header.padding_len, 1);
+
+=09=09=09=09memset(cont->sbuf + start, 0, header.padding_len);
+=09=09=09}
+
+=09=09=09break;
+=09=09}
+
 =09=09default:
 =09=09=09goto error;
 =09=09}
diff --git a/drivers/mbimmodem/mbim-message.h b/drivers/mbimmodem/mbim-mess=
age.h
index 885cc433..c28ab9b3 100644
--- a/drivers/mbimmodem/mbim-message.h
+++ b/drivers/mbimmodem/mbim-message.h
@@ -17,6 +17,11 @@ enum mbim_command_type {
 =09MBIM_COMMAND_TYPE_SET =3D 1,
 };
=20
+enum mbim_tlv_type {
+=09MBIM_TLV_TYPE_INVALID =3D 0,
+=09MBIM_TLV_TYPE_WCHAR_STR =3D 10,
+};
+
 struct mbim_message_iter {
 =09const char *sig_start;
 =09uint8_t sig_len;
diff --git a/drivers/mbimmodem/mbim-private.h b/drivers/mbimmodem/mbim-priv=
ate.h
index 6a9e0b2d..c62e0655 100644
--- a/drivers/mbimmodem/mbim-private.h
+++ b/drivers/mbimmodem/mbim-private.h
@@ -32,6 +32,13 @@ struct mbim_fragment_header {
 =09__le32 cur_frag;
 } __attribute__ ((packed));
=20
+struct mbim_tlv_header {
+=09__le16 type;
+=09uint8_t reserved;
+=09uint8_t padding_len;
+=09__le32 data_length;
+} __attribute__ ((packed));
+
 struct mbim_message *_mbim_message_build(const void *header,
 =09=09=09=09=09=09struct iovec *frags,
 =09=09=09=09=09=09uint32_t n_frags);
--=20
2.52.0

