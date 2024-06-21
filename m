Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F410B16C870
	for <ofono@lists.linux.dev>; Fri, 21 Jun 2024 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950711; cv=none; b=lM1NBodkO/t5V0CSZBn0bQgaob98i5QTjDjTwrrTJBolnwpIW6iv/x1haTGUyqZb+gUjUfXXeqfEw6dfzdlRpxi3bTY+WsHDNfzuelJplFCYECDHoAAvqdNBTlKalTjxXDtuWA4248S+iAJyoRJkU6Qh82CbNZGgTIgr8ACV3gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950711; c=relaxed/simple;
	bh=2kqIos1/chwSOR6blOZwYPL0gJKH/qSbyjP4ocPr/MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrQKFDatYHLdfb6oyYXwBY4pq5ADLUKm++LGKoPgrA+JbBnctof5F3seu/eMwfcT+eTYCyehiWNYqRXah+4d/s43pXGhEDQWLtUgLY0W2TZdDQCpJ8JBSBiEt9E2+a9Oqz5UiHP+hULBx53nx2z5Z9NJxY/IFTx3PSYFSuUOV3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=A04rODaw; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="A04rODaw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/+oPRnGiJLTyevIMBcW+iQEwItrBPGWQG9cyQIEjEvU=; b=A04rODawGkhABefWAZptt/dhFa
	0pM02Rt4iB/Es0y14CF6F1WNKacCNAxpltI5z2m3FE+IfF77g7oeZdvRWJgBXbUUfGx/CxBdA/9oe
	8vadBjS4NVscfeQ6BF6gKi+SZzeIp48y5pNTHCOSKn3C38uNYOPmkjj0WmaQmS3+yC9ryCgibkDP5
	aIR5qLkuWPZPgp3+an9kkDp5nPSErDtokkvdwWyWab1iIjspxJqKlBhBuAwrAWfUsnjSJqX4zSwnq
	ZQzFPyRz+vjDQH9+EN/khYGLD7pEaRj1TvhzpLNOlb1QU+XgXxNu6fY+/1zTy6V66a0HrEY1PwTGL
	tz7n89Lg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1sKXbH-000Fu9-Eq; Fri, 21 Jun 2024 08:18:19 +0200
Received: from [2a06:4004:10df:0:7026:cf6e:8884:b421] (helo=Seans-MBP.snzone.dk)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1sKXbH-000HV4-1v;
	Fri, 21 Jun 2024 08:18:19 +0200
Date: Fri, 21 Jun 2024 08:18:17 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev, 
	Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: qmi: differentiate between lte-cat-m1 and lte-cat-nb1
Message-ID: <wejfxratz363pxgqph6cn5qnyexcsaaucpmb4twiumhd36fbd3@rvl45njp5ffr>
References: <13BA976A-5959-4708-97F2-77285400EFB1@geanix.com>
 <1218dd9c-7d11-4024-9beb-dd72dc6d8e69@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1218dd9c-7d11-4024-9beb-dd72dc6d8e69@gmail.com>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27312/Thu Jun 20 10:34:55 2024)

On Thu, Jun 20, 2024 at 10:00:01AM UTC, Denis Kenzior wrote:
> Hi Sean,
> 
> On 6/20/24 2:28 AM, Sean Nyekjaer wrote:
> > Hi Denis,
> > 
> > We are using the Quectel BG96, when online Technology comes up as “lte”.
> > We would like to see if it’s connected via “lte-cat-m1” or “lte-cat-nb1”.
> 
> I don't think oFono even supports this yet?  I remember someone added the
> enums, but I don't think any driver actually reports this?

Yes, the enums are there ACCESS_TECHNOLOGY_NB_IOT_M1 and
ACCESS_TECHNOLOGY_NB_IOT_NB1. They are not used.

> 
> > It doesn’t look like the QMI standard is supporting this differentiation,
> > I have also looked in libqmi and uqmi. Is this the correct assumption?
> 
> No idea.  I assume it is supported, but may not have been exposed by libqmi.

The qmi interface returns QMI_NAS_NETWORK_RAT_LTE. Looks the same in
libqmi and uqmi. No special cases for cat-m1 and nb1.

> 
> > 
> > Via AT commands, we can get the info:
> > AT+QCSQ
> > +QCSQ: "CAT-M1",-62,-88,168,-11
> > AT+QNWINFO
> > +QNWINFO: "CAT-M1","23801","LTE BAND 20",6350
> > 
> > Guess we are in the same boat as the folks from "RFC - Add AT interface to qmi device” thread.
> > We need to add the AT interface in the modem driver and in some way prefer the technology from the AT interface.
> 
> There's nothing stopping the modem driver from initializing an AT port.  You
> can do that today.  It can then report things like network registration
> state on behalf of the netreg atom.  At least in theory.

By modem driver you mean drivers/ or plugins/ ?
Guess I would need to modify the gobi driver or add a quectelqmi one?

> 
> How is M1/NB state reported?  Is there an unsolicited notification?

You would have to ask via AT+QCSQ or AT+QNWINFO.

One more use-case I see is when we are testing with a unregistered simcard.
Ofono via qmi reports the status as "searching", but AT+CREG? reports (the correct) +CREG: 0,3
3=Registration denied

/Sean
