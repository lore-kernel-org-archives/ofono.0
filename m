Content-Type: multipart/mixed; boundary="===============4315362090336833921=="
MIME-Version: 1.0
From: Vijay.Nayani@elektrobit.com
Subject: RE: [PATCH] atmodem: CEREG support for LTE network status reporting
 in AT modem
Date: Tue, 22 Feb 2011 16:59:58 +0200
Message-ID: <AA48DD8077D5D945A49BD1782C1140F1E7BDF9@fioues08.ebgroup.elektrobit.com>
In-Reply-To: <AANLkTikHRFPigctx=W=KsyKUBrnFFh=k5yVBa1-c_aoh@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4315362090336833921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 =


> -----Original Message-----
> From: Tomasz Gregorek [mailto:tomasz.gregorek(a)gmail.com] =

> Sent: 22 February 2011 16:09
> To: ofono(a)ofono.org
> Cc: Nayani Vijay
> Subject: Re: [PATCH] atmodem: CEREG support for LTE network =

> status reporting in AT modem
> =

> Hi Vijay
> =

> =

> 2011/2/22 <Vijay.Nayani@elektrobit.com>
> =

> =

> =

> =

> 	> Subject: [PATCH] atmodem: CEREG support for LTE network
> 	> status reporting in AT modem
> 	>
> 	> [PATCH] atmodem: CEREG support for LTE network status
> 	> reporting in AT modem Tomasz Gregorek tomasz.gregorek at
> 	> gmail.com Thu Feb 17 19:52:45 PST 2011
> 	>
> 	>     * Previous message: [PATCH 2/5] bluetooth: add a
> 	> bluetoothd connect watch
> 	>     * Next message: Problem with SIM lock states not showing
> 	> correctly in Ofono API.
> 	>     * Messages sorted by: [ date ] [ thread ] [ =

> subject ] [ author ]
> 	>
> 	> From: Tomasz Gregorek <tomasz.gregorek@stericsson.com>
> 	=

> 	>
> 	> This is a proposal for CEREG support based on the AT modem.
> 	> Support in driver should work, though I have an issue =

> with the core.
> 	>
> 	> The core has one gprs status currently. In case of having
> 	> second status for LTE, there is need of having two satuses,
> 	> one for each, 3G and LTE, or to combine those two into one.
> 	>
> 	> I took second approach as it leaves current oFono API, though
> 	> it is not perfect.
> 	=

> 	=

> 	I have been working on solution that comprises of =

> separate eps atom and
> 	corresponding driver. Code has been tested against =

> modified phonesim for
> 	eps.Will provide an RFC patch soon once I bring it to =

> certain logical
> 	end.
> 	=

> 	Regards,
> 	Vijay
> 	=

> =

> =

> This is what I was thinking about too.
> For me, from status point of view, both networks look very =

> similar, thats why I was thinking about using gprs atom / =

> driver for status handling and create separate atom for QoS / IMS.
> =


I agree with you , both bearers are almost similar.Minor difference i
see are context managment (especially default context creation) and some
eps related spill over on other existing atoms (For ex SIM would not
contain some ISIM (IMPU/IMPI)related stuff).My idea is seperate atoms
solution would even work for legacy switch back(CSFB) too with a minimal
impact on exiting architecture.Your comments on these ideas would also
very valuable here as i assume you have real modem unlike me.

> I am at most interested in your solution. I know from Denis =

> that this is what was agreed.
> =

> Br
> Tomasz Gregorek
> =


Will submit the rfc patch and short design write up once i have code
ready.

Br,
Vijay

--===============4315362090336833921==--

