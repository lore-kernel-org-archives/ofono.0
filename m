Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C79C182BD
	for <ofono@lists.linux.dev>; Sun, 12 Nov 2023 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lsk/xqiz"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4084095722aso31329115e9.1
        for <ofono@lists.linux.dev>; Sun, 12 Nov 2023 12:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699820952; x=1700425752; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=upb5qD9Hn1+r9XWGPUxfAI4TbYCUMWzz4X8b/QMmMd0=;
        b=Lsk/xqizpIPXnenV0f1cHs8nP3jTtP83HkDVl9sa9+dVkkk8Qa41tnT/b5Bvx5+7SE
         XUckpSVG3crBOlfOL0fMfbP5uN9z8MkQQoWYuWSugVVa60J/dO4/kzwzjzHWrOYcK/ZK
         ylglo7sObl0lzB2FtJB0jWaf8vnls2PkwYYzFf2jneA44GNhD2L4bs5gZZNYa9ipZ+wV
         We3cIoFPYWvmvq0sfeckfuDrnuOLvwtlXBp/VRSt9G/Ixob/OmNoKAK69diCJL8wIQrJ
         pZepigx/U9Pmmkr0UyuCZw2Oj20CBdmc+e7SqjV0UTdRfuITmwHBhYrw0L2JWiBo4XIl
         4RZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699820952; x=1700425752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upb5qD9Hn1+r9XWGPUxfAI4TbYCUMWzz4X8b/QMmMd0=;
        b=nq7oIdVBBJYaCSkT+0r1bm/J9rASt9ajQ4Aa9iK8xqpCbkcKVL/DOLIwfrgyt3r4AL
         vLxj+8T+iQg5TaWX1Z4XP+X/a/m5VY7908XW9aFvXl+DSUtFaHY9ZqeVoNlVzsCtSUr4
         1icKLNGy2UeeL7GhBpk0AuKQOApeZe25c+jnwIpF1nqakyqnmtiry4ItSlY1DYQsIgfc
         NQ+peujM9NpJsJk10QCloSiVrduPUFllAWxZlscZFaBHdPbHS0hTatNwdivhTqCuBEZC
         torhIyFtyHxl/uCsstodalNV2edC1X1shH6b2ByXoGv6Ti8bM19MdOxORb7Qr7ZaPdCy
         tWPQ==
X-Gm-Message-State: AOJu0Ywb5k5i//xWEHXOH5EJdIAj2E+POlUNR5UugoA9Q9EDQzsJsup+
	Wh0RJ3p+sQ5+P+qncNKLs5L28cEeYPA=
X-Google-Smtp-Source: AGHT+IH6LV8KLYOinwLG16KVZN2lmN4C10cq96T6mx4YZ41Wvu9gej85BsI6c++zMME4WW9fw9nMgg==
X-Received: by 2002:a5d:6102:0:b0:32d:aab0:44dc with SMTP id v2-20020a5d6102000000b0032daab044dcmr3124161wrt.28.1699820952227;
        Sun, 12 Nov 2023 12:29:12 -0800 (PST)
Received: from tp440p.steeds.sam ([41.84.247.172])
        by smtp.gmail.com with ESMTPSA id c15-20020a5d4f0f000000b0032db430fb9bsm3903182wru.68.2023.11.12.12.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 12:29:11 -0800 (PST)
Date: Sun, 12 Nov 2023 22:29:08 +0200
From: Sicelo <absicsz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev
Subject: Re: Improper Handling for Messages That Do Not Specify
 Source/Address Port
Message-ID: <ZVE1lIgh8uJg9amK@tp440p.steeds.sam>
References: <ZU4D3kXFAvCHs55i@tp440p.steeds.sam>
 <e48fe212-7a30-4bae-a892-f22d3495e169@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e48fe212-7a30-4bae-a892-f22d3495e169@gmail.com>

Hi Denis

On Sun, Nov 12, 2023 at 12:34:29PM -0600, Denis Kenzior wrote:
> Hi Sicelo,
> 
> On 11/10/23 04:20, Sicelo wrote:
> > Hi
> > 
> > While running ofono in debug mode, I discovered that there are certain
> > types of sms-like messages that arrive in ofono core, but are discarded
> > without being sent to the client. For these, the ofono log shows a lot
> > of:
> > 
> >    ofonod[3424627]: Got an 8-bit encoded message, however no valid src/address port, ignore
> > 
> 
> When that code was written, this was what the spec wanted.  There was no way
> to identify the 8-bit character set of SMS messages, any 8-bit messages had
> to be a binary SMS with port/destination provided.
> 
> Maybe this has changed since, but I'd need some link / document to refer to ...

I am also not sure, but on an Android phone, for example, it shows up
somewhat similar to what most of us call flash messages.

> > These messages are valid, and ofono should not discard them. In my case,
> > for example, the messages come in while connected to mobile data. They
> > are sent by the carrier periodically to notify me about the credit that
> > has been deducted from my prepaid plan.
> 
> Sure, so how does oFono interpret these? ASCII? Latin1? UTF8?

From tracing on isimodem on the Nokia N900, it seemed to be plain ASCII,
i.e. one byte-per-character. Unfortunately this message is carrier
initiated, so I don't have an easy way to get them to send it at will.

When I eventually get to it, I guess I will start by testing with
commenting out the code that checks for the src/dst port, and see where
things go.

Sicelo
