Content-Type: multipart/mixed; boundary="===============6245049112915087584=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/9] cbs: Watch for changes to relevant SIM files.
Date: Thu, 17 Feb 2011 15:10:40 -0600
Message-ID: <4D5D8ED0.2080408@gmail.com>
In-Reply-To: <1297756739-2958-6-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6245049112915087584==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 02/15/2011 01:58 AM, Andrzej Zaborowski wrote:
> ---
>  src/cbs.c |   32 +++++++++++++++++++++++++++++++-
>  1 files changed, 31 insertions(+), 1 deletions(-)
> =


Patch has been applied.  One more comment below:

> @@ -886,7 +888,33 @@ static void sim_cbmid_read_cb(int ok, int length, in=
t record,
>  	g_free(str);
>  =

>  done:
> -	cbs_got_file_contents(cbs);
> +	if (cbs->efcbmid_update) {
> +		topic_str =3D cbs_topics_to_str(cbs, cbs->topics);
> +		cbs->driver->set_topics(cbs, topic_str,
> +					cbs_set_powered_cb, cbs);
> +		g_free(topic_str);

I think you meant to do this only if CBS atom was powered.  I fixed this
under that assumption.  Can you double check my logic?

> +
> +		cbs->efcbmid_update =3D FALSE;
> +	} else
> +		cbs_got_file_contents(cbs);
> +}
> +

Regards,
-Denis

--===============6245049112915087584==--

