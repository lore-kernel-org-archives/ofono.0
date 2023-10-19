Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF5A7F0
	for <ofono@lists.linux.dev>; Thu, 19 Oct 2023 02:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWqT05lh"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1ea82246069so1621535fac.3
        for <ofono@lists.linux.dev>; Wed, 18 Oct 2023 19:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697682071; x=1698286871; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+fhBRZ/i4RQ7++YxSvEBZ0e7TAs6xwKdRlF4j9McRBk=;
        b=RWqT05lhIz0tq9S9SUHQqZ5qjP28wHujcfhK+y0xF7s+DmXwhyvYKfP3fbkEjn+yeL
         oEyBzkiC9ddksEN+CCMMDPCpsbQ5EQeDFZnXzbwDdsnh6vZtqRalBSTFCE3zweMhu8Bt
         Xk11johCRFu32kVuuxKRK3ntz0j/TQSnqlSWlzoMwYN5jjGRU5IfMZajj69dvwbCbWkZ
         xajGKy6KI/OF8yf9NZ2JkMkxh56oK1xck+jTVz/+vzSd9697eXww+el/ZO/Li8+Bc/e1
         jHFF3UviPmbzblWcgnOLi+bE1KEPf6xbdjgRudJ8bZ0cRpDWZqoGXHYCvKMkZ0cSk3Hf
         +avQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697682071; x=1698286871;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fhBRZ/i4RQ7++YxSvEBZ0e7TAs6xwKdRlF4j9McRBk=;
        b=fxFsbnHTcTdkhdZVi2V6yLQMjmLa604JgNj1r4nBR7IMBRorKJHbIOqjyBTWNGyjmU
         9Ubj4QFwpI3pQ1v089jsoc194JFqQ380A5DMsUrNOg9qvhLJfmS8R8dz0rQvARdE3GZl
         sh3TVdk6YFd6gY+bXa15jbBcGY7XdgZ03diG4QErKPXiVQEvTFxMyfibqGNTQf6rynFS
         PCZbqMg03h5u1IcalXZIjpam4QM8VyaoxZx+Wr1pGvI/0r/wV5ci4PiBTc5ZX2vz7iQH
         5STLr+p315VVzGpgMFEIu54cFdy+vayVZ4wBO4wzSVBOSBiUJU+xB8rt2OpvHrQI9t1X
         9Gug==
X-Gm-Message-State: AOJu0Ywq2zzYhTqOadBnm0phGanhnxUbIUYALXFyGi/cdrTP3VvmPGVP
	nn2B/Ve25iQSALkMbnEO6AhK8xjycxA=
X-Google-Smtp-Source: AGHT+IELH0T19oV0DcZlH0XO0QjWj2GnaOP0zczShKyCbhW37pdHCliUwJWz4Y3TpbodgdBw+OQhPQ==
X-Received: by 2002:a05:6870:f217:b0:1dc:9714:e2b3 with SMTP id t23-20020a056870f21700b001dc9714e2b3mr1396980oao.7.1697682071165;
        Wed, 18 Oct 2023 19:21:11 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id eg48-20020a05687098b000b001e9a253afa3sm958435oab.49.2023.10.18.19.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 19:21:10 -0700 (PDT)
Message-ID: <4a003c7d-4cee-4111-8bed-2bb51e5f510b@gmail.com>
Date: Wed, 18 Oct 2023 21:21:09 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] gatchat: added command completion by timeout
Content-Language: en-US
To: MaxLyubimov <m.lyubimov@aqsi.ru>, ofono@lists.linux.dev
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
 <20231017104902.717947-14-m.lyubimov@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231017104902.717947-14-m.lyubimov@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maxim,

On 10/17/23 05:49, MaxLyubimov wrote:
> ---
>   gatchat/gatchat.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 82 insertions(+)
> 

So I think you're going to need to give a bit more context for how this is 
expected to work.  There are commands (on older modems) that can take minutes to 
complete.  This is why multiplexers were invented.  Now this is probably quite 
rare, but I imagine it can still happen.

Also, what happens if the command times out?  You generate a synthetic CME 100 
error, but what then?

Also, this change is full of coding style violations, please fix those before I 
look further.

Regards,
-Denis
