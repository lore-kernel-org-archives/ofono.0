Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255F21DC9BB
	for <ofono@lists.linux.dev>; Wed,  2 Jul 2025 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751443225; cv=none; b=hxeqNVskYyK/9j0m7r9mlVNIP9azMW9WGYg2K6VS6z80xrp28a8FMl44h4SvpkMYVTbj/Xf/W69EZO1c3PAJ9FPi+BbgJwCGt32O5b0VmT6jceLhZzpQPQf8e98tYzX7pl9zMTXne5WcaGga5dPIahgqfA/PaqYPwJmxNPYMMVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751443225; c=relaxed/simple;
	bh=59S0R7OWQaB8h0FgKxNET87uh0TmdZPdI8E3jRaBTrM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUI2Cs+cZvrAUdpjAmx/uy/G5LiGdvgal9m0okLpiejrR7v/6HKZx9IAVB5QxWTOxUpSUP1DlLAP1AlFhVa+WBUX5Coe7duXWInr4kWZq88ytDNSxTTwN6ZfK/678Iig/GfRa5RUf4+pwhFS6xaJN+AhTA1nsW8hqqKXqHHz9uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=hG8YTsLX; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="hG8YTsLX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751443212; x=1751702412;
	bh=UXvc9x8xli+mQ/GY+/GgfApypQfTxlcXvLllW5PRCAM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hG8YTsLXnLhOOnG4KZiewSKO7oDrjvX9Rq/UBYIh/P1+QB66e1Upy6gN5FyboitAf
	 OsUgmNMOR/VQpEUqm7p+GP2NyQAXoPSTPov43VYlKzz3zR6RR6mrjFm1hdkxKQ7GFz
	 J0acc156vH+7YaMzbyfs1IbSOGBN1ckRRd4G/u6//x9v1Y43geBpurzNBUSF/pevTg
	 OlQvc1Aj3gnXaP1jX/l7mZC/tW/coeIUqjm610b/5CiDwnFXxp4h67c+YEyxW0VU+q
	 5c8u4X96l7wWI7upITs4EwXPIB/l8IxYCK3CiQFwQUgO4+3sRI3rYqXSbu5O77f4dv
	 sI/DRknjWevlQ==
Date: Wed, 02 Jul 2025 08:00:07 +0000
To: Denis Kenzior <denkenz@gmail.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: ofono@lists.linux.dev
Subject: Re: [PATCH 4/4] doc: sim-api document ForbiddenPLMN
Message-ID: <ikidoj3gpw2x3bgdetcho3bewvfghxiz6pa44oqsjl7mu4a4zq@hxmurfcjb4ao>
In-Reply-To: <6f5e3e42-bd90-4951-8ddd-f11f5d8c4765@gmail.com>
References: <20250701-fplmn-v1-0-d7fe9c901b57@geanix.com> <20250701-fplmn-v1-4-d7fe9c901b57@geanix.com> <6f5e3e42-bd90-4951-8ddd-f11f5d8c4765@gmail.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 0bbecfd69209e12c8222e74be3be629f4d62c411
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, Jul 01, 2025 at 10:02:55AM +0100, Denis Kenzior wrote:
> Hi Sean,
>=20
> On 7/1/25 4:29 AM, Sean Nyekjaer wrote:
> > ---
> >   doc/sim-api.txt | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/doc/sim-api.txt b/doc/sim-api.txt
> > index 419d8ec3ef17fc5b2876d1047249ab76bf608cce..a127ad55b358c082e853e15=
f52eead5bbbf5fae3 100644
> > --- a/doc/sim-api.txt
> > +++ b/doc/sim-api.txt
> > @@ -227,3 +227,10 @@ Properties=09boolean Present [readonly]
> >
> >   =09=09=09This property will range from 1 (default) to
> >   =09=09=09CardSlotCount (max) value.
> > +
> > +=09=09array{string} ForbiddenPLMN
>=20
> Maybe ForbiddenNetworks or ForbiddenNetworkOperators?  I like to not use
> all-caps acronyms in snake-case APIs.  We also use NetworkOperator in
> network-api.txt...

ForbiddenNetworkOperators it is :)

>=20
> > +
> > +=09=09=09The list contains a list of forbidden PLMNs
> > +=09=09=09(Mobile Country Code (MCC) and Mobile Network Code (MNC)).
>=20
> So you want to always be overwriting the entire list?  I guess that would=
 work,
> but note that the modem can actually manage this file as well.  How would=
 oFono
> know when this happened?  Does the modem send a SIM REFRESH via STK/CAT? =
 Does
> your vendor have any guidance here?
>=20
> > +
> > +=09=09=09Max allowed elements in sim is 4.
>=20
> This isn't really limited to 4, in fact it is variable length, see 3GPP 3=
1.102,
> or the ETSI equivalent here:
> https://www.etsi.org/deliver/etsi_ts/131100_131199/131102/18.04.00_60/ts_=
131102v180400p.pdf.
>   Section 4.2.16.
>=20
> Either we only support the 'clear' operation, or we need to expose the le=
ngth
> somehow.

I'm in favor of only supporting the 'clear' operation.

For the get operation would it be okay to collect the list on demand
when GetProperties is called?

>=20
> Regards,
> -Denis

/Sean

