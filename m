Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DA81DF989
	for <ofono@lists.linux.dev>; Mon, 28 Oct 2024 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140671; cv=none; b=XhOf7CGmeV/C0zuVyXKcL0WDhXxUaSlC7Exd0iAizowbVRa3iA8+262G15BnnvKAbAqGYjZXzIIEun640aucdsALnCfu0F7oMg7pqbwb0d0Xqn7uTjzf5im4yQ2pFnsTcHM7MkmGlnRYGw7/kpSYDkadyUSfJjim+0Xre85LlSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140671; c=relaxed/simple;
	bh=m0fXI6S6u/PjTDJMZ0a2UgS00p0tztVRftQRY1MCATE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJnQucNsTxsXPsA8rC0tmqOu1wKDadNup4xQJoVivrA4zIm/1PgWxk8/QevGFTzQxDamsVj7J4aPR6zWhBQ1HE6S0R/MDQByn71cFcJ24YgXvWJVBoGiptwSUMaZWzw6BE52GqBtAvW7EbQUq0k7LocIlJ45HcasHpWiX4y20Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftMeTwaK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftMeTwaK"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a850270e2so763117466b.0
        for <ofono@lists.linux.dev>; Mon, 28 Oct 2024 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730140667; x=1730745467; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2qLu1ygp+wE4st/J7Z92DDA6mTM6IdMYgoTvKalXDA8=;
        b=ftMeTwaKD3VTiJXrPT6LBKYnqM+timTzJ+rAIHOcR+roDcZPlRXlKF4N91EljrzLvv
         CGg8kemP2THNR0PBaHNTpF0QQP4GVuQYP1p4D0eCsOTWE+iwEu5mir3iZ1smS1sEpKV0
         WfNIjFgg1UMeQFH17KM7qjEfVEbW6kOOTSSQiG5LMuStRuGDit/d8cZ003ig1EW0uV4G
         t2z+A1aOmuTCJJtOOEDWL8uk4+xKjQH3gSUKRnClhq7kr1TaNxpXsFGCquCx+e6RZB4q
         7ow7CAI/DziuYhfwjwTFdYesw6hpNhU6ts42RE7xbydyUxBcFuSv0OTZ1VfCh33ZAqMk
         8lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730140667; x=1730745467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qLu1ygp+wE4st/J7Z92DDA6mTM6IdMYgoTvKalXDA8=;
        b=PJyyh2PABZkwQQtBOrgGTaYfOKxOrqW8xaieraLKko3Ss0+QHYYWcGvRc8d/KaNDxW
         R83cZk0lpicdfGbpm6LgFyrQDXtg9I0fwf5McXhqXUR+tmOVPCu1tiovKsm/ij/gLsfD
         VdO3BQ/n2PA84Erg5n9U8U/bvUdwP/Ua6Vm94JSa9D8zh03kRf3cwvh/0m4+R0ICnL2l
         ow4S3vSWM3BFli7mo3uEuOawKQlAzgUB+psLAgmdAkebsf8DQZY0jMeNoGPBKTqCxmC7
         46/PBuUT2yYlxhvjrhGAF/dbcraDy9fCD8nCUGtV9hJJBX/KoOW1R9SHuEdFuKeRyajm
         WTKQ==
X-Gm-Message-State: AOJu0YycD3HmOtxO3cuPXcdPtQ4CjZSi81nBGjWVVoBamMSPHOzDdAm3
	c6+C3Y5Noven+pq15fR/tr92wxiOdedwK9YamB62CYBmF5MoFPyPZO32pw==
X-Google-Smtp-Source: AGHT+IG7rFwg8hIzDJHQ3Xum4SvIJrh4sJLqOYfKmPa6VVfRObX+8wH+wt5Z737i0w6RVQ4IGrgK6w==
X-Received: by 2002:a17:906:c111:b0:a9a:b823:14ca with SMTP id a640c23a62f3a-a9de5ca083dmr1004844566b.6.1730140667066;
        Mon, 28 Oct 2024 11:37:47 -0700 (PDT)
Received: from tp440p.steeds.sam ([41.84.246.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9afcef10efsm399278266b.0.2024.10.28.11.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 11:37:46 -0700 (PDT)
Date: Mon, 28 Oct 2024 20:37:42 +0200
From: Sicelo <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Improper Handling for Messages That Do Not Specify
 Source/Address Port
Message-ID: <Zx_Z9i7u1vy_aWhv@tp440p.steeds.sam>
References: <ZU4D3kXFAvCHs55i@tp440p.steeds.sam>
 <e48fe212-7a30-4bae-a892-f22d3495e169@gmail.com>
 <ZVE1lIgh8uJg9amK@tp440p.steeds.sam>
 <Zxzl8Z6UJbvjG9kA@tp440p.steeds.sam>
 <bb6e9097-65b8-45c0-9738-f376e21f5e2e@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb6e9097-65b8-45c0-9738-f376e21f5e2e@gmail.com>

Hi

On Mon, Oct 28, 2024 at 01:32:09PM -0500, Denis Kenzior wrote:
> > ofonod[3912]: PN_SMS (0x02): SMS_PP_ROUTING_NTF [id=0x08 utid=0x03 len=136]:
> > ofonod[3912]:     * 03 08 00 01 11 84 00 02 82 0C 02 08 07 91 62 78 : ...............bx
> > ofonod[3912]:     * 09 00 00 F5 80 74 6D 00 04 14 D0 C5 F9 1D 04 6A : .....tm........j
> > ofonod[3912]:     * BE C5 69 76 19 00 14 42 01 62 41 51 81 80 56 48 : ..iv...B.bAQ..VH
> > ofonod[3912]:     * 65 6C 6C 6F 20 32 36 38 37 39 39 30 30 34 35 32 : ello.26879900452
> > ofonod[3912]:     * 20 79 6F 75 20 68 61 76 65 20 62 65 65 6E 20 63 : .you.have.been.c
> > ofonod[3912]:     * 68 61 72 67 65 64 20 45 30 20 66 6F 72 20 30 20 : harged.E0.for.0.
> > ofonod[3912]:     * 4D 42 2E 47 65 74 20 6D 6F 72 65 20 66 72 6F 6D : MB.Get.more.from
> > ofonod[3912]:     * 20 6F 75 72 20 62 75 6E 64 6C 65 73 20 6F 6E 20 : .our.bundles.on.
> > ofonod[3912]:     * 6F 66 66 65 72 00 00 00                         : offer...
> > ofonod[3912]: gisi: No error information NTF to 0x63fa40 [res=0x02, id=0x08, utid=0x03]
> > ofonod[3912]: src/sms.c:ofono_sms_deliver_notify() len 117 tpdu len 109
> > ofonod[3912]: src/sms.c:handle_deliver()
> > ofonod[3912]: src/sms.c:sms_dispatch()
> > ofonod[3912]: src/sms.c:sms_dispatch() dst -1 src -1
> > 
> > So yes, this particular message is ASCII
> 
> Do you want to send a patch?  I'm still not sure how oFono would know that
> this is a flash message?  I suppose we can check whether it is valid utf8
> and treat it as a text message.

I also have no clue at this point, so not sure what to do in the code.
However I will see if I can find any information, and maybe find
relevant code in Android for more clues.

Regards
Sicelo
