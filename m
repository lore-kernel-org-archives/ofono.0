Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26026176185
	for <ofono@lists.linux.dev>; Thu, 30 May 2024 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058348; cv=none; b=tA2ZXCKOl7h3uhHTc0fPm9HTCHUET3v9H8nc4a2IaNHRt+7ZYdD7Tnu87JxQ77s6jD9rs81vnC74l6/hMjc5JXe7KnXpIpCZWeYEH6PjTlJ/UYVuf/KEY9mu22/++yb8Va8M9mznlUocmL0K+RZEMCkqD3/He8gaSXOttmlmOVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058348; c=relaxed/simple;
	bh=3CDSiZZ8QIfEmwSRYG1+pzxj9lFJZvO2ZFLwLY13mI4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rFg5K6ErSuqTGbmnILJSzwisPtlxieBrHneXJkjLYlLvp4Tjvvls1XiecTjFZ3Ut9xHE64zfBMeFQc0BMYI2hp28yMiqoHUa8jwOALuezxRY2S1yNrn4SmyIAsr7eAcV+LPm6npWAJG4a6yE3E/kFnO+d5aHCqFznM8R/p4awrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=COOnbZLc; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="COOnbZLc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=MIME-Version:Content-Transfer-Encoding:Content-Type:
	References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=3CDSiZZ8QIfEmwSRYG1+pzxj9lFJZvO2ZFLwLY13mI4=; b=COOnbZLcIlwZ8c5M95bwPV7xKX
	R+8xge+JMhinfksCR8uG3xaUn1NXcCTgIuQ+KRNUzQ+j8eOgsp6Xwfk+JD3NorlXjg7e+uwAyTb9+
	Pw6bMeTgLOBR+XKlvcVIN4eLkV/Ke4Bq9QpNmTMPZQJntPwreo2VizcTMFfxQV0nBz+BxvhuJitcE
	VDFJttqYFU6wLTmnfi5AQhzk7MMwdIjhBEL/xH4DXyIn6yfC9IS7pVT21y0r/NuTSjfhMXtJgNyDH
	6BajcURepH5ZVnHM1FoUdAbSkr6i0/oZFpcf2t+o/ha8qhO2MnG3bb3zPBZTwy9hwAGGNpgYJi17C
	+SNL0TBg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1sCbJJ-000P7m-6m; Thu, 30 May 2024 10:38:57 +0200
Received: from [185.17.218.86] (helo=[192.168.64.76])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@geanix.com>)
	id 1sCbJJ-000BKx-19;
	Thu, 30 May 2024 10:38:57 +0200
Message-ID: <037fc1e0e1dfbb816dcde6f66bccae95520fbb70.camel@geanix.com>
Subject: Re: [PATCH] quectel: fix use after free
From: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Date: Thu, 30 May 2024 10:38:56 +0200
In-Reply-To: <79f5b88a-d625-4c5c-addd-13727f8516c3@gmail.com>
References: <20240528082648.2010586-1-martin@geanix.com>
	 <79f5b88a-d625-4c5c-addd-13727f8516c3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27290/Wed May 29 10:30:54 2024)

Hi Deniz,

