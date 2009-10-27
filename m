Content-Type: multipart/mixed; boundary="===============6451644252223389419=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SIM PIN unlock
Date: Tue, 27 Oct 2009 11:10:18 -0500
Message-ID: <200910271110.18713.denkenz@gmail.com>
In-Reply-To: <4AE71585.6040804@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6451644252223389419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

> Ok. I have narrowed it down a little.
>
> It seems to be the CRSM command reading the
> SIM_EFLI_FILEID when it succeeds.
>
> ofonod[6326]: > AT+CRSM=3D192,28421\r
> ofonod[6326]: < \r\n+CRSM: 144,
> ofonod[6326]: < 0,850D00046F05040001FFAA03020000\r\n\r\n
> ofonod[6326]: < \r\nOK\r\n
>
> goes no further....

The parser is stuck because your modem is spewing garbage.  atgen plugin us=
es =

the _really_ strict gsmv1 syntax.  I suggest you make a custom driver for y=
our =

device that uses the gsm_permissive syntax.

> 	ofono_sim_read(sim, SIM_EFLI_FILEID,
>          	                OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
>                  	        sim_efli_read_cb, sim);

This is wrong and won't get you very far as there are about 20 other SIM fi=
les =

that we read.

Regards,
-Denis


--===============6451644252223389419==--

