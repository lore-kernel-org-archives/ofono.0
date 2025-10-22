Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FBE34B674
	for <ofono@lists.linux.dev>; Wed, 22 Oct 2025 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142763; cv=none; b=Zfa+G+yhxMOiFfFJoNBQLtjd8aOPZg+11HZ9Pcbc8qE/KoBU3Ck1F/V0wpG1MdmN8xt+5dTFSxqz6qL7f1YnnRzAYruHmeShhG3O7Wv5/6EdH0nti7Ft9mwWL4QmIu0lPyEeIT9P1qqW8zmTDHd+OR7rzV8UAhrv/X5Zf+OeoNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142763; c=relaxed/simple;
	bh=JAxHgeoexQie6A57OdL3SkNbED4tnmICq2iC0Vme0xA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kCWD22HzLCRISHk56jkb3V2ytrKp4v/5FDNlVICqkI5++bxqikFPNm5SXa909+dM2HZUtEIF4fWtskYJhLhrMKAChSeDmnCEb3spu6etRHQn55ej6MEG0rR3s9XCxUHvbKnpgpPGe7Fv1wtFJoLUX5oQDaHVSAcf1axXqCpOr9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=C7maExPG; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="C7maExPG"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 37758240027
	for <ofono@lists.linux.dev>; Wed, 22 Oct 2025 16:19:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1761142753; bh=Q3Oaq6LIx4k7ZqihXb6pgJZPSv6MWy/81CdFw1ZaPVQ=;
	h=Content-Type:Mime-Version:Subject:From:Date:Cc:Message-Id:To:
	 From;
	b=C7maExPG/8/b0KmmpU43B+b9GfqB9j/5EMlXOeaO1o3rcN0K8/mDmtcRqmuFR+9V2
	 PD+cexVeBbDBdeWYAME4n8dJGW/Tx/u5DGjf+O+w4KrL9i083iHoAn5FNH1NG1EOTF
	 kWMcd9B+1NOXqFssXD2wLc/yey6ieLBlc8dvvdFwEPPqv66LhFCt6JqqOvJy36p5jl
	 TPQCImfgvolaUlstqBsKNuLvpdG9algLFsIF4CCXOtsJ0iCLDFvKk0NqpMO9jvWZd1
	 3TgtGdvECiUGcSMcOvrmvIIHZRJ50SyGe1tz7cPZaztH2wauNlGwimGKUSJPoK4ZWX
	 qszWFHr59KIVw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4csB9r33BKz9rxL;
	Wed, 22 Oct 2025 16:19:12 +0200 (CEST)
Content-Type: multipart/signed;
	boundary="Apple-Mail=_5FB8C55D-A0D0-4F6C-AB4F-5ADCEDA3998D";
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
In-Reply-To: <53399cca-6444-46d9-8250-7d909d8511af@gmail.com>
Date: Wed, 22 Oct 2025 14:19:12 +0000
Cc: =?utf-8?Q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>,
 ofono@lists.linux.dev
Message-Id: <9356AE58-35CD-469D-8F44-B3BE6A3DF1BA@posteo.de>
References: <90E62BD5-4BE0-433C-AE89-6B7D99AACE9D@posteo.de>
 <936c9eeeb421fd6f215bd7dc1e26fb9cf00d9f3e.camel@geanix.com>
 <53399cca-6444-46d9-8250-7d909d8511af@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>


--Apple-Mail=_5FB8C55D-A0D0-4F6C-AB4F-5ADCEDA3998D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello Denis,

> The 5 second timing is suspicious.  oFono core does set a timer and =
will invoke a .disable() if .enable() doesn't succeed in a given time.  =
But the default timeout is 20 seconds (see src/modem.c =
DEFAULT_POWERED_TIMEOUT)

I bet these 5 seconds are just coincidence as oFono agitated the power =
button GPIO beforehand. I saw this timeout and already increased it to =
45 seconds to check if there maybe log delays in responses from the =
modem and the original timeout would mask them.


Best regards,

Christian


--Apple-Mail=_5FB8C55D-A0D0-4F6C-AB4F-5ADCEDA3998D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEIhqZz/J2souq/IKUfmJl21on4+EFAmj459UACgkQfmJl21on
4+GuFA/+I6uHyQpW7302GpIDxELiceln+/1/v5ML2pkvafzVFHDjpFM/7S5VM7gU
xPmGT7uuZzDDa8sI0O2OBSes77kDDjbnciW/Xhu1ZlrZ2vwtPAdU0uHFTalNPvE6
m4zTK2zdP2/joi0LbFFy0vq4ghTQkKVKKXqs1RiV9VtY4IXMetLtWo8X407fDAkl
L6233tUjBDRMjsXsiu8qWSxNBVFVd2nLws3NAidXLN+fCrWesbUJ4FN3CG/R8zM/
kMNtLSx1pxTkyUA+MFq/FZP+9784Rwyf2X3V3MkXrUKqPC16lNWOUDwf0Srnf4x4
QYDihv7feg9lbnxx8b80DCbRDifDEwL9dwGlLBcp68MI7MU+q2e7Bt0oTtTkW71T
1D11x6T5dH3eRAYiphwvnuUOiMoFdbi8n+2aBRoKZ5fAzPCMSFSchUxcFakqcezh
w6V5y8jD4Sjo6/ppVVGfawscTh7GgtJAf/JnKb0Egx1hXJ3XYKtn4zkmKl5YuveB
XLGXc3QRQC3KgwahsBmlpyRzpT/4j6bgI6DS6zO8/ehYAVK1nC7A5UcBkX8W1EM2
pA+Wc/sscaudEg2DACoixlTqYSgZqQj/a4npAtdj5nnJJy64R1isFpjtO6M3FPXT
rl5wtDCUJU6rPAXEYiT8sg+Nt8oTnAafFyw5+kxRT7B225848kM=
=Gfxf
-----END PGP SIGNATURE-----

--Apple-Mail=_5FB8C55D-A0D0-4F6C-AB4F-5ADCEDA3998D--
