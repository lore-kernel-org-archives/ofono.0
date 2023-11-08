Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B47211C83
	for <ofono@lists.linux.dev>; Wed,  8 Nov 2023 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8rrmy8b"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9d267605ceeso1016678366b.2
        for <ofono@lists.linux.dev>; Wed, 08 Nov 2023 02:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699439348; x=1700044148; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LPXoDYM/dgX2TDWJPKM4KeEJ93mEPGg+dPGj76p/O/I=;
        b=E8rrmy8bYfaWN/SWQ4NxR8BNCvrDc+Oy+CdMBT4BuexkcvW+Q/O9hsa5kva5XC5AEM
         OYGfErnGjBPWsCq/3SQ3mvdijB0qEHs0bW/4vRzm353XEdySIf4c2HmF/7NwfpMFmJ7p
         +F9xSLpAv8zMDm0Vi/fVhbLxa7zPg0Lsm2vGKtJWHTF4ZoJJDgovhZ9S164acLDLD/as
         Jjl+3jIHbgj702qlNUnL1RabpSXBnFjQXWXfhAem5RGulxFmRXwhrszCXRchEaEShQ/k
         G6b8fvG6Lp83PAV+0zPV1uBOGWpyIdWp8YBJfCan4P2tjp98vryJ7Wdgaq4JhrfzXN25
         vg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699439348; x=1700044148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPXoDYM/dgX2TDWJPKM4KeEJ93mEPGg+dPGj76p/O/I=;
        b=eOYay5RR/NcvnhvicsmTBsGCnnELsz+DolB9WBznzsg0uF69ZZtE1SeK48VrZqEapo
         bBeAFvFQymFyqBdaPBTeFNBRFyz2jmP7PlU1EFRDQEcbOcuAShBroBf8TQah48OYXKof
         c3HKhA0r94crYVipWfYNkzMUMoXxMd7I18p9a7Qd/WVg/YRdqmdoRwG+8Yk+hukdjuIe
         a8BSznO+ceTevCvZj64JnebYlSXQ0BEFfP551I/GgI/WsSyn8ai4uaEEkX0Nk86n0RJv
         DT09KvdYw7wq/Y7cWahUlyCGy7SjhUSBIVdl0Ym5AGJYYcqUpgDACPUjXoVH1aYTb2ZQ
         +jeA==
X-Gm-Message-State: AOJu0YwW6ggOKG7v5hlLOwOPPT9ecjvgfeMQlCFVYjN7ZBjYC0EIDdjZ
	VmqCsLtgrxtGy1d3O4NnifI=
X-Google-Smtp-Source: AGHT+IHnEV/t893p13ImmmMI3V1RgdVf9ppLf8Va+NzsadDBiIumXM3Zx8acaswReSwSmsn2tGqoZQ==
X-Received: by 2002:a17:906:c190:b0:9be:834a:f80b with SMTP id g16-20020a170906c19000b009be834af80bmr920813ejz.75.1699439347555;
        Wed, 08 Nov 2023 02:29:07 -0800 (PST)
Received: from tp440p.steeds.sam ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id h11-20020a17090634cb00b009b28ad521f4sm820280ejb.4.2023.11.08.02.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:29:06 -0800 (PST)
Date: Wed, 8 Nov 2023 12:29:02 +0200
From: Sicelo <absicsz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: isimodem: reporting operator name to core from unsolicited
 indications
Message-ID: <ZUti7nteHmcie5a7@tp440p.steeds.sam>
References: <ZUZqIXkQNnen4Bfv@tp440p.steeds.sam>
 <540c9645-cc9a-4eda-96b1-4ee710a21891@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <540c9645-cc9a-4eda-96b1-4ee710a21891@gmail.com>

Hi Denis

On Sun, Nov 05, 2023 at 09:03:19PM -0600, Denis Kenzior wrote:
> > 	ofonod[27080]: PN_NETWORK (0x0A): NET_OPER_NAME_READ_REQ [id=0xE5 utid=0x2E len=8]:
> > 	ofonod[27080]:     * 2E E5 00 3F 00 00 00 00                         : ....?....
> > 	ofonod[27080]: PN_NETWORK (0x0A): NET_OPER_NAME_READ_RESP [id=0xE6 utid=0x2E len=10]:
> > 	ofonod[27080]:     * 2E E6 01 00 00 00 00 00 00 00                   : ...........
> > 	ofonod[27080]: gisi: normal RESP to 0xb6c8d0e0 [res=0x0A, id=0xE6, utid=0x2E]
> > 	ofonod[27080]: drivers/isimodem/network-registration.c:check_response_status() Request failed: NET_CAUSE_COMMUNICATION_ERROR
> > 	ofonod[27080]: src/network.c:current_operator_callback() 0x57c940, 0
> > 	ofonod[27080]: src/network.c:current_operator_callback() Error during current operator
> > 
> Funny, so it fails at random?

Yes. I am guessing that the RESP is directly from the modem, so this
failure is nothing that we can do anything about.

> Refer to ofono_netreg_status_notify implementation here:
> https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/src/network.c#n1347
> 
> Every time the network registration status is notified to the core, and it
> is roaming / registered, the driver current_operator method is invoked.
> 
> You can try to handle the NET_REG_STATUS_IND in the driver

This is what the POC patch I posted tries to do.

> cache it and
> invoke the above notify function to the core. Then in the current_operator
> driver function, return the cached name.

This is where my lack of skill gets exposed - reg_status_ind_cb only has
access to netreg of type ofono_netreg, and nd of type netreg_data.
However the notify function, as called from name_get_resp_cb, requires
to be passed structs of type ofono_netreg_operator_cb_t,
ofono_network_operator and isi_cb_data. I am not sure I see how to pass
these from reg_status_ind_cb.

So essentially I have two questions:
 1. Where can I cache the name? I think nd->nitz_name is fine, but
 perhaps there is a better option
 2. How can I make the cached name available in name_get_resp_cb?

Will appreciate suggestions. I guess it is something very simple but
that eludes me.

Sicelo
