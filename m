Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D4420C470
	for <ofono@lists.linux.dev>; Fri, 11 Oct 2024 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728651499; cv=none; b=Tvsge8Lv7D4ISJCqSOUIbyQn89r04Lvx359QOvd0OUWchwNHq2xGc62cr9nr3QuvANIW6GmB7YFCxBmFABB+DqeCWgeWbI445UcFh4aHWHv0THnBT+yejJzTuRfQfBtCuQ8GSjOm0bL7FlZnFXYDwPEwX5/TsJ/7EKeQ7cEekc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728651499; c=relaxed/simple;
	bh=yjQecyVEsBv5WpZbRycJWPRKkyHedHO6jxhdp+6a4Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHsv8tYIiVeLV+LibdQSBAe/jSMPFdIKylrJqJhX7SeMbla9cJF6YO3kfqpkuMnu+i+xaNWmtVHZ7WFCg9hiSEQUTCeHSWlky6r1kU1u7NnvofhqSCE3nEWnMHGp7gVsxIrgSm9KF04N6nvdp0Wg5wBTZFVNGeAU1vM+ewK7ACE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=GOgTHjL+; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="GOgTHjL+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=kfembFmZt52C3WP+4skXg7xMRx0ncbVesE9W/toI41k=; b=GOgTHj
	L+FTsm/+xmSHEQ2eNby1Af2y2FKrO1sK44N8mkf8rSZWhEi+r9uHP2Sna09/Nh32Xy436XvjzDpON
	8wR20ND/d189KzjvXYV4OJKwRHJ/NSfIBkPGhxOnCVsgYvyL4iqiTM2Gr7i3vES5vx1il16VCBG4o
	Uao5S2GcQ5Onv1jwrQP0PK8HUzLmdZUkIzFIKK35J5vdkB1eFfK0g2i5WMlTEpAny4Xt4+lhPZ3uU
	kU/tbqXp3HDjTJa78R5kYbWmr+jNk8nVbX76ys9ijdLZLUpNdn6cFb7TXLwkv8ZYyLuET7wZnaATe
	SRHL8AZClShKUmPjJx2IUyavfBhg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1szFDi-000HOW-6p; Fri, 11 Oct 2024 14:58:13 +0200
Received: from [185.17.218.86] (helo=Seans-MacBook-Pro.local)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1szFDh-000JQu-1i;
	Fri, 11 Oct 2024 14:58:13 +0200
Date: Fri, 11 Oct 2024 14:58:13 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev
Subject: Re: [RFC] atmodem: let +COPS: report access technology
Message-ID: <gm64cf5m7sx5qrjoaumf6524ldstqythicfqoqoljtanfyjlxa@5lg2qveme5ox>
References: <20241008091009.1567305-1-sean@geanix.com>
 <51d4c953-000f-47e5-8179-63c10e5e708d@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51d4c953-000f-47e5-8179-63c10e5e708d@gmail.com>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27424/Fri Oct 11 10:30:09 2024)

Hi Denis,

On Wed, Oct 09, 2024 at 10:47:33AM +0100, Denis Kenzior wrote:
> Hi Sean,
> 
> On 10/8/24 4:10 AM, Sean Nyekjaer wrote:
> > When using the SIMCom A7672E-FASE in gsm mode, gsm is never reported as
> > access technology. Fix this by letting +COPS: report it.
> > ---
> > For EUTRAN networks at_creg_cb() is setting the correct technology.
> > But as I read it, CREG doesn't differentiate between GSM and UMTS.
> > Can we fix this by using the technology from +COPS: ?
> > 
> >   drivers/atmodem/network-registration.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/network-registration.c
> > index 46b8512a..ccd01234 100644
> > --- a/drivers/atmodem/network-registration.c
> > +++ b/drivers/atmodem/network-registration.c
> > @@ -353,6 +353,9 @@ static void cops_cb(gboolean ok, GAtResult *result, gpointer user_data)
> >   	op.status = 2;
> >   	op.tech = tech;
> > +	/* Set current access technology */a

So something like:

if (nd->vendor == OFONO_VENDOR_SIMCOM_A76XX) ?
> > +	nd->tech = tech;
> > +
> 
> Maybe behind a vendor check with an explanation?  COPS isn't really meant to
> be used for this as it can contain the cell capabilities rather than the
> actual registration technology.

And an explanation from the SIMCom datasheet?

> 
> >   	DBG("cops_cb: %s, %s %s %d", name, nd->mcc, nd->mnc, tech);
> >   	cb(&error, &op, cbd->data);
> 
> Regards,
> -Denis

/Sean
