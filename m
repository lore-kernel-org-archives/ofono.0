Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9570018C008
	for <ofono@lists.linux.dev>; Sat, 16 Nov 2024 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731780814; cv=none; b=SmXC624oYOvDr6XMJ5lcgw24ECJ+dKb95pPUbAlBQcfTxkv9fXI+AT+BsdGaGJmAbxpSNjJZwidYLlWZ5frdQcca3Rr0TkAZD6v8FlXltNx+Ur93AAjgsh91hdlrQNZ1llYLFfml7D9j6S/ApZ3CPTuIeFlC6sI6gimZpk4R/T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731780814; c=relaxed/simple;
	bh=iEtkkgy12FotN3WwdYv8iH730tPlhmbNu9kh1ZeA2bE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RO7Dmbvd/gdM6KMzgzI1kwxJ84prTxL7AIh3FvrTm+qGcjhXlWXpdNweTNA7VcOyQM6qfZF69Cc2fH3AHjJoyYAmcZsxaNb5KFfhaW6+eDkRux8+mLZJFJGkCULWmP0MnqtUVj5WQBmIgUTORaKyviM1eHmpPkVwTzGlTmQqzl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4fefc9b7.dip0.t-ipconnect.de [79.239.201.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 459A6CECD8;
	Sat, 16 Nov 2024 19:07:47 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH 1/8] rmnet: Add skeleton
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20241115220053.49613-1-denkenz@gmail.com>
Date: Sat, 16 Nov 2024 19:07:36 +0100
Cc: ofono@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <65EE9630-2CA2-43D9-AD37-316BF08A725E@holtmann.org>
References: <20241115220053.49613-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3826.200.121)

Hi Denis,

> Add skeleton of the RMNet interface management module.  Implement the
> basic API structure and register the module with oFono core.
> ---
> Makefile.am |  2 ++
> src/rmnet.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> src/rmnet.h | 25 +++++++++++++++++++++++
> 3 files changed, 86 insertions(+)
> create mode 100644 src/rmnet.c
> create mode 100644 src/rmnet.h
>=20
> diff --git a/Makefile.am b/Makefile.am
> index d379201d362b..d107dc410fd2 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -353,6 +353,8 @@ builtin_sources +=3D plugins/u8500.c
> endif
>=20
> if QMIMODEM
> +builtin_sources +=3D src/rmnet.h src/rmnet.c
> +
> qmi_sources =3D drivers/qmimodem/qmi.h drivers/qmimodem/qmi.c \
> drivers/qmimodem/ctl.h \
> drivers/qmimodem/dms.h \

does this make really sense? Putting this into drivers/qmimodem/rmnet.c =
is not possible?

We might actually need a generic abstraction for del_interface / =
add_interface and allow for drivers to register their implementation for =
it, but that is a different story.

Regards

Marcel

