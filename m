Content-Type: multipart/mixed; boundary="===============6181328359953584132=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 12/12] qmi: use standard endian macros
Date: Thu, 29 Mar 2018 10:33:08 -0500
Message-ID: <ef78e1a9-473c-6fef-0eeb-865687a6cd55@gmail.com>
In-Reply-To: <20180329135801.5981-13-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6181328359953584132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/29/2018 08:58 AM, Jonas Bonn wrote:
> ---
>   drivers/qmimodem/qmi.c | 58 +++++++++++++++++++++++++------------------=
-------
>   1 file changed, 29 insertions(+), 29 deletions(-)
> =


Won't be taking this one.  If we're sticking to glib, then we should use =

glib macros.  ell has its own versions of these, so this is just extra =

churn for no benefit.

Regards,
-Denis

--===============6181328359953584132==--

