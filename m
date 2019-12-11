Content-Type: multipart/mixed; boundary="===============6751703949713752968=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: Update attach state on context deactivation for LTE
Date: Wed, 11 Dec 2019 15:08:58 -0600
Message-ID: <8bc90037-fa9f-9f49-335c-aedceb01efac@gmail.com>
In-Reply-To: <20191211191317.12677-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6751703949713752968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 12/11/19 1:13 PM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> To be considered attached on LTE a context should be activated.
> But in case the context got deactivated we did not update
> the attached state, it remained attached.
> That caused the connection manager to try to re-activate the
> context manually, but for LTE thats done automatically.
> In the case of ublox it returns errors, which is passed
> on to the connection manager, which tries again and
> again, until we get attached again.
> =

> It looked like this:
> 12:03:18 ofonod[547]: Aux: < \r\n+CIEV: 2,3\r\n
> 12:03:23 ofonod[547]: Aux: < \r\n+CIEV: 2,2\r\n
> =

> Deactivated

Shouldn't we get a CREG actually?  That tells us we're not connected at =

all?  Or does the modem somehow still have another default bearer active?

Anyhow, I'll go ahead and take this.  Applied, thanks.

Regards,
-Denis
--===============6751703949713752968==--

