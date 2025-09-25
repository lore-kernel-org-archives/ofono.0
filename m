Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A3F1C8632
	for <ofono@lists.linux.dev>; Thu, 25 Sep 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812156; cv=none; b=B+4NwWDk/VjMoU8yx3cr9FV+uCfv9pCcgAJkxKvjVvkFK3+wrZ72L75vGq3M9MDcaybx54i8P1QcYdWW4UWxuXz2xrLv4NDtAqBMGGckhSYPWtA3kXomX7ZNmFh2DUBil6+lMXCrkSRK4FvmaCLL4ZSP8n5U3YHeg9MXHr05pR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812156; c=relaxed/simple;
	bh=j0DWykalquMEvhvxofhgR373hlMDWw25tFbk3kQJQVo=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=MvqVf8kJq4AmvsZAko2QwYXGTahVP9Vct1ukI4iCdzQmmBUPk5Iw2oHW7dt9RjkrjkZdr4KPSOxlMNe4tex3dNjVE8Q0xv10OfY3g/xePzmc/BW4GQ6XUqM2H3SJ5oDJ1rIxLkz3efGgPUaHGaOQ6CWgSEcx09Fwy8FIqYpUQeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=QIbBF9RL; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="QIbBF9RL"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id BAEA4240103
	for <ofono@lists.linux.dev>; Thu, 25 Sep 2025 16:55:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1758812151; bh=nfRmqq/3psbHQ93RoqaUCfs7MIwTZeKN23NgKQU1JFA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:From;
	b=QIbBF9RLFi2GS9zle2ddIoHjH1cQCCAaMpFZEmlaacQ8UeEFG+9JQAwkFdIz7AtQE
	 ZtLmq4NLcI8vrJCUOPTcvHRES81cpCls7V7YUW0MgpgV1SnZ6WFKx4yv7SfPq+d0OM
	 DMXZO/fSCCOxmXJyv+e0n0u+XfSuaa4T2mr0UtV4gpO7Ssa3I97SZeGsmEfaRsXKmJ
	 Q4UlJzdmPuY52Biv73FViut348g2Zxwi8rfmLNCTW/Of3X6d/LnabUFgSpg+9QuMP+
	 bf2yWhWvVx1VzZNpYxgDF6Lkl18HOp8Mtct2StsH+SKBGdsii/Cap6eBYJPUdhkeX+
	 S8mlw56xGkseA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cXcGb2YBJz9rxS
	for <ofono@lists.linux.dev>; Thu, 25 Sep 2025 16:55:51 +0200 (CEST)
From: Christian Meusel <christian.meusel@posteo.de>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_94C00879-6570-4EA2-A508-8E8663BBF4F1";
	protocol="application/pgp-signature";
	micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Quectel EC21 with internal GSM MUX
Message-Id: <90E62BD5-4BE0-433C-AE89-6B7D99AACE9D@posteo.de>
Date: Thu, 25 Sep 2025 14:55:51 +0000
To: ofono@lists.linux.dev


--Apple-Mail=_94C00879-6570-4EA2-A508-8E8663BBF4F1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello,

I'm updating an embedded Linux system and reached the point where most =
things work but I'm still struggling with getting a Quectel EC21 back =
into operation.

I updated from Linux 5.12 with oFono 1.34 to Linux 6.1 with oFono 2.18. =
I also switched from using n_gsm as GSM MUX to oFono's internal MUX =
because n_gsm does not seem to receive responses from the modem when =
transitioning from plain AT to GSM MUX-ing on the serial line in Kernel =
6.1. I can tell more of that story upon request, but I'm trying to cut =
the effort for debugging and fixing by using oFono's MUX for the moment.

For a Quectel M95 this is the end of the story as I can use a cellular =
data connection again.

But this is not the case for a Quectel EC21 in the same setup. After =
adding a delay for the modem to switch into GSM MUX mode, communication =
stalls after the first message from setup_aux [1] from =
plugins/quectel.c, I can see the first of the AT commands issued from =
this function on the wire, an OK response from the modem is received, =
and then communications stalls. None of the other commands appears on =
the wire. The other commands got queued according to further =
instrumentation of g_at_chat_send.

    Sep 25 14:45:48 target ofonod[4030]: =
../../../../../../workspace/sources/ofono/plugins/quectel.c:ate_cb() =
0x4f6400
    Sep 25 14:45:48 target ofonod[4030]: at_chat_send_common: enqueued =
"AT+CMUX=3D0,0,5,127,10,3,30,10,2", len is 1
    Sep 25 14:45:48 target ofonod[4030]: UART: > =
AT+CMUX=3D0,0,5,127,10,3,30,10,2\r
    Sep 25 14:45:48 target ofonod[4030]: UART: < \r\n
    Sep 25 14:45:48 target ofonod[4030]: UART: < OK\r\n
    Sep 25 14:45:48 target ofonod[4030]: =
../../../../../../workspace/sources/ofono/plugins/quectel.c:cmux_cb() =
0x4f6400
    Sep 25 14:45:49 target ofonod[4030]: =
../../../../../../workspace/sources/ofono/src/modem.c:get_modem_property()=
 modem 0x4f6400 property Mux
    Sep 25 14:45:49 target ofonod[4030]: =
