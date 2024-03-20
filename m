Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A5E364C4
	for <ofono@lists.linux.dev>; Wed, 20 Mar 2024 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902958; cv=none; b=NFZKBCW3uCnSfs8M/nAryKRg1RYYm1jeJks8dHIRIRrghqwNm/n6W4Qt/b7jXGj6cjbwtrMMdWFjYjcDzzqWRs7DEhsMHMWW3BJosDRth7A27ofhFX8bZODpjYCWBYL2QiIIcq2n5kW7MTDjHl/G08HdxOi7CmVKvZgSii2TFdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902958; c=relaxed/simple;
	bh=VmbJSn14HbcqKUh41wis8n3mUemA8+THagQTtJfFvBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aCjr9Co5gYnnAibHUGBd1/vIkT2qEkuXSK1PpHr9yeHUeho+HwXexZ0TUplRizWctnP2uQ3JjjAIWzqLCWfuIT8wQOP4aQeIO3b/88q97Xj/yRxOZdTDIRxWnFcjcOPBnT3biZFw+YHE74rfbb0SFzT2MExGjUWxVWhw08Xd6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rp2ZA0FI; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp2ZA0FI"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a4a2d99598so1691971eaf.2
        for <ofono@lists.linux.dev>; Tue, 19 Mar 2024 19:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710902955; x=1711507755; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R5gfqdzQQsM0267MbbJWGv+bvRzdjkOqRCsEd69Mjfs=;
        b=Rp2ZA0FIC9ywGeRdSOW9QC/oK2yseVgFakGRZIH3RgOM9FKoCdkKQNtoDrB7XdEc/Y
         ALCN93Qq+xnrR39gzuhP6FQ+PVYBmTh67VstCw42wBq8LYkOF4WraFKhM8A2+CAiIDwv
         TZ6RN82ocKW6QJziKAqkrhPIWIz8KWhFodnk8VCBL433eGi46hkojLBnuBUxNixeH8Je
         HpczR54icrf8MclLBgHzXiJZUuFbWm3M/LkQRYnzVBans/n0lHmSGLzVO/DqQJGSmE3i
         VUqUbh2XjnPfP7dFBKscNMD7LUOV1SzafAq5Gc9n8HI5HYZp87CSGCbw0alh2tB5O7k+
         jTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902955; x=1711507755;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5gfqdzQQsM0267MbbJWGv+bvRzdjkOqRCsEd69Mjfs=;
        b=MUJW43YBIhReDMa5lbhUWlvoz1/c78ZengZY2sfC+UeAQ6kn/ssOv8j7rg/rk+doOh
         AySy3oYa2hnHN2gLs3cPlqBRwQP1aDpBpQBEeYj4DkV8KruVfsJkSH0qLNrXkJsDCTV+
         AUv0DvjASS3AByFrwWmpb6MR1kAxu8eYgIsZ7/x08c2I0HDKYC/2/LcvKsBV9eRLLeNW
         1f5BirdOIJdvfXnyB+Tt2nk7iGTKkYnsArJVhyEvqeuda7lamjv8W/l2wXRXP1KIFEjM
         CYvU3wgYooRY+qyRKIQK6YTBQPFmRJP01ZnbCVT+dOEv+T631NS61yVt5rX7/kXpUVOg
         LUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+W6IirWcfB1Hyzy7Gh6Cz+lYfEtl0x3Ezh/dCJoLR8ZX2bA3RdpegcoNWFaSTjtdL4+0QGQ9V5BqxcN+cNyI4pSGsljE=
X-Gm-Message-State: AOJu0Yx2xEsjrrfqUwatvUfIo4RaFCStBA5opZ7iKDxx1E9bxRxd6LRG
	FzqaRXiFo/2jCsECxujj2sG0vcTXE1l4mQX8rzYmzkiIp2dGR56O
X-Google-Smtp-Source: AGHT+IE5KrF0oi1y0hxnyFeDyaEEvsxL6vusKItkbdjIhNwoAghLk57BkmZh1uzjDDsyFTDi3NkBFA==
X-Received: by 2002:a05:6820:995:b0:5a4:b8de:2f4c with SMTP id cg21-20020a056820099500b005a4b8de2f4cmr1040908oob.7.1710902955383;
        Tue, 19 Mar 2024 19:49:15 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id dh8-20020a0568201e0800b005a49df78628sm1520072oob.39.2024.03.19.19.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 19:49:15 -0700 (PDT)
