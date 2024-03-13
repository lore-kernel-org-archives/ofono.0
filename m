Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E5018629
	for <ofono@lists.linux.dev>; Wed, 13 Mar 2024 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710316786; cv=none; b=ZnoExUy8a75nYRvGa6Zc+BqFS4V6AYIkWjD+zZVfJuKNUegAoliP8Fb9bxeqFeP5gfzIewbgyotEbp3WDRM6GbWkcsUs/AcWgFcO9Ahw9avIUASMr04ms0S32CmtgibGaF950XMLIxcHjThxtNagx8C0eMNoh+lzglPL3WaoHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710316786; c=relaxed/simple;
	bh=oQsS5S1Chkk25VyefKPPl8rDj+A9jYjNRNgcgyrhuys=;
	h=To:From:Subject:Content-Type:Date:Message-ID:MIME-Version; b=UwGVzmEB1RYfKTAvreMMdWJ3K4p3WHu8NhUSvm+8yNQ0fWfRFUXBuDhamXR83hErmnOdsQ3fI6z3RW2b1ODZadlf9uqIwnx7bzK/GL5pYIDffBrqV7aUSzdpGwo1JMYyMbLZ+zjsHI4+yt6BNnuTiOHrOzKye+tMGJ2cF776b6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5j8FXSs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5j8FXSs"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-413e9965782so1830125e9.3
        for <ofono@lists.linux.dev>; Wed, 13 Mar 2024 00:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710316782; x=1710921582; darn=lists.linux.dev;
        h=mime-version:message-id:date:content-transfer-encoding:subject:from
         :to:from:to:cc:subject:date:message-id:reply-to;
        bh=oQsS5S1Chkk25VyefKPPl8rDj+A9jYjNRNgcgyrhuys=;
        b=P5j8FXSs8N4DhUXoUnVafQ9F/kVFMxCiY+jjEPgp9iG9qzsqJvYIPzQfjxbzJ66qve
         bp+ozagqYxmKerPJeTdqANh+JmKky5ygkfuzT5/WKiEx8zq2Qq6x4kFzh0cRW0FCEaJV
         i7u+m67BBQ5vDd00hrlViW6ycHYSVe62Nx4V9pT6koLpTnvSyu8EBKtxkakcL/t+6dG0
         I3aG55c5tC5b9FsWrXuuf6meyw1RdfDLU0hagGb0skEfIS+3Rz+ITPyUbO3/6Qhw0/iF
         XC4umm8HF9BnjogCay9vO6/zb16PupdApLmHkZq9FsjgCQDjOsr4m3TpdJf8ajGOBqIm
         /aQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710316782; x=1710921582;
        h=mime-version:message-id:date:content-transfer-encoding:subject:from
         :to:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQsS5S1Chkk25VyefKPPl8rDj+A9jYjNRNgcgyrhuys=;
        b=dI9Qo2PsoYduZ7PgQZy10mCko4hGUVKvDUx/jYcyElbXDtggIhc+JNgywLDTD68Esv
         +6mDc2Lso344RtjiKB8s236B8dgMNEjNdP1ukRhDY0xdKFouKrcAG/pY85jsNNq01FBl
         rt//IJMLAVWUbOeZIJEiJZKDHXEXk8FByq5+0SIjP6NkwgjUMbynh27TvsZVvrlwYXnv
         8EEjYvPYd8j84JCKOAAY4NPZAxHDgiip7slPjcHJDSQQ8QxgOZwI9y8zAaVA0XwZ40Gx
         d+fiqiVpXZboAPKjt7RCkXbXqFFCjqnHv0tboYD2MCo8zrvLMq9laWUrxgepZbhrGTiG
         GaFQ==
X-Gm-Message-State: AOJu0Yw2/IBL3xX2bg85+i4SLxlL4ubOEaCnMN9KL3mL1ero0Z1GMmFU
	LrnL75eM8+3qEnLN9Rxa1psOyz8h+WsROm33AwmdkQketNlt9yUWD8rni8AH
