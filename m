Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830801A0B07
	for <ofono@lists.linux.dev>; Wed,  4 Dec 2024 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306616; cv=none; b=oinMqQlKCHUMDqeT6MGf5BcPwMexZpoROj+kUKtc+DNSf3Oj8Quik1S8t78RPqYCILxpD6fCqeaM8AOZrqXlUZP3k6jQwM+tlFcPbrF3JsjjZHW1ES8vQzDDBRjtg2bMWYpVtvMj0aH/IC9DScp2AAKCGT/ZpEDNo+IH8y56ZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306616; c=relaxed/simple;
	bh=5TyqBBx5cyUNiaGqA9uXvyrGcYW6KcirUwZUxOQWxjQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=V8dotEJEfA52s12mT/IhcaOXCch7u6LYlc19NaWHKraK5sDbwk7qvQXJD0yL0Db/Y8nQ7fybN4oToJPGBJAetIXw07Znn6iFAANmHJz9fM8J34v9gqIw5nmVOY1C6OcuJVVY/1LUBxB9lMf69IrzzkRxbZ63qX3o6L1W3GV+hEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4fefc905.dip0.t-ipconnect.de [79.239.201.5])
	by mail.holtmann.org (Postfix) with ESMTPSA id F2CA7CECD4;
	Wed,  4 Dec 2024 10:55:36 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH 2/2] smsutil: check status report fits in buffer
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20241204082207.24692-2-absicsz@gmail.com>
Date: Wed, 4 Dec 2024 10:55:26 +0100
Cc: ofono@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B63F8F5-BC10-4D95-8204-552823D06A1B@holtmann.org>
References: <20241204082207.24692-1-absicsz@gmail.com>
 <20241204082207.24692-2-absicsz@gmail.com>
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>
X-Mailer: Apple Mail (2.3826.200.121)

Hi Sicelo,

> Fixes CVE-2023-4232
> ---
> src/smsutil.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/src/smsutil.c b/src/smsutil.c
> index bdb1d04f..8c1aaad3 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -1077,6 +1077,9 @@ static gboolean decode_status_report(const =
unsigned char *pdu, int len,
> if ((len - offset) < expected)
> return FALSE;
>=20
> + if (expected > (int)sizeof(out->status_report.ud))
> + return FALSE;
> +

every time we do casting, I would asked myself if the variable really =
has the right type and if casting could be avoided.

For example, what is the reason that sms_udl_in_bytes() returns int =
instead of size_t or unsigned int? Denis?

Regards

Marcel

