Content-Type: multipart/mixed; boundary="===============7424034865108496942=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] modem.h: ofono_modem_set_powered_timeout_hint
Date: Wed, 24 Oct 2018 14:32:48 -0500
Message-ID: <5d600f7c-1f87-fa13-67f9-dda4cce228de@gmail.com>
In-Reply-To: <20181024052810.28128-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7424034865108496942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/24/2018 12:28 AM, Giacinto Cifelli wrote:
> function to set the powered timeout dynamically.
> =

> The function is effective if called before Powered=3Dtrue,
> so it is best called in udevng.
> If not called, the timeout is set by default to 20 seconds.
> ---
>   include/modem.h | 3 +++
>   1 file changed, 3 insertions(+)
> =


Both applied after tweaking some style issues & the commit description.

Regards,
-Denis


--===============7424034865108496942==--

