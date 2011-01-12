Content-Type: multipart/mixed; boundary="===============6794440576379143665=="
MIME-Version: 1.0
From: Jussi.Kangas@tieto.com
Subject: RE: [PATCH] sim: check if lock is locked after code changing attempt
Date: Wed, 12 Jan 2011 09:39:21 +0200
Message-ID: <20A4FB08D632914F9C09B9F05CBDF258192D753286@EXMB02.eu.tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6794440576379143665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On Tue, 2011-01-11 at 16:08 +0200, Lucas De Marchi wrote:
> Hi Jussi
> =

> On Tue, Jan 11, 2011 at 10:17 AM,  <Jussi.Kangas@tieto.com> wrote:
> > Hi,
> >
> > This is fix to Marit Henriksen's TODO item "Check SIM pin status if sim=
_change_pin fails". I've discussed with Marit and it's ok for her if I fix =
the issue. Problem here is that issue could perhaps also be fixed with retr=
y counter solution introduced by Lucas De Marchi couple of tasks ago. That =
would seem however require some extra implementation in ste modem ( at leas=
t I was not able get the ofono show correct values without extra modificati=
ons ) and I think that isimodems don't have that sort of retry counter at a=
ll. Because of that and since I had this solution already implemented I pro=
pose it to be added as well.
> >
> =

> I failed to understand why you are hard-coding this and why you'd like
> to use retry counters. Can't you just check the pin state by calling
> sim_pin_check()?
> =

> Moreover, this is not really implementing what the TODO item says.
> =

> =

> regards,
> Lucas De Marchi

Marit already proposed sim_pin_check approach 2010/11/2. Denis Kenzior
thought that initializing sim interface would not be a good idea. See
mail "Re: [Patch] sim: Check SIM pin status after changing pin" from
Friday 5th in November 2010. =


True, fix proposal does not do exactly what TODO item says. It trusts to
returned error value instead of going to check the sim state once more.
In my testings this value has been trustable so far and there has not
been reason to go check the state. Of course I've tested only with one
modem so this might not be a universal truth.

I don't particularly wish to use the retry counters. I was just thinking th=
at same
information ( PUK required ) could be deduced by counting the retries. =


Br,
-Jussi




--===============6794440576379143665==--

