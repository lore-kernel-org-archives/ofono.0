Content-Type: multipart/mixed; boundary="===============2586384144260607222=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] fake a sim-inserted status
Date: Mon, 20 Dec 2010 15:31:07 -0600
Message-ID: <4D0FCB1B.50808@gmail.com>
In-Reply-To: <1292005692-19615-1-git-send-email-fgau@pyneo.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2586384144260607222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/10/2010 12:28 PM, F. Gau wrote:
> From: M. Dietrich <mdt@emdete.de>
> =

> 	while the sim detection does not work this patch at least allows to use
> 	those modems. until someone has the time to work out a correct solution
> 	this is a usefull workaround.
> ---
>  plugins/huawei.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index 25dfaca..df506d3 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -586,6 +586,7 @@ static void huawei_pre_sim(struct ofono_modem *modem)
>  	ofono_devinfo_create(modem, 0, "atmodem", data->pcui);
>  	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
>  					"atmodem", data->pcui);
> +	ofono_sim_inserted_notify(data->sim, TRUE);
>  =

>  	data->sim_poll_count =3D 0;
>  	query_sim_state(modem);

I don't want to completely bypass the sim inserted logic (which seems to
work on other Huawei models) for the sake of EM770.

So I really prefer that we do this a bit smarter.  Even simple model to
behavior matching would be acceptable...

Regards,
-Denis

--===============2586384144260607222==--

