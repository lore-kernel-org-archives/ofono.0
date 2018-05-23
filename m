Content-Type: multipart/mixed; boundary="===============8008579352872946174=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Rework at_pin_send_puk It seems that the function
 at_pin_send_puk should have been changed along with at_pin_send,
 because it's also refering to the at_pin_send_cb callback See this commit :
 ba9f126716db3ae0bf6a3139088d9657cfb8b851
Date: Wed, 23 May 2018 09:05:51 -0500
Message-ID: <28318a89-b90c-59ba-35d2-75dba83eb10a@gmail.com>
In-Reply-To: <1526994511-302-3-git-send-email-florent.beillonnet@ext.actia.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8008579352872946174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florent,

On 05/22/2018 08:08 AM, Florent Beillonnet wrote:
> ---
>   drivers/atmodem/sim.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =


I went ahead and applied this after fixing up the commit header & =

description.  Please see doc/coding-style.txt, item M5 in particular.

Thanks!

Regards,
-Denis

--===============8008579352872946174==--

