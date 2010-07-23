Content-Type: multipart/mixed; boundary="===============3519322180320595432=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 1/2] stkutil: convert img to xpm
Date: Fri, 23 Jul 2010 13:52:53 -0700
Message-ID: <20100723135253.529347e0@kcaccard-MOBL3>
In-Reply-To: <4C49F5AF.3030000@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3519322180320595432==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Jul 2010 15:03:59 -0500
Denis Kenzior <denkenz@gmail.com> wrote:
> =

> This also brings up another point.  You're assuming that the caller is
> appending the CLUT right after the image data and massaging the clut
> offset appropriately.  This is a really bad idea since the caller will
> have to do some significant pre-processing.
> =

> You can handle this in one of two ways:
> =

> 1. Assume the calling logic will read the entire image file before
> calling this function.  In this case, modifying the signature as follows
> might be a good idea:
> =

> char *stk_image_to_xpm(const unsigned char *file,
> 			unsigned short file_len,
> 			enum stk_img_scheme scheme,
> 			unsigned short img_offset,
> 			unsigned short img_len);
> =

> 2. Assume the calling logic is clever and will optimize reading of the
> file, including peeking into the image header to determine the where the
> CLUT is located and reading it.  In this case you can either reuse the
> signature from 1 above, or come up with something else.
> =

> Remember, reading from the SIM is extremely slow, so any and all clever
> optimization tricks are definitely wanted.

So, is it likely given normal usage that we'll access an image a single
image at a time, or is it more likely that we'll access a bunch of images
all at once?  It may be better to read an entire image data file (with
multiple images) and keep it cached if we are likely to immediately
need the other images.  In which case I'd be inclined to just pass
in the entire data image file and the offset like you have above.  If =

we are only likely to use a single image for any given length of time,
then it seems better to have the caller be smart and pass us the clut.

--===============3519322180320595432==--

