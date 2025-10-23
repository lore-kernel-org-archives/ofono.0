Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2B330E0C8
	for <ofono@lists.linux.dev>; Thu, 23 Oct 2025 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220893; cv=none; b=UuNm4EyYry2S5/ZtrDuxI69uOBcNuw9eHGbM2GhqUkLZfjRBDrPcSFZBlquryl1Rj4C26RyUwjd89EYAqUQpndY+LLrGQMimZvvUPYSuli04PCxi4gBU/r5i686Ezo5gktbkp8Qoc5QoEDvuZv2BnmYDaNC9r3hkCCyTDLfha5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220893; c=relaxed/simple;
	bh=b6gDH5Kz78i0QbeYFBanZNOzca8fuQ1lTc1d55QuszY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YE6eQcD5tO/PFpa+6XKd722peyi/yQHDYC/3t39EmuGp0MqTowV3KX2X4iSMqJQrn6R11ZQE8NsaZPoCl3Av6ariCT7vlzvB4s8KW+G3+wgV55caHIc6CPWmNs98yYT0YfPVS8v8G16qVCNo5PG3dOy3eE2jBbIJ/fjSvqF3Rgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Usp6XVgk; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Usp6XVgk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1761220884; x=1761480084;
	bh=b6gDH5Kz78i0QbeYFBanZNOzca8fuQ1lTc1d55QuszY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Usp6XVgkwoT45PwNm2uydYeArLBFOWBtRaJpuVfAZM5t7raoEn8ogH5SzImeAqLls
	 bb12lKKtnY4IMmwHPkVaKS33zuc0ZLfQGpJ9v83Bw8/5VC33Yc31LzrOhDnWz9QpiX
	 ocMK1MkCPcKgHqLdnrq3gPxbAHhAJs+06wKOeyXp4ySV/bUH5SGOjN3Z6Urc5mklrW
	 VHL40Oxx6TxE0Gz24zDC+lqsiZRzQMX56mbSA+4OtrlzjFOSnAtwWTjnlwSzkNYYur
	 1FIo0ItG4rXSUc0+IM3NJluUsrNC5RjdQCw1CMZM90BgQsEEAW/6VSxVNg4QUarqko
	 9+57d8m6j05Ng==
Date: Thu, 23 Oct 2025 12:01:19 +0000
To: Denis Kenzior <denkenz@gmail.com>, Christian Meusel <christian.meusel@posteo.de>
From: =?utf-8?Q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>
Cc: ofono@lists.linux.dev
Subject: Re: Quectel EC21 with internal GSM MUX
Message-ID: <8bdad6366fd5d1801efb4eecf8b15114d04fec9c.camel@geanix.com>
In-Reply-To: <6ca39764-c990-4505-b287-d6450aab803f@gmail.com>
References: <90E62BD5-4BE0-433C-AE89-6B7D99AACE9D@posteo.de> <26b9ed81-db18-4876-a8b8-c9595150a311@gmail.com> <63E4C6A3-EAFA-45F4-8D23-7500BDC45DBD@posteo.de> <6ca39764-c990-4505-b287-d6450aab803f@gmail.com>
Feedback-ID: 134068524:user:proton
X-Pm-Message-ID: 096d96cfc2c321e8581726191ee281028ec12e8f
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Christian, Denis

On Wed, 2025-10-01 at 10:03 -0500, Denis Kenzior wrote:
> Hi Christian,
>=20
> >=20
> > We are operating this modem with a single physical serial
> > connection between CPU and modem. Starting in AT mode and switching
> > over to GSM 07.10 MUX-ing. If I'm getting this correctly, there are
> > three GSM MUX channels opened: control, aux, and PPP data.
>=20
> Gotcha.=C2=A0 You're using naming conventions of pre-multiplexed devices
> (e.g.
> multiple USB interfaces, 1 AT port per USB interface) and this is
> confusing me.
>=20
> >=20
> > What do you mean with premultiplexed ports? The one serial port we
> > are using starts in plain AT communication mode after powering up
> > the device and is then put into GSM 07.10 multiplexing mode.
> >=20
>=20
> Yeah forget I mentioned this :)
>=20
> >=20
> > > You can invoke g_at_chat_send however you like, even one after
> > > the other in the same function.=C2=A0 The underlying implementation
> > > still uses a command queue, so commands will be sent only when
> > > the modem channel is idle, or after receiving a final response
> > > from the modem (ERROR, OK, etc)
> >=20
> > Thank you for clarifying this. Last weeks debugging brought me to
> > the point where I found the command list in g_at_chat and I got up
> > to the point where additional instrumentation below have_line gives
> > me the following:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 Sep 26 09:43:25 target ofonod[2502]: chat_wake=
up_writer
> > =C2=A0=C2=A0=C2=A0=C2=A0 Sep 26 09:43:25 target ofonod[2502]: Aux: > AT=
E0; &C0;
> > +CMEE=3D1\r
> > =C2=A0=C2=A0=C2=A0=C2=A0 Sep 26 09:43:25 target ofonod[2502]: Aux: < \r=
\nOK\r\n
> > =C2=A0=C2=A0=C2=A0=C2=A0 Sep 26 09:43:25 target ofonod[2502]: have_line=
(0x5d6e78, "OK")
> > =C2=A0=C2=A0=C2=A0=C2=A0 Sep 26 09:43:25 target ofonod[2502]:
> > at_chat_handle_command_response(0x5d6e78, ..., "OK")
> > =C2=A0=C2=A0=C2=A0=C2=A0 Sep 26 09:43:25 target ofonod[2502]: checking =
common
> > terminators
> > =C2=A0=C2=A0=C2=A0=C2=A0 Sep 26 09:43:25 target ofonod[2502]: at_chat_f=
inish_command
> > =C2=A0=C2=A0=C2=A0=C2=A0 Sep 26 09:43:25 target ofonod[2502]: command q=
ueue not empty
> > =C2=A0=C2=A0=C2=A0=C2=A0 Sep 26 09:43:25 target ofonod[2502]: chat_wake=
up_writer
>=20
> Here's how GAtChat operates:
> - When 1 or more commands are queued up via g_at_chat_send(), GAtChat
> checks if
> there's a command in progress.=C2=A0 If there is, it waits for the final
> response.
> - If the modem is idle, it wakes up the writer.=C2=A0 This sets up poll t=
o
> notify the
> application using POLLOUT.
> - When POLLOUT arrives, the command is sent to the kernel via
> write().
> - When POLLIN arrives, the command response is processed
> - If it is a final response, go back to step 1.
>=20
> What seems to be happening is that POLLOUT is somehow broken on this
> particular
> device.=C2=A0 I imagine the kernel suffers from the same problem.

Could it be hardware flow control that not configured right on either
end? I remember having issues with both swapped cts/rts lines, and with
floating signals (i.e. halt/flow state could change by putting a finger
on the board).

// Martin

