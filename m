Content-Type: multipart/mixed; boundary="===============6218219443944412158=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] gathdlc: Unset disconnect function in unref
Date: Tue, 06 Jul 2010 11:28:26 -0500
Message-ID: <4C3359AA.3000500@gmail.com>
In-Reply-To: <1278410258-3077-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6218219443944412158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> @@ -278,6 +278,7 @@ void g_at_hdlc_unref(GAtHDLC *hdlc)
>  		hdlc->record_fd =3D -1;
>  	}
>  =

> +	g_at_io_set_disconnect_function(hdlc->io, NULL, NULL);

Since GAtHDLC does not set the disconnect function, this really belongs
in GAtPPP.

>  	g_at_io_unref(hdlc->io);
>  	hdlc->io =3D NULL;
>  =


However, I really question why this patch is necessary.  The only way
the disconnect function is not reset today is if the GAtIO is refed and
g_at_chat_resume is not called.

We do call g_at_io_set_disconnect function in g_at_chat_resume.

Regards,
-Denis

--===============6218219443944412158==--

