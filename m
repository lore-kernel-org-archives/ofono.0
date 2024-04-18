Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49193142E63
	for <ofono@lists.linux.dev>; Thu, 18 Apr 2024 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451987; cv=none; b=dHYB9JYsdQWnkpM0gP+U/dE2zDe39bg6dr9LkzOYW5bhSjk+F4d784AHA7JdubEuiXXxRANM7Y3yWzwDWaAa7N57yYSai06mV4ejmGbdlz39RL3KDn9NoN7SjHedQivJk0XD7bEo2EMff4EjJAal3TdSFB/osPVi69jXYB6aEqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451987; c=relaxed/simple;
	bh=lK4tj36uRZiE6v7cOdUSyrFwHTuhuSz8YmFOH5xLt7w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rG5glq43RlUTibv561Lnnx1CLbO7A0Pnho7wIyg3px+bONkS/ikFQr39yUZsUpQx74SsGOclbDMD9VClDY78zX2Emor77mCb1iPT8ix4G3df/K2uSHsZrk5WpnWEVOxlFno4cnTTJEkAydVEnNR3bwpQutvKX6mVTc7mV4/TE4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4fefc49c.dip0.t-ipconnect.de [79.239.196.156])
	by mail.holtmann.org (Postfix) with ESMTPSA id CCF20CECC5;
	Thu, 18 Apr 2024 16:53:03 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v4 1/4] qmimodem: voicecall: Implement call dialing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <6a029dbd-76ff-4485-b37f-1a8ee97a9338@gmail.com>
Date: Thu, 18 Apr 2024 16:52:53 +0200
Cc: Adam Pigg <piggz1@gmail.com>,
 ofono@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <9B293F2E-E5BC-47AF-AC4F-CD086909A8B7@holtmann.org>
References: <20240413215318.12236-1-adam@piggz.co.uk>
 <e17d9cdb-03ee-4f1e-b2d4-1a5c02040777@gmail.com>
 <2693964.vuYhMxLoTh@adam-laptop-hp>
 <c450908a-d42f-4d09-b90f-26cba9dfd495@gmail.com>
 <0E7F2740-A440-40EE-AD31-3FA355B6B17E@holtmann.org>
 <6a029dbd-76ff-4485-b37f-1a8ee97a9338@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hi Denis,

>> if phone_number.number is a fixed size buffer, wouldn=E2=80=99t you =
just use snprintf
>> instead. Or just use strncpy/stpncpy with a buffer size - 1.
>=20
> No, because the source is not guaranteed to be null terminated.  That =
is why it has a size parameter.
>=20
> Here's a good overview of all the most popular string copying methods =
and their advantages / disadvantages.
>=20
> https://lwn.net/Articles/905777/
>=20
> What is really needed is a function that takes both src and dst buffer =
sizes into consideration.  I'm not aware of one.

strncpy/stpncpy both set the dest to zero, but you are right, it will be
still off by one. So best is to just zero out the dest buffer with =
memset
first and then just copy dest size - 1 at max. Then you get your \0 in
case of truncation.

Regards

Marcel

