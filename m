Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02914CE19
	for <ofono@lists.linux.dev>; Wed, 22 Nov 2023 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7t4UC49"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2c83d37a492so494961fa.3
        for <ofono@lists.linux.dev>; Wed, 22 Nov 2023 09:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700675617; x=1701280417; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aOWt65IjJP64XmfRBS9b6R82hcP9+pBXL/8v5lXhdBw=;
        b=l7t4UC49PlYq+K3XmjChfquV6VuR5blFZKqrMxjGteBif1Bq71gmCenWMfFT8o7Wqf
         RRmykPM+jaxYNHi5g2UjWF4Btq5AjAbufkgghAy3Xyn+0+2/mml5/7TB0MgZbV8zuY53
         qlEztxZoJECcFOsmQn7EfKTV/+AU78/tcC1CeGIQY+hUyx+iTfV4k5lJm3mpvh6fBuco
         DSuAMwqM5iEpF+MB0Z1AExMjRR9eXVY6uK5Vc9YPtbRyhO/2B9M0/ohqrngy9Xwe6U4d
         5PqAzFTx37CvVm6QYBQRONRA2MRAETCWDxNQ1b7ZwHNF2HUtu7nxLAZSQPsdHd0iEU3j
         IE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700675617; x=1701280417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOWt65IjJP64XmfRBS9b6R82hcP9+pBXL/8v5lXhdBw=;
        b=dQYo17z/niY9ZCai5b3V61IurBm/8BJy7nw6Ae95mKWtRMaxqEII2F8EQwnbzehDNz
         c/4TTB2zFg/BSWWB6e9ssoMHgT+luCUVvizVCGwUVlxJiXnvFIVSrUCxuOOm8tnLkswN
         9hvTat/omo/Mp/r36RuHU6K4RBKsng1waaTumtI5qTcBqOP28+QsjRSZkpM9c3yci1jm
         qWDZXQ+TNEG/GpOuQmfw7RYYHKLKaTOIq94yJoTRaIgvs7/9+3F7PWsGj+mqJSXsnndK
         wKyZi4vgEZ2kPs2KV/ETdAKTEd02drCRMXOCMuAVEHuzr6Rus4Gg1nGLmpvRSg16klhh
         2mjA==
X-Gm-Message-State: AOJu0Yz2Ne9Ak/OFimv9DHQkpKjLrziLTCP3/4pNLQHsBFdGwYPNPIr3
	hhbg3dhN4RJ0PC4mCBp8rLQ=
X-Google-Smtp-Source: AGHT+IG6ndUpuB3g3LVWDOuPC+4Rf4gXMH+i927kM9GIA5/Ek6HVoYJ7kqVrJsl4c5bq8t88tqwcRw==
X-Received: by 2002:a2e:9cc7:0:b0:2c5:1483:fae0 with SMTP id g7-20020a2e9cc7000000b002c51483fae0mr2396243ljj.4.1700675617132;
        Wed, 22 Nov 2023 09:53:37 -0800 (PST)
Received: from tp440p.steeds.sam ([2602:fbf6:10:a::2])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c450700b00405959bbf4fsm92108wmo.19.2023.11.22.09.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:53:36 -0800 (PST)
Date: Wed, 22 Nov 2023 19:53:21 +0200
From: Sicelo <absicsz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev
Subject: Re: [PATCH] isimodem: parse extra details from REG_STATUS_IND
Message-ID: <ZV5AERD8NNEXvkKg@tp440p.steeds.sam>
References: <20231118122948.418378-1-absicsz@gmail.com>
 <c5ef782f-69fc-476e-96b7-e1814516d43d@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ef782f-69fc-476e-96b7-e1814516d43d@gmail.com>

Hello Denis

On Mon, Nov 20, 2023 at 09:07:26AM -0600, Denis Kenzior wrote:
> I do get a compiler warning here:
> 
> drivers/isimodem/network-registration.c:537:3: error: misleading
> indentation; statement is not part of the previous 'if'
> [-Werror,-Wmisleading-indentation]
>                 strncpy(op.name, nd->nitz_name, OFONO_MAX_OPERATOR_NAME_LENGTH);
>                 ^
> drivers/isimodem/network-registration.c:532:2: note: previous statement is here
>         if (!check_response_status(msg, NET_OLD_OPER_NAME_READ_RESP) &&
>         ^

Interestingly this one was not caught on my compilation runs. I will fix
in v2.

> > +				g_isi_sb_iter_get_alpha_tag(&iter, &an, len, 6);
> > +				break;
> > +			case 3:
> > +				/* Full name */
> > +				g_isi_sb_iter_get_alpha_tag(&iter, &fn, len, 6);
> > +				break;
> 
> But you don't check the error returns of these two calls

I left out the checking here because in both cases, we are breaking at
the next statement, regardless of the success or failure of the calls. I
will see if I can implement checking.

> > +	if (fn[0] != '\0')
> > +		strncpy(nd->nitz_name, fn, OFONO_MAX_OPERATOR_NAME_LENGTH);
> > +	else if (an[0] != '\0')
> > +		strncpy(nd->nitz_name, an, OFONO_MAX_OPERATOR_NAME_LENGTH);
> 
> So how do you know fn/an aren't NULL?

Please excuse my confusion here - I thought the `if` conditions do check
whether an or fn are NULL. I will appreciate assistance or suggestion
for an alternative way to ensure this, since I definitely do not want to
copy over garbage into nd->nitz_name at this point in the code.

> Use g_strlcpy instead of strncpy since it takes care of setting the
> terminating NULL.

I will do this in v2. While going through some older commits, I also
found use of l_strlcpy. Should I prefer g_strlcpy in this instance?

Thank you very much for the review, and looking forward to hearing from
you soon.

Sincerely
Sicelo
