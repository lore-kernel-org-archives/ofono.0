Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0D62EC095
	for <ofono@lists.linux.dev>; Thu, 27 Nov 2025 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265822; cv=none; b=AY/49KUnJ6i+LuVdaQs92fE+4c9KbzOU5RVw2pDIL9QuRsmnlaKs2m4vjMPPPfyKghIwzyULuP4PfWdWZQnWpj+B5cAcDJfYIi103qmpeobXQH0XsGIuBuqvDg69UN6n3sUzu7+vIEc0Bx7428Z9fiU7XnC1NiqtvN1nshZHjvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265822; c=relaxed/simple;
	bh=hJ0wLqKIkMNa4qGKuaqMcclM/rCFu45Uy9aVui+Vneo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKFGRDkr4jGpm22WjuITaNw+e9rsECzE75vxinRN775XK61YfA5bYt9s8z8Cuj/PvmVf2PRLQ2AIZqRu7V9/fWFpBY3DeWeeHRyKEbwMApt+i2Dne/AAX4LCPo65mN5A63B5bgyFfKK3Hy/t6pHvCpihJ8C6rKFBJaQul4/k6EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=PkJ6owFf; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="PkJ6owFf"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=PkJ6owFffbY3ovkLzIsJkac6KxaQgCj8jkBFveE+Eb+4NuQcZg8L683LS1zMkWnMV6EuHol06mp3BkrNP+YO4m3yY1M4rdk9lTlJLxpQ1xiL8bgY7A8A7ZHQMy8ZXfonenfvT9b0GBUaNvXO5gMBTwHoYOblWQmjg0mcoNwBxHTh8+RZoQCs7xupOTpQhXsuWgCDX7ykwzLPpEPsZFI773HexY73/kqXfiYuYENx3X8m48DCd6AdD85mTUG903nnoM1dxoyfhr4S+NHUE0J5S9680DaLTOr8loO5z+veukE6pM0HSqT4z17YZS4im5KiraN/XGNk1nLqaHT9dexgyQ==; s=purelymail2; d=purelymail.com; v=1; bh=hJ0wLqKIkMNa4qGKuaqMcclM/rCFu45Uy9aVui+Vneo=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 62202782;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 27 Nov 2025 17:50:17 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v5 08/10] mbim: Add support for nested fixed arrays in arrays/structs In some arrays, a nested array can be a fixed array coupled with an OL-pair, which breaks the existing assumptions of arrays and structs, leading to wrong data being parsed. Or the parent array can have no OL-pair in this condition.
Date: Thu, 27 Nov 2025 22:49:42 +0500
Message-ID: <20251127174946.89981-9-thevancedgamer@mentallysanemainliners.org>
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

For example:
The UICC low-level access data has a struct array, but the array itself
has no OL-pair, instead the OL-pair is of the struct, so the position is
no longer incremented in the array parser so the nested struct can parse
its OL-pair properly.

The method for detecting a fixed array is also flawed, because a nested
array can be fixed, e.g. in the example above, the AID array inside the
struct array is a fixed array, but parsing fails due to it being treated
as a variable array.

Introduce a new argument type to parse fixed nested arrays in order to
solve this. Also remove out_n_elem for arrays, since it can be a
separate field away from the array itself.