Message-ID: <c54f27a6-5f3f-488f-9970-62c0373370bf@gmail.com>
Date: Tue, 19 Mar 2024 21:49:14 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] qmimodem voicecall support
Content-Language: en-US
To: Adam Pigg <piggz1@gmail.com>, ofono@lists.linux.dev
References: <5612854.ZASKD2KPVS@adam-laptop-hp>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <5612854.ZASKD2KPVS@adam-laptop-hp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 3/18/24 17:51, Adam Pigg wrote:
> Hi
> 
> As previously mentioned, ive been working on updating Ofono in Sailfish.  There
> are several patches which probably are of no interest, but this one may be.
> It implements voicecall support for the qmimodem driver, and ive tested it on
> a PinephonePro, and can make/receive/hangup calls.
> 
> I cant take credit for the original implementation, it was taken from other
> ofono forks out there, such as https://github.com/maemo-leste-upstream-forks/
> ofono/commit/9c8ec63c1bb41a03cd87d2733dd83ecd148d0105
> 
> The changes I have made include:
> *moving voice_generated.* into voice.*
>    This is because it isnt actually generated and reduces the files in the tree
> *removed glib and replaced with ell
> *tweaked the notify code in call_list.c
>    Changed the disconnect type from UNKNOWN because in src/voicecall.c, if the
> reason is UNKNOWN then it doesnt then perform the dbus notify
>    Made it call ofono_voicecall_disconnected when the state was DISCONNECTED
> (QMI state disconnecting and end)
> 

That's an awesome start.  Some preliminary comments:

- Since you've made so many changes already, even based on work by other 
authors, it would be okay to add your copyright to the added / modified files.

- Coding style and formatting.  There's quite a bit of formatting problems in 
the file.  See oFono's doc/coding-style.txt for our coding style guidelines. 
Also, it may be a good idea to run this patch and future submissions through 
Linux Kernel's checkpatch.pl script to avoid going through multiple rounds of 
reviews due to style issues.  Some minor nitpicks I can fix in place (assuming 
the author doesn't mind) when applying the patch, but there's too many in this 
RFC at the moment.

- Also watch out for mixed tabs and space indentation, > 80 char lines, 
redundant double empty lines, etc.

- Redundant changes.  Many changes seem to be spurious / redundant, particularly 
in voice.h file.  This makes the diff bigger for no apparent reason.  Can this 
be fixed?

- Much of voice.c seems to be not useful.  The only user of these functions 
would be in the voicecall driver itself.  I'd rather not introduce intermediate 
APIs for no reason.  Could you inline the operations directly in the driver 
method implementation?  For example, static void dial() invokes 
qmi_voice_dial_call().  Just inline the qmi_voice_dial_call() implementation 
inside dial().

- I know this is an existing driver, but any chance you could split this up a 
bit into multiple patches?  Think of it as telling a story / writing a novel. 
Introduce new data structures / operations as you use them.  One strategy might 
be to break this up like this:
	- Dial implementation
	- Event processing / all_call_status_ind()
	- Answer implementation
	- Release specific implementation
	- hangup active implementation
	- DTMF implementation

> The common/call_list.* files can potentially be used by other drivers.
> 

Can you put call_list.[ch] into the voicecall.c for now?  I understand the 
reason for why this was invented / why this exists, but ultimately there's a 
much better approach that we can utilize.  We'll worry about this a bit later 
once the initial set is upstream.

> Apologies for attaching the patch, git send-email is not my normal work flow!
> :)

Please use git send-email for submissions.  Patchwork does not work well with 
attachments.  oFono CI (which is still a bit WIP) doesn't like attachments 
either.  It is also much easier to comment on patches sent via git send-email 
since the patch contents can be easily replied to in-line.

As a side benefit, the CI runs checkpatch, checks compilation on multiple 
platforms, etc.

Regards,
-Denis
