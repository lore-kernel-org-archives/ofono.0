Content-Type: multipart/mixed; boundary="===============4175969514772323668=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] qmimodem: query_passwd_state can be retried
Date: Mon, 16 Jan 2017 22:26:19 -0600
Message-ID: <87629214-9b68-4e94-851f-f264f1964012@gmail.com>
In-Reply-To: <20170117102904.970-2-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4175969514772323668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

On 01/17/2017 04:29 AM, Christophe Ronco wrote:
> Retry command QMI_UIM_GET_CARD_STATUS during query_passwd_state if a
> temporary error status has been detected.
> This happens with a MC7430 modem when query_passwd_state is called just
> after PIN is entered.
> ---
>  drivers/qmimodem/sim.c | 95 ++++++++++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 81 insertions(+), 14 deletions(-)
>

Applied, thanks!

Regards,
-Denis


--===============4175969514772323668==--

