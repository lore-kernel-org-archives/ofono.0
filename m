Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B4356448
	for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684798; cv=none; b=MsDRNZ3Opx+isl2hZ26dJdua2qL7dmznoV1giquCVzPf4aF+VDI0q2pDt9A60PipKM59fYFcemA7XD+3UrhtWAEPFrShZ/x3GVXnQTctDm/AyZQTtljc5UEjKvM/N22RomA2HijozBxLSddDtBrN2oumoW3A1huqffOgdU8tMoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684798; c=relaxed/simple;
	bh=+UqRjqIjyUFkBeldtl0lr9pwnYq+Sf+q8Oipbz+BmRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WNx/yAwJnrRvuPz0aZ3r1Eg8Sd34xJoX6WelmgHJbwHUO8NN13Z6vMz/Zx46+ptvvPj2bOilR3osLnSEotHsg3pQVgatCB5FQ/oZAieBEjCFF0x9hjkU9Hv4lLNr9axZUJOUbuhV/GCaFU1EFDm7qPbFmJO/8rkjrj/Yfs+vkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENrcBf7u; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENrcBf7u"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bda741ad7dso415588b6e.1
        for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 09:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705684796; x=1706289596; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnbHKlvabpA5e/3I4b+GyIPHwCwq646uSMLbhm6kox0=;
        b=ENrcBf7uu8n/Wd8l9Ctg/N5K9oaZPjK2Ii3V0Ol9qcljdXgtzaVvY5Au9ObOFl0Qu7
         kpJPMOheu6GyI67NJ4XFjy4+pR2yoAuAlrpe49D55kb8VrnfvyXCjh8RBraNCOmXnjww
         jW6iuYsxCRmrVc87bNcXheEuz7byVxj2rmVZr8iigj+r8RN8okX7cp9XRYfkjSq/7/3Z
         oNg7/KxInnpKABIAO5AX5ssZSOsxdLFTz4UYCUOKk66v0qzhPMVJfUyy+LErFbaV11L4
         x2oZAQ9938A0NussbrFexS0m22FtM7ivVrQ0/XFStPE4+y7ihhPW79xzNlr9IHg13AjS
         2cFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705684796; x=1706289596;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnbHKlvabpA5e/3I4b+GyIPHwCwq646uSMLbhm6kox0=;
        b=hZ4pkBUC3WKRM7OiNWRrPdOgdr+45+PYbeAKKVx4yy/lgN48Kaptt7PZVipbXN9jDj
         ulwn513uzmXqfe30SrPPbIgR9+6vfsyLRArH9m1rt5WjFnDF5kQruK0iAXF22ID3z170
         ACQisCq1s9zbVk/6z9cU/VFeLGQR46lOTAc4qQb/PdH/4QIxKjmD1gbxg3MA1oPW31eI
         AcclFPFhD8vgtiEsXPhR8HvqPyrZmxj6+fACJxNAhzjxTqyPpghNnTKCMeJEqvjrcUDw
         38RUdsTKXcOeWODLUyXr0iQYDgDcPu4j4nuh5uSo7nQNS6EvxB80HHT4Rkvl8dGIBExw
         Ow1Q==
X-Gm-Message-State: AOJu0Ywws+XAwdWPcXgCR++7kWBu5JJYPQWOUtmO8tJhKsQc9lzdZ8le
	kLToP95+LhCj1xR9PYDRL9q80vmr99JT33Y/epGW+9v8UcKlwVpNNlcH3Ske
X-Google-Smtp-Source: AGHT+IH5OJBe3KBU1bjrM25lXvzS2zkuREIumqmjZxoP9mCXkfx7EM60ciQBj3VWsoAgnVBzyoujWQ==
X-Received: by 2002:a05:6870:420c:b0:206:e340:39d8 with SMTP id u12-20020a056870420c00b00206e34039d8mr141177oac.19.1705684796528;
        Fri, 19 Jan 2024 09:19:56 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id zd27-20020a056871279b00b00210b451fe96sm924517oab.47.2024.01.19.09.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 09:19:56 -0800 (PST)
Message-ID: <c66954ea-81b8-41bd-b261-aade6edd48c3@gmail.com>
Date: Fri, 19 Jan 2024 11:19:55 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gatchat: fix unref
Content-Language: en-US
To: Maxim Lyubimov <m.lyubimov@aqsi.ru>, ofono@lists.linux.dev
References: <20240119111017.1407534-1-m.lyubimov@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240119111017.1407534-1-m.lyubimov@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maxim,

On 1/19/24 05:10, Maxim Lyubimov wrote:
> If the new_bytes handler processes a modem shutdown URC, it results in

So new_bytes would call into at_chat_match_notify(), and one of the callbacks 
invoked would call g_at_chat_unref?

> a call to the g_at_chat_unref function, which includes a call to the
> chat_cleanup function, which clears the list of URC handlers that

This should be taken care of by in_notify being set?  Hmm... I guess you end up 
unrefing the last chat...

Do you have a backtrace or asan output by any chance?

> continue to be traversed after the current handler has completed, and
> may lead to errors. To correct the situation, the at_chat_ref function
> has been added, which is called at the beginning of the new_bytes

The original intent with the re-entrancy guards was to stop processing input 
once g_at_chat_unref has been called.  In theory, if all chats have been cleaned 
up via g_at_chat_unref, then the calls to:
	at_chat_cancel_group(chat->parent, chat->group);
	g_at_chat_unregister_all(chat);

...should unregister all notifications and commands.  So I think what you 
propose here is okay...  But I wonder if a more explicit stop of processing 
would be better.  Maybe:
  - Do not invoke chat_cleanup if in_read_handler is TRUE in at_chat_unref()
  - Invoke chat_cleanup in addition to g_free at the end of new_bytes?

> handler. Added a call to the at_chat_unref function at the end of the
> new_bytes handler. Added at_chat_ref function call to g_at_chat_clone.
> The previous partial solution to this problem has been removed.
> ---
>   gatchat/gatchat.c | 84 +++++++++++++++++++++++------------------------
>   1 file changed, 41 insertions(+), 43 deletions(-)
> 

Regards,
-Denis