../../../../../../workspace/sources/ofono/plugins/quectel.c:cmux_activatio=
n_delay_cb() 0x4f6400
    Sep 25 14:45:49 target ofonod[4030]: =
../../../../../../workspace/sources/ofono/plugins/quectel.c:cmux_gatmux() =
0x4f6400
    Sep 25 14:45:49 target ofonod[4030]: =
../../../../../../workspace/sources/ofono/plugins/quectel.c:create_chat() =
0x4f6400
    Sep 25 14:45:49 target ofonod[4030]: =
../../../../../../workspace/sources/ofono/plugins/quectel.c:create_chat() =
0x4f6400
    Sep 25 14:45:49 target ofonod[4030]: =
../../../../../../workspace/sources/ofono/plugins/quectel.c:identify_model=
() 0x4f6400
    Sep 25 14:45:49 target ofonod[4030]: at_chat_send_common: enqueued =
"AT+CGMM", len is 1
    Sep 25 14:45:49 target ofonod[4030]: Aux: > AT+CGMM\r
    Sep 25 14:45:49 target ofonod[4030]: Aux: < \r\nEC21\r\n\r\nOK\r\n
    Sep 25 14:45:49 target ofonod[4030]: =
../../../../../../workspace/sources/ofono/plugins/quectel.c:cgmm_cb() =
0x4f6400 ok 1
    Sep 25 14:45:49 target ofonod[4030]: =
../../../../../../workspace/sources/ofono/plugins/quectel.c:cgmm_cb() =
0x4f6400 model EC21
    Sep 25 14:45:49 target ofonod[4030]: =
../../../../../../workspace/sources/ofono/plugins/quectel.c:setup_aux() =
0x4f6400
    Sep 25 14:45:49 target ofonod[4030]: at_chat_send_common: enqueued =
"ATE0; &C0; +CMEE=3D1", len is 1
    Sep 25 14:45:49 target ofonod[4030]: at_chat_send_common: enqueued =
"AT+QURCCFG=3D"urcport","uart1"", len is 2
    Sep 25 14:45:49 target ofonod[4030]: at_chat_send_common: enqueued =
"AT+CFUN?", len is 3
    Sep 25 14:45:49 target ofonod[4030]: Aux: > ATE0; &C0; +CMEE=3D1\r
    Sep 25 14:45:49 target ofonod[4030]: Aux: < \r\nOK\r\n
    Sep 25 14:45:54 target ofonod[4030]: Aux: < \r\nNORMAL POWER =
DOWN\r\n
    Sep 25 14:45:54 target ofonod[4030]: Modem: < \r\nPOWERED DOWN\r\n
    Sep 25 14:45:54 target ofonod[4030]: Aux: < \r\nPOWERED DOWN\r\n

I'm digging into oFono's codebase for the first time. In setup_aux, I'm =
seeing g_at_chat_send-ing multiple requests in a row and =
g_at_chat_send-ing without a callback for the first time. Is this =
supposed to work or might this be the cause of the current "roadblock" =
on my way?


Best regards,

Christian

--=20
[1] =
https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/plugins/quecte=
l.c?h=3D2.18#n824=

--Apple-Mail=_94C00879-6570-4EA2-A508-8E8663BBF4F1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEIhqZz/J2souq/IKUfmJl21on4+EFAmjVV90ACgkQfmJl21on
4+HyQw/+KcIMKFYFYxq0Y32ZPBgnicedswVrHtPJSZy5aGb13lUqheRFpVHv021S
/WYNptWE3XIw0SGnI8+A0fr+cLxIwsjrHj0M6mdbMHJV0oySuv0N0ChcbZor2j06
s+exfVcRKrBQOb/v/49ilvMtp3mpFT1cAIWws/WD162twL0s1oKSOdZSlQ6da5No
LJk3KqWfbATvaZIEAL8SrGjOMVeNM6Q9sZNOFu7JXncy7TXpV2rP2DSRnguZmAD9
9FLr8pSYZYru73XTJta3Cu9kMNYjSSRGyy6tPuTXZD5/cS9DQ7TBFfAKyveWMP/l
XPV1eUsS7N2kCtUIFT79Wd9YA1t9Mmbl8hACORAS2wGax0QI9gs2iRxAG2yMUCjV
C+ZtQUtFHE47QysTkXmnJ63EuN4CH79AA7S0fueOd8VpFMBQo5Bop5IFwwb8//fq
/GpmgJ8pSdG0U0utBVuYoxsuJNboFqI0Kf5KHFh8iCx6abxaQLe3Fmwz8iVYRG10
4u1MOpECBqhbAJK3ewepsEhvszocH2HjchDH395cbt91iax+swDHgiccAJMUZwZp
bBE1Kzr/3+EzjjVemX1TonT6U1XXr+LhO+K5nk66KSyt2yWRsvQ/9/HpnfqWZUZl
ePL1cHFBu/1pU4/K4CYVKTWsmOV4uQA2d8T7Dn0mOs5tHZZKoe0=
=G+v+
-----END PGP SIGNATURE-----

--Apple-Mail=_94C00879-6570-4EA2-A508-8E8663BBF4F1--
