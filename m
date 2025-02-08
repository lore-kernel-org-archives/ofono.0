Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E938B6FBF;
	Sat,  8 Feb 2025 00:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738975170; cv=none; b=HJi2BpbsxWhOgkpFcdyWMK6DVPhVeU68qiDv6YI2voQXyyYB5MN171tkXMYHBwX8CD0AGXHFWZa6/VpnKumUtiVf7ye5083dtYm+HzDJ/9rQEj8rk1lca6ZBKK3zlY03B3wLqmfnMKXpsFEU7FUHW2huAb2V/d9tBOgKTy0w1k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738975170; c=relaxed/simple;
	bh=+TK/FJbX/67kGIlX7CCTMBXq4kYh7c5FhhWBYdO9NaI=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=HEgWgCPvxLuO3vdnYYRGd6QTQjNmth/oDNwNjiqcbZzQYhSAwiZXR7q0u0UkazjkWlkPsIScJk6ibiRevL53x8Hqbe6aE5uYKY71MO1VPgDkzmZJDd/kQi0kv4K8jGTR/LNBM3ML81/ixASLPZxaEtrViy2HZqUm99MKWzI2BDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=l62kYfmh; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="l62kYfmh"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 14734164A79;
	Fri,  7 Feb 2025 19:39:21 -0500 (EST)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id BB6DB124FD3;
	Fri,  7 Feb 2025 19:39:20 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: oFono: Plugin Has the Incorrect Conditional for Evaluating When a
 Context Was Successfully Added
Message-Id: <C1FDD6E3-31EB-42B6-9D67-BDABD453F0F4@nuovations.com>
Date: Fri, 7 Feb 2025 16:39:09 -0800
Cc: ofono@lists.linux.dev
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:content-type:content-transfer-encoding:mime-version:subject:message-id:date:cc:to; s=pair-202401062137; bh=v4dt+/XRGV3cDOVefg0NxgLc40zUsuQfyB4Vq8RfJ0Q=; b=l62kYfmh/+i9er7ibD886jB/f3HKjUq+dWlJkuv0Jy962F/5mm0OikrftjHc8wQtEmYwnnPHDgAt2WjwDdOUv8MDge1fweh5z/uS4SRyvQ8U+ryuJalpsrqkg+sRSZsuVv0C/f2Mf0gWiO8xDXOqpa7IJw49b39wDDBd+Yqf49rrU4xQl/xA5dWen6LAa0jOFNuVV5FaTzBBoXd/XXbbz1o8I9TfVJ1oDsM3Zlbb69Bprr4vz/6aW9tU4nLf6XOjw6hrtNohO9Gf6zcVq/30J9BiKGTdcYzPpOLZZIvjzHk5dnuMSeszHsJUeJsRLpQ6DlDDdUdIJ4P3xcjXRSjcZQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Team Connection Manager and Ofono:

At the appropriate moment in the oFono plugin lifecycle, it gets and =
evaluates contexts from a given Cellular modem. Depending on the =
HNI/MCC+MNC and the network operator, there may be one or more such =
contexts, each with a different type.

Within =E2=80=98cm_get_contexts_reply', each received context is =
iterated on, evaluating each for the type =E2=80=98internet' by calling =
=E2=80=98add_cm_context'. If the context is not of type =E2=80=98internet=E2=
=80=99, =E2=80=98cm_get_contexts_reply' should continue to iterate until =
all contexts are exhausted or a matching context is found.

The return semantics of =E2=80=98add_cm_context=E2=80=99 are =E2=80=98-EIN=
VAL' if a context *not* of the type =E2=80=98internet' is evaluated; =
otherwise zero ('0') if a context of type =E2=80=98internet' was found.

However, the current conditional logic of =E2=80=98cm_get_contexts_reply' =
is:

    while (dbus_message_iter_get_arg_type(&dict) =3D=3D =
DBUS_TYPE_STRUCT) {
        const char *context_path;

        dbus_message_iter_recurse(&dict, &entry);
        dbus_message_iter_get_basic(&entry, &context_path);

        dbus_message_iter_next(&entry);
        dbus_message_iter_recurse(&entry, &value);

        if (add_cm_context(modem, context_path, &value))
            break;

        dbus_message_iter_next(&dict);
    }

So, assuming a set of contexts from, for example Verizon, such as '[ { =
vzwims, ims }, { vzwinternet, internet }, { vzwapp, wap } ]', then the =
above logic will encounter '{ vzwims, ims }', evaluate that it is not of =
type =E2=80=98internet', return =E2=80=98-EINVAL' from =
=E2=80=98add_cm_context', that will satisfy the conditional and trigger =
the =E2=80=98break' from the =E2=80=98while' loop and context iteration =
will terminate. This then misses the second '{ vzwinternet, internet }' =
context that was sought and the Cellular interface will never come up on =
connman.

See https://github.com/Nuovations/connman/issues/133.

Patch forthcoming which amounts to:

        if (add_cm_context(modem, context_path, &value) =3D=3D 0)
            break;

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/

