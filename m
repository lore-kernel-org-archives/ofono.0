Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388AA82D83
	for <ofono@lists.linux.dev>; Mon, 25 Mar 2024 23:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409555; cv=none; b=rnhgcYb6hHoJNyKR1B8oxf+d6CdCDwlvWXW1YLWa2+CKF0Txlpc9kugyjkXg/zNTZeDHlZwWrPW9P6ZzOJ3fxPeDlNNBn8GodxVio9qvQNWk523AX8iX7QwVOKl//65LZ4KnAcJVRKDF9FJ/8h3sa5cKag07GUS0yhViU5TuNSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409555; c=relaxed/simple;
	bh=H7Gnrav854S2LJtEVhS9NBxUICOS2VCYeIDszZqBRc0=;
	h=To:From:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-ID:MIME-Version; b=GE+hN7qtrs6WdOKCqdOE7J1v2AL2Y3/fCaolFq28nsjpUp8XXCNKRpaCZSmdidTSDLGZ9CYiWDjyHXtVQ0Fnr4ZF6WNXkabsER3RdUTEhEaqsL+0rT6rmwcCQqdkaJbRDP66Lkddv04czbuXLfJyinfnxq+HvSJN1pY6AZfTwU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErMA6Ss0; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErMA6Ss0"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d46dd8b0b8so64308351fa.2
        for <ofono@lists.linux.dev>; Mon, 25 Mar 2024 16:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711409552; x=1712014352; darn=lists.linux.dev;
        h=mime-version:message-id:date:content-transfer-encoding:references
         :in-reply-to:subject:from:to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7Gnrav854S2LJtEVhS9NBxUICOS2VCYeIDszZqBRc0=;
        b=ErMA6Ss0WH75I3WoBIM32/ACroh87mLGuLFnXxTtcN/SejfuBoA7LYUme7t4Qwcccl
         qbXtuVJPzzqbRzXpUrwGNOmsghJjU5840WCfQBQDFriQA9XVCNhwUOxZMKiZoGQFzpIw
         EI1zgyVdWkymbOiYSIVQOwppnQorLNHs0Ymnswsawkad7HjTZUKWr3NyI6HkFAxOdl8C
         7lQa30rOnPwEMnf/osEDTgyariiQwfaYCUQAXZb3KlEaTuqSp/996RefA7nZF/38gsGN
         8k46OBlbqvceOximtMZLYAN2aY1EG60ZS6Eo2SAWP1JgbIeMz+edPICxacAX5S0jOKac
         Ow4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711409552; x=1712014352;
        h=mime-version:message-id:date:content-transfer-encoding:references
         :in-reply-to:subject:from:to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H7Gnrav854S2LJtEVhS9NBxUICOS2VCYeIDszZqBRc0=;
        b=ewTzxjL5VdAMEm3GrDtGmfqn1n5PfGjWg3snfQdWwoP0S7x64z7hIUcsAOnQgTAhE+
         J6BeuwPq+Bm+HPOgsy+NMthEBO6cIhXkvu7/PnC0aKGw62T35vqqp9Hqi12Pmlykysoc
         7RpQ7/WBmQKrd3+WcVj1OQd2+DEctWQa5sdDYE+SqWnKr1tj7KZKh0F1XFGpa0TdeTIM
         yAmkPK3nJc4ptdVCIZiO2Bg+dZ78YC3/NIRiPSI1tWOAheWdj+u2e24opwSyU2zBBEZA
         B6Els9GDJ7znEl+w5sxhpfEt1+7R9lMJauSuXnmqt5kq2Ut51u+g7Vry7JYoQi5nC7Fc
         TD+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyNdTij6VBW6UKGxNPnhGMSvUbwk63EtOiNj3U3eNjt9mZZiIoj9nV6Wfb6drdD//h+Ohg9TkLMW+6r7DBwVDjWFUX6+k=
X-Gm-Message-State: AOJu0YwcwKvfVJRx+FSJhdn0zhcr3slIo0tpBL5CLaAb8Ehq6FaUHIUP
	2luhXMuuWYCw/46UM1gxAPh/LKnyYwEhPXIIIGpcNYG9xe0o4AEa
X-Google-Smtp-Source: AGHT+IFrPy8ZcH+4HnWBTuW095kVhC2qameK81IB2TsEogdZc4phc2/PJnjfbqj9fMEnk+F+NB449Q==
X-Received: by 2002:a2e:a708:0:b0:2d6:b072:22c5 with SMTP id s8-20020a2ea708000000b002d6b07222c5mr675493lje.42.1711409551908;
        Mon, 25 Mar 2024 16:32:31 -0700 (PDT)
Received: from [100.96.214.50] (92.40.181.135.threembb.co.uk. [92.40.181.135])
        by smtp.gmail.com with ESMTPSA id r13-20020a056402018d00b0056c18b79cd3sm1055804edv.22.2024.03.25.16.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:32:31 -0700 (PDT)
X-Priority: 3
To: denkenz@gmail.com,adam@piggz.co.uk,ofono@lists.linux.dev
From: piggz1@gmail.com
Subject: Re: [PATCH 1/4] [qmimodem][voicecall] Implement call dialing
In-Reply-To: <3c148086-1baa-4a72-83b9-c3d0fe0a8b5a@gmail.com>
References: <20240325221742.5931-1-adam@piggz.co.uk>
 <3c148086-1baa-4a72-83b9-c3d0fe0a8b5a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Date: Mon, 25 Mar 2024 23:32:29 +0000
