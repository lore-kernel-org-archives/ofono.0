Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B292F14D2B7
	for <ofono@lists.linux.dev>; Wed,  1 Oct 2025 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323687; cv=none; b=fXMC+uBilgyVu6rWV3ZmUdVgJwrbEqb7vQxdLOjwJcq+wFCZ1AdoeRQSq6TuJYXzAEzBSg7XPqCXDTgxK3iDsi7rawuXsPWiIah3G8uFTKhrqSgpoQ3QcNpYADa7DVg8bTqSvOTJpMhau5jBWCC1YJ6LAKb5seYkb0InB7Zgugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323687; c=relaxed/simple;
	bh=UQd1v/hLGtqJHP0TUQ02iZIQzUysXfeTxKN7byxlTK0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sEVqqMKjEYt+Tdh4mehcNnfmQWoU9XYbpCCpkgGUXOA2gHlzO90yY8ebE4ZHz4FGYE58Bk2U1NBebw4t+ydr8cxgYYl52aWZJksCy+BgVCt4gEHoyKNilepFyHAmXFwbrwMRWDpYEzAUG52PHgW/0NLt06Pat/zdrapAg5Mfi7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=X91ivmcC; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="X91ivmcC"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 9DECC240027
	for <ofono@lists.linux.dev>; Wed,  1 Oct 2025 15:01:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1759323681; bh=ddjzUMBQlrZWhFXT3xeLNah16TlHhuoEC8xyGzGXnPA=;
	h=Content-Type:Mime-Version:Subject:From:Date:Cc:Message-Id:To:
	 From;
	b=X91ivmcC6YVzoZphwKj30p1hXHCSh2ng8Mtn5giweiDFmAm7X2eR+BS8SSvKjMD/R
	 I2NIt7SQj9HvAtT/q6UuYUI3BWdZXkityYk4H7vsCfGPCZYVNW2UTbt0TjaP+WNERR
	 FKTRu0ovDMQcssCxH5XlL7U0476lbCdCwcPczQppudN04edI7ITvfr0ToaU9W+CAcG
	 GK5K+GgMSZ+N3u/cCe5Oa8bHMrZWjnsudyhkmtizfwsWOxSsWG0oO/Xi/J/6nPagyB
	 Mh34VnL0Z6zCweGKrW4JmojHwMmt5Sn/0wAHlaBy02tYtpvO6yFhRrCZGCUmfWBvO4
	 YcyVrq10Kf/lQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ccFRh6dWZz6v0g;
	Wed,  1 Oct 2025 15:01:20 +0200 (CEST)
Content-Type: multipart/signed;
	boundary="Apple-Mail=_3C7FAA98-A904-4A1E-B327-A1BCA94C7606";
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
In-Reply-To: <26b9ed81-db18-4876-a8b8-c9595150a311@gmail.com>
Date: Wed, 01 Oct 2025 13:01:21 +0000
Cc: ofono@lists.linux.dev
Message-Id: <63E4C6A3-EAFA-45F4-8D23-7500BDC45DBD@posteo.de>
References: <90E62BD5-4BE0-433C-AE89-6B7D99AACE9D@posteo.de>
 <26b9ed81-db18-4876-a8b8-c9595150a311@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>


--Apple-Mail=_3C7FAA98-A904-4A1E-B327-A1BCA94C7606
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello Dennis,

thank you very much for you reply!

> If the kernel isn't getting responses, highly likely oFono won't =
either.  Did something change at the driver level? Have you tried git =
bisect?

Yes, this was my starting point. And I enden up discovering that the =
answers in question are received by the UART driver but n_gsm just does =
not see it (and oFono is not bothered with MUX-ing and MUX management in =
this setup at all).

There are some big overhauls to n_gsm between Kernel 5.12 and 6.1. I =
bisected but this just brings me to one of them and which did quite =
substantial to break my usecase with Quectel M95 and EC21. These issue =
still exist at the latest upstream version of the Kernel. I don't have =
the call stack at hand right now, but the situation looked there like:

    * n_gsm got new data pushed via gsmld_receive_buf
    * And while still in this call to gsmld_receive_buf
        * The received data got immediately paresed
        * A new request was sent to the modem
        * It timed out because no answer was received from the modem by =
the n_gsm

However, there was actually an answer received by the UART driver. But =
it got not pushed to n_gsm which was still stuck in gsmld_receive_buf. =
As far as I'm overseeing things here, to untangle this, n_gsm needs to =
split receiving and processing data from the UART to untangle this.

I'm trying to work around this for the moment by switching from the =
n_gsm GSM MUX to oFono's internal one. This works like a treat for the =
Quectel M95. But there are issues with the Quectel EC21.


> Not familiar with this hardware.  Is this a USB modem?  How many AT =
ports does it have?