Signed-off-by: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
---
 drivers/mbimmodem/gprs.c         |  2 +-
 drivers/mbimmodem/mbim-message.c | 29 +++++++++++++++++++++--------
 drivers/mbimmodem/sms.c          |  5 +++--
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/mbimmodem/gprs.c b/drivers/mbimmodem/gprs.c
index 06a50f3d..23953faf 100644
--- a/drivers/mbimmodem/gprs.c
+++ b/drivers/mbimmodem/gprs.c
@@ -175,7 +175,7 @@ static void provisioned_contexts_query_cb(struct mbim_m=
essage *message,
 =09if (mbim_message_get_error(message) !=3D 0)
 =09=09return;
=20
-=09if (!mbim_message_get_arguments(message, "a(u16ysssuu)",
+=09if (!mbim_message_get_arguments(message, "ua(u16ysssuu)",
 =09=09=09=09=09=09&n_contexts, &contexts))
 =09=09return;
=20
diff --git a/drivers/mbimmodem/mbim-message.c b/drivers/mbimmodem/mbim-mess=
age.c
index ecb4f689..637c2cf8 100644
--- a/drivers/mbimmodem/mbim-message.c
+++ b/drivers/mbimmodem/mbim-message.c
@@ -309,7 +309,8 @@ static bool _iter_next_entry_basic(struct mbim_message_=
iter *iter,
 }
=20
 static bool _iter_enter_array(struct mbim_message_iter *iter,
-=09=09=09=09=09struct mbim_message_iter *array)
+=09=09=09=09=09struct mbim_message_iter *array,
+=09=09=09=09=09bool fixed_array)
 {
 =09size_t pos;
 =09uint32_t n_elem;
@@ -322,7 +323,7 @@ static bool _iter_enter_array(struct mbim_message_iter =
*iter,
 =09if (iter->container_type =3D=3D CONTAINER_TYPE_ARRAY && !iter->n_elem)
 =09=09return false;
=20
-=09if (iter->sig_start[iter->sig_pos] !=3D 'a')
+=09if (iter->sig_start[iter->sig_pos] !=3D 'a' && iter->sig_start[iter->si=
g_pos] !=3D 'A')
 =09=09return false;
=20
 =09sig_start =3D iter->sig_start + iter->sig_pos + 1;
@@ -335,7 +336,7 @@ static bool _iter_enter_array(struct mbim_message_iter =
*iter,
 =09 */
 =09fixed =3D is_fixed_size(sig_start, sig_end);
=20
-=09if (fixed) {
+=09if (fixed || fixed_array) {
 =09=09pos =3D align_len(iter->pos, 4);
 =09=09if (pos + 4 > iter->len)
 =09=09=09return false;
@@ -351,12 +352,15 @@ static bool _iter_enter_array(struct mbim_message_ite=
r *iter,
=20
 =09data =3D _iter_get_data(iter, pos);
 =09n_elem =3D l_get_le32(data);
-=09pos +=3D 4;
+=09if (fixed)
+=09=09pos +=3D 4;
+=09else if (fixed_array)
+=09=09iter->pos +=3D 4;
=20
 =09if (iter->container_type !=3D CONTAINER_TYPE_ARRAY)
 =09=09iter->sig_pos +=3D sig_end - sig_start + 1;
=20
-=09if (fixed) {
+=09if (fixed || fixed_array) {
 _Pragma("GCC diagnostic push")
 _Pragma("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
 =09=09_iter_init_internal(array, CONTAINER_TYPE_ARRAY,
@@ -518,13 +522,22 @@ static bool message_iter_next_entry_valist(struct mbi=
m_message_iter *orig,
 =09=09=09=09iter =3D &stack[indent - 1];
 =09=09=09break;
 =09=09case 'a':
-=09=09=09out_n_elem =3D va_arg(args, uint32_t *);
 =09=09=09sub_iter =3D va_arg(args, void *);
=20
-=09=09=09if (!_iter_enter_array(iter, sub_iter))
+=09=09=09if (!_iter_enter_array(iter, sub_iter, false))
 =09=09=09=09return false;
=20
-=09=09=09*out_n_elem =3D sub_iter->n_elem;
+=09=09=09end =3D _signature_end(signature + 1);
+=09=09=09signature =3D end + 1;
+=09=09=09break;
+=09=09/* Fixed array with an OL pair list, no element count
+=09=09 * TODO: Implement sending fixed arrays to the modem too
+=09=09 */
+=09=09case 'A':
+=09=09=09sub_iter =3D va_arg(args, void *);
+
+=09=09=09if (!_iter_enter_array(iter, sub_iter, true))
+=09=09=09=09return false;
=20
 =09=09=09end =3D _signature_end(signature + 1);
 =09=09=09signature =3D end + 1;
diff --git a/drivers/mbimmodem/sms.c b/drivers/mbimmodem/sms.c
index 1f52ef7e..c0610ef3 100644
--- a/drivers/mbimmodem/sms.c
+++ b/drivers/mbimmodem/sms.c
@@ -211,7 +211,7 @@ static void mbim_parse_sms_read_info(struct mbim_messag=
e *message,
 =09uint32_t status;
 =09uint32_t pdu_len;
=20
-=09if (!mbim_message_get_arguments(message, "ua(uuay)",
+=09if (!mbim_message_get_arguments(message, "uua(uuay)",
 =09=09=09=09=09=09&format, &n_sms, &array))
 =09=09return;
=20
@@ -219,7 +219,8 @@ static void mbim_parse_sms_read_info(struct mbim_messag=
e *message,
 =09=09return;
=20
 =09while (mbim_message_iter_next_entry(&array, &index, &status,
-=09=09=09=09=09=09=09&pdu_len, &bytes)) {
+=09=09=09=09=09=09=09&bytes)) {
+=09=09pdu_len =3D bytes.n_elem;
 =09=09int i =3D 0;
=20
 =09=09/* Ignore Draft (2) and Sent (3) messages */
--=20
2.52.0

