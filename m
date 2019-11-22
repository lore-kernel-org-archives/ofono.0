Content-Type: multipart/mixed; boundary="===============0695694026948616265=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] - oFono v1.31 stuck in loop when unplugging a USB dongle
 connected via PPP
Date: Thu, 21 Nov 2019 21:23:58 -0600
Message-ID: <abea5e7c-c489-c177-14b1-d0fc7a397bb5@gmail.com>
In-Reply-To: <20191119105320.2673.41258@new-ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0695694026948616265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jimmy,

On 11/19/19 4:53 AM, Jimmy Gysens wrote:
> Hi,
> =

> After unplugging a Huawei USB dongle, the 'atoms' in oFono are removed vi=
a 'flush_atoms'.
> Every atom has a destruct function pointer, used as a - yes - destructor.
> =

> When unplugging a dongle, connected via PPP, oFono will remove the curren=
t GPRS context (=3D data connection).
> =

> The function calls are:
> =

> flush_atoms -> destruct -> gprs_context_remove -> at_gprs_context_remove =
-> modem_disconnect
> =

> Because the device is physically removed, the IO channel for the AT port =
is gone.
> =

> In 'at_gprs_context_remove', there is an attempt to resume communication =
over that AT port, but that
> is not possible. This is detected, and 'io_disconnect' (pointer to 'modem=
_disconnect') is called.
> =

> 'modem_disconnect' has the same atom and tries to remove it again, so it =
calls the same destructor.
> =

> modem_disconnect -> destruct -> gprs_context_remove -> at_gprs_context_re=
move -> modem_disconnect
> =

> And the loop is started.
> =

> The easiest way to fix this, is to move the GPRS context removal. After a=
 disconnect, oFono tries to
> re-open the AT port. If that fails (and it will in this case), we're done=
, since 'modem_disconnect' returns.
> =

> In case the AT port can be opened, for example, when setting up a new con=
nection, the previous GPRS context
> is removed.
> =

> The old GPRS context is removed via:
>   - 'flush_atoms' in case the USB device is physically removed.
>   - 'modem_disconnect' in case a new connection is being set up.
> =

> The loop hereby is fixed, without altering general functionality of oFono=
. This fix is limited to Huawei devices and has been tested using the follo=
wing devices:
> =

> - E3531i-2
> - E3372
> - E3531s-2
> - E369
> - E1552
> =

> The patch itself:
> =

> ---
>   ofono-1.31/plugins/huawei.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> =


Thanks for the detailed report!  I went ahead and applied this fix =

upstream after massaging the commit description a bit.

Regards,
-Denis
--===============0695694026948616265==--

