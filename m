Content-Type: multipart/mixed; boundary="===============8477331613228087632=="
MIME-Version: 1.0
From: Vijay.Nayani@elektrobit.com
Subject: RE: [PATCH] atmodem: CEREG support for LTE network status reporting
 in AT modem
Date: Tue, 22 Feb 2011 15:46:02 +0200
Message-ID: <AA48DD8077D5D945A49BD1782C1140F1E7BDE3@fioues08.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8477331613228087632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 =


> Subject: [PATCH] atmodem: CEREG support for LTE network =

> status reporting in AT modem
> =

> [PATCH] atmodem: CEREG support for LTE network status =

> reporting in AT modem Tomasz Gregorek tomasz.gregorek at =

> gmail.com Thu Feb 17 19:52:45 PST 2011
> =

>     * Previous message: [PATCH 2/5] bluetooth: add a =

> bluetoothd connect watch
>     * Next message: Problem with SIM lock states not showing =

> correctly in Ofono API.
>     * Messages sorted by: [ date ] [ thread ] [ subject ] [ author ]
> =

> From: Tomasz Gregorek <tomasz.gregorek@stericsson.com>
> =

> This is a proposal for CEREG support based on the AT modem.
> Support in driver should work, though I have an issue with the core.
> =

> The core has one gprs status currently. In case of having =

> second status for LTE, there is need of having two satuses, =

> one for each, 3G and LTE, or to combine those two into one.
> =

> I took second approach as it leaves current oFono API, though =

> it is not perfect.

I have been working on solution that comprises of separate eps atom and
corresponding driver. Code has been tested against modified phonesim for
eps.Will provide an RFC patch soon once I bring it to certain logical
end.

Regards,
Vijay

--===============8477331613228087632==--

