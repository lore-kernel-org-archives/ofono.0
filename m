Content-Type: multipart/mixed; boundary="===============4921254314561309767=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] atmodem: remove pending idle callbacks at device
 removal
Date: Tue, 04 Dec 2012 23:49:48 -0600
Message-ID: <50BEE07C.1070500@gmail.com>
In-Reply-To: <1354635227-9344-1-git-send-email-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4921254314561309767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mingli,

On 12/04/2012 09:33 AM, Jonas Bonn wrote:
> From: Mingli Wu<mingli@southpole.se>
>
> If device probe and removal happen in short succession, it's possible
> that the idle handler registered in the probe function doesn't run before
> the device is removed.  In this case, the idle handler needs to be
> unregistered so that it does not run and try to access the data that's
> destroyed during the removal.
> ---
>   drivers/atmodem/call-barring.c    |    1 +
>   drivers/atmodem/call-forwarding.c |    1 +
>   drivers/atmodem/call-settings.c   |    1 +
>   drivers/atmodem/sim-auth.c        |    1 +
>   drivers/atmodem/sim.c             |    1 +
>   drivers/atmodem/stk.c             |    1 +
>   6 files changed, 6 insertions(+)
>

Patch has been applied, thanks.

Regards,
-Denis

--===============4921254314561309767==--

