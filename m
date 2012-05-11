Content-Type: multipart/mixed; boundary="===============8223490100660626066=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono-tests internet context: DNS works,
 ping wget and ssh do not (Connection Refused)
Date: Thu, 10 May 2012 19:46:00 -0500
Message-ID: <4FAC6148.5010804@gmail.com>
In-Reply-To: <4FAC3827.4000802@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8223490100660626066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Darren,

<snip>

> I've updated the context:
> =

> =

> AccessPointName=3Dwap.cingular
> Username=3DWAP(a)CINGULARGPRS.COM
> Password=3DCINGULAR1
> =

> I still get an IP address via DHCP and name resolution is working, but
> my ping,wget,ssh tests fail.

If name resolution is working, doesn't this suggest that you get packets
to the network?

> =

> A colleague allowed me to bottow his AT&T phone. I used this SIM card
> and he had the same APN and Username entered in the phone (assuming same
> password, wasn't visible and he didn't want me to change it just in case
> :-). His phone reported an "EDGE" connection and successfully, albeit
> SLOWLY, displayed web pages.

You are using your pre-paid SIM in this phone correct?  Was it an older
feature-phone type device?  If so, then I suspect the phone is using the
WAP browser, not a regular internet connection.  That is what WAP
gateway is for, to convert regular HTML web pages into an 'optimized'
binary format on slow (think 10 years ago) networks.

> =

> So this suggests to me that the SIM can do IP and not just WAP. However,
> it says EDGE (2G?), does ofono support EDGE? I am I off in the weeds now?
> =


Yes oFono supports 2G and yes you're in the weeds.  You just need to
find a SIM card with a proper data plan.  Unfortunately US carriers
don't really understand that it is useful to have actual data allowances
on prepaid plans ;)

Regards,
-Denis

--===============8223490100660626066==--

