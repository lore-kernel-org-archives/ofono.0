Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3F6288B1
	for <ofono@lists.linux.dev>; Mon, 14 Oct 2024 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921115; cv=none; b=eXgYqqooP5Q4t/mqP8f4iPpCniHLiVHgBwoQ4rb33jqGaw4u1TuhxjN2y0RZp3DmaZefdYny+C74IKZJ9T7sunM12A9WEPs2lNd5bOdrZjunIrCddvRLZkYnQgAYEbI4khxpEDmEOGSoonkdURYfoVbzR7+9yV5kmfFkcsADdx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921115; c=relaxed/simple;
	bh=uk21JKXpIi7yRcb/qX5wMkP8OnOgQeS5VP7nCQNbPpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ug+niB+zcu6T3QY3iD9WsKRXc32JLSMoatdSCRxGociRT2VH0OEZq4ycFB0EVNjDe4L0gutha4vQWIbM3qAu+jdDHjzHabKZxL3ygzgAJuXR7NG0rzGLAyZWL8y1Eyg2P0zwU5RCqLqPJ26I4UpfmYF7BlYhgHJdPf1Qq3C7VpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTmZZowV; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTmZZowV"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5e5b5715607so2250028eaf.1
        for <ofono@lists.linux.dev>; Mon, 14 Oct 2024 08:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728921113; x=1729525913; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLIzQ7vG0Buj9X4859uXL6ed09bopvYMfKiH07NR+HI=;
        b=FTmZZowVBD2ttOIJ6CIpGp4e7jFN34Abg9hya1nB7o0VhVOH7WHicY8Rr64ufyIMwP
         mb42mzocnxVYR4Ji2UGziobbI7v0cE6bvZQAoeQOX0qAQhFtfQl2eLlC8vCYoNwhtF7/
         JIex7ZgOarlzykZWm8F/d3IlKil5ga5GeufCSm/p6s0wOYDvHUCRivoeB+H7C/gRhqpP
         ddASoyWCJ+LbYtZX36jd3MUQBaTOu5SDGyHHVBx1YrwNmrCs2GMTrH5MosAjiO4DLHfC
         ZQz/FJno2uWR4ct+kVBTeAhEqszUau3jOLPW3Y3A0BunD+g9FYVpSW/UHH+gTVSiUS/9
         iewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728921113; x=1729525913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLIzQ7vG0Buj9X4859uXL6ed09bopvYMfKiH07NR+HI=;
        b=eYZCBJlhJefQoY65KFrBabSoBRuzLJk7j0B23l7tweC4yyLd0AG+nABoyXvzeOlChy
         j857LoHG1pRfeVPzyhFEx/weCp0Ztit+UMnje+QXF40pLABYrGdOCtwVCW0bnIU+3LuO
         CklHowzluWCxgq6gF89EaDO8pRgLfXcfRjBd5KlHFYmyjD3xxSmO6aeCRODZlF4zO+Dp
         MxREbz1o9+/fX/o0QPOQtSxX0ThgDWlqpa7HmaCZetVf+RHrPfyLjWOwMyG/UxFi1UJo
         J29B8JoHa/8/uTb59aDUwlF3hGyYmS5t7Ywb8NvQc5N9MpAqve9kBO8pVEDSZ5fETkOM
         A5wg==
X-Gm-Message-State: AOJu0Yw7gBtk2vpvCTP1aI/Ag4rxkI2jX20+aKlinWOYTXKsAkXYyR85
	xdCRiisHl5r3Ok4PNi/ER23cxAusTghxCNkhmPio5ZZQsnAjVzseY4uObA==
X-Google-Smtp-Source: AGHT+IFNuhXrIg+wJoOEZ7+Wwrv65B6ESVx3bavQVWwoL884dxXrP8fk24Sg38nDf3fDJNrC1K/FDg==
X-Received: by 2002:a05:6820:6682:b0:5e7:fe95:4acb with SMTP id 006d021491bc7-5e990cf9789mr7118302eaf.3.1728921113228;
        Mon, 14 Oct 2024 08:51:53 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5eb1171fae8sm1391182eaf.24.2024.10.14.08.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 08:51:52 -0700 (PDT)
Message-ID: <3c09dea1-c98f-4b9b-a4cf-468e8cfd0bd8@gmail.com>
Date: Mon, 14 Oct 2024 10:51:49 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] atmodem: let +COPS: report access technology
To: Sean Nyekjaer <sean@geanix.com>
Cc: ofono@lists.linux.dev
References: <20241008091009.1567305-1-sean@geanix.com>
 <51d4c953-000f-47e5-8179-63c10e5e708d@gmail.com>
 <gm64cf5m7sx5qrjoaumf6524ldstqythicfqoqoljtanfyjlxa@5lg2qveme5ox>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <gm64cf5m7sx5qrjoaumf6524ldstqythicfqoqoljtanfyjlxa@5lg2qveme5ox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

> 
> So something like:
> 
> if (nd->vendor == OFONO_VENDOR_SIMCOM_A76XX) ?
>>> +	nd->tech = tech;
>>> +

Yep.

>>
>> Maybe behind a vendor check with an explanation?  COPS isn't really meant to
>> be used for this as it can contain the cell capabilities rather than the
>> actual registration technology.
> 
> And an explanation from the SIMCom datasheet?
> 

Yeah, that would be great.

Regards,
-Denis
