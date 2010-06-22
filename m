Content-Type: multipart/mixed; boundary="===============4831392096666174671=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 1/2] stkutil: convert text attributes to html
Date: Mon, 21 Jun 2010 19:51:06 -0700
Message-ID: <20100621195106.6fbf2025@kcaccard-MOBL3>
In-Reply-To: <AANLkTinZvOfO4tH1KWkCwob2aL4SLeIz_6N42BQlETpW@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4831392096666174671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jun 2010 00:45:39 +0200
andrzej zaborowski <balrogg@gmail.com> wrote:

> Can we always end_format() and start_format() when the formatting
> changes, and just once instead of in a loop?  Here's a test case that
> I'm worried about:
> =

> text is "abc"
> attribute 1 (red text) starts at 0, len 2
> attribute 2 (blue text) starts at 1, len 2
> =

> the generated html, by my reading will look like this:
> <span style=3D"color: red;">a<span style=3D"color: blue;">b</span>c</span>

I ran this test just to make sure, the generated html is not as
you fear and is correct (I used different colors though)

<html><body><span style=3D"color: #347235;background-color: #FFFFFF;">a<spa=
n style=3D"color: #0000A0;background-color: #FFFFFF;">b</span></span>c</bod=
y></html>

I can add this exact test as a unit test if you would like.

--===============4831392096666174671==--

