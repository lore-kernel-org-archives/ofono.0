Content-Type: multipart/mixed; boundary="===============8724568665316554761=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono crash (setting offline while connected)
Date: Tue, 01 Mar 2011 15:38:52 -0600
Message-ID: <4D6D676C.5020400@gmail.com>
In-Reply-To: <AANLkTinXKYT0=DbhwtB5kXdu8fR=Of5zfp2Sh9xaDhXk@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8724568665316554761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Amit,

A gentle reminder not to post on this mailing list.

On 02/25/2011 11:51 PM, Amit Mendapara wrote:
> Hi Denis,
> =

> I tried several things but no luck. Here I am attaching the backtrace as
> you suggested. What I found is, ofono crashes on
> `ofono_gprs_context_remove(data->gc)` call when `linktop_disconnect` was
> called second time. I am still not sure why `linktop_disconnect` is
> being called twice in this case.

Sounds like you're encountering the same issue as
https://bugs.meego.com/show_bug.cgi?id=3D13679.  Basically when the modem
is put offline, the gprs atom and the context are removed automatically
by the core.  However, the modem driver does not clean up properly.

Please work with Martin to come up with a proper fix.

Regards,
-Denis

--===============8724568665316554761==--

