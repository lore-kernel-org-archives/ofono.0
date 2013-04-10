Content-Type: multipart/mixed; boundary="===============0305122750436448490=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH 1/8] hfpmodem: Add codec watcher register
Date: Wed, 10 Apr 2013 16:31:08 -0300
Message-ID: <20130410193108.GA2098@samus>
In-Reply-To: <5164C3FE.9070600@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0305122750436448490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

[snip]

> >+guint hfp_slc_codec_watch_register(struct hfp_slc_info *info,
> >+				hfp_slc_codec_watch_cb_t cb, void *user_data)
> >+{
> >+	struct codec_watch *watch =3D g_new0(struct codec_watch, 1);
> >+
> >+	watch->slc =3D info;
> >+	watch->cb =3D cb;
> >+	watch->user_data =3D user_data;
> >+
> >+	return g_at_chat_register(info->chat, "+BCS:", bcs_notify, FALSE,
> >+								watch, g_free);
> >+}
> =

> Why would you do this in the SLC ?  The SLC establishment only
> requires HF to send a BAC after the BRSF has been exchanged.  We do
> this successfully in brsf_cb.  I do not see why we can't monitor
> +BCS inside plugins/hfp_hf_bluez5.c?

The only point was to avoid having any AT logic inside the hfp_hf_bluez5
plugin. Will send an updated version with this logic inside hfp_hf_bluez5. =
It
does indeed make the code easier to follow.


Cheers,
-- =

Vinicius

--===============0305122750436448490==--

