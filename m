Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9745818FC9F
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567562; cv=none; b=EZfjhgfAGIJ+IrtJYO7sfVW3mXJJ18v0wiBVGuN+BJ+hf7E9TzYASpMHq1MVbnYh9tK6etkQCHYLt3Ajf1aFHe6MThXbwUgyFOhJn7yslEh6/gGlEr4bgkPuot/vyggsl3Okf31DNQ3sr+AZgz/qhvMA7Emzx9bUFuQc+ZKvQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567562; c=relaxed/simple;
	bh=hq3WsVRrZNbYBd6u1u9z+oHkHb9vihgMo11KN+h3K24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5o38D4Yk4h5F4lEIGT8U6piSKGETlU8DClSX1RhkNPIMUmdUJxTdoA4KN6GVgj0UkPsPsYj7d6/dDKu++9Qy7bj+c3S3YvFbGNCrekL1TrYq45ny7wYh/D8+U+WAAHr2uTiDVsT6eLROtdAcA5ARCD7imc9m7gKJwnUOEihsaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXUFjYzY; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXUFjYzY"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-726e8700159so1233757a34.3
        for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 13:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739567559; x=1740172359; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ra71ZMvLhdW5g8rJoXOG64HxBD3xITvZ4lowAy22z9Y=;
        b=YXUFjYzY6SZrGo645MNlZkdr7ndGP2VgeAZ8Vfd/5AW6DhNzqHGYNIhdLc9eapyAYn
         b1Vrhn8O+e/bzolbal7CYpRKNLmXC8C0ndjQtctMLL8OI+LvZWqWq0/WBYrnZk1tAZpe
         Tzj6cw9tjKBdOQCGuJQvrTJnFrOG+gXve/SZU6IuDfuKyfK81CSmb5wAiBBLiY5GqbbU
         OMWaEd9GQfDt5IbAz+vPdF0svmfohHwqeDzDqbdvC4QrYfE45pSRkhUFiD+1G7WOiNJb
         sZ6xmxbvecZB7vx750BWwfrnuJ3Zc09yTd1CnD1KLqy3qVKLbykX+VbnGJuK7IgvJaQ4
         8cbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739567559; x=1740172359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ra71ZMvLhdW5g8rJoXOG64HxBD3xITvZ4lowAy22z9Y=;
        b=Ye4uBDPWeFByKYT2PwCUH9MDTGAFE+2VLyaMPufWMz83HiHPbzChUFilm8zWzmkyWL
         SNRse8GQWjUw7DlFZXyBdvwRfjA7M7ROUOBr1Lh/7NhqykanYExNJLMk9LBUVX46XsGS
         q+RavRs1iuyMyJ82g6pgRNHq3tQFP8aC6QToMSP5J3AieKQ/hfUoqGqmtqX62ByV6/1s
         scWwqmBedU/jGGSjtLkGbY1oy9WWeMDZVDeLtzmHEzX6YTrMMv/FgohaeD3h0VfZaOLD
         qc52Lo5J9VxvNsa3b6RV+hrnheNWihAA+N1TTITkbaiUpGf7JjsT1gFY5WSuJF5kEpXs
         xtKQ==
X-Gm-Message-State: AOJu0YxxonJqd0z222OJAeCPvQFhoE+nz5RjiD6NgBciB23SW7SkOqk4
	zC1mPKiBcMmvc5N8G4e/IMONqWfxA00jNhjUu9E+rbP+aX/qd6JNGNvlAw==
X-Gm-Gg: ASbGncvsAZkn56BqWhEF4CcxBfauWeUWXsQX/GBBbvTgACS9uuBz1E7eUj6+cMH2Mi5
	msMBZlboRnYS1V/1UElss6NFO+CcO9UZ/kvgaN5aid20A264sbBHGejwxmFc22WTkrl7lKTuHNT
	CLiUDk9Eh+JIrHtXUkecV5hMrvmeG1VOLLVzUa945BE5O8egd1YdqmaSMKDX0fodXWSGP5/09gE
	gwjGcCPAIsiir9RAlR3DJlIzOJb9VaarU8mrpo62qpzOyEv6P7uMf2Ztan/G5SsHmG8e2cVRLaO
	wiPZdpXHQ8L0Cu3zIQlQqrKfZe91V2bhz0MRL5bKAyB5j+4jLhCSo8DW
X-Google-Smtp-Source: AGHT+IEYiY8lcTdcAqE3kg5xopzMZ8ht1lR0qBmqUoPqKSJsh1zTj+Ff1Q8XqqORoZ+z9Jn5kilthQ==
X-Received: by 2002:a05:6808:f08:b0:3ea:3320:385b with SMTP id 5614622812f47-3f3eb0f4515mr632020b6e.19.1739567559538;
        Fri, 14 Feb 2025 13:12:39 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3f3da92bf0fsm1529934b6e.9.2025.02.14.13.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 13:12:39 -0800 (PST)
Message-ID: <cc723f38-b21e-4d50-bca5-9a844ec857a6@gmail.com>
Date: Fri, 14 Feb 2025 15:12:38 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] qmi: Implement QMI service request rate limiting
 in 'can_write_data'.
To: Grant Erickson <gerickson@nuovations.com>
Cc: ofono@lists.linux.dev
References: <cover.1739509438.git.gerickson@nuovations.com>
 <31c04f926af6ddfe0e244c2d6b0999ee9442659a.1739509438.git.gerickson@nuovations.com>
 <bee3deed-8285-4452-9c14-c40b60c06ade@gmail.com>
 <468C8C98-64D5-43F0-87FD-F4B9CB63049D@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <468C8C98-64D5-43F0-87FD-F4B9CB63049D@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Grant,
 >
> I’ve noted that the default ofono warning flags do not highlight the potential conditional issue with ’now’ on arm, aarch64, or x86_64 with gcc or clang. If I dial up warnings with -Wall -Wextra -Weverything, then I get the warning.

This sometimes depends on the version of gcc as well.

> 
> With that in mind, do you want ’now’ to follow M7 with the default warning flag set or to not follow M7 but ensuring the warning is addressed using default initialization with a non-default set of warning flags?

M7 should be followed, and if the warning is known to be spurious, then a pragma 
may be added.  See ell for examples of this (grep for _Pragma).  However, 
_Pragma is not always followed.  Easiest may be to give the compiler a chance of 
misinterpreting the intent :)

Regards,
-Denis
