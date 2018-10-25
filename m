Content-Type: multipart/mixed; boundary="===============8271035314162454299=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] atmodem/atutil.h: cb_data ref/unref possibility
Date: Thu, 25 Oct 2018 09:12:42 +0200
Message-ID: <CAKSBH7FKdqXUpS=c=KF0S6xdqnKy-x01GN1ZTWQg4ObOXJgfTA@mail.gmail.com>
In-Reply-To: <a3c6c6fc-0af1-f99a-95c3-1d8bb09fed4f@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8271035314162454299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Thu, Oct 25, 2018 at 8:55 AM Jonas Bonn <jonas@norrbonn.se> wrote:
>
> Hi Giacinto,
>
>
> On 25/10/2018 07:03, Giacinto Cifelli wrote:
> > +static inline struct cb_data *cb_data_ref(struct cb_data *cbd)
> > +{
> > +     if (cbd =3D=3D NULL)
> > +             return NULL;
> > +
> > +     g_atomic_int_inc(&cbd->ref_count);
> > +
>
> Let me just vent my disagreement with using atomic accessors here again:
>
> i)  If I'm a new contributor, unfamiliar with ofono, and I see this then
> I think:  "oh oh, this is a thread-safe library... better be
> careful."... and then I get all confused because nothing else is handled
> in a thread-safe manner.
>
> ii)  The atomic operations introduce an unnecessary memory barrier.
>
> I _presume_ that the code is written this way because it was inherited
> from connman and connman made an early attempt to be thread safe...???
> I'm not sure that legacy is worth preserving.
>
> Anyway, enough said on the matter.  The implementation is fine aside
> from my reservations.

overall I agree with you, but I have no feelings for the code.
If not needed otherwise, I adapt to the various projects I contribute,
in style and preferences.
Here was decided by Marcel that this is the only way, and I adhere to this.

But, since I am investing quite some time on ofono, and it is not a
company internal project,
I plan to write a book on it, where I could also mention that it is
not thread-safe, despite the occasional presence of atomic operations.

>
> /Jonas
>

Giacinto

--===============8271035314162454299==--

