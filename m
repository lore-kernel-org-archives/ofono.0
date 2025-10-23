Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABCC347BC3
	for <ofono@lists.linux.dev>; Thu, 23 Oct 2025 19:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761249046; cv=none; b=YgIg87WL9KhYnPZL7Yf6wDHE7T/J70toHFGbBj8ODfuKKys/h6UgWou7iROfpzUJrULpYUiI3mdDwoXm/cxZYlYJOATUjPHwqcysu5DzsXzC+b/Zvkv2fpTUHMgOY4+Tq+VCLGz38R4ZKAriK+bzZY2B/ube3YyPK6dRmBZcbNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761249046; c=relaxed/simple;
	bh=n9jVNv9v5K1rDiofGAAlVccGi0e9bqYCDKDia4g8HL8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IvYncTs1R+4ebbwW5qCOqoszfIHUVHxI9ZqmKRJhnfS5Zx40KA53rUl+xVBtu2IIyOVf3vsW7ggKsoWSIC36IiJpbWL9zWFf5Fs6LDmKQum/8J3a4pNnSybizryzytnFKq03+9SQnP7JAQPI6MeCmRVm4kMi06nL/Aiyt2a2K2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=jnWDC575; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="jnWDC575"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 9C769240101
	for <ofono@lists.linux.dev>; Thu, 23 Oct 2025 21:50:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1761249041; bh=VXjk9YD2bSlKRAX/jhxnsJqw75gfo2nlVw/0zFgD+Cg=;
	h=Content-Type:Mime-Version:Subject:From:Date:Cc:Message-Id:To:
	 From;
	b=jnWDC575ehU0mXHfZb5i+O0aDJ8TP5i07m6W2bjRCx6/u6wOm3uKMGyh4lRzjQAM9
	 KrXDTUWi9Q+Htp7BRRO/FiMxLeoBmnSsRpsq3TDXaDaj8jXoHPICTfijk0aL3eFR7I
	 EprKCokzahIhOWdAWisTnjc4HRHp59gCoYuLjhX6ezQrQeHznohhXVTs/WaFz0aHJU
	 y0N7Po64D/IOVwHYlZZETGgQUJjAF75fThIjVPaT1PYJQ/tXdNzgJ/1PR47KDHUfKu
	 ul2yBF+lASrjSxc2wFyMHvEynhqD1zI9fgFOH1TziKc08gzNe2Zt71H8Ech/KHRnBz
	 mMP5L/0FqNiSg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4csxTr5ncqz6tvZ;
	Thu, 23 Oct 2025 21:50:40 +0200 (CEST)
Content-Type: multipart/signed;
	boundary="Apple-Mail=_1E9C1760-C6D7-4740-8B08-CB021D82BAFB";
	protocol="application/pgp-signature";
	micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: Quectel EC21 with internal GSM MUX
From: Christian Meusel <christian.meusel@posteo.de>
In-Reply-To: <8bdad6366fd5d1801efb4eecf8b15114d04fec9c.camel@geanix.com>
Date: Thu, 23 Oct 2025 19:50:41 +0000
Cc: Denis Kenzior <denkenz@gmail.com>,
 ofono@lists.linux.dev
Message-Id: <024EE5A2-730F-4CC7-AB20-6D95DEE94998@posteo.de>
References: <90E62BD5-4BE0-433C-AE89-6B7D99AACE9D@posteo.de>
 <26b9ed81-db18-4876-a8b8-c9595150a311@gmail.com>
 <63E4C6A3-EAFA-45F4-8D23-7500BDC45DBD@posteo.de>
 <6ca39764-c990-4505-b287-d6450aab803f@gmail.com>
 <8bdad6366fd5d1801efb4eecf8b15114d04fec9c.camel@geanix.com>
To: =?utf-8?Q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>


--Apple-Mail=_1E9C1760-C6D7-4740-8B08-CB021D82BAFB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello Martin and Denis!

