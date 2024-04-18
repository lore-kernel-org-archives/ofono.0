Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AD729A1
	for <ofono@lists.linux.dev>; Thu, 18 Apr 2024 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423521; cv=none; b=cW7Swu7/Aww0/0e6iYYVpwamMS2JzGOFOjn1AlYJGv1wpveabsfuhjBJeHJyi7fiIUvVSOU/8RNKMar5lluCM12hjQbdQVfsUD9tFlyeMC9Wt3kpAOcYFeb35zKdHdzahpnUxfKpWJoLRLZ5Z5QBMCI3teaULBJuA9kprAXVmBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423521; c=relaxed/simple;
	bh=3Fm7HM8WxDKck/skBt+Fc7A5aVVTuJ3bf0NV+DUIqFg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tp3Yyfk1nai1P5JHFy1OOexiujyp7wjtFupcoGt4I48Yd3N7EwPmOxWClcYW53WQEWDcv6XNSRURIx2DrQlX378fDSqqhaSk6LaJ6pWLYSCW+VhDoDLjJbx+L0l7FoaQB/B5F7aaRYZ3lHNyxxWstBcz1zO7URwgsJM3hdQkYoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4fefc49c.dip0.t-ipconnect.de [79.239.196.156])
	by mail.holtmann.org (Postfix) with ESMTPSA id BB270CECC5;
	Thu, 18 Apr 2024 08:58:38 +0200 (CEST)
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
In-Reply-To: <c450908a-d42f-4d09-b90f-26cba9dfd495@gmail.com>
Date: Thu, 18 Apr 2024 08:58:28 +0200
Cc: Adam Pigg <piggz1@gmail.com>,
 ofono@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <0E7F2740-A440-40EE-AD31-3FA355B6B17E@holtmann.org>
References: <20240413215318.12236-1-adam@piggz.co.uk>
 <e17d9cdb-03ee-4f1e-b2d4-1a5c02040777@gmail.com>
 <2693964.vuYhMxLoTh@adam-laptop-hp>
 <c450908a-d42f-4d09-b90f-26cba9dfd495@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hi Denis,

>>>> + number_size =3D remote_party->number_size + 1;
>>>=20
>>> Why +1?  We can't copy more than remote_party->number_size bytes =
from
>>> remote_party->number, otherwise we read out of bounds ?
>> In my testing I found that the last digit of the number was being =
missed.
>> This fixed it, though I suspected it may come back to haunt me!  Any
>> suggestions?
>=20
> l_strlcpy takes 3 parameters:
> destination
> source
> size of the destination in bytes
>=20
> So strictly speaking, l_strlcpy should be invoked as:
> l_strlcpy(call->phone_number.number,
> remote_party->number,
> sizeof(call->phone_number.number));
>=20
> l_strlcpy ensures that if strlen(src) is bigger than the destination =
buffer, the result is truncated, but the destination buffer is still =
'\0' terminated.
>=20
> But here's the problem, in QMI, strings are not NULL terminated, so =
you're just getting lucky that remote_party->number has a '\0' somewhere =
at the end.  What you need to do is copy at most remote_party->size =
bytes into a buffer of sizeof(call->phone_number.number) and make sure =
the buffer is still '\0' terminated.
>=20
> You can do this using MAX(), memcpy and memset, or the far easier to =
understand:
>=20
> char *tmp =3D l_strndup(remove_party->number, remote_party->size);
>=20
> l_strlcpy(call->phone_number.number, tmp, =
sizeof(call->phone_number.number));
> l_free(tmp);

if phone_number.number is a fixed size buffer, wouldn=E2=80=99t you just =
use snprintf
instead. Or just use strncpy/stpncpy with a buffer size - 1.

Regards

Marcel

