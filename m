Content-Type: multipart/mixed; boundary="===============6455516857503507424=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: Fix a race if a context get deactivated while
 read
Date: Wed, 08 May 2019 09:41:06 -0500
Message-ID: <5a234683-1eb6-c51b-1145-776760f4c5aa@gmail.com>
In-Reply-To: <20190508072756.6093-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6455516857503507424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 05/08/2019 02:27 AM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> When a context gets activated we read its settings, but
> if the context gets deactivated during this time we should
> not indicate that the context is activated when the settings
> are received.
> ---
>   drivers/atmodem/gprs.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> =


Applied, thanks.

Regards,
-Denis


--===============6455516857503507424==--

