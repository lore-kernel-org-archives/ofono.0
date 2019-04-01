Content-Type: multipart/mixed; boundary="===============4086156630664463569=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ublox: Correct the USBCONF reply prefix
Date: Mon, 01 Apr 2019 09:56:58 -0500
Message-ID: <6b7d1438-f008-b25c-e5f0-60403e6bf5bc@gmail.com>
In-Reply-To: <20190331201846.6645-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4086156630664463569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 03/31/2019 03:18 PM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> According to the u-blox AT Commands Manual and my tests
> the response prefix of AT+UUSBCONF is "+UUSBCONF:", including
> a colon. The colon was missing in the code, causing next step
> to parse a number to fail, since a colon is not a number.
> ---
>   plugins/ublox.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis


--===============4086156630664463569==--