X-Google-Smtp-Source: AGHT+IHsfG25eiW8Sc947gZ3eB1tbOjjPCxJI4NL3Skat/K7GBvzhzfs8SERtcCtc/vmtoz2qpFPnw==
X-Received: by 2002:a05:600c:19cc:b0:413:128a:403 with SMTP id u12-20020a05600c19cc00b00413128a0403mr1697260wmq.1.1710316782162;
        Wed, 13 Mar 2024 00:59:42 -0700 (PDT)
Received: from [10.11.197.70] (92.40.168.3.threembb.co.uk. [92.40.168.3])
        by smtp.gmail.com with ESMTPSA id he13-20020a05600c540d00b0041331ca9692sm1479079wmb.10.2024.03.13.00.59.41
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 00:59:41 -0700 (PDT)
X-Priority: 3
To: ofono@lists.linux.dev
From: piggz1@gmail.com
Subject: Possible ofono patches
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Date: Wed, 13 Mar 2024 07:59:40 +0000
Message-ID: <scd9r5.saa0vh.2sch1i-qmf@smtp.gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

SGkgYWxsDQoNCkEgZmV3IHdlZWtzIGFnbywgaSBzdGFydGVkIGEgcGVyc29uYWwgcHJvamVjdCB0
byB0cnkgdG8gcmViYXNlIHRoZSBqb2xsYSBvZm9uYWxvIGRidXMgYXBpJ3MgYW5kIGNoYW5nZXMg
b250b3Agb2YgY3VycmVudCBvZm9uby4gIEkgYW0gd3JpdGluZyBhYm91dCBpdCBoZXJlIGh0dHBz
Oi8vd3d3LnBpZ2d6LmNvLnVrL3NpdGVzL3Bnei9ibG9nDQoNCk15IGN1cnJlbnQgd29yayBpcyBh
Z2FpbnN0IDIuNSB3aXRoIHBhdGNoZXMgdGhhdCBhcmUgc29tZXdoYXQgd29ya2luZyB3aXRoIG15
IHBpbmVwaG9uZS4gTXkgdHJlZSBvZiBpbmRpdmlkdWFsIHBhdGNoZXMgaXMgYXZhaWxhYmxlIGF0
IGh0dHBzOi8vZ2l0aHViLmNvbS9waWdnei9vZm9uby11cHN0cmVhbS90cmVlL21haW4vcnBtDQoN
Ckkgd29uZGVyZWQgaWYgYW55b25lIHdvdWxkIGNhcmUgdG8gc2NhbiBvdmVyIHRoZW0gYW5kIHBy
b3ZpZGUgZmVlZGJhY2sgYXMgdG8gd2hldGhlciBhbnkgYXJlIHN1aXRhYmxlIHRvIHVwYXRyZWFt
IGludG8gb2Zvbm8uICBJIGFwcHJlY2lhdGUgbm90IGFsbCB3aWxsIGJlLCBidXQgd2l0aCBzb21l
IHJld29yaywgb3RoZXJzIG1heSBiZSBvZiBpbnRlcmVzdC4NCg0KVGhlcmUgaXMgYSB3b3JraW5n
IHZvaWNlY2FsbCBpbXBsZW1lbnRhdGlvbiBmb3IgcW1pbW9kZW0sIHdoaWNoIGluY2x1ZGVzIGEg
cmVmYWN0b3JlZCBjYWxsLWxpc3QgaW1wbGVtZW50YXRpb24uICBNYW55IG9mIHRoZSBvdGhlcnMg
YWRkIGRidXMgaW50ZXJmYWNlcyBmb3Igc2FpbGZpc2ggc28gbWF5IG5vdCBiZSBpbnRlcmVzdGlu
Zy4gDQoNClRoYW5rcyB0byBhbnlvbmUgd2hvIHRha2VzIGEgbG9vaw0KDQpBZGFtDQoNCi0tIA0K
U2VudCBmcm9tIG15IFNhaWxmaXNoIGRldmljZQ==
