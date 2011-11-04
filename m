Content-Type: multipart/mixed; boundary="===============1005609355705642758=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: CDMA modems and oFono
Date: Fri, 04 Nov 2011 15:20:05 -0500
Message-ID: <4EB448F5.6020802@gmail.com>
In-Reply-To: <4EB3E1F4.1010007@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1005609355705642758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 11/04/2011 08:00 AM, Guillaume Zajac wrote:
> Hi Denis,
> =

> I have sent some patches concerning UIM for CDMA modem but I think I am
> missing something around modem.c so you can give them up :)
> =

> For the moment, "modem.c" is designed for GSM modem, SIM atom is watched
> to add a state watch to make modem progressing into pre_sim post_sim
> online states etc...
> However in the case of a CDMA modem we will have to watch another type
> of atom (UIM for instance) and make the modem progressing into the
> following states: pre_uim post_uim etc...
> =


I think we need to understand in what ways UIM and SIMs are different.
E.g. is it a manner of different EFs being present and their read order
or something more fundamental.  To my understanding 3GPP just recycled
the SIM specs from ETSI, so the fundamentals should be the same.

> So what would you suggest to introduce CDMA modem into oFono?
> Should we create another src/cdma_modem.c with its own watches, states
> and cdma_atoms?
> Or should we keep the current naming (e.g. pre_sim post_sim etc...) and
> change current api to create cdma modem?
> Something like: ofono_modem_create(cdma=3Dtrue/false) that is called from
> udevng. Then this new modem would be tagged as cdma and we would look
> for UIM atom intstead of SIM atom in case of cdma modem.
> =

> What do you think about it?

I think we need to learn a bit more about UIMs first.  Ideally I'd like
to handle both in the sim atom if possible.  At least that would make
sense from dual-mode device standpoint (e.g. something than can use CDMA
and LTE)

Regards,
-Denis

--===============1005609355705642758==--

