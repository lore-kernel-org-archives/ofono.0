Content-Type: multipart/mixed; boundary="===============0298582899305747187=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 2/2] gathdlc: Unset disconnect function in unref
Date: Wed, 07 Jul 2010 09:32:59 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351F6F23B4@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C3359AA.3000500@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0298582899305747187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Denis Kenzior wrote:
> Hi Zhenhua,
> =

>> @@ -278,6 +278,7 @@ void g_at_hdlc_unref(GAtHDLC *hdlc) =

>>  	hdlc->record_fd =3D -1; }
>> =

>> +	g_at_io_set_disconnect_function(hdlc->io, NULL, NULL);
> =

> Since GAtHDLC does not set the disconnect function, this really
> belongs in GAtPPP. =


How about unset io_disconnect() in GAtPPP? Since GAtPPP doesn't have suspen=
d/resume, the io_disconnect always exist until ppp is dead.
 =

>>  	g_at_io_unref(hdlc->io);
>>  	hdlc->io =3D NULL;
>> =

> =

> However, I really question why this patch is necessary.  The only way
> the disconnect function is not reset today is if the GAtIO is refed
> and g_at_chat_resume is not called.
> =

> We do call g_at_io_set_disconnect function in g_at_chat_resume.

Good catch. I fixed it in gatserver and will send a patch out soon. Yes, af=
ter reset the disconnect function, the problem is gone.
 =

> Regards,
> -Denis



Regards,
Zhenhua


--===============0298582899305747187==--

