Content-Type: multipart/mixed; boundary="===============8143288844062290831=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] gprs: Use -1 as netreg status during init.
Date: Wed, 07 Aug 2019 16:57:08 -0500
Message-ID: <0554da46-aa6b-3f74-a23e-518b09a09dd0@gmail.com>
In-Reply-To: <20190806083356.21197-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8143288844062290831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 8/6/19 3:33 AM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> Previously the valid "unknown" netreg status was set
> during startup, but its a bit problematic for gprs.
> There might be cases where a LTE context is activated
> before netreg is finished updating its status.
> Resulting in gprs taking faulty actions.
> Instead we set the status to -1 until we are updated
> with a known value.
> During the time the status is -1, gprs postpones actions until
> the status is valid (>=3D 0).
> ---
>   src/gprs.c | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============8143288844062290831==--

