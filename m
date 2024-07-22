Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C1816E891
	for <ofono@lists.linux.dev>; Mon, 22 Jul 2024 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665814; cv=none; b=urYyz7lBWa3M6N+LCEiPkFrsAOcUXdb8muh1ns/hFoweZyubLhWJofiz3FkTz3T6k4sjDwJQZ8FkXwaSZuvjHy3/l0bVZyW8Kvc4pU9bpr2uLNZH9oiwyYBvH9ZSCdO8TRBS9kG2aefZNB6GuWUfhuzT7exv8BbpLJm6FtiK3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665814; c=relaxed/simple;
	bh=e0BveJUXoCNw5TDmEqSx+XCDFXNcHzBnOUzohFyioqs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ed1wSTvvxjm9jiqLA/VJ2L/7tb3Ipx3ZgTtnp/qqlftrSz8yu0aHM4uY9NjHGtQsvHR3udfif/zljLwoLmtNtdavjwO5RQozZCP0B6DIe5ZtcUeViNonuPzaxPpvyPdBNE9FI7N9WiTb+nLQ9EvLm5ix2BAt5tEQhVL89jabvO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrDphrKX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrDphrKX"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-427db004e36so19032595e9.3
        for <ofono@lists.linux.dev>; Mon, 22 Jul 2024 09:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721665811; x=1722270611; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OO75YvvcLVbW9WW8AS4aVh+/cdkXHqgVgMtOLpNwN7w=;
        b=lrDphrKX5k2+ZNPLclTBLsjT9xOmn22L77ZXloGs6WEp5yzHpdhzOKk0HsYGrlGBqf
         koQg6Eua7/O9zyzagIQ3pO06RSUwHPRnMVmodmhicPW1eAXB9vDU71Yr0FB3GjoVd4gT
         liR3VTRsT+R2cwr/uCAyhG8XHAd3wVw+fU5jeTDBbdP6vKPR3MgNBmz9mnTVOP6MqkII
         YNcAEQV63ctlXTdANFl9tpIefqMbW71U+78NOpiobwmbktwqBYHzqmpYdYR/lXbiDscR
         ZjQdiIsvLGfFC0qfG7M8uJq60IwGp6Z6o0wNhFXAmIb7ety5Mm9mgpdfnaFNmbPOoJnf
         mWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721665811; x=1722270611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OO75YvvcLVbW9WW8AS4aVh+/cdkXHqgVgMtOLpNwN7w=;
        b=pAXDjx8UNRBLv+PM5Xg+k78apmDLxCRkGu69OTPjBere5LDMu0bFQGWaamxnrPaf9j
         zYaq8vWisBXd0ai8AfcMfZITOYk5gytWuvbBqHjHqktAQexhpuUDrm8OUU80Hn3zJuxy
         Lnt/VkAOW6pyJyUatAPtCnNaarphrRvG9rN0Sg2OT7gXW5WestxGgs/DKuwaNEeVnk2y
         lkpiXhllHvqSnjLjAA/8H1G+I8snCKmZCxIY2NveMtxFEBnXElFD1+x76nekmAJ/hsXs
         GkR17urJq8gypKQ83NtDs4z7aAtV2aNjCPz5IP8VOcZA9nwF506pQV+vefDMwPtXTv23
         7c7g==
X-Gm-Message-State: AOJu0Yzca0RlmGB9ff3kdn9oK18PsdnR4pzeK/iyyV3fkkygH0DRHrfS
	8H99LaoOYqqVunutaQB1KqS1FoBfa42oNOuvSvOro6q/bUqotrRowCSaJA==
X-Google-Smtp-Source: AGHT+IHlGlKrbNuk767GSJWl4HNGHQ2jgKJKa8NPEN/QpS36YtvpA9+nXtqfhP+PlZ2E7Ruuh0/toA==
X-Received: by 2002:a05:600c:1381:b0:426:5b3b:88b0 with SMTP id 5b1f17b1804b1-427dc523cf5mr43940795e9.14.1721665810687;
        Mon, 22 Jul 2024 09:30:10 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([90.246.116.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e42bsm164220515e9.30.2024.07.22.09.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 09:30:08 -0700 (PDT)
From: Adam Pigg <piggz1@gmail.com>
To: ofono@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Subject: Re: Linker errors with external ELL
Date: Mon, 22 Jul 2024 17:30:05 +0100
Message-ID: <4735172.vXUDI8C0e8@adam-laptop-hp>
In-Reply-To: <0b06f3d4-c509-465e-bceb-574d900fed6d@gmail.com>
References:
 <2705084.vuYhMxLoTh@adam-laptop-hp>
 <0b06f3d4-c509-465e-bceb-574d900fed6d@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Dennis

Ah, ok, i (wrongly) assumed some of them (the dbus ones) were upstream, so 
this is a self inflicted issue!

Adam
On Monday 22 July 2024 16:55:23 BST Denis Kenzior wrote:
> Hi Adam,
> 
> On 7/21/24 6:14 AM, Adam Pigg wrote:
> > Hi Dennnis
> > 
> > Just to let you know, I have to patch Makefile.am when building with
> > external ELL as a few of the unit tests fail to link due to missing
> > l_basename.
> None of the unit tests listed in your Makefile.am patch are upstream.  I
> suspect they're present only in the Sailfish ofono fork you're using?
> 
> Regards,
> -Denis