We are operating this modem with a single physical serial connection =
between CPU and modem. Starting in AT mode and switching over to GSM =
07.10 MUX-ing. If I'm getting this correctly, there are three GSM MUX =
channels opened: control, aux, and PPP data.


> Looks like it has multiple pre-multiplexed ports.

What do you mean with premultiplexed ports? The one serial port we are =
using starts in plain AT communication mode after powering up the device =
and is then put into GSM 07.10 multiplexing mode.


> Why do you need multiplexing in this case?

To my understanding, this is the default mode of operation (when =
operating over a single serial line).


> I've also never seen / heard a modem support CMUX when it is already =
pre-multiplexed, but maybe such combinations do exist.

It does perfectly fine with Kernel 5.12 and its state of n_gsm. I bet =
I'm seeing the issues described here because we may some of the few if =
not the only folks operating the modems like that.


> You can invoke g_at_chat_send however you like, even one after the =
other in the same function.  The underlying implementation still uses a =
command queue, so commands will be sent only when the modem channel is =
idle, or after receiving a final response from the modem (ERROR, OK, =
etc)

Thank you for clarifying this. Last weeks debugging brought me to the =
point where I found the command list in g_at_chat and I got up to the =
point where additional instrumentation below have_line gives me the =
following:

    Sep 26 09:43:25 target ofonod[2502]: chat_wakeup_writer
    Sep 26 09:43:25 target ofonod[2502]: Aux: > ATE0; &C0; +CMEE=3D1\r
    Sep 26 09:43:25 target ofonod[2502]: Aux: < \r\nOK\r\n
    Sep 26 09:43:25 target ofonod[2502]: have_line(0x5d6e78, "OK")
    Sep 26 09:43:25 target ofonod[2502]: =
at_chat_handle_command_response(0x5d6e78, ..., "OK")
    Sep 26 09:43:25 target ofonod[2502]: checking common terminators
    Sep 26 09:43:25 target ofonod[2502]: at_chat_finish_command
    Sep 26 09:43:25 target ofonod[2502]: command queue not empty
    Sep 26 09:43:25 target ofonod[2502]: chat_wakeup_writer

=46rom this I conclude that oFono actually considers the OK after =
ATE0... sufficient for finishing ATE0... and wakes up the writer. But I =
don't see any resulting action from this. In the first place, I was =
assuming that oFono does not consider just OK as a valid and final =
response due do a repetition of the command from the modem is missing in =
this case. But the debug log with the additional instrumentation tells =
otherwise ... Looking deeper into this is my next thing on the list =
after finishing some other work.

Do you have any ideas what could cause oFono to not write the next =
command on the line in this situation?


Best regards,

Christian=

--Apple-Mail=_3C7FAA98-A904-4A1E-B327-A1BCA94C7606
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEIhqZz/J2souq/IKUfmJl21on4+EFAmjdJhEACgkQfmJl21on
4+G7/w/+J6yp97Wy+zzLHdDwLILkBE1F933Fe7F8/0x7vPdWQKGvxPmVhjCeVCYI
tHqEs+TBW1RTDTKWjrnT/chHR/9u1x+OL3IlDrDP8CDqgQfiaf5U6qltw6DfYJQi
knXQlHdGym5dDvZM1SEnPrmVWgb60bEGP42FbVUDRdpRZO3baaz8YH3UicUxm+9i
oqHaMxB7k55AdG/3qIxnQzTQRpHFotVsQGZao6a9WV/xLDAZBPuDtXXiFnVl7bZw
mJocaI9E4qxFKRJHCA4YyMQRkkxQX9HiqgwSD3Nck2lURuMTWhOWDRPi4woCeSIH
U0zpyiPd3RB5teLoJgv6Bhc79rKAbFI3hrhMnvbwB0a4rPmqMtgQ0YJ92LW69ywm
ShT/J5wAxDc0L6TPmQMd8XKvnH+oJ8GJdRX6zt5dR1pxmL1xl3X11qgL2J7yktCz
hgA/PJqeFxmakKjkNtpYryWeXhtmFbfuYEKL62JUu+tcuU65hImSxhfccO0WkP6b
yVJFduHN0Ybo+hPU6UQ+SEYSTudnofSljgLK8F9LB/cfDqcNVXzgIlvj3xE9ufpd
F/VbPbOK/LR2figLP/PMJgXijx3OqbCkhg5XaeSFkWpJJHwnDmnwnefPIc83XyfW
V5V9P9ACBscw3+vGZSQrmtQUjys0bhHBUSJFG6zGKFljNG6KMyU=
=8sjP
-----END PGP SIGNATURE-----

--Apple-Mail=_3C7FAA98-A904-4A1E-B327-A1BCA94C7606--
