Content-Type: multipart/mixed; boundary="===============5024062535666786803=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: A way of polling SIM status
Date: Tue, 19 Oct 2010 13:28:03 -0500
Message-ID: <4CBDE333.7090605@gmail.com>
In-Reply-To: <D87B22B1FE8C0F479CA9BEAD6C25AAE805CEE378@ism-mail03.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5024062535666786803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 10/19/2010 05:41 AM, Zhang, Caiwen wrote:
> Hi, =

> =

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
> =

> Following are the proposed implementation:
> =


Unfortunately some modems report CPIN: READY even though they're not
ready.  The only reliable way to poll for this is to poll the IMSI, then
the phonebook and the sms store and report ready only once all of them
can be manipulated.

Regards,
-Denis

--===============5024062535666786803==--