> Could it be hardware flow control that not configured right on either
> end? I remember having issues with both swapped cts/rts lines, and =
with
> floating signals (i.e. halt/flow state could change by putting a =
finger
> on the board).

Thank you for this hint! CTS and RTS should be set up properly. I have =
not seen (unexpected) glitches in any recording of the serial connection =
between modem and the host controller so far. There is a small pulse on =
nCTS after switching from plain AT communication to GSM 07.10 muxing and =
while "pressing the power button". The former seems like normal behavior =
from the modem while switching protocols - the latter I have ignored so =
far as they happen after the initial failed initialization.

I uploaded two screen shots to [1] and [2] and just in case you want to =
look at the huge Saleae Logic [3] capture with analog data you can find =
it at [4] or another system startup without analog data at [5].


My next step is to strace oFono's interaction with the serial interface =
to the modem. Do you have a bespoke configuration for strace? Let's see =
what this reveals. I expect so see the calls to poll which I did not got =
from just instrumenting oFono.


Best regards,

Christian

--=20
[1] =
https://christian-meusel.de/share/3536ce67db07de020d6b5b8fa6fe70422cf85c93=
107f9944debae488339fa61e/20251023-1839-6.1-omux-o6d8c-analog-overview.png
[2] =
https://christian-meusel.de/share/3536ce67db07de020d6b5b8fa6fe70422cf85c93=
107f9944debae488339fa61e/20251023-1839-6.1-omux-o6d8c-analog-cts-glitch-at=
-mux-activation.png
[3]=20
[4] =
https://christian-meusel.de/share/3536ce67db07de020d6b5b8fa6fe70422cf85c93=
107f9944debae488339fa61e/20251023-1839-6.1-omux-o6d8c-analog.sal (about =
800 MB)
[5] =
http://christian-meusel.de/share/3536ce67db07de020d6b5b8fa6fe70422cf85c931=
07f9944debae488339fa61e/20251023-2052-6.1-omux-o6d8c.sal (few KB)=

--Apple-Mail=_1E9C1760-C6D7-4740-8B08-CB021D82BAFB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEIhqZz/J2souq/IKUfmJl21on4+EFAmj6hwEACgkQfmJl21on
4+H7ABAAoZT+gQWoI1OBFR7rWlExcJzeC0YZQ9tkCMmWCxRCN8vtjarXQUSwpgxh
b2L7F6vCYGWbuVie2rW2lZDzvyd1SvmcDz5qtFi2mxdPhklfemivpJnmmuqVfSsV
Mgr7ERREU7uG/0yDrhA6ffecSbBrIi0io2QIALhWdjgbrLiVTPQxqGESfB539BfR
FvCxxMiMH5zKfrI8znUTU1QauBHLxVTy7M0y7kyYDTtEhjd0puIRAZDyWG73m6oO
xms349/fRpkF02+adrLd7KsQfFbhfHUEpiyCbO+uM/4NA/H32ZD8aeGys4tlEgSz
CtkrtneLF7anlqbQJkhoSkA+zr3o0Dew51ma4lSz3N4VLJz5m+FGKN1KjaSBa8MT
lGeYCe2Zj4QRn2IDbHWx7h3m0ixogOMMsicRgHHUvDYu+V825o0pTn+pvoUqvDvt
AIlboPPDTxMj39QCgERafD8xaFkPpUCjo7uvMEfZkoVmnTf/xOC0dKih00YDzbu3
iBpLWwpo6OaRGV95K5O5XUU7dWABTQtnYIAGVNic2Iis0Y0KHyApMCQ/9646/hP/
lWDJF0y+7nejJ7nKExFzit4j9WgoRibqB0RpLaQYMHI19e96nKE2WcbTLCduaxbK
HrG3O3stTRiLHzjDqMFA5nKVDlZ89R6ulu08SaahInrHW+/Jbpk=
=FaYa
-----END PGP SIGNATURE-----

--Apple-Mail=_1E9C1760-C6D7-4740-8B08-CB021D82BAFB--
