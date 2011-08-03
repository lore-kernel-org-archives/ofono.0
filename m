Content-Type: multipart/mixed; boundary="===============8898016195696735441=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] huawei: cleanup sim polling when the modem is removed.
Date: Wed, 03 Aug 2011 11:50:44 +0200
Message-ID: <1312365045.3373.4.camel@aeonflux>
In-Reply-To: <1312359794-2455-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8898016195696735441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

>  plugins/huawei.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index 1380369..eaf8b07 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -107,6 +107,9 @@ static void huawei_remove(struct ofono_modem *modem)
>  	/* Cleanup after hot-unplug */
>  	g_at_chat_unref(data->pcui);
>  =

> +	if (data->sysinfo_poll_source)
> +		g_source_remove(data->sysinfo_poll_source);
> +
>  	g_free(data);
>  }

so actually you do not wanna do this in the remove callback. You wanna
do this in the disable callback just before you cancel all pending
commands.

Doing this in the remove callback has the potential problem that you
might poll CPIN while trying to execute CFUN. In theory this does not
matter since GAtChat will not execute commands at the same time, but why
bother keeping the timeout running if we already know that we are going
to shutdown the device.

We call disable before we call remove, but the only thing that I have
not checked is what happens to this if we have not succeeded with enable
yet. So if I remember this right, then disable is always called (even if
enable has not yet called set_powered), but I need Denis to confirm
this.

Regards

Marcel



--===============8898016195696735441==--

