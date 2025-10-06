Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5151B4247
	for <ofono@lists.linux.dev>; Mon,  6 Oct 2025 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759756582; cv=none; b=cKADAshRECoJqzr7Ius49BzgKN46JS6DrnPvqgPqCYFrTIB2zb5tJK/Ub8mGC34xk6My26HF3MFvAvsK8AtyPux+C5XJ7eh/8JLBXmpwIYQVL7Ew4FUymFjCjFWYs6hTtGqUIfBc4f9ICNSnFIjEdpF8wukR1gd23+7oBsV8eB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759756582; c=relaxed/simple;
	bh=cw4/Oea+Mo/4b5e3Z+ZlSAGnpwnTsHZ9Z/EmBBXR6f0=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cShBdfYPKcX1rF/ThE0ZgDxrqEavLXtu1zGkJQ35TdtKuKVN6z4SVT0pBf0vnoijvwWq3u/rDE4aIFT52zXsqXU6ar9aXOofa169eehLWN5heooCAEV30/fTs0HEyJb3r4dRrwVTuDKqNZWsWw5TDtY5QeA1ZhsnI0PI2aa2npg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=NjNxh1mb; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="NjNxh1mb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1759756569; x=1760015769;
	bh=cw4/Oea+Mo/4b5e3Z+ZlSAGnpwnTsHZ9Z/EmBBXR6f0=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NjNxh1mbN1I+DU7raiMYvz7vFeO7r9EfjatvGdEgzvB3Egf0sn56fN6DopZP1eKlg
	 TW+I0179p8R/1wBj5x7q/Rde6jaNVIbVaaqHPyDGWzPFmw99lhjBr84FuwEihXp1AR
	 w3iWrae1D+iYDHkj1te/fEkwDTqoW+wNgnMWiwSafhMK3wozm6GPod56TvSG3FMKE5
	 XDI9BBld8suxh7uE6SZedf9q0abPXMVp4PeAEuFiSAJQpVsB0BGju+3pxtuu9g/UY9
	 AgGwQ/sScVjMEUjUVf6z0C8PlpRH4HbMmmLjYY7V3ZOg+O9AQxaAqmDvtuDBcdWyVs
	 9I1judJscJnhg==
Date: Mon, 06 Oct 2025 13:15:59 +0000
To: Christian Meusel <christian.meusel@posteo.de>, ofono@lists.linux.dev
From: =?utf-8?Q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: Quectel EC21 with internal GSM MUX
Message-ID: <936c9eeeb421fd6f215bd7dc1e26fb9cf00d9f3e.camel@geanix.com>
In-Reply-To: <90E62BD5-4BE0-433C-AE89-6B7D99AACE9D@posteo.de>
References: <90E62BD5-4BE0-433C-AE89-6B7D99AACE9D@posteo.de>
Feedback-ID: 134068524:user:proton
X-Pm-Message-ID: a1da7b146c51a7561c3d381e37e9ee162d7aad0c
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_d2uTBtYi2VMtAcWdExwgoHD9eopdPjOX4J6bfoE5VVk"

--b1=_d2uTBtYi2VMtAcWdExwgoHD9eopdPjOX4J6bfoE5VVk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-09-25 at 14:55 +0000, Christian Meusel wrote:

<snip>

> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:48 target ofonod[4030]:
> ../../../../../../workspace/sources/ofono/plugins/quectel.c:ate_cb()
> 0x4f6400
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:48 target ofonod[4030]: at_chat_send_comm=
on:
> enqueued "AT+CMUX=3D0,0,5,127,10,3,30,10,2", len is 1
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:48 target ofonod[4030]: UART: >
> AT+CMUX=3D0,0,5,127,10,3,30,10,2\r
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:48 target ofonod[4030]: UART: < \r\n
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:48 target ofonod[4030]: UART: < OK\r\n
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:48 target ofonod[4030]:
> ../../../../../../workspace/sources/ofono/plugins/quectel.c:cmux_cb()
> 0x4f6400
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:49 target ofonod[4030]:
> ../../../../../../workspace/sources/ofono/src/modem.c:get_modem_prope
> rty() modem 0x4f6400 property Mux
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:49 target ofonod[4030]:
> ../../../../../../workspace/sources/ofono/plugins/quectel.c:cmux_acti
> vation_delay_cb() 0x4f6400
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:49 target ofonod[4030]:
> ../../../../../../workspace/sources/ofono/plugins/quectel.c:cmux_gatm
> ux() 0x4f6400
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:49 target ofonod[4030]:
> ../../../../../../workspace/sources/ofono/plugins/quectel.c:create_ch
> at() 0x4f6400
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:49 target ofonod[4030]:
> ../../../../../../workspace/sources/ofono/plugins/quectel.c:create_ch
> at() 0x4f6400
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:49 target ofonod[4030]:
> ../../../../../../workspace/sources/ofono/plugins/quectel.c:identify_
> model() 0x4f6400
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:49 target ofonod[4030]: at_chat_send_comm=
on:
> enqueued "AT+CGMM", len is 1
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:49 target ofonod[4030]: Aux: > AT+CGMM\r
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:49 target ofonod[4030]: Aux: <
> \r\nEC21\r\n\r\nOK\r\n
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:49 target ofonod[4030]:
> ../../../../../../workspace/sources/ofono/plugins/quectel.c:cgmm_cb()
> 0x4f6400 ok 1
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:49 target ofonod[4030]:
> ../../../../../../workspace/sources/ofono/plugins/quectel.c:cgmm_cb()
> 0x4f6400 model EC21
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:49 target ofonod[4030]:
> ../../../../../../workspace/sources/ofono/plugins/quectel.c:setup_aux
> () 0x4f6400
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:49 target ofonod[4030]: at_chat_send_comm=
on:
> enqueued "ATE0; &C0; +CMEE=3D1", len is 1
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:49 target ofonod[4030]: at_chat_send_comm=
on:
> enqueued "AT+QURCCFG=3D"urcport","uart1"", len is 2
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:49 target ofonod[4030]: at_chat_send_comm=
on:
> enqueued "AT+CFUN?", len is 3
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:49 target ofonod[4030]: Aux: > ATE0; &C0;=
 +CMEE=3D1\r
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:49 target ofonod[4030]: Aux: < \r\nOK\r\n
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:54 target ofonod[4030]: Aux: < \r\nNORMAL=
 POWER
> DOWN\r\n
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:54 target ofonod[4030]: Modem: < \r\nPOWE=
RED
> DOWN\r\n
> =C2=A0=C2=A0=C2=A0 Sep 25 14:45:54 target ofonod[4030]: Aux: < \r\nPOWERE=
D DOWN\r\n

I think these "POWER" notification from the modem are the culprit. We
carry the attached patch in our setup to avoid those messages stalling
the AT parser.

I must admit that past me would have written a better commit message,
but here we are :/

With that said: Why does the modem choose to power down? Is
someone/something toggling the power-up GPIO to the modem?

// Martin

--b1=_d2uTBtYi2VMtAcWdExwgoHD9eopdPjOX4J6bfoE5VVk
Content-Type: text/x-patch; charset=UTF-8; name=0001-gatchat-handle-trailing-r-n-on-quectel-power-warning.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-gatchat-handle-trailing-r-n-on-quectel-power-warning.patch

