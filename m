Content-Type: multipart/mixed; boundary="===============5616378454641158728=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0] Read EF_ICCID property of SIM
Date: Tue, 27 Apr 2010 09:21:21 -0500
Message-ID: <201004270921.21557.denkenz@gmail.com>
In-Reply-To: <20100427080912.GB14818@gumpy.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5616378454641158728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

> On Tue, Apr 27, 2010 at 08:36:31AM +0200, Daniel Wagner wrote:
> > > Please use the sim file queue like EFpl does, no need to invent your
> > > own solution.
> >
> > I used the ofono_sim_read function but that didn't work. On the
> > terminal I saw only:
> >
> > CRSM=3D192,12258
> >
> > With read_file_transparent it is:
> >
> > ofonod[2048]: Control:> AT+CRSM=3D176,12258,0,0,10\r
> > ofonod[2048]: Control:< \r\r\n+CRSM:
> > 144,0,"989422024754212460F6"\r\n\r\nOK\r\n
> =

> I looked into this. It comes down to:
> =

> ofono_sim_read -> sim_op_next -> read_file_info
> =

> and since sim_op_next does not check what structure type it is, it
> always calles read_file_info (CRSM=3D192).
> =

> I'm not sure how to resolve this here. The problem is the callback
> given to sim_op_next has of course a different signature than
> read_file_transparent wants (ofono_sim_read_file_cb_t vs
> ofono_sim_read_cb_t)
> =

> Should I add something like:
> =

> int ofono_sim_read_transparent(struct ofono_sim *sim, int id,
>     				      	enum ofono_sim_file_structure expected_type,
> 					ofono_sim_read_cb_t cb, void *data)
> =


ofono_sim_read handles transparent, cyclic and record based files.  There =

should be no need to add anything.  Just do exactly what e.g. EFli / EFpl =

functions do.

What modem are you using? Some of them are dumb and don't implement +CRSM '=
GET =

RESPONSE' properly.

Regards,
-Denis

--===============5616378454641158728==--

