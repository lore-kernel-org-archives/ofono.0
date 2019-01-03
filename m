Content-Type: multipart/mixed; boundary="===============1288905920375191363=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix voice call initialization problem
Date: Thu, 03 Jan 2019 17:18:33 -0600
Message-ID: <79cded92-3179-004d-73d6-4aeeac87f8f3@gmail.com>
In-Reply-To: <1546531540-31621-1-git-send-email-khaled.romdhani@ardia.com.tn>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1288905920375191363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Khaled,

On 01/03/2019 10:05 AM, khaled romdhani wrote:
> when the voice call driver is probing, I noticed sometimes
> a CME Error with the code =3D 4 (operation not supported)
> related to AT commands "AT+CSSN=3D1,1" and "AT^SLCC=3D1".
> =

> In the current voice call implementation for Gemalto modems
> the ofono_voicecall_create() is called on the gemalto_pre_sim().
> The sim is not totaly readed by the module, it is not yet
> online which is causing a sporadic problem at driver
> intialization also when launching some outgoing/incoming calls.
> =

> This change moves the ofono_voicecall_create() to the
> gemalto_post_online() to be sure that sim is well registred
> and online.
> ---
>   plugins/gemalto.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============1288905920375191363==--