RnJvbSBlODJkNDgzNDA1OGI5MDg0Zjc3M2JiNWEyMGU1YTNlYjVlODA3ZTYwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/TWFydGluPTIwSHVuZGViPUMzPUI4bGw/PSA8
bWFydGluQGdlYW5peC5jb20+CkRhdGU6IEZyaSwgMTcgSnVsIDIwMjAgMTE6MTk6MDYgKzAyMDAK
U3ViamVjdDogW1BBVENIXSBnYXRjaGF0OiBoYW5kbGUgdHJhaWxpbmcgXHJcbiBvbiBxdWVjdGVs
IHBvd2VyIHdhcm5pbmcgVVJDcwoKVXBzdHJlYW0tU3RhdHVzOiBJbmFwcHJvcHJpYXRlCi0tLQog
Z2F0Y2hhdC9nYXRjaGF0LmMgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2dhdGNoYXQvZ2F0Y2hh
dC5jIGIvZ2F0Y2hhdC9nYXRjaGF0LmMKaW5kZXggZGQ5MTA5MTUuLjM1NzY5ZDFhIDEwMDY0NAot
LS0gYS9nYXRjaGF0L2dhdGNoYXQuYworKysgYi9nYXRjaGF0L2dhdGNoYXQuYwpAQCAtNjk2LDYg
KzY5Niw3IEBAIHN0YXRpYyBjaGFyICpleHRyYWN0X2xpbmUoc3RydWN0IGF0X2NoYXQgKnAsIHN0
cnVjdCByaW5nX2J1ZmZlciAqcmJ1ZikKIAlnYm9vbGVhbiBpbl9zdHJpbmcgPSBGQUxTRTsKIAlp
bnQgc3RyaXBfZnJvbnQgPSAwOwogCWludCBsaW5lX2xlbmd0aCA9IDA7CisJaW50IHN0cmlwX3Rh
aWwgPSAwOwogCWNoYXIgKmxpbmU7CiAKIAl3aGlsZSAocG9zIDwgcC0+cmVhZF9zb19mYXIpIHsK
QEAgLTcyNiw2ICs3MjcsMzMgQEAgc3RhdGljIGNoYXIgKmV4dHJhY3RfbGluZShzdHJ1Y3QgYXRf
Y2hhdCAqcCwgc3RydWN0IHJpbmdfYnVmZmVyICpyYnVmKQogCiAJcmluZ19idWZmZXJfZHJhaW4o
cmJ1Ziwgc3RyaXBfZnJvbnQpOwogCXJpbmdfYnVmZmVyX3JlYWQocmJ1ZiwgbGluZSwgbGluZV9s
ZW5ndGgpOworCisJc3dpdGNoIChsaW5lX2xlbmd0aCkgeworCQljYXNlIDE4OgorCQkJaWYgKG1l
bWNtcChsaW5lLCAiTk9STUFMIFBPV0VSIERPV04gIiwgMTgpID09IDApCisJCQkJc3RyaXBfdGFp
bCArPSAyOworCQkJYnJlYWs7CisJCWNhc2UgMjE6CisJCQlpZiAobWVtY21wKGxpbmUsICJPVkVS
X1ZPTFRBR0UgV0FSTklORyAiLCAyMSkgPT0gMCkKKwkJCQlzdHJpcF90YWlsICs9IDI7CisJCQli
cmVhazsKKwkJY2FzZSAyMjoKKwkJCWlmIChtZW1jbXAobGluZSwgIlVOREVSX1ZPTFRBR0UgV0FS
TklORyAiLCAyMikgPT0gMCkKKwkJCQlzdHJpcF90YWlsICs9IDI7CisJCQlicmVhazsKKwkJY2Fz
ZSAyNDoKKwkJCWlmIChtZW1jbXAobGluZSwgIk9WRVJfVk9MVEFHRSBQT1dFUiBET1dOICIsIDI0
KSA9PSAwKQorCQkJCXN0cmlwX3RhaWwgKz0gMjsKKwkJCWJyZWFrOworCQljYXNlIDI1OgorCQkJ
aWYgKG1lbWNtcChsaW5lLCAiVU5ERVJfVk9MVEFHRSBQT1dFUiBET1dOICIsIDI1KSA9PSAwKQor
CQkJCXN0cmlwX3RhaWwgKz0gMjsKKwkJCWJyZWFrOworCX0KKworCWlmIChyaW5nX2J1ZmZlcl9s
ZW4ocmJ1ZikgPj0gKGludClwLT5yZWFkX3NvX2ZhciArIHN0cmlwX3RhaWwpCisJCXAtPnJlYWRf
c29fZmFyICs9IHN0cmlwX3RhaWw7CisKIAlyaW5nX2J1ZmZlcl9kcmFpbihyYnVmLCBwLT5yZWFk
X3NvX2ZhciAtIHN0cmlwX2Zyb250IC0gbGluZV9sZW5ndGgpOwogCiAJbGluZVtsaW5lX2xlbmd0
aF0gPSAnXDAnOwotLSAKMi41MC4xCgo=

--b1=_d2uTBtYi2VMtAcWdExwgoHD9eopdPjOX4J6bfoE5VVk--

