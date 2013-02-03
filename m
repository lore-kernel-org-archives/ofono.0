Content-Type: multipart/mixed; boundary="===============6781550938031252505=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 2/2] hfpmodem: Request AT+CLCC again after callheld=<2
 or 3>
Date: Sat, 02 Feb 2013 21:23:00 -0600
Message-ID: <510DD814.4050908@gmail.com>
In-Reply-To: <510FDFBD.8020900@timomueller.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6781550938031252505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Timo,

> I agree, that the core logic shouldn't be polluted with phone specific
> workarounds. This is especially true when the quirks somehow interfere
> or modify the standard path. Having said this, I'd consider this fix
> general enough to justify it's integration in the standard driver, since
> the policy makes sense for any phone (mis)behaving this way, keeping the
> phone specific quirks to an absolute minimum.
>

You can extend this justification logic to any mis-behavior.  We have to =

draw a line somewhere.

> I know that the N9 is the only phone that has seen this problem so far,
> but the problem will occur with every phone that doesn't "atomically"
> change the CLCC list the moment it reports an indicator change (+CIEV).
>

Our motto here is 'We do not deal with hypothetical situations'.  So =

unless you find another phone that behaves in this manner, lets try not =

to speculate ;)

> As described in the commit message the phone already told the HF that it
> has set up an outgoing call (or that it's already alerting). The only
> thing missing is the detailed information about the call, which is
> retrieved using the AT+CLCC request.
>
> So in this case I think it's valid to generally try to fill in the
> missing information by issuing another AT+CLCC request. Otherwise the
> call will be alerting and although the phone has reported all indicator
> changes to oFono, we won't be able to reasonably control it from HF side.
>

I disagree.  However, I do think we need to get started on the HFP =

quirks framework.

Regards,
-Denis

--===============6781550938031252505==--

