Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1307015A85A
	for <ofono@lists.linux.dev>; Mon, 18 May 2026 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779143332; cv=none; b=U/QoNWJscGDE3iNSmOg+Y/DFdt0njdsbFNcCSarbuIdtSn/8QQ3bP3KwzXXI4afGz+VIaQlHsLHWj+IR/y3t2QvoO8Tvvg7DoNPyzmMNA+E+4L4t09ZNUu2CK9Iamn1BFdKMjIEQWp2O+uCvKj0P8dn8zN7rmtwMWWGFBX+D65s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779143332; c=relaxed/simple;
	bh=88TU6pSgOSqQZYaCbolGx2tCkmt4AUA7qt/VJYokg4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=JXsOT5mqDob0ANdD1/noVoRs1fFhLA7HB8NcG7JZUk760iP1rAq1dsw+2W0+pDs7HAln9mPOWNC2lZ06Tjp6uc3i+2R8S3/jgjkcpcvcWPpiEXgy4UnWLiFPWQ3nCVNq6SesbbRtFJt0bMBgzlz19lDa21Gu9FYmmeLYuT923c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 7D5F611CB92; Mon, 18 May 2026 18:19:24 -0400 (EDT)
Received: from [192.168.12.132] (unknown [172.56.35.188])
	by spindle.queued.net (Postfix) with ESMTPSA id 2A77A11CB8B;
	Mon, 18 May 2026 18:19:24 -0400 (EDT)
Message-ID: <56f28586-afad-4a8b-97c8-d63e8ddb1aac@queued.net>
Date: Mon, 18 May 2026 18:19:23 -0400
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sim: fix use-after-free in open_channel_cb watcher loop
To: Marius Gripsgard <marius@ubports.com>
References: <0107019e04adf95a-a0e08395-5cda-4937-b142-329901156dcd-000000@eu-central-1.amazonses.com>
Content-Language: en-US
Cc: ofono <ofono@lists.linux.dev>
From: Andres Salomon <dilinger@queued.net>
Autocrypt: addr=dilinger@queued.net; keydata=
 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
In-Reply-To: <0107019e04adf95a-a0e08395-5cda-4937-b142-329901156dcd-000000@eu-central-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

On 5/7/26 19:02, Marius Gripsgard wrote:
> The notify callback (get_session_cb -> sim_fs_end_current) calls
> __ofono_sim_remove_session_watch, which removes and frees the current
> GSList node from session->watches->items. iter = g_slist_next(iter)
> then reads ->next from the freed node, on newer glibc the freed memory
> holds a random tcache key rather than accessible heap data, turning the
> next iter->data dereference into a SIGSEGV.
> 
> Advance iter before calling notify so the next-pointer is captured
> before the current node can be freed.
> ---
>   src/sim.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/sim.c b/src/sim.c
> index dedb7d8d..6a733169 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -3659,9 +3659,9 @@ end:
>   		struct ofono_watchlist_item *item = iter->data;
>   		ofono_sim_session_event_cb_t notify = item->notify;
>   
> -		notify(active, session->session_id, item->notify_data);
> -
>   		iter = g_slist_next(iter);
> +
> +		notify(active, session->session_id, item->notify_data);
>   	}
>   }
>   


This fix looks both necessary (the error path in get_session_cb() will 
potentially call __ofono_sim_remove_session_watch() in its error path; 
and get_session_cb() is used as a notify callback and open_channel_cb() 
iterates unsafely through a GSList) and correct.

In general ofono should probably be calling g_slist_foreach() instead of 
manually iterating through lists to avoid this type of bug.