On Tue, 2024-05-28 at 17:13 -0500, Denis Kenzior wrote:
> On 5/28/24 3:26 AM, Martin Hundeb=C3=B8ll wrote:
> > Exitting ofono before going online with a quectel modem procudes
> > the
> > following use-after-free error:
> >=20
> > ^Cofonod[776]: Terminating
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D776=3D=3DERROR: AddressSanitizer: heap-use-after-free on address
> > 0xb4150734 at pc 0x005ad063 bp 0xbefa26c0 sp 0xbefa26c4
> > READ of size 4 at 0xb4150734 thread T0
> > =C2=A0=C2=A0=C2=A0=C2=A0 #0 0x5ad060 in ofono_sim_remove_file_watch
> > ../git/src/sim.c:2621
> > =C2=A0=C2=A0=C2=A0=C2=A0 #1 0x5ad060 in unwatch_sim_ecc_numbers
> > ../git/src/voicecall.c:2820
> > =C2=A0=C2=A0=C2=A0=C2=A0 #2 0x5ad060 in voicecall_unregister
> > ../git/src/voicecall.c:2849
> > =C2=A0=C2=A0=C2=A0=C2=A0 #3 0x57f910 in __ofono_atom_unregister ../git/=
src/modem.c:336
> > =C2=A0=C2=A0=C2=A0=C2=A0 #4 0x57f910 in __ofono_atom_unregister ../git/=
src/modem.c:329
> > =C2=A0=C2=A0=C2=A0=C2=A0 #5 0x57f910 in flush_atoms ../git/src/modem.c:=
492
> > =C2=A0=C2=A0=C2=A0=C2=A0 #6 0x57f910 in modem_change_state ../git/src/m=
odem.c:586
> > =C2=A0=C2=A0=C2=A0=C2=A0 #7 0x58013e in set_powered ../git/src/modem.c:=
974
> > =C2=A0=C2=A0=C2=A0=C2=A0 #8 0x58054a in __ofono_modem_shutdown ../git/s=
rc/modem.c:2279
> > =C2=A0=C2=A0=C2=A0=C2=A0 #9 0x58054a in signal_handler ../git/src/main.=
c:85
> >=20
> > 0xb4150734 is located 4 bytes inside of 8-byte region
> > [0xb4150730,0xb4150738)
> > freed by thread T0 here:
> > =C2=A0=C2=A0=C2=A0=C2=A0 #0 0xb6a88110=C2=A0 (/lib/libasan.so.8+0x97110=
) (BuildId:
> > 1374acedfadbe21a32d37a0a1f15e27d16516851)
> > =C2=A0=C2=A0=C2=A0=C2=A0 #1 0x641216 in sim_fs_free ../git/src/simfs.c:=
123
> > =C2=A0=C2=A0=C2=A0=C2=A0 #2 0x641216 in sim_fs_free ../git/src/simfs.c:=
103
> > =C2=A0=C2=A0=C2=A0=C2=A0 #3 0x5de12c in sim_remove ../git/src/sim.c:323=
9
> > =C2=A0=C2=A0=C2=A0=C2=A0 #4 0x57f95a in flush_atoms ../git/src/modem.c:=
495
> > =C2=A0=C2=A0=C2=A0=C2=A0 #5 0x57f95a in modem_change_state ../git/src/m=
odem.c:586
> > =C2=A0=C2=A0=C2=A0=C2=A0 #6 0x58013e in set_powered ../git/src/modem.c:=
974
> > =C2=A0=C2=A0=C2=A0=C2=A0 #7 0x58054a in __ofono_modem_shutdown ../git/s=
rc/modem.c:2279
> > =C2=A0=C2=A0=C2=A0=C2=A0 #8 0x58054a in signal_handler ../git/src/main.=
c:85
> >=20
> > previously allocated by thread T0 here:
> > =C2=A0=C2=A0=C2=A0=C2=A0 #0 0xb6a8891c in __interceptor_calloc
> > (/lib/libasan.so.8+0x9791c) (BuildId:
> > 1374acedfadbe21a32d37a0a1f15e27d16516851)
> > =C2=A0=C2=A0=C2=A0=C2=A0 #1 0x597b3e in sim_fs_context_new ../git/src/s=
imfs.c:155
> > =C2=A0=C2=A0=C2=A0=C2=A0 #2 0x597b3e in ofono_sim_context_create ../git=
/src/sim.c:2549
> > =C2=A0=C2=A0=C2=A0=C2=A0 #3 0x597b3e in watch_sim_ecc_numbers
> > ../git/src/voicecall.c:2925
> > =C2=A0=C2=A0=C2=A0=C2=A0 #4 0x57f506 in call_watches ../git/src/modem.c=
:314
> > =C2=A0=C2=A0=C2=A0=C2=A0 #5 0x4977be in at_clck_query_cb
> > ../git/drivers/atmodem/sim.c:1612
> > =C2=A0=C2=A0=C2=A0=C2=A0 #6 0x556cf4 in at_chat_finish_command
> > ../git/gatchat/gatchat.c:465
> > =C2=A0=C2=A0=C2=A0=C2=A0 #7 0x5583ae in at_chat_handle_command_response
> > ../git/gatchat/gatchat.c:527
> > =C2=A0=C2=A0=C2=A0=C2=A0 #8 0x5583ae in have_line ../git/gatchat/gatcha=
t.c:606
> > =C2=A0=C2=A0=C2=A0=C2=A0 #9 0x5583ae in new_bytes ../git/gatchat/gatcha=
t.c:765
> > =C2=A0=C2=A0=C2=A0=C2=A0 #10 0x559ef6 in received_data ../git/gatchat/g=
atio.c:122
> > =C2=A0=C2=A0=C2=A0=C2=A0 #11 0x563400 in dispatch_sources ../git/gatcha=
t/gatmux.c:184
> > =C2=A0=C2=A0=C2=A0=C2=A0 #12 0x56402c in received_data ../git/gatchat/g=
atmux.c:272
> >=20
> > The reason is the voicecall atom holding a reference to the sim
> > atom,
> > which is read in the voicecall_unregister() path. Avoid the error
> > by
> > simply instantiating the sim atom before the voicecall atom, which
> > makes
> > the latter being unregistered first.
>=20
> Thanks for the reported.=C2=A0 This should really be fixed in the core.=
=C2=A0
> Can you try=20
> the following patch:
>=20
> https://patchwork.kernel.org/project/ofono/patch/20240528220642.251435-1-=
denkenz@gmail.com/
>=20
>=20

I've tested the patch, and it fixes the issue.

Thanks,
Martin
