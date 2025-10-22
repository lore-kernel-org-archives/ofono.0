Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6701E3431EA
	for <ofono@lists.linux.dev>; Wed, 22 Oct 2025 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142462; cv=none; b=s46VaSFI8lschrM0uGSaUPLAT2RrGVMiJdwdHVlTl62i74vmC8yNnwg5+lNNVsNlLQIuCv2sOiP8M+d4ttJ7ax5MnhVSKsi6jphRQBfNnU02qqj8cuG2pWgJiWU2t/1iYC95A8Ql5IZf+G1YV7honVEMVQeSHglympVW628sBqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142462; c=relaxed/simple;
	bh=NhnPNNIcgctkNeY70vGDQiWCUzqeP8CbU7wCKDleNgQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iOrTNztxxnSkEjrcDbnkuxDLUA09LHc6hgRSvdHJgMRaQaLwEALcNYdvCIapjb0UtMM0DQw3uNXghbkXCC4t1e0am8d68Oy4gYem8F86D7V+RMDCO906foLb0lDCqXAeph9mwfrQFfrm7dZkP4ejGsGSMkeBYuC3ZnPzvwB+i6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=KIrXbMei; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="KIrXbMei"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 63A2F240101
	for <ofono@lists.linux.dev>; Wed, 22 Oct 2025 16:14:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1761142457; bh=wKC+fIL5iSXJaKCp4KdgabH6H2So4m43fy4o+ehPxu8=;
	h=Content-Type:Mime-Version:Subject:From:Date:Cc:Message-Id:To:
	 From;
	b=KIrXbMeiolzqgiJg870lTFuBSW6y1w/FhR96j3wN6kYGRTLGXv68r+VkhYXzc20C2
	 MrovzEh9Oed7oB6+1EBaaUmCSgeEzYdJUgZ4oHhgjP7Tz48bBA9G6wV8VnpnbNExRe
	 Urwdo30E6f9Zhl/FrrA4NXK0KLLKu9SYOlA2gmJIQt6XxBuXleYACu6pNQNEvM/5Oy
	 xm0tpkwlQyFVCpH56uA71PhdHfZp+EzTEJkSjbYl/7PG+WoyxiirD0zC8l31Osq0+F
	 sEl0D8UhTE9bpvo9gZmqc55VKn6MjwO3+5c0CA0OBVkZrhQRhCoeinFoSG8vjFv2CP
	 A1H9AB0SAscSA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4csB486bFbz9rxD;
	Wed, 22 Oct 2025 16:14:16 +0200 (CEST)
Content-Type: multipart/signed;
	boundary="Apple-Mail=_3B46C668-6910-4491-BB3E-5B5455DF05E2";
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
In-Reply-To: <936c9eeeb421fd6f215bd7dc1e26fb9cf00d9f3e.camel@geanix.com>
Date: Wed, 22 Oct 2025 14:14:17 +0000
Cc: ofono@lists.linux.dev
Message-Id: <E59AD6B8-4510-46E8-AB92-AFA4133D375D@posteo.de>
References: <90E62BD5-4BE0-433C-AE89-6B7D99AACE9D@posteo.de>
 <936c9eeeb421fd6f215bd7dc1e26fb9cf00d9f3e.camel@geanix.com>
To: =?utf-8?Q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>


--Apple-Mail=_3B46C668-6910-4491-BB3E-5B5455DF05E2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello Martin,

> I think these "POWER" notification from the modem are the culprit. We
> carry the attached patch in our setup to avoid those messages stalling
> the AT parser.

thank you very much for your patch! I applied it and added another case =
for "+QIND: PB DONE" too. But this still does not help to get the =
communication between host and modem unstuck again.


> With that said: Why does the modem choose to power down? Is
> someone/something toggling the power-up GPIO to the modem?

Yes, it's oFono toggling the modem power in the attempt to switch the =
modem on. The messages appeared due to the modem already being powered =
on, therefore getting powered down which takes some time, and oFono =
meanwhile trying to start the modem initialization. Sorry this was not =
the best compilation of communication samples from my side.


Best regards,

Christian


--Apple-Mail=_3B46C668-6910-4491-BB3E-5B5455DF05E2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEIhqZz/J2souq/IKUfmJl21on4+EFAmj45qUACgkQfmJl21on
4+GGHA//f8CTUEREBL33hyXQdzL+XkqgG3IOUBjkKs+4KSDjw9TAZh8jQaa5q6QW
XNhDyUjBv8TsV7s8X6WucNy76U6tT5WbAHeNgd6WWnF27UUpl0WhfKLBPYO9k2qp
EHBiWGOR5ZZu6LYMHoe3KomRCNWqPCoVUaZ5JFJwGNnvsnRzX18TGDCbHr+VSg+T
Vnyf8jTRfFCU4PqJJ5Qo+4LK/3QIB7T6QznGF1SWVw9XWjZu4ck8NNvP/wBgJ6C6
MDbmqItWlcT+bpS3g6rI8Lmrw4yapIfxke45qIUJZ/F12awrgr7ikBxb7QJ0UtAm
X+ySbosEXcKmwxUOQlQdUjn3SBk8YzBgzZdIaICLLXCSWs6K8Q3dPmRQU6Be94T/
L6lr4fLPSGSCZkDh6DWOqrVVFg6rofrxKNxUs7SF97gbQ1mjn4dYLGpdEUkM3J/i
aZeTzE4SYzRbviUIcUq3OXsP3SVBPVoIEhhTPXtFYIDyMFFaylqlE1goic7mSYRy
BWVdQaqCKMbl4du4gUeaIQwORoCSGxfPKZeahGyuuEsdxCIK+EkKOUU3/W/tpUxL
85o+abr1Zwu0Fs9HJhFrah5AS3qqDnXkdhQyBn5iw0bEWUofTV9kGfakY5z21a4v
qMPiEBBA08/Cr8o0WGMiBqneCGdc6i0ZceaCWKnvUK8CQd+j9u8=
=57Z9
-----END PGP SIGNATURE-----

--Apple-Mail=_3B46C668-6910-4491-BB3E-5B5455DF05E2--
