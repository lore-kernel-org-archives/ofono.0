Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74E14C7C
	for <ofono@lists.linux.dev>; Thu,  7 Sep 2023 16:49:21 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5738cb00eebso680058eaf.2
        for <ofono@lists.linux.dev>; Thu, 07 Sep 2023 09:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694105360; x=1694710160; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IHt/fetpCz/ZAsSNtYDACTrpOb9InAvE2RT8zuF++OY=;
        b=Re+vvB6tbcqrIFY4ZFekh0KBD0YPXwcb6DZCaC0L1aHQExqEkrVxIjjuuEadXn460E
         yvKBGV4xg7a4ZW56AsHQJGQ2Bgq9LxrRzJqAlMzXGumpNPvQV3r0Kv9t1gPNEP0MJ5+B
         C+70thgEK9RyLFDG+xdK8nBfzN/FUOZfo1fn/m3wcQJAB5QYGqdPHah5lIAbqyNRM0St
         9zZFILXOVPBf0Fl4be2kSSCgDXXvAKmDR9MNO47RFb+wCaNv2qKaOrTCX2IDRrPa35yb
         i58kZcRaj/T9i0DakWq1UU+IAwSyynzQvC8BNkIKZWkSZ1tT2xio7ZqsxjmV+p/EqJxu
         3Z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694105360; x=1694710160;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHt/fetpCz/ZAsSNtYDACTrpOb9InAvE2RT8zuF++OY=;
        b=cIPMpJNffjvQnYFPQJGucTAq4KKAUxfV/TG/k0wFNzg0N0VlQ0inZrCruIC7AvbzRg
         l1LUxkeVvSDE8m56MxyDLRdQjbYMM18R8d/gdw6e2IC9Q4RnK+2QhemAdo+OSOY8gnW7
         kpA43eVs5bdmbg35CkvUQX9EM+SLrhGa2V+ssPa4E8PPkmykmqyjGs1tGP5mEaZ4Tkon
         xqcufQIKwgKav2utsu6wzs+xBQYXaa+cZFS7QJJsnAwRSPE5jFgstwquyklcy2x4mUq6
         2TDwcw6djxd7RQClO/VnfgqLgvS9eUDyVkzCn7MIICNUHwr4/sAgAZZ6ZeQm7jqcHGbN
         V1mg==
X-Gm-Message-State: AOJu0Yz95pQ4ekD6RUi+yU3+D0d4lBOrZtSypRGPDuuSf5zzvp1+Y5YQ
	F+gZ9Kw5WLtQMr6aQ5yPw29Oh2eSlSoeXNFjWq69+QruDRU=
X-Google-Smtp-Source: AGHT+IGcPBlVNpqr97gN78JNqP4pqlYxw63lxCp6bEnPNTBj+RgM6groQ3/qxjyePIXsaay7RRUpRTvmFWef5EDYPZE=
X-Received: by 2002:a4a:3802:0:b0:571:aceb:26ce with SMTP id
 c2-20020a4a3802000000b00571aceb26cemr161635ooa.1.1694105358870; Thu, 07 Sep
 2023 09:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Mohamed Ali Fodha <fodha.mohamed.ali@gmail.com>
Date: Thu, 7 Sep 2023 17:49:07 +0100
Message-ID: <CAAcv5+6TL4qU9N-CsVDjusG=p-c4ZL3LYQQdCZyLDA4TkvJn3Q@mail.gmail.com>
Subject: LET context deactivation
To: ofono@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

I am using SIM7600 chip with ofono 1.31, when I set Online to true,
the internet context is activated and it is not possible to deactivate
it at all using the following command:

dbus-send --system --type=method_call --print-reply --dest=org.ofono
/csim7x00_0/context1 org.ofono.ConnectionContext.SetProperty
string:"Active" variant:boolean:false

According to the log I saw always activate_primary which is
automatically called after above command.

Any idea how to disable the automatic LTE context which is created?

Thank you n advance,
Mohamed Ali
