Content-Type: multipart/mixed; boundary="===============3906159898666188906=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 0/2] CPIN polling mechanism
Date: Fri, 22 Jul 2011 09:18:49 -0500
Message-ID: <4E2986C9.6020908@gmail.com>
In-Reply-To: <1311242513-17724-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3906159898666188906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On 07/21/2011 05:01 AM, Nicolas Bertrand wrote:
> v2 changes:
>  - change AT channel from modem to aux
>  - raise timeout to 20 since some dongle take a while to be
>    operational
>  - send sim inserted notify related to the current status
> =

> As no SIM card status urc is available with ZTE and Speedup, the SIM =

> state is set by default to OFONO_SIM_STATE_INSERTED even if no SIM card =

> is inserted. Also, we are facing with a modem latency after the ttyUSB =

> is opened (first AT commands are failing and the PIN status query =

> returns CME ERROR: 14 - SIM Busy).
> So, to deal with those 2 issues, this patch set is introducing a =

> preliminary PIN status polling in the ZTE/Speedup plugins. In practice, =

> this polling is started after the modem is enabled and stopped when the =

> CPIN query returns an other result than CME ERROR 14 or when the polling =

> duration exceeds 5 seconds.
> As a result, the SIM state is set according the result of the CPIN query =

> and the update of the modem_powered state is postponed which delays the =

> next AT commands.
> =

> Developed conjointly with philippe nunes.
> =


I've added PIN polling utility to drivers/atmodem/atutil.c and have made
the mbm plugin use this.  Can you check whether this utility is suitable
for ZTE/Speedup drivers?

Regards,
-Denis

--===============3906159898666188906==--

