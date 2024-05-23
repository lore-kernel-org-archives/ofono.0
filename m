Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5261D545
	for <ofono@lists.linux.dev>; Thu, 23 May 2024 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470786; cv=none; b=RgJGKFWrgxIvgzgm6ncSuqccxIb+cH0FGAMvLTTx8TD8xxD7CdU9/wwu5kaCSKqWQ5S1P67CjxGflMk5mXZ3Rw0GtYGeCLQ88SBrTZzvqMeQZgwLD5s0cPC8o4Oq+2GejBCJGkBMN5Tsmc+bk0aYTrcY9ioT9mkC3OeLYJSCPyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470786; c=relaxed/simple;
	bh=8DbJ707C9m7xRQYbKvGkvfSHU4VPnI29PXmyXx8A9MM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dTV4sqNqhOB1tF/v1vcJp+V20l058ycgM/qVFiu/EY8PuObMfcOucINcUQnxWtWw6PpSRvgMptXSYP9A++nsQuNBA3b3AV+RMvpo9pfc3o+ZsQcvnfnObggdpzmDfEG+lhURpGH5BzoyyVonsgUKTvw4HHHKaEsIc+xD6Dvn/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=rMqCOrd5; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="rMqCOrd5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=MIME-Version:Content-Transfer-Encoding:Content-Type:
	References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8DbJ707C9m7xRQYbKvGkvfSHU4VPnI29PXmyXx8A9MM=; b=rMqCOrd5uO4S+Njp6T2XcUMg0Y
	RhEoJ/Et7UxgmbIAGc40UkWQqV4M+e7MRPjfPyKVt8WflBIRr3uBrs1w66c+9qFuVxoU+YtsyHwwm
	E1yNqHWuxHU0PXzx67wGfHr8Wv6uwA5xASQJcYdJRoKgN2R+r+bYb1suZH45vHV4OwoNbyipZHjfY
	b1c10sVEQZZ56iOHEgnE5jKKmIr+5xseEreRSHBWfUAvoFMI2m8s1LiICRz5OfcDzRT+7bc8dEdNL
	UuQ9YC/2Yc/O3IZKkUU0unBB/XgTKTQbkzP0blajBVC5PodoCmxaMqpm841LmHL7hOTIBDHEGjOD0
	828sV6qA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1sA8SU-0004da-PQ; Thu, 23 May 2024 15:26:14 +0200
Received: from [185.17.218.86] (helo=[192.168.64.76])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@geanix.com>)
	id 1sA8SU-000AFO-34;
	Thu, 23 May 2024 15:26:14 +0200
Message-ID: <1a844ac9b3b451e151569e7f5cb2f1562adce8ad.camel@geanix.com>
Subject: Re: [PATCH 08/10] udevng: register support for SIMCom A76XX USB
 serial modem
From: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Date: Thu, 23 May 2024 15:26:14 +0200
In-Reply-To: <1f043a8186d42fe4a65914e0c44f106ef4ccc41c.camel@geanix.com>
References: <20240430115234.180185-1-martin@geanix.com>
	 <20240430115234.180185-8-martin@geanix.com>
	 <1f043a8186d42fe4a65914e0c44f106ef4ccc41c.camel@geanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27284/Thu May 23 10:32:30 2024)

On Wed, 2024-05-22 at 09:48 +0200, Martin Hundeb=C3=B8ll wrote:
> Hi,
>=20
> On Tue, 2024-04-30 at 13:52 +0200, Martin Hundeb=C3=B8ll wrote:
> > Register the 1e0e:9011 usb id as a specialization of the sim7100
> > driver.
>=20
> I'm seeking advice on an issue that I experience with this SIMCom
> A7672E modem: Not closing the PPP session when powering down the
> modem
> breaks a following attempt to go online.
>=20
> When setting Powered to false on dbus, any active PPP session is
> destroyed without terminating it. The modem then keeps the session
> alive for 15 seconds, even after sending AT+CFUN=3D0 and AT+CFUN=3D1.
>=20
> The active session on the modem somehow interferes powering up the
> modem again, and activating the gprs context.
>=20
> The issue can be worked around by setting Online to false before
> setting Powered to false.
>=20
> I've been in contact with SIMCom, and while they understand the
> issue,
> they more or less tell me to just close the PPP session before
> sending
> AT+CFUN=3D0 :( I'm still trying to make them fix the issue properly,
> but
> I don't hold my breath...
>=20
> Is there a way to make ofono send a proper PPP terminate request to
> the
> modem when powering down?

SIMCom has agreed to add a vendor AT command that enables reset of
modem PPP state upon either AT+CFUN=3D0 or a subsequent AT+CFUN=3D1.

I'll create a patch once I get my hands on the updated firmware.

// Martin
