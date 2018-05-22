Content-Type: multipart/mixed; boundary="===============8005083879718589186=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] plugins: fixed crash in udevng
Date: Tue, 22 May 2018 15:39:59 -0500
Message-ID: <6a0f508e-c4d2-997a-712c-87e0ab3bcf56@gmail.com>
In-Reply-To: <20180522203549.6755-1-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8005083879718589186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 05/22/2018 03:35 PM, James Prestwood wrote:
> The return value from ofono_modem_register was not being checked. If this=
 fails
> the modem object is not setup and causes a crash. This was specifically s=
een
> when using the mbim driver without having configured with mbim support.
> =

> Now the modem object gets destroyed properly if the modem registration fa=
ils.
> ---
>   plugins/udevng.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis


--===============8005083879718589186==--