Message-ID: <64u1qk.saxg27.runf3m-qmf@smtp.gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

QWggb2ssIHRoYW5rcywgaWxsIGNoZWNrIHRoaXMgaW4gdGhlIG1vcm5pbmcuICBJdCB3YXMgYWdh
aW5zdCBhIGJyYW5jaCBmcm9tIDIuNSB3aGljaCBhbHNvIGNvbnRhaW5zIHRoZSBvdGhlciBjaGFu
Z2VzIGkgbmVlZCBmb3IgdGVzdGluZyB3aXRoIHNhaWxmaXNoLiAgaWxsIHJlYmFzZSBpdCBvbiBI
RUFEIGFuZCByZS1zdWJtaXQuDQoNCk9uIE1vbmRheSwgMjUgTWFyY2ggMjAyNCwgRGVuaXMgS2Vu
emlvciB3cm90ZToNCj4gSGkgQWRhbSwNCj4gDQo+IE9uIDMvMjUvMjQgMTc6MTYsIEFkYW0gUGln
ZyB3cm90ZToNCj4gPiBBZGQgdm9pY2VjYWxsIGRpYWxsaW5nIHRvIHRoZSBxbWltb2RlbSBkcml2
ZXINCj4gPiBJbmNsdWRlcyByZXF1aXJlZCBpbmZyYXRydWN0dXJlIGFuZCBzZXR1cCBvZiB0aGUg
UU1JIHNlcnZpY2VzDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3FtaW1vZGVtL3ZvaWNlLmggICAg
IHwgIDUxICsrKysNCj4gPiAgIGRyaXZlcnMvcW1pbW9kZW0vdm9pY2VjYWxsLmMgfCA1MDYgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwg
NTU1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+IA0KPiBIbW0sIGhhdmUg
eW91IHJlYmFzZWQgb24gdG9wIG9mIGdpdCBIRUFEPw0KPiANCj4gQ0kgc2VlbXMgdW5hYmxlIHRv
IGFwcGx5IHRoaXMgc2VyaWVzDQo+IA0KPiBSdW4gZ2l0LXB3IHNlcmllcyBhcHBseSA4MzgxMTIN
Cj4gRmFpbGVkIHRvIGFwcGx5IHBhdGNoOg0KPiBBcHBseWluZzogSW1wbGVtZW50IGNhbGwgZGlh
bGluZw0KPiBlcnJvcjogc2hhMSBpbmZvcm1hdGlvbiBpcyBsYWNraW5nIG9yIHVzZWxlc3MgKGRy
aXZlcnMvcW1pbW9kZW0vdm9pY2VjYWxsLmMpLg0KPiBlcnJvcjogY291bGQgbm90IGJ1aWxkIGZh
a2UgYW5jZXN0b3INCj4gaGludDogVXNlICdnaXQgYW0gLS1zaG93LWN1cnJlbnQtcGF0Y2g9ZGlm
ZicgdG8gc2VlIHRoZSBmYWlsZWQgcGF0Y2gNCj4gUGF0Y2ggZmFpbGVkIGF0IDAwMDEgSW1wbGVt
ZW50IGNhbGwgZGlhbGluZw0KPiBXaGVuIHlvdSBoYXZlIHJlc29sdmVkIHRoaXMgcHJvYmxlbSwg
cnVuICJnaXQgYW0gLS1jb250aW51ZSIuDQo+IElmIHlvdSBwcmVmZXIgdG8gc2tpcCB0aGlzIHBh
dGNoLCBydW4gImdpdCBhbSAtLXNraXAiIGluc3RlYWQuDQo+IFRvIHJlc3RvcmUgdGhlIG9yaWdp
bmFsIGJyYW5jaCBhbmQgc3RvcCBwYXRjaGluZywgcnVuICJnaXQgYW0gLS1hYm9ydCIuDQo+IA0K
PiBBbHNvLCBJIGNhbid0IGRvIGl0IG1hbnVhbGx5IG9uIG15IGVuZCBkdWUgdG86DQo+IA0KPiBb
ZGVua2VuekBhcmNoZGV2IG9mb25vXSQgZ2l0IHB3IHNlcmllcyBhcHBseSA4MzgxMTINCj4gRmFp
bGVkIHRvIGFwcGx5IHBhdGNoOg0KPiBBcHBseWluZzogSW1wbGVtZW50IGNhbGwgZGlhbGluZw0K
PiAuZ2l0L3JlYmFzZS1hcHBseS9wYXRjaDo5MjogbmV3IGJsYW5rIGxpbmUgYXQgRU9GLg0KPiAr
DQo+IC5naXQvcmViYXNlLWFwcGx5L3BhdGNoOjY1MjogbmV3IGJsYW5rIGxpbmUgYXQgRU9GLg0K
PiArDQo+IGVycm9yOiAyIGxpbmVzIGFkZCB3aGl0ZXNwYWNlIGVycm9ycy4NCj4gDQo+IFJlZ2Fy
ZHMsDQo+IC1EZW5pcw0KPg0KDQotLSANClNlbnQgZnJvbSBteSBTYWlsZmlzaCBkZXZpY2U=
