Content-Type: multipart/mixed; boundary="===============3551106308578694751=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 1/2] stkutil: convert img to xpm
Date: Fri, 23 Jul 2010 14:39:13 -0700
Message-ID: <20100723143913.7756e88e@kcaccard-MOBL3>
In-Reply-To: <4C4A0394.2060406@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3551106308578694751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Jul 2010 16:03:16 -0500
Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Kristen,
> =

> On 07/23/2010 03:52 PM, Kristen Carlson Accardi wrote:
> > On Fri, 23 Jul 2010 15:03:59 -0500
> > Denis Kenzior <denkenz@gmail.com> wrote:
> >>
> >> This also brings up another point.  You're assuming that the caller is
> >> appending the CLUT right after the image data and massaging the clut
> >> offset appropriately.  This is a really bad idea since the caller will
> >> have to do some significant pre-processing.
> >>
> >> You can handle this in one of two ways:
> >>
> >> 1. Assume the calling logic will read the entire image file before
> >> calling this function.  In this case, modifying the signature as follo=
ws
> >> might be a good idea:
> >>
> >> char *stk_image_to_xpm(const unsigned char *file,
> >> 			unsigned short file_len,
> >> 			enum stk_img_scheme scheme,
> >> 			unsigned short img_offset,
> >> 			unsigned short img_len);
> >>
> >> 2. Assume the calling logic is clever and will optimize reading of the
> >> file, including peeking into the image header to determine the where t=
he
> >> CLUT is located and reading it.  In this case you can either reuse the
> >> signature from 1 above, or come up with something else.
> >>
> >> Remember, reading from the SIM is extremely slow, so any and all clever
> >> optimization tricks are definitely wanted.
> > =

> > So, is it likely given normal usage that we'll access an image a single
> > image at a time, or is it more likely that we'll access a bunch of imag=
es
> > all at once?  It may be better to read an entire image data file (with
> > multiple images) and keep it cached if we are likely to immediately
> > need the other images.  In which case I'd be inclined to just pass
> > in the entire data image file and the offset like you have above.  If =

> > we are only likely to use a single image for any given length of time,
> > then it seems better to have the caller be smart and pass us the clut.
> =

> The problem is we just don't know, so we have to assume the worst case.
>  Anything that minimizes the number of reads is a good thing (TM).
> =

> For instance, you might have couple of dozen images from EFimg dispersed
> among multiple EFiidf files.  Each EFiidf file might be 65K in length,
> but EFimg files might only refer to about 10k from all of them.
> =

> It is perfectly OK for EFiidf to contain mostly garbage (e.g. for future
> updates, installation of new SIM Toolkit applications on the SIM +
> associated image data, etc)  So you simply can't assume any sort of
> packing or efficient storage use.
> =

> In this case, a clever algorithm that minimizes the number of SIM
> fetches is needed.
> =

> Regards,
> -Denis

If that is the case then I propose we assume a smart algorithm fetched
our data for us and change the signature to something like this:

unsigned char *stk_image_to_xpm(const unsigned char *image_body,
				enum stk_image_scheme scheme,
				unsigned int height,
				unsigned int width, unsigned int ncolors,
				const unsigned char *clut);

We would assume that the caller has done all the sanity checking on
the file and handed us a clut of appropriate size as well.

--===============3551106308578694751==--

