Content-Type: multipart/mixed; boundary="===============9172204555249430283=="
MIME-Version: 1.0
From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH v0] Read EF_ICCID property of SIM
Date: Tue, 27 Apr 2010 10:09:12 +0200
Message-ID: <20100427080912.GB14818@gumpy.localdomain>
In-Reply-To: <20100427063631.GA14818@gumpy.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9172204555249430283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 27, 2010 at 08:36:31AM +0200, Daniel Wagner wrote:
> > Please use the sim file queue like EFpl does, no need to invent your ow=
n =

> > solution.  =

> =

> I used the ofono_sim_read function but that didn't work. On the
> terminal I saw only:
> =

> CRSM=3D192,12258 =

> =

> With read_file_transparent it is:
> =

> ofonod[2048]: Control:> AT+CRSM=3D176,12258,0,0,10\r
> ofonod[2048]: Control:< \r\r\n+CRSM: 144,0,"989422024754212460F6"\r\n\r\n=
OK\r\n

I looked into this. It comes down to:

ofono_sim_read -> sim_op_next -> read_file_info
 =

and since sim_op_next does not check what structure type it is, it
always calles read_file_info (CRSM=3D192). =


I'm not sure how to resolve this here. The problem is the callback
given to sim_op_next has of course a different signature than
read_file_transparent wants (ofono_sim_read_file_cb_t vs
ofono_sim_read_cb_t)

Should I add something like:

int ofono_sim_read_transparent(struct ofono_sim *sim, int id,
    				      	enum ofono_sim_file_structure expected_type,
					ofono_sim_read_cb_t cb, void *data)

thanks,
daniel

--===============9172204555249430283==--

