Content-Type: multipart/mixed; boundary="===============1972860517293611563=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH v1 06/10] hfpmodem: Add dynamic hfp_slc_info allocation
Date: Wed, 23 Jan 2013 20:04:30 -0300
Message-ID: <20130123230430.GD6545@samus>
In-Reply-To: <51004938.30503@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1972860517293611563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 14:34 Wed 23 Jan, Denis Kenzior wrote:
> Hi Vinicius,
> =

> >diff --git a/plugins/phonesim.c b/plugins/phonesim.c
> >index 26f96d0..9210e02 100644
> >--- a/plugins/phonesim.c
> >+++ b/plugins/phonesim.c
> >@@ -929,8 +929,8 @@ static int localhfp_enable(struct ofono_modem *modem)
> >
> >  	g_at_chat_set_disconnect_function(chat, slc_failed, modem);
> >
> >-	hfp_slc_info_init(info, HFP_VERSION_LATEST);
> >-	info->chat =3D chat;
> >+	info =3D hfp_slc_info_init(chat, HFP_VERSION_LATEST);
> >+	g_at_chat_unref(chat);
> >  	hfp_slc_establish(info, slc_established, slc_failed, modem);
> >
> >  	return -EINPROGRESS;
> =

> This part makes no sense.  I refer you to localhfp_probe() function.
> Are you testing any of your changes?

Ugh. That is what happens when you mess with code that you are not familiar
with, and do not properly test it.

Will send a new version of the remaining of the series, without any changes
related to the allocation of hfp_slc_info. So we delay having to deal with
allocating it until we really need it. And we do not touch code that we
are not sure how it works.

> =

> Regards,
> -Denis


Cheers,
-- =

Vinicius

--===============1972860517293611563==--

