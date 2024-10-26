Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C918800D
	for <ofono@lists.linux.dev>; Sat, 26 Oct 2024 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729947130; cv=none; b=imFNaPQ8VUyAZXx0J0qFAoMmAKKbkWXKzan+dCtBRcxBubRQXCroA7xO1kr9d5/cjVV+E/5AYW1RngavqobFZR8EBt5TruDTyqmyncBNIMCP7lrDWzAvLuX5VJQWAjdE5GvLvMrl0pEjmLUsqNKlooyn/vRmOdw/ifpwmpiZ8L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729947130; c=relaxed/simple;
	bh=uLv9KkL5JWLZ/gHBQ+9GSSTHl2B4Of3O+BWJEVHo6JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKJ2Yxb/5ODAzE4jUNHA/QF8uouQPqFfigiPCpKxXaSOY14ZpIJRbjaB9GgvFIX0AdcOrGs1tn1K4lDT3RLz0ztzdAi2tSkK1AOIYVX+hf1HACMu54d1IG5SADB39MRIqw0+D8/BYhuKRznLVJWBukTboZRAl2ZHln1Afp6VdZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYX5GLTR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYX5GLTR"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a850270e2so472058766b.0
        for <ofono@lists.linux.dev>; Sat, 26 Oct 2024 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729947126; x=1730551926; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xJhNEDRjn54cVf8o+QG83VVjEXYWH+EIbeBd9jpF8gE=;
        b=FYX5GLTRQmX76HCufG+WOlr6dpP3BZxDVXWgnOmjBEUuOYvTCG9LQKYGqMWi26cCVO
         86pMAIbjSUnT6zDIAs3xC8nOYa8xUJ1sc7hANbhBLUbZBswSmI6b297Z0e5UO5gcO38D
         884amK71Z0ECYSEcR+N/hiZeSQAXkANO3HfVECpl78uiqo3jHHEJJzeHxsDPSediN2Sh
         8vhjl13zz/vxGJ0XiRR8R0w6GJAZlKRhUmeORgYutiOH2/5YhUft0NIcnK98aqL0RQGa
         wfYF7EuxEp3Ajs8zygVyXGbK7H0E1ySVTOc85rFNmIA9AdU2c/UZCZND6FaCo7dboFMK
         ujIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729947126; x=1730551926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJhNEDRjn54cVf8o+QG83VVjEXYWH+EIbeBd9jpF8gE=;
        b=Z7atxvSXnCsrVSRoHFtk5tZuLnLXVdyVBjV4Bb95NZ4A57CkGs8j08ldyi2m5jMUbP
         SZkHE3lPy9ijbmYIyVrWL6LxsFe23RDQSyh6FqkG2QkNqajaBJg6tI+TaQw3ZECeLYd+
         NKwWpYK3ewpdND0lbthpFDsNh/HfcBylLk/dnwXDcsKHzXdxUVCZeY6uZKqm22lHfF2K
         vzryECAar8x2U/D5U+k+eiyIcZff49i/ZjCFJm3JDmPHaMFmOhxTzWfNGbrp10FFdZsH
         4Y+jmnCRy4jbGrLp5dvuxRfd6X4uyEMakFa5Jj8DItFAu+igxHjQ4PToQbSoB9PnqwLq
         +J7g==
X-Gm-Message-State: AOJu0YxlxV3t5U9DOkXY3CQa71IOSjuN7QtXVb6ZVHm5G99Q7RJ2XnUC
	+R/4ht3ISgsMZWQMZkp2zTwvCk+lgxtZ3wmadIhDVeEAcIBSgMt+zgxTqg==
X-Google-Smtp-Source: AGHT+IFBCJHcwHMaml4PBOhpllk7KViXMvk3hKYwPSvTD1rnvqZUjQsXKWBYpZjYmH8yuS2/rINfBA==
X-Received: by 2002:a17:906:c105:b0:a99:6791:5449 with SMTP id a640c23a62f3a-a9de615ad79mr210661366b.52.1729947125938;
        Sat, 26 Oct 2024 05:52:05 -0700 (PDT)
