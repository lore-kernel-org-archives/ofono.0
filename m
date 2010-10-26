Content-Type: multipart/mixed; boundary="===============8063753559842343327=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: Re: modem atom api change request for support GSM&CDMA dual mode
Date: Mon, 25 Oct 2010 21:10:29 -0700
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702B73BAF@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8063753559842343327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

>Zhang, Caiwen to ofono
>
>Hi all,
> =

>Considering support GSM + CDMA dual mode, it is necessary to let upper
layer to
>know the type of the modem currently in use. My proposed solution is
add a =

>property 'Type' in modem atom to indicate it. The following is the
definition =

>of the property:
> =

>string Type [readonly]                  =

>                               =

>Type of the modem. The possible values are:
> "gsm" - the modem is a GSM modem
> "cdma" - the modem is a CDMA modem
> "unknown" - the modem is neither a GSM modem nor
>             a CDMA modem

As there are also Multimode modems(both GSM and CDMA), Property name
Type would be misleading.

string ModemAccessTechnology [readonly]

Current Access Technology of the Modem. =

The Possible values are:
"gsm" - the current modem access technology is GSM
"cdma" - the current modem access technology is CDMA

BR,
Rajesh

--===============8063753559842343327==--

