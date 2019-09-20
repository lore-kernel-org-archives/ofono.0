Content-Type: multipart/mixed; boundary="===============4925014786177169299=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: deattach driver when gprs status indicates
 unregistered
Date: Fri, 20 Sep 2019 09:58:51 -0500
Message-ID: <be8a9d4e-a0dd-22fe-5630-e43453ebf0bc@gmail.com>
In-Reply-To: <20190917214807.19663-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4925014786177169299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 9/17/19 4:48 PM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> In the same way as we consider the driver attached when the
> gprs status indicates we are registered, we should consider
> it deattached when the status indicates unregistration.
> =

> If we don't, then we would not always recover from the case
> when deattaching the driver fails. We would just revert back
> the driver attached status to true, and "ignore" if the status
> indicates the opposite when we check the registration status
> afterwards.
> ---
>   src/gprs.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============4925014786177169299==--