Received: from tp440p.steeds.sam ([41.84.226.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30d6fdd1sm173843266b.170.2024.10.26.05.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 05:52:05 -0700 (PDT)
Date: Sat, 26 Oct 2024 14:52:01 +0200
From: Sicelo <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Improper Handling for Messages That Do Not Specify
 Source/Address Port
Message-ID: <Zxzl8Z6UJbvjG9kA@tp440p.steeds.sam>
References: <ZU4D3kXFAvCHs55i@tp440p.steeds.sam>
 <e48fe212-7a30-4bae-a892-f22d3495e169@gmail.com>
 <ZVE1lIgh8uJg9amK@tp440p.steeds.sam>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVE1lIgh8uJg9amK@tp440p.steeds.sam>

On Sun, Nov 12, 2023 at 10:29:08PM +0200, Sicelo wrote:
> Hi Denis
> 
> On Sun, Nov 12, 2023 at 12:34:29PM -0600, Denis Kenzior wrote:
> > Hi Sicelo,
> > 
> > On 11/10/23 04:20, Sicelo wrote:
> > > Hi
> > > 
> > > While running ofono in debug mode, I discovered that there are certain
> > > types of sms-like messages that arrive in ofono core, but are discarded
> > > without being sent to the client. For these, the ofono log shows a lot
> > > of:
> > > 
> > >    ofonod[3424627]: Got an 8-bit encoded message, however no valid src/address port, ignore
> > > 
> > 
> > When that code was written, this was what the spec wanted.  There was no way
> > to identify the 8-bit character set of SMS messages, any 8-bit messages had
> > to be a binary SMS with port/destination provided.
> > 
> > Maybe this has changed since, but I'd need some link / document to refer to ...
> 
> I am also not sure, but on an Android phone, for example, it shows up
> somewhat similar to what most of us call flash messages.
> 
> > > These messages are valid, and ofono should not discard them. In my case,
> > > for example, the messages come in while connected to mobile data. They
> > > are sent by the carrier periodically to notify me about the credit that
> > > has been deducted from my prepaid plan.
> > 
> > Sure, so how does oFono interpret these? ASCII? Latin1? UTF8?
> 
> From tracing on isimodem on the Nokia N900, it seemed to be plain ASCII,
> i.e. one byte-per-character. Unfortunately this message is carrier
> initiated, so I don't have an easy way to get them to send it at will.
> 

Today I got a sample, while working on the phonet patch:

ofonod[3912]: PN_SMS (0x02): SMS_PP_ROUTING_NTF [id=0x08 utid=0x03 len=136]:
ofonod[3912]:     * 03 08 00 01 11 84 00 02 82 0C 02 08 07 91 62 78 : ...............bx
ofonod[3912]:     * 09 00 00 F5 80 74 6D 00 04 14 D0 C5 F9 1D 04 6A : .....tm........j
ofonod[3912]:     * BE C5 69 76 19 00 14 42 01 62 41 51 81 80 56 48 : ..iv...B.bAQ..VH
ofonod[3912]:     * 65 6C 6C 6F 20 32 36 38 37 39 39 30 30 34 35 32 : ello.26879900452
ofonod[3912]:     * 20 79 6F 75 20 68 61 76 65 20 62 65 65 6E 20 63 : .you.have.been.c
ofonod[3912]:     * 68 61 72 67 65 64 20 45 30 20 66 6F 72 20 30 20 : harged.E0.for.0.
ofonod[3912]:     * 4D 42 2E 47 65 74 20 6D 6F 72 65 20 66 72 6F 6D : MB.Get.more.from
ofonod[3912]:     * 20 6F 75 72 20 62 75 6E 64 6C 65 73 20 6F 6E 20 : .our.bundles.on.
ofonod[3912]:     * 6F 66 66 65 72 00 00 00                         : offer...
ofonod[3912]: gisi: No error information NTF to 0x63fa40 [res=0x02, id=0x08, utid=0x03]
ofonod[3912]: src/sms.c:ofono_sms_deliver_notify() len 117 tpdu len 109
ofonod[3912]: src/sms.c:handle_deliver()
ofonod[3912]: src/sms.c:sms_dispatch()
ofonod[3912]: src/sms.c:sms_dispatch() dst -1 src -1
ofonod[3912]: Got an 8-bit encoded message, however no valid src/address port, ignore
ofonod[3912]: PN_SMS (0x02): SMS_GSM_RECEIVED_PP_REPORT_REQ [id=0x09 utid=0x05 len=16]:
ofonod[3912]:     * 05 09 00 00 00 00 00 01 06 08 00 00 00 00 00 00 : .................
ofonod[3912]: PN_SMS (0x02): SMS_GSM_RECEIVED_PP_REPORT_RESP [id=0x0A utid=0x05 len=4]:
ofonod[3912]:     * 05 0A 00 00                                     : .....
ofonod[3912]: gisi: normal RESP to 0xb6d106e0 [res=0x02, id=0x0A, utid=0x05]

So yes, this particular message is ASCII
