Content-Type: multipart/mixed; boundary="===============4521471606922948630=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH qmi lte v3 5/6] qmi: stop listening to packet service
 notifications
Date: Mon, 17 Apr 2017 12:19:53 -0500
Message-ID: <3d9bafa0-a01d-bcb9-c189-521e5beeb93b@gmail.com>
In-Reply-To: <20170415153446.31803-7-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4521471606922948630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/15/2017 10:34 AM, Jonas Bonn wrote:
> The packet service status notification tells whether there is _any_
> active and enabled context.  Using this to decide whether to
> release any given context makes no sense.

The gobi driver only supports a single context and afaik only a single =

network interface is available.  Do you have hardware with support for =

multiple active contexts?

Otherwise I think it would be safe to assume that in a single-context =

case, this code is doing the right thing.

>
> It might make sense to monitor this status in the GPRS atom, but
> not here in the gprs-context atom.
> ---
>  drivers/qmimodem/gprs-context.c | 30 ------------------------------
>  1 file changed, 30 deletions(-)
>

Regards,
-Denis


--===============4521471606922948630==--

