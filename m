Content-Type: multipart/mixed; boundary="===============6702796277433913357=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 0/2] add support of void parameters in CMER
Date: Thu, 24 Feb 2011 14:02:49 -0600
Message-ID: <4D66B969.10904@gmail.com>
In-Reply-To: <1298567766-17745-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6702796277433913357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 02/24/2011 11:16 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> following commands are supported :
> AT+CMER=3D3,0,0,1,0
> =

> OK
> AT+CMER=3D3,0,0,1
> =

> OK
> AT+CMER=3D3,,,1
> =

> OK
> AT+CMER=3D3,,,1,
> =

> OK
> AT+CMER=3D,,0,1,
> =

> OK
> AT+CMER=3D3, ,,1
> =

> OK
> AT+CMER=3D3,a,0,1
> =

> ERROR
> AT+CMER=3D3,"a",0,1
> =

> ERROR
> AT+CMER=3D3,
> =

> OK
> AT+CMER=3D3
> =

> OK
> =

> Fr=C3=A9d=C3=A9ric Danis (2):
>   gatchat: add g_at_result_iter_next_number_default API
>   emulator: add support of void parameters in CMER
> =

>  gatchat/gatresult.c |   30 ++++++++++++++++++++++++++++++
>  gatchat/gatresult.h |    2 ++
>  src/emulator.c      |   24 ++++++++++++------------
>  3 files changed, 44 insertions(+), 12 deletions(-)
> =


Both patches have been applied, thanks.

Regards,
-Denis

--===============6702796277433913357==--

