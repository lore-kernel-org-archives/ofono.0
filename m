Content-Type: multipart/mixed; boundary="===============4454301276101443482=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: A way of polling SIM status
Date: Tue, 19 Oct 2010 13:13:04 +0200
Message-ID: <1287486784.3316.143.camel@aeonflux>
In-Reply-To: <D87B22B1FE8C0F479CA9BEAD6C25AAE805CEE378@ism-mail03.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4454301276101443482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

> Due to some other tasks, it a long time did not take part in the
> discussion
> Here.  I see there are much discussion about how to polling SIM status. =

> =

> Maybe we can start to polling the SIM status with AT+CPIN? when the
> probe
>  function of SIM atom driver is invoke. If it return  +CME: 10  or +CME:
> SIM not
>  inserted. It means there is no SIM inserted. If it return other result,
> invoke =

> ofono_sim_register register the APIs first and then waiting user input
> password
> (if password is required) or notify SIM is ready(if SIM is ready).

you did look at the SIM ready patches that Pekka send a few days ago?

And do me a favor, even RFC patches should follow the coding style of
oFono upstream.

Regards

Marcel



--===============4454301276101443482==--

