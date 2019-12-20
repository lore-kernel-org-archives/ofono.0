Content-Type: multipart/mixed; boundary="===============0515348805448242745=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] xmm7xxx: modified handling of XSIM states for xmm modems
Date: Fri, 20 Dec 2019 12:33:23 -0600
Message-ID: <fc40d481-c043-110d-27e0-fe8066be1fcc@gmail.com>
In-Reply-To: <1576760164-30892-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0515348805448242745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 12/19/19 6:56 AM, Antara Borwankar wrote:
> +XSIM:7 state as defined in xmm7560 functional AT specification
> only indicates ready for attach.
> =

> +CPIN: READY is received after SIM is completely initialized.
> Also indicating readiness of Phonebook and SMS. Hence moving the
> creation of SMS and Phonebook atom to xmm7xxx_post_sim function.
> =

> +XSIM:4 PUK needed state was not handled. It must be handled
> same as PIN needed state. Added handling of this case to
> switch_sim_state_status function.
> ---
>   plugins/xmm7xxx.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============0515348805448242745==--

