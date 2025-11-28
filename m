Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8919723C4F4
	for <ofono@lists.linux.dev>; Fri, 28 Nov 2025 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764347818; cv=none; b=Vk+mGF8m8th4mPqchRR4Lkk7N4c24A2VGxjiLkpED2lnXlWhzcdaRYne1I5sLNf+CsIB1xLVVvG6T5vxRgSxPPInZGV24bGW2n6352uclv5xstcQ4G5RhgIYo2eSFVjseM/oOXhcL83y5nLx19xWjUrOqi6aYAO09v/030tnIU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764347818; c=relaxed/simple;
	bh=u6FqVxB8R38pheevalwIZJB6/WnE1aJseU/6eT+yNcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dZJM2MW17nHdvucwBMoikCClvwqqyGhUm4TC4RLc+7RSYGVyxEoWIZqpC7Ao+lbyDTCXHfPAxaSt+pOM+aYUZWh+nZgihzsjJjLRasmSYAGwt7w3GRJuVolAAzkKLecffrPR5B9bhXEFhb59zDBeKZlXifExxfYL8u5T3S3YLQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fH6jR8N4; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fH6jR8N4"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3e37ad3d95aso1388066fac.3
        for <ofono@lists.linux.dev>; Fri, 28 Nov 2025 08:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764347816; x=1764952616; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B/c5eiBOwIAmGJRwmmRwdiYiizU1tpqLHKCbV1J7ISA=;
        b=fH6jR8N47N3mQrBOTNj1doWjYlxBpXyWWAEfJq1ADAMn4lvX+WDQljYh4WjR4GU/3n
         3RvWUGb3FBM+n8DH40eRvS5iPHllEwWRmRLFsQgEhXswj0vjm+vluqa8O/wxrtnXIEDd
         G3ieArVCl3sddx/b5RPGerlvcIcbBv73SZcP+ZXW2pXmnQDE+1MrV4OPfR6oe5C5XsSt
         gUHUjk801Ox8gTCOZsOyD+aaxasxhx+BflKoq5/NNexZkRdB43aXkpXfVTtmTYwY9sOO
         13ugPJCnTR0m8Kfz89SNZ8oLRMCdYSiPEe1S6dtmzVDB/d6y7WdDAmew81oCFERCzK3Z
         dRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764347816; x=1764952616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/c5eiBOwIAmGJRwmmRwdiYiizU1tpqLHKCbV1J7ISA=;
        b=jBcmRbJ+DrIcVQ/KPj7sr94bsvimTC8gYNGpIo4RlxaspLLJoJeEQF61yOdWshpM86
         Umflu/cm/WwQ4ElYA8DnOM/Y/1gxEbEJTX6oQHK9A9j6m4V9AVc4HcP7lB9Wx75x8M19
         cO1rTTKkJqPqA5mYh9EzkmM4MaTxtsqLlkWcgMxPAJthltTAbL4JnviqdUFPSIZ6Wlsi
         +WT0VGzyOV3EtrSVcqUIx62Rc8iT8yFXtt2YWjSR4tHTKY0C51SZ9uUEypsILtye6joG
         8kawUeKc00cn9ofop5EHyfvpu6kDt1HAAPbhzbFDcWZDsvr+LHQKUJKAP6+PAfJSW4fG
         dJMg==
X-Forwarded-Encrypted: i=1; AJvYcCUPqqudiiV2X+qb5Niiuu9dcchSmvMaMgxqD31ceG/gcFCBc657wQwCXhicgihcdOtJRKSzjg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzkl8S6UecqwJ2MhAHch1wXr4dRC5JoBCOefunzIQD+LFnYs4VX
	YySFIJCRFGJ8A08amXtFnl1YEOu1tgE6Ij2FE5PKFty6UHoTXFanOphI
X-Gm-Gg: ASbGncsgcjyvM9vZLreTSLQc3UY7454GaOqzLk4GtV9FJgHLJ4UuEXn7C6Z8AKbID1k
	o4AkwpPb9NbR/vA3baX13M7q0UepgAi7/BORVFwgKtQKfwlmoSOEbddLSLNDGdrSY0AxxoAgLVO
	KNdXYvqeaxvfmSQ0mG+xIqxfXxeb5ZPj36wX3iFzZ9fdjujWrv6Lvc+ieImcvSYe94OcAaG5tU/
	eYYvmmp2Hb9vNIMctfagLLYpUdKlcOjr/7UO31m7WCZyqTb44TTktDZyrPx4W/K9qe0hctr/wX8
	NrBYc2akwEoMAHRsWz7Canlt/wnFr42z7J1Wt8U3lFev4AeIBypgcOuiLbzHpCLdgwU+e5GFeLg
	25S/o+Ip0nzobgAIpdkBJqVPud65fp7D9WDhLByLmMDtEx/BXUCRe5roYoqXB5LdUC41E96/FZX
	JhGho27geh/6+5UuqEKtsHp+k=
X-Google-Smtp-Source: AGHT+IHd6uqvqc629HidY3E7ZDwGFtfvFaj0KLAogMtybS/JkJB+liS5SjOInXdW/0nmALP49O3TuQ==
X-Received: by 2002:a05:6870:72d3:b0:3e8:3382:aaf9 with SMTP id 586e51a60fabf-3ed1fff5b3bmr8163286fac.37.1764347815541;
        Fri, 28 Nov 2025 08:36:55 -0800 (PST)
Received: from [172.16.49.130] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-3f0dd02a927sm1960889fac.19.2025.11.28.08.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 08:36:54 -0800 (PST)
Message-ID: <079fb21f-5e84-4129-9fdf-65329b88e819@gmail.com>
Date: Fri, 28 Nov 2025 10:36:53 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] mbimmodem: add support for SIM I/O operations
To: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>,
 ofono <ofono@lists.linux.dev>
References: <20251127174946.89981-1-thevancedgamer@mentallysanemainliners.org>
 <20251127174946.89981-10-thevancedgamer@mentallysanemainliners.org>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20251127174946.89981-10-thevancedgamer@mentallysanemainliners.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Muhammad,

On 11/27/25 11:49 AM, Muhammad Asif wrote:
> Signed-off-by: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>

No Signed-off-by for oFono contributions.  Please see HACKING, "Submitting 
patches" section.

> ---
>   drivers/mbimmodem/mbim.c |   5 +
>   drivers/mbimmodem/mbim.h |  16 +++
>   drivers/mbimmodem/sim.c  | 223 ++++++++++++++++++++++++++++++++++-----
>   drivers/mbimmodem/util.c |  37 +++++++
>   drivers/mbimmodem/util.h |   1 +
>   5 files changed, 255 insertions(+), 27 deletions(-)
> 

This patch seems to be corrupt:

[denkenz@archdev ofono]$ git am 
~/Downloads/v5-09-10-mbimmodem-add-support-for-SIM-I-O-operations.patch
Applying: mbimmodem: add support for SIM I/O operations
error: corrupt patch at line 423
Patch failed at 0001 mbimmodem: add support for SIM I/O operations
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
[denkenz@archdev ofono]$ git am --abort

Regards,
-Denis
